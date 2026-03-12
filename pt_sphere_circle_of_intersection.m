function [i_circle_X, i_circle_Y, i_circle_Z, pts_on_c, rays, direction_vectors, L] = pt_sphere_circle_of_intersection(pt, R, pt_loc, N_rays)
% https://math.stackexchange.com/questions/2688081/find-the-equation-of-a-cone-tangent-to-a-sphere

% calculates circle of intersection, given:
% center of sphere: pt
% radius of sphere: R
% point where all the tangent lines come from: pt_loc

D_vec = pt-pt_loc;
D = norm(D_vec);
% D_Ju = norm(pt-Juva_loc);

L = sqrt(D^2 - R^2);
% L_Ju = sqrt(D_Ju^2 - R^2);

% A_Ju = (pt-Juva_loc)./norm(pt-Juva_loc);

r = (D_vec(1)^2 + D_vec(2)^2)^(1/2); % sqrt(x^2 + y^2)
z = D_vec(3);

z1 = r * (z*L - r*R) / (r*L + z*R);

new_pt = pt_loc + [D_vec(1) D_vec(2) z1];

A_D = (    pt-pt_loc)./norm(    pt-pt_loc);
A_L = (new_pt-pt_loc)./norm(new_pt-pt_loc);

P = pt_loc + L .* A_L; % point of intersection of the tangent line to the sphere


r_cone = -A_D; % unit vector pointing from center of sphere to cone tip

% equation of plane:
% dot(r, [x y z]) = dot(r, P)
% r(1) (x-P(1)) + r(2) (y-P(2)) + r(3) (z-P(3)) = 0

% line from cone tip to center: [x y z] = pt + t .* r

% center C, of circle of intersection: 
% dot(r, pt + t.*r) = dot(r,pt) + t * |r|^2 = dot(r,P)
% t_C = [dot(r,P)-dot(r,pt)] / |r|^2
% C = pt + t_C .* r
C = pt + (dot(r_cone,P) - dot(r_cone,pt)) / norm(r_cone)^2 .* r_cone;

s_cone = [1 1 1]; % any random vector which is not in the plane of intersection
v_cone = cross(r_cone,s_cone) / norm(cross(r_cone,s_cone)); % vector 1 in plane
u_cone = cross(r_cone,v_cone) / norm(cross(r_cone,v_cone)); % vector 2 in plane

% circle of intersection equation: [x y z] = C + Rc cos(th) .* u + Rc sin(th) .* v

Rc = norm(P-C); % radius of this circle

i_circle_X = @(th)  C(1) + Rc*cos(th) * u_cone(1) + Rc*sin(th) * v_cone(1);
i_circle_Y = @(th)  C(2) + Rc*cos(th) * u_cone(2) + Rc*sin(th) * v_cone(2);
i_circle_Z = @(th)  C(3) + Rc*cos(th) * u_cone(3) + Rc*sin(th) * v_cone(3);

angles = linspace(2*pi/N_rays, 2*pi, N_rays);
pts_on_c = [i_circle_X(angles); i_circle_Y(angles); i_circle_Z(angles)]';

direction_vectors = zeros(N_rays,3);
rays               = cell(N_rays,3);

for i = 1:N_rays
    direction_vectors(i,:) = (pts_on_c(i,:) - pt_loc) ./ norm(pts_on_c(i,:) - pt_loc);
    rays{i,1} = @(d) pt_loc(1) + d * direction_vectors(i,1);
    rays{i,2} = @(d) pt_loc(2) + d * direction_vectors(i,2);
    rays{i,3} = @(d) pt_loc(3) + d * direction_vectors(i,3);
end

% i_line_X = @(d) pt_loc(1) + d * A_L(1);
% i_line_Y = @(d) pt_loc(2) + d * A_L(2);
% i_line_Z = @(d) pt_loc(3) + d * A_L(3);