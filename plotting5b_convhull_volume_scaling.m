% This program creates a shape out of the intersections of the lines
% most of the calculations for that are done in the function
% "intersection_shape"
% only works with 2 locations at the moment

% close all


loc = readtable("original_locations.csv"); % [Lapua=1, Alajarvi=2, Miekankoski=3]
% [N_deg, N_min, N_sec, E_deg, E_min, E_sec]
ori = readtable("orientations\bulb2-6_22-16.csv");


th1 = rad(65,0,0);
th2 = rad(60,0,0);
ph1 = rad(21,0,0);
ph2 = rad(37,0,0);


image = imread("figures/Maps-65_21-60_37-locs_named.png");
% [N_th, N_ph, a] = size(image);
N_th = 10;
N_ph = 10;

[th,ph] = meshgrid(linspace(th1, th2, N_th), linspace(ph1, ph2, N_ph));
th = th';
ph = ph';

figure; %                        );%
surf(px(th,ph), py(th,ph), pz(th));%, image, "LineStyle", "none");
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
    fplot3(X,Y,Z,[0,500],'Color',clr(j,:),'LineWidth',1.5);
end

N1 = find(ori.loc ~= ori.loc(1),1)-1;
N2 = N-N1;


% trisurf(k1, endpoints1(:,1), endpoints1(:,2), endpoints1(:,3))
% scatter3(shape_pts(:,1), shape_pts(:,2), shape_pts(:,3),20,'filled');

shape_pts = intersection_shape(theta, phi, psi, lambda, N1, N2);

K = convhull(shape_pts(:,1), shape_pts(:,2), shape_pts(:,3));
trisurf(K,shape_pts(:,1), shape_pts(:,2), shape_pts(:,3),'FaceAlpha',0.3,'FaceColor',[0 0 1],'LineWidth',.2);

center_pt = centroid_polyhedron(K,shape_pts);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
center_sphere = center_pt;

theta1 = rad(loc.N_deg(1),loc.N_min(1),loc.N_sec(1));
phi1 =   rad(loc.E_deg(1),loc.E_min(1),loc.E_sec(1));
Lapua_loc = [px(theta1,phi1) py(theta1,phi1) pz(theta1)];

theta6 = rad(loc.N_deg(6),loc.N_min(6),loc.N_sec(6));
phi6 =   rad(loc.E_deg(6),loc.E_min(6),loc.E_sec(6));
Juva_loc = [px(theta6,phi6) py(theta6,phi6) pz(theta6)];

R = 15; % km, initial guess
[i_circle_X1, i_circle_Y1, i_circle_Z1, pts_on_c1, rays1, dir1, L1] = pt_sphere_circle_of_intersection(center_sphere, R, Lapua_loc, N1);
[i_circle_X6, i_circle_Y6, i_circle_Z6, pts_on_c6, rays6, dir6, L6] = pt_sphere_circle_of_intersection(center_sphere, R, Juva_loc , N2);

shape_pts_sphere = intersection_shape_rays(rays1, rays6, dir1, dir6, N1, N2);

Ks = convhull(shape_pts_sphere(:,1), shape_pts_sphere(:,2), shape_pts_sphere(:,3));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
volume        = volume_polyhedron(K,shape_pts);
volume_sphere = volume_polyhedron(Ks,shape_pts_sphere);

volume_ratio = volume/volume_sphere;
R = R * volume_ratio^(1/3);
% you could iterate the above multiple times to get a more accurate value
% for R, but after only 1 rescaling, it's already within 1% accurate

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [i_circle_X1, i_circle_Y1, i_circle_Z1, pts_on_c1, rays1, dir1, L1] = pt_sphere_circle_of_intersection(center_sphere, R, Lapua_loc, N1);
% [i_circle_X6, i_circle_Y6, i_circle_Z6, pts_on_c6, rays6, dir6, L6] = pt_sphere_circle_of_intersection(center_sphere, R, Juva_loc , N2);
% 
% shape_pts_sphere = intersection_shape_rays(rays1, rays6, dir1, dir6, N1, N2);
% 
% Ks = convhull(shape_pts_sphere(:,1), shape_pts_sphere(:,2), shape_pts_sphere(:,3));
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% volume_sphere2 = volume_polyhedron(Ks,shape_pts_sphere);
% 
% volume_ratio2 = volume/volume_sphere2;
% R2 = R * volume_ratio2^(1/3);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

scatter3(center_pt(1), center_pt(2), center_pt(3),50,[0 0 0],'filled')
scatter3(shape_pts(:,1), shape_pts(:,2), shape_pts(:,3),20,[0 1 0],'filled');

daspect([1 1 1])
% view([75.7894 10.887]);
% zoom(1.5)
% xlim([2450.774038945304 2890.15478515625]);
% ylim([1116.666666666667,1583.333333333333]);
% zlim([5600,6000]);

% [maj, semi_maj, semi_min] = size_of_shape(shape_pts);
% disp(maj)
% disp(semi_maj)
% disp(semi_min)