function shape_pts = intersection_shape(theta, phi, psi, lambda, N1,N2)
% input: list of N1+N2 angles, defining the N1+N2 lines from both locations

% Pseudocode overview of this function

% direction vector V(d) = [X(d) Y(d) Z(d)]
% facenormals F = [F1; F2; ... Fn]
% dot(V,F) < 0 for all Fi -> point is inside
% dot(V,Fa) = 0 && dot(V,F{~a}) < 0 -> point is inside triangle number "a"
%
% for each line V(d) of loc1:
%   for each triangle t of loc2:
%       solve dot(V(d),Ft) == 0 -> d_t = (distance along V that gives the intersection)
%       calculate dot(V(d_t,F{~t})          {all other triangles}
%       if dot(V(d_t,F{~t}) < 0 for all ~t:
%           shape_pts(i) = [X(d_t) Y(d_t) Z(d_t)];   % add it to the list
%           i = i + 1;
%
% repeat above, but with:
% for each line V(d) of loc2:
%   for each triangle t of loc1:
%       ...
%
% K = convhull(shape_pts(:,1), shape_pts(:,2), shape_pts(:,3));
% trisurf(K,shape_pts(:,1), shape_pts(:,2), shape_pts(:,3));

shape_pts = zeros((N1+N2)*2,3);     % list of intersection pts of lines with triangles
u = 1;  % index for shape_pts
% (N1+N2)*2 is a bit overkill, but means that I don't need to dynamically change the size of the array

endpoints1 = zeros(N1+1,3);
endpoints2 = zeros(N2+1,3);
% line length is chosen here to be 400 (km),
% exact value doesn't impact intersection calculation.
for i = 1:N1
    [X,Y,Z] = line_eq(theta(i), phi(i), psi(i), lambda(i));
    endpoints1(i,:) = [X(400) Y(400) Z(400)];
end
for i = 1:N2
    [X,Y,Z] = line_eq(theta(i+N1), phi(i+N1), psi(i+N1), lambda(i+N1));
    endpoints2(i,:) = [X(400) Y(400) Z(400)];
end
% viewing locations:
endpoints1(N1+1,:) = [px(theta(1)   , phi(1))    py(theta(1)   , phi(1))    pz(theta(1))];
endpoints2(N2+1,:) = [px(theta(N1+1), phi(N1+1)) py(theta(N1+1), phi(N1+1)) pz(theta(N1+1))];


k1 = convhull(endpoints1(:,1), endpoints1(:,2), endpoints1(:,3));
k2 = convhull(endpoints2(:,1), endpoints2(:,2), endpoints2(:,3));
% convhull creates a convex polyhedron out of a list of points in 3D,
% the list of points we use is the endpoints of the lines, + the start pt

[a,~] = find(k1==N1+1);
k1 = k1(a,:); % only really need the triangles on the sides, not at the end
[a,~] = find(k2==N2+1);
k2 = k2(a,:); % only really need the triangles on the sides, not at the end

TR1 = triangulation(k1,endpoints1);
F1 = faceNormal(TR1);
M1 = size(F1,1);
TR2 = triangulation(k2,endpoints2);
F2 = faceNormal(TR2);
M2 = size(F2,1);

p1 = endpoints1(N1+1,:);
p2 = endpoints2(N2+1,:);    
for i = 1:N1
    A = [Ax(theta(i) ,phi(i), psi(i), lambda(i))   Ay(theta(i), phi(i), psi(i), lambda(i))   Az(theta(i), psi(i), lambda(i))];
    for j = 1:M2
        d = dot(p2-p1,F2(j,:))/dot(A,F2(j,:));        % solves the equation of dot(V(d),F) = 0 for d
        % p1+d*A1    is position vector,
        % p1+d*A1-p2 is direction vector
        temp = find(dot(repmat(p1-p2+d*A, M2-1, 1), F2(1:end ~=j,:),2) > 0, 1);   % looks for any instances where dot(d*A, F) > 0, excluding index j
        % size(F2) = (M2,3); so ^ is repeated M2-1 times (~=j) to match size
        if isempty(temp)
            % the point that is a distance "d" away from "p1", in the
            % direction of "A", is in the plane with index j, 
            % and 'below' the planes with index ~j -> inside triangle j
            shape_pts(u,:) = p1 + d*A; 
            u = u+1;
        end
    end
end
for i = N1+1:N1+N2
    A = [Ax(theta(i) ,phi(i), psi(i), lambda(i))   Ay(theta(i), phi(i), psi(i), lambda(i))   Az(theta(i), psi(i), lambda(i))];
    for j = 1:M1
        d = dot(p1-p2,F1(j,:))/dot(A,F1(j,:));        % solves the equation of dot(V(d),F) = 0 for d
        % p2+d*A2    is position vector,
        % p2+d*A2-p1 is direction vector
        temp = find(dot(repmat(p2-p1+d*A, M1-1, 1), F1(1:end ~=j,:),2) > 0, 1);   % looks for any instances where dot(d*A, F) > 0, excluding index j
        % size(F1) = (M1,3); so ^ is repeated M1-1 times (~=j) to match size
        if isempty(temp)
            % the point that is a distance "d" away from "p2", in the
            % direction of "A", is in the plane with index j, 
            % and 'below' the planes with index ~j -> inside triangle j
            shape_pts(u,:) = p2 + d*A;
            u = u+1;
        end
    end
end
shape_pts = shape_pts(shape_pts(:,1) ~= 0,:); % delete empty values