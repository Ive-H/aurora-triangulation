close all

pt = [2541.6 1451.9 5790.6];
% pt = [2503.4 1537.9 5785.4];

R = 150; % radius (km)

loc = readtable("original_locations.csv");
theta1 = rad(loc.N_deg(1),loc.N_min(1),loc.N_sec(1));
phi1 =   rad(loc.E_deg(1),loc.E_min(1),loc.E_sec(1));
Lapua_loc = [px(theta1,phi1) py(theta1,phi1) pz(theta1)];

% theta6 = rad(loc.N_deg(6),loc.N_min(6),loc.N_sec(6));
% phi6 =   rad(loc.E_deg(6),loc.E_min(6),loc.E_sec(6));
% Juva_loc = [px(theta6,phi6) py(theta6,phi6) pz(theta6)];

N_rays = 10;
[i_circle_X, i_circle_Y, i_circle_Z, pts_on_c, rays, A, L] = pt_sphere_circle_of_intersection(pt, R, Lapua_loc, N_rays);


% plotting the test sphere itself, with center: "pt" & radius: "R"
% pt(1) + R * cos(theta).*cos(phi); 
% pt(2) + R * cos(theta).*sin(phi);
% pt(3) + R * sin(theta);
% theta in [-pi/2, pi/2], phi in [0, 2pi]


[theta,phi] = meshgrid(linspace(-pi/2, pi/2, 30), linspace(0, 2*pi, 60));

figure;
surf(pt(1) + R * cos(theta).*cos(phi),...
     pt(2) + R * cos(theta).*sin(phi),...
     pt(3) + R * sin(theta),'FaceAlpha',0.2,'LineStyle','none');

hold on;

%fplot3(i_line_X, i_line_Y, i_line_Z, [0,L]);
fplot3(i_circle_X, i_circle_Y, i_circle_Z, [0,2*pi]);
scatter3(pts_on_c(:,1), pts_on_c(:,2), pts_on_c(:,3));
scatter3(Lapua_loc(1), Lapua_loc(2), Lapua_loc(3));
for i = 1:N_rays
    fplot3(rays{i,1}, rays{i,2}, rays{i,3}, [0,L]);
end

daspect([1 1 1])
% v1(D,θ,φ) -> v2(L,θ,φ,α)