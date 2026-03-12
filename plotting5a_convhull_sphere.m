% This program creates a shape out of the intersections of the lines
% most of the calculations for that are done in the function
% "intersection_shape"
% only works with 2 locations at the moment

% close all


loc = readtable("original_locations.csv"); % [Lapua=1, Alajarvi=2, Miekankoski=3]
% [N_deg, N_min, N_sec, E_deg, E_min, E_sec]



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

% f = figure;
% f.Position = [2000 -100 900 600];
surf(px(th,ph), py(th,ph), pz(th), map_image, "LineStyle", "none");
% plots a section of the Earth's surface
xlabel("x (km)");
ylabel("y (km)");
zlabel("z (km)");
xlim([2200 2900]);
ylim([1100 1800]);
zlim([5500 5900]);
view([111, 11]);
%view([248, 28]);

hold on;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% center_sphere = [2632 1271 5795];
center_sphere = [2541.6 1451.9 5790.6];
% center_sphere = [2317 1683 5817];
R = 20; % km

theta1 = rad(loc.N_deg(1),loc.N_min(1),loc.N_sec(1));
phi1 =   rad(loc.E_deg(1),loc.E_min(1),loc.E_sec(1));
Lapua_loc = [px(theta1,phi1) py(theta1,phi1) pz(theta1)];

theta6 = rad(loc.N_deg(6),loc.N_min(6),loc.N_sec(6));
phi6 =   rad(loc.E_deg(6),loc.E_min(6),loc.E_sec(6));
Juva_loc = [px(theta6,phi6) py(theta6,phi6) pz(theta6)];

N_rays = 10;
[i_circle_X1, i_circle_Y1, i_circle_Z1, pts_on_c1, rays1, dir1, L1] = pt_sphere_circle_of_intersection(center_sphere, R, Lapua_loc, N_rays);
[i_circle_X6, i_circle_Y6, i_circle_Z6, pts_on_c6, rays6, dir6, L6] = pt_sphere_circle_of_intersection(center_sphere, R, Juva_loc , N_rays);


[theta,phi] = meshgrid(linspace(-pi/2, pi/2, 30), linspace(0, 2*pi, 60));

surf(center_sphere(1) + R * cos(theta).*cos(phi),...
     center_sphere(2) + R * cos(theta).*sin(phi),...
     center_sphere(3) + R * sin(theta),'FaceAlpha',0.5,'FaceColor',[0 0 1],'LineStyle','none');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

shape_pts = intersection_shape_rays(rays1, rays6, dir1, dir6, N_rays, N_rays);

K = convhull(shape_pts(:,1), shape_pts(:,2), shape_pts(:,3));
trisurf(K,shape_pts(:,1), shape_pts(:,2), shape_pts(:,3),'FaceAlpha',0.2,'FaceColor',[1 0 0],'LineStyle','none');

center_polyhedron = centroid_polyhedron(K,shape_pts);

scatter3(center_polyhedron(1), center_polyhedron(2), center_polyhedron(3),50,[1 0 0],'filled')
scatter3(center_sphere(1),     center_sphere(2),     center_sphere(3),    50,[0 1 0],'filled')
%scatter3(shape_pts(:,1), shape_pts(:,2), shape_pts(:,3));

daspect([1 1 1])

% [maj, semi_maj, semi_min] = size_of_shape(shape_pts);
% disp(maj)
% disp(semi_maj)
% disp(semi_min)