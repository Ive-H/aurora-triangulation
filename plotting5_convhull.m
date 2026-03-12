% This program creates a shape out of the intersections of the lines
% most of the calculations for that are done in the function
% "intersection_shape"
% only works with 2 locations at the moment

% close all


loc = readtable("original_locations.csv"); % [Lapua=1, Alajarvi=2, Miekankoski=3]
% [N_deg, N_min, N_sec, E_deg, E_min, E_sec]

ori = readtable("orientations\bulb2-8_57-16.csv");
% [loc, p_deg, p_min, p_sec, l_deg, l_min, l_sec]


th1 = rad(65,0,0);
th2 = rad(60,0,0);
ph1 = rad(21,0,0);
ph2 = rad(37,0,0);



map_image = imread("figures/Maps-65_21-60_37-locs_named.png");
[N_th, N_ph, a] = size(map_image);


% Mercator correction
y1 = iGd(th1);
y2 = iGd(th2);
y_grid = linspace(y1, y2, N_th);

theta_grid = Gd(y_grid);

[th,ph] = meshgrid(theta_grid, linspace(ph1, ph2, N_ph));
th = th';
ph = ph';

figure; %                        );%
surf(px(th,ph), py(th,ph), pz(th), map_image, "LineStyle", "none");
% plots a section of the Earth's surface

hold on;

N = size(ori,1);        % number of orientations
Nl = 7;                 % number of total locations
clr = [1 0 0; .5 .5 0; 0 1 0; 0 .5 .5; 0 0 1; .5 0 .5; .4 .4 .4];    % line color per location

j = 1;
newloc = ones(Nl,1);            % list of moments that 'loc' switches
line_names = strings(N,1);      % for the legend

theta = zeros(N,1);
phi   = zeros(N,1);
psi   = zeros(N,1);
lambda= zeros(N,1);

for i = (1:N)

    for l = (2:Nl)
        if i == find(ori.loc == l,1)
            j = l;
            newloc(j) = i;
        end
    end
    % Assuming that the orientations are grouped by location, 
    % and that j = 1 is always inlcuded,
    % j=loc_number
    % 
    % The number of orientations per location varies between files,
    % as well as which locations are included,
    % so without changing the data format of the input files
    % this seemed like the most simple solution.

    theta(i) = rad(loc.N_deg(j),loc.N_min(j),loc.N_sec(j));
    phi(i)   = rad(loc.E_deg(j),loc.E_min(j),loc.E_sec(j));
    
    psi(i)   = rad(ori.p_deg(i),ori.p_min(i),ori.p_sec(i));
    lambda(i)= rad(ori.l_deg(i),ori.l_min(i),ori.l_sec(i));

    [X,Y,Z] = line_eq(theta(i),phi(i),psi(i),lambda(i));
    fplot3(X,Y,Z,[0,500],'Color',clr(j,:),'LineWidth',.5);
end

N1 = find(ori.loc ~= ori.loc(1),1)-1;
N2 = N-N1;

% % copy of intersection_shape() such that the intermediate steps can be plotted:
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% endpoints1 = zeros(N1+1,3);
% endpoints2 = zeros(N2+1,3);
% for i = 1:N1
%     [X,Y,Z] = line_eq(theta(i), phi(i), psi(i), lambda(i));
%     endpoints1(i,:) = [X(500) Y(500) Z(500)];
% end
% for i = 1:N2
%     [X,Y,Z] = line_eq(theta(i+N1), phi(i+N1), psi(i+N1), lambda(i+N1));
%     endpoints2(i,:) = [X(500) Y(500) Z(500)];
% end
% endpoints1(N1+1,:) = [px(theta(1)   , phi(1))    py(theta(1)   , phi(1))    pz(theta(1))];
% endpoints2(N2+1,:) = [px(theta(N1+1), phi(N1+1)) py(theta(N1+1), phi(N1+1)) pz(theta(N1+1))];
% 
% 
% k1 = convhull(endpoints1(:,1), endpoints1(:,2), endpoints1(:,3));
% k2 = convhull(endpoints2(:,1), endpoints2(:,2), endpoints2(:,3));
% % convhull creates a convex polyhedron out of a list of points in 3D,
% % the list of points we use is the endpoints of the lines, + the start pt
% 
% [a,b] = find(k1==N1+1);
% k1 = k1(a,:); % only really need the triangles on the sides, not at the end
% [a,b] = find(k2==N2+1);
% k2 = k2(a,:); % only really need the triangles on the sides, not at the end
% 
% TR1 = triangulation(k1,endpoints1);
% F1 = faceNormal(TR1);
% M1 = size(F1,1);
% TR2 = triangulation(k2,endpoints2);
% F2 = faceNormal(TR2);
% M2 = size(F2,1);
% 
% p1 = endpoints1(N1+1,:);
% p2 = endpoints2(N2+1,:); 
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% shape_pts = zeros((N1+N2)*2,3);
% u = 1;
% for i = 1:N1
%     A = [Ax(theta(i) ,phi(i), psi(i), lambda(i))   Ay(theta(i), phi(i), psi(i), lambda(i))   Az(theta(i), psi(i), lambda(i))];
%     for j = 1:M2
%         d = dot(p2-p1,F2(j,:))/dot(A,F2(j,:));        % solves the equation of dot(V(d),F) = 0 for d
%         % p1+d*A1    is position vector,
%         % p1+d*A1-p2 is direction vector
%         temp = find(dot(repmat(p1-p2+d*A, M2-1, 1), F2(1:end ~=j,:),2) > 0, 1);   % looks for any instances where dot(d*A, F) > 0, excluding index j
%         % size(F2) = (M2,3); so ^ is repeated M2-1 times (~=j) to match size
%         if isempty(temp)
%             % the point that is a distance "d" away from "p1", in the
%             % direction of "A", is in the plane with index j, 
%             % and 'below' the planes with index ~j -> inside triangle j
%             shape_pts(u,:) = p1 + d*A; 
%             u = u+1;
%         end
%     end
% end
% shape_pts = shape_pts(shape_pts(:,1) ~= 0,:); % delete empty values
% scatter3(shape_pts(:,1), shape_pts(:,2), shape_pts(:,3), 20, clr(1,:), "filled");
% shape_pts = zeros((N1+N2)*2,3);
% for i = N1+1:N1+N2
%     A = [Ax(theta(i) ,phi(i), psi(i), lambda(i))   Ay(theta(i), phi(i), psi(i), lambda(i))   Az(theta(i), psi(i), lambda(i))];
%     for j = 1:M1
%         d = dot(p1-p2,F1(j,:))/dot(A,F1(j,:));        % solves the equation of dot(V(d),F) = 0 for d
%         % p2+d*A2    is position vector,
%         % p2+d*A2-p1 is direction vector
%         temp = find(dot(repmat(p2-p1+d*A, M1-1, 1), F1(1:end ~=j,:),2) > 0, 1);   % looks for any instances where dot(d*A, F) > 0, excluding index j
%         % size(F1) = (M1,3); so ^ is repeated M1-1 times (~=j) to match size
%         if isempty(temp)
%             % the point that is a distance "d" away from "p2", in the
%             % direction of "A", is in the plane with index j, 
%             % and 'below' the planes with index ~j -> inside triangle j
%             shape_pts(u,:) = p2 + d*A;
%             u = u+1;
%         end
%     end
% end
% shape_pts = shape_pts(shape_pts(:,1) ~= 0,:); % delete empty values
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% trisurf(k2, endpoints2(:,1), endpoints2(:,2), endpoints2(:,3), "FaceColor", [1 1 0], "FaceAlpha", 1)
% scatter3(shape_pts(:,1), shape_pts(:,2), shape_pts(:,3), 20, clr(6,:), "filled");

shape_pts = intersection_shape(theta, phi, psi, lambda, N1, N2);

K = convhull(shape_pts(:,1), shape_pts(:,2), shape_pts(:,3));
trisurf(K,shape_pts(:,1), shape_pts(:,2), shape_pts(:,3),'FaceAlpha',0.3,'FaceColor',[0 0 1],'LineWidth',.2);

center_pt = centroid_polyhedron(K,shape_pts);

% scatter3(center_pt(1), center_pt(2), center_pt(3),50,[0 0 0],'filled')
% scatter3(shape_pts(:,1), shape_pts(:,2), shape_pts(:,3),20,[0 1 0],'filled');

daspect([1 1 1])
%view([75.7894 10.887]);
view([78.8 10]);
xlim([2400 2900])
ylim([1100 1700])
zlim([5572.2 5900])
xlabel("x (km)")
ylabel("y (km)")
zlabel("z (km)")

%zoom(1.5)

% xlim([2450.774038945304 2890.15478515625]);
% ylim([1116.666666666667,1583.333333333333]);
% zlim([5600,6000]);



% [maj, semi_maj, semi_min] = size_of_shape(shape_pts);
% disp(maj)
% disp(semi_maj)
% disp(semi_min)