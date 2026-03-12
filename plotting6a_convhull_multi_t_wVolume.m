% This program creates a shape out of the intersections of the lines
% most of the calculations for that are done in the function
% "intersection_shape"
% only works with 2 locations at the moment

% for multiple timesteps

% close all
% clear ori
% clc

loc = readtable("original_locations.csv");
% [N_deg, N_min, N_sec, E_deg, E_min, E_sec]


% % 8_05 - 10_39 ; Lapua-Juva ; bulb2,stick2
% ori{1} = readtable("orientations\bulb2-8_06-16.csv");
% ori{2} = readtable("orientations\stick2-8_05-16.csv");
% ori{3} = readtable("orientations\bulb2-8_23-16.csv");
% ori{4} = readtable("orientations\stick2-8_23-16.csv");
% ori{5} = readtable("orientations\bulb2-8_40-16.csv");
% ori{6} = readtable("orientations\stick2-8_39-16.csv");
% ori{7} = readtable("orientations\bulb2-8_57-16.csv");
% ori{8} = readtable("orientations\stick2-8_56-16.csv");
% ori{9} = readtable("orientations\bulb2-9_14-16.csv");
% ori{10} = readtable("orientations\stick2-9_14-16.csv");
% ori{11} = readtable("orientations\bulb2-9_31-16.csv");
% ori{12} = readtable("orientations\stick2-9_32-16.csv");
% ori{13} = readtable("orientations\bulb2-9_48-16.csv");
% ori{14} = readtable("orientations\stick2-9_48-16.csv");
% ori{15} = readtable("orientations\bulb2-10_05-16.csv");
% ori{16} = readtable("orientations\stick2-10_05-16.csv");
% ori{17} = readtable("orientations\bulb2-10_22-16.csv");
% ori{18} = readtable("orientations\stick2-10_22-16.csv");
% ori{19} = readtable("orientations\bulb2-10_39-16.csv");
% ori{20} = readtable("orientations\stick2-10_39-16.csv");
% dt = [0 17 0 17 0 17 0 17 0 17 0 17 0 17 0 17 0 17 0];
% T = 20;
% clr = [1 0 0;   1 0 0;   0 1 0;    0 1 0;    0 0 1;   0 0 1;...
%        .8 .2 0; .8 .2 0; 0 .8 .2; 0 .8 .2; .2 0 .8; .2 0 .8;...
%        .6 .4 0; .6 .4 0; 0 .6 .4; 0 .6 .4; .4 0 .6; .4 0 .6; .6 .6 .6; .6 .6 .6; ];
% line_names = [""; "8:06"; ""; "8:23"; ""; "8:40"; ""; "8:57"; ""; "9:14"; "";...
%                   "9:32"; ""; "9:48"; ""; "10:05"; ""; "10:22"; "";"10:39"; "";];

% % % 5_33 - 10_39 ; Lapua-Juva ; bulb2
% ori{1} = readtable("orientations\bulb2-5_33-16.csv");
% ori{2} = readtable("orientations\bulb2-5_50-16.csv");
% ori{3} = readtable("orientations\bulb2-6_07-16.csv");
% ori{4} = readtable("orientations\bulb2-6_24-16.csv");
% ori{5} = readtable("orientations\bulb2-6_41-16.csv");
% ori{6} = readtable("orientations\bulb2-6_58-16.csv");
% ori{7} = readtable("orientations\bulb2-7_15-16.csv");
% 
% ori{8} = readtable("orientations\bulb2-7_32-16.csv");
% ori{9} = readtable("orientations\bulb2-7_49-16.csv");
% ori{10} = readtable("orientations\bulb2-8_06-16.csv");
% ori{11} = readtable("orientations\bulb2-8_23-16.csv");
% ori{12} = readtable("orientations\bulb2-8_40-16.csv");
% ori{13} = readtable("orientations\bulb2-8_57-16.csv");
% 
% ori{14} = readtable("orientations\bulb2-9_14-16.csv");
% ori{15} = readtable("orientations\bulb2-9_31-16.csv");
% ori{16} = readtable("orientations\bulb2-9_48-16.csv");
% ori{17} = readtable("orientations\bulb2-10_05-16.csv");
% ori{18} = readtable("orientations\bulb2-10_22-16.csv");
% ori{19} = readtable("orientations\bulb2-10_39-16.csv");
% T = 19;
% dt = ones(T-1,1)*17;
% clr_line = [0 0 1]; % consistent with plotting8


% % % 5_33 - 10_39 ; Lapua-Juva ; bulb3
% ori{1} = readtable("orientations\bulb3-5_33-16.csv");
% ori{2} = readtable("orientations\bulb3-5_50-16.csv");
% ori{3} = readtable("orientations\bulb3-6_07-16.csv");
% ori{4} = readtable("orientations\bulb3-6_24-16.csv");
% ori{5} = readtable("orientations\bulb3-6_41-16.csv");
% ori{6} = readtable("orientations\bulb3-6_58-16.csv");
% ori{7} = readtable("orientations\bulb3-7_15-16.csv");
% 
% ori{8} = readtable("orientations\bulb3-7_32-16.csv");
% ori{9} = readtable("orientations\bulb3-7_49-16.csv");
% ori{10} = readtable("orientations\bulb3-8_06-16.csv");
% ori{11} = readtable("orientations\bulb3-8_23-16.csv");
% ori{12} = readtable("orientations\bulb3-8_40-16.csv");
% ori{13} = readtable("orientations\bulb3-8_57-16.csv");
% 
% ori{14} = readtable("orientations\bulb3-9_14-16.csv");
% ori{15} = readtable("orientations\bulb3-9_31-16.csv");
% ori{16} = readtable("orientations\bulb3-9_48-16.csv");
% ori{17} = readtable("orientations\bulb3-10_05-16.csv");
% ori{18} = readtable("orientations\bulb3-10_22-16.csv");
% ori{19} = readtable("orientations\bulb3-10_39-16.csv");
% T = 19;
% dt = ones(T-1,1)*17;
% clr_line = [0 1 0]; % consistent with plotting8

t_start_utc     = datetime(2025,4,3,21,5,33);
t_end_utc       = datetime(2025,4,3,21,10,39);
t_utc           = t_start_utc:seconds(17):t_end_utc;
t_start_utc_2   = datetime(2025,4,3,21,5, 33+17/2);
t_end_utc_2     = datetime(2025,4,3,21,10,39-17/2);
t_utc_2         = t_start_utc_2:seconds(17):t_end_utc_2;

line_names = [""; "5:33"; "5:50"; "6:07"; "6:24"; "6:41"; "6:58"; "7:15"; ...
                  "7:32"; "7:49"; "8:06"; "8:23"; "8:40"; "8:57"; ...
                  "9:14"; "9:31"; "9:48"; "10:05"; "10:22"; "10:39"];

% % contrast coloring
% clr = [1 0 0;   0 1 0;    0 0 1;...
%        .8 .2 0; 0 .8 .2; .2 0 .8;...
%        .6 .4 0; 0 .6 .4; .4 0 .6; .6 .6 .6; ...
%        1 0 0;   0 1 0;    0 0 1;...
%        .8 .2 0; 0 .8 .2; .2 0 .8;...
%        .6 .4 0; 0 .6 .4; .4 0 .6;];

% gradient coloring
clr = [1 0 0; .8 .2 0; .6 .4 0; .4 .6 0; .2 .8 0; ...
       0 1 0; 0 .8 .2; 0 .6 .4; 0 .4 .6; 0 .2 .8; ...   
       0 0 1; .2 0 .8; .4 0 .6; .6 0 .4; .8 0 .2; ...
       1 0 0; .8 .2 0; .6 .4 0; .4 .6 0;];


th1 = rad(65,0,0);
th2 = rad(60,0,0);
ph1 = rad(21,0,0);
ph2 = rad(37,0,0);


map_image = imread("figures/Maps-65_21-60_37-locs_named.png");
[N_th, N_ph, temp] = size(map_image);


% Mercator correction
y1 = iGd(th1);
y2 = iGd(th2);
y_grid = linspace(y1, y2, N_th);

theta_grid = Gd(y_grid);

[th,ph] = meshgrid(theta_grid, linspace(ph1, ph2, N_ph));
th = th';
ph = ph';

f = figure;
f.Position = [2000 -100 900 600];
surf(px(th,ph), py(th,ph), pz(th), map_image, "LineStyle", "none");
% plots a section of the Earth's surface
xlabel("x (km)");
ylabel("y (km)");
zlabel("z (km)");
xlim([2300 2900]);
ylim([1100 1800]);
zlim([5500 5900]);
view([111, 11]);
%view([248, 28]);

hold on;

Nl = 7;                 % number of locations


center_pt               = zeros(T,3);
theta_pt                = zeros(T,1);
phi_pt                  = zeros(T,1);

theta_shape                = zeros(T,50);
phi_shape                  = zeros(T,50);

volume_shape            = zeros(T,1);
heights                 = zeros(T,1);
displacements           = zeros(T-1,3);
distances               = zeros(T-1,1);
parallel_distances      = zeros(T-1,1);

speeds                  = zeros(T-1,1);
parallel_speeds         = zeros(T-1,1);

%%%%%%%%%%%%%%%%%%%

displacements2           = zeros(T-2,3);
distances2               = zeros(T-2,1);
parallel_distances2      = zeros(T-2,1);

speeds2                  = zeros(T-2,1);
parallel_speeds2         = zeros(T-2,1);

%%%%%%%%%%%%%%%%%%%

error_position          = zeros(T,1);
error_distances         = zeros(T-1,1);
error_speeds            = zeros(T-1,1);
error_theta             = zeros(T,1);
error_phi               = zeros(T,1);

sigma_degrees           = .5; 
sigma_seconds           = 2;


theta1 = rad(loc.N_deg(1),loc.N_min(1),loc.N_sec(1));
phi1 =   rad(loc.E_deg(1),loc.E_min(1),loc.E_sec(1));
Lapua_loc = [px(theta1,phi1) py(theta1,phi1) pz(theta1)];

theta6 = rad(loc.N_deg(6),loc.N_min(6),loc.N_sec(6));
phi6 =   rad(loc.E_deg(6),loc.E_min(6),loc.E_sec(6));
Juva_loc = [px(theta6,phi6) py(theta6,phi6) pz(theta6)];


for t = (1:T)
    j = 1;
    N = size(ori{t},1);             % number of orientations
    dist = 1e6*ones(N,3);

    theta = zeros(N,1);
    phi   = zeros(N,1);
    psi   = zeros(N,1);
    lambda= zeros(N,1);

    for i = (1:N)

        for l = (2:Nl)
            if i == find(ori{t}.loc == l,1)
                j = l;
            end
        end
        % assuming that the orientations are grouped by location, j=loc_number
        
        theta(i) = rad(loc.N_deg(j),loc.N_min(j),loc.N_sec(j));
        phi(i)   = rad(loc.E_deg(j),loc.E_min(j),loc.E_sec(j));
    
        psi(i)   = rad(ori{t}.p_deg(i),ori{t}.p_min(i),ori{t}.p_sec(i));
        lambda(i)= rad(ori{t}.l_deg(i),ori{t}.l_min(i),ori{t}.l_sec(i));
    end
    N1 = find(ori{t}.loc ~= ori{t}.loc(1),1)-1;
    N2 = N-N1;

    shape_pts = intersection_shape(theta, phi, psi, lambda, N1, N2);
    N_pts_shape = size(shape_pts,1);

    K = convhull(shape_pts(:,1), shape_pts(:,2), shape_pts(:,3));
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    trisurf(K,shape_pts(:,1), shape_pts(:,2), shape_pts(:,3),'FaceAlpha',0.1,'FaceColor',clr(t,:),'LineStyle','none');
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    center_pt(t,:) = centroid_polyhedron(K,shape_pts); % mean(shape_pts,1);
    volume_convhull = volume_polyhedron(K,shape_pts);
    volume_shape(t) = calculate_volume_shape(center_pt(t,:), volume_convhull, Lapua_loc, Juva_loc, N1, N2);
    
    x = center_pt(t,1);
    y = center_pt(t,2);
    z = center_pt(t,3);
    r = norm(squeeze(center_pt(t,:)));
    
    %                     ori{t}.bulb_number(i)
    % scatter3(x, y, z, 20, clr(i,:), 'filled');
    
    theta_pt(t) = asind(z/r);
    phi_pt(t)   = atand(y/x);  % [x>0]

    X = shape_pts(:,1);
    Y = shape_pts(:,2);
    Z = shape_pts(:,3);
    R = vecnorm(shape_pts(:,:),2,2);
    theta_shape(t,1:N_pts_shape) = asind(Z./R);
    phi_shape(t,1:N_pts_shape)   = atand(Y./X);

    R_E = 6371;

    heights(t) = ( center_pt(t,1)^2 + center_pt(t,2)^2 + center_pt(t,3)^2 ) ^ (1/2) - R_E;
    
    error_position(t) = norm(Lapua_loc-center_pt(t,:)) * sind(sigma_degrees);
    
    % error_{A/B} = A/B * ( (error_A / A)^2 + (error_A / B)^2 )^(1/2)
    error_z_div_r = z/r * ( (error_position(t)/z)^2 + (error_position(t)/r)^2 )^(1/2);
    error_y_div_x = y/x * ( (error_position(t)/y)^2 + (error_position(t)/x)^2 )^(1/2);

    % error of arcsin(x) = error_x / (1 - x^2)^(1/2);
    error_theta(t) = error_z_div_r / (1 - (z/r)^2);
    % error of arctan(x) = error_x / (1 + x^2);
    error_phi(t) = error_y_div_x / (1 + (y/x)^2);
    

    if t ~= 1
        displacements(t-1,:) = center_pt(t,:)-center_pt(t-1,:);
        distances(t-1) = norm(displacements(t-1,:));
        speeds(t-1) = distances(t-1)/dt(t-1);

        error_distances(t-1) = norm(Lapua_loc - center_pt(t,:)) * sind(sigma_degrees);
        
        % v = x/t -> σ_v = |v|* sqrt[ (σ_x/x)^2 + (σ_t/t)^2 - 2*σ_xt/x*t ]
        % σ_xt = 0 (covariance between distance & time)
        
        error_speeds(t-1) = norm(speeds(t-1)) * ((error_distances(t-1)/distances(t-1))^2 + (sigma_seconds/dt(t-1))^2 )^(1/2);
        
        if t ~= 2
            displacements2(t-2,:) = center_pt(t,:)-center_pt(t-2,:);
            distances2(t-2) = norm(displacements2(t-2,:));
            speeds2(t-2) = distances2(t-2)/(2*dt(t-2));
        end
    end
end
total_displacement = center_pt(T,:) - center_pt(1,:);   % vector
total_distance = norm(total_displacement);              % scalar
Dt = sum(dt);                               % total time elapsed
h_dt = Dt/(2*(T-1));                         % half of averaged dt

for t = 1:T-1
    parallel_distances(t) = dot(displacements(t,:), total_displacement) / total_distance;
    parallel_speeds(t)    = parallel_distances(t)/dt(t);
    if t~=T-1
        parallel_distances2(t) = dot(displacements2(t,:), total_displacement) / total_distance;
        parallel_speeds2(t)    = parallel_distances2(t)/(2*dt(t));
    end
end

avg_heights              = mean(heights);
avg_error_position       = mean(error_position);

avg_parallel_speeds      = mean(parallel_speeds);
avg_error_speeds         = mean(error_speeds);

avg_volume_shape         = mean(volume_shape);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
scatter3(center_pt(:,1), center_pt(:,2), center_pt(:,3),20,clr,'filled');
daspect([1 1 1])
legend(line_names, "Position", [0.848,0.357,0.09,0.528]);

hold off;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

t_start_utc     = datetime(2025,4,3,21,5,33);
t_end_utc       = datetime(2025,4,3,21,10,39);
t_utc           = t_start_utc:seconds(17):t_end_utc;
t_start_utc_2   = datetime(2025,4,3,21,5, 33+17/2);
t_end_utc_2     = datetime(2025,4,3,21,10,39-17/2);
t_utc_2         = t_start_utc_2:seconds(17):t_end_utc_2;

x = t_utc; % linspace(0, Dt, T);
y = heights;
xconf = [x x(end:-1:1)];         
yconf = [y+error_position; y(end:-1:1)-error_position(end:-1:1)]';

linecolor = [1 0.8 0.8];

figure;
hold on;
fill(xconf,yconf, clr_line, 'FaceAlpha', .5, 'EdgeColor', 'none');
plot(x, y, 'LineWidth', 2, 'LineStyle','-' , 'Color', clr_line);
ymax = ceil(max(yconf)/20)*20;
ylim([0, ymax]);

xlabel("time (UTC)")
ylabel("altitude (km)")
grid on;
hold off;

% line_names1 = cat(1,line_names1,"shapes2");
% legend(line_names1, "Location", "southeast")

figure;
hold on
yyaxis left
plot(x, volume_shape, "Color", clr_line, "LineWidth", 1, 'LineStyle', '-');
%ymax = max(ceil(volume_shape/1000)*1000);
ymax = 20000;
ylim([0 ymax])
ylabel("Volume of bead (km^3)")
xlabel("time (UTC)")

yyaxis right
ylabel("Equivalent sphere radius (km)");
Rmax = (ymax *3/4) ^ (1/3);
ylim([0 Rmax]);
grid on;
hold off;

figure;
hold on;
x = t_utc_2; % linspace(h_dt, Dt-h_dt, T-1);

y = parallel_speeds';
yerr = error_speeds';

xconf = [x x(end:-1:1)];
yconf = [y+yerr y(end:-1:1)-yerr(end:-1:1)];

fill(xconf, yconf, clr_line, "FaceAlpha", .5, "EdgeColor","none");
plot(x, y, 'LineWidth', 2, "Color", clr_line);    

xmin = datetime(2025,4,3,21,5,0);
xmax = datetime(2025,4,3,21,11,0);
plot([xmin xmax],[0 0],"Color",[0 0 0]); % horzontal black line at y=0
ylim([-1 3]);
xlabel("time (UTC)")
ylabel("parallel speed (km/s)")
grid on;
hold off;



f = figure;
f.Position = [2.6 41.8 1200 750];
hold on;

% with Mercator scaling correction:
surf(ph .*180./pi, th .*180./pi, zeros(size(th)), map_image, "LineStyle", "none")
view(2);

line_names3 = strings(1,1);

for t = 1:T
    thetas = theta_shape(t,(theta_shape(t,:) ~= 0));
    phis   =   phi_shape(t,(  phi_shape(t,:) ~= 0));
    k = convhull(thetas,phis);
    fill(phis(k),thetas(k),clr(t,:), "FaceAlpha", .2);
    line_names3 = cat(1,line_names3,"");
end

for t = 1:T-1
    A = [  phi_pt(t)-error_phi(t)     phi_pt(t)-error_phi(t)     phi_pt(t+1)+error_phi(t+1)      phi_pt(t+1)+error_phi(t+1) ];
    B = [theta_pt(t)-error_theta(t) theta_pt(t)+error_theta(t) theta_pt(t+1)+error_theta(t+1)  theta_pt(t+1)-error_theta(t+1)];

    fill(A, B, clr_line, "FaceAlpha", .2, "EdgeColor","none");
    line_names3 = cat(1,line_names3,"");
end
plot(phi_pt,theta_pt, "Color", clr_line, "LineWidth", 1.5);
line_names3 = cat(1,line_names3,"4");




xlabel("Longitude");
ylabel("Latitude");
xlim([21 37])
ylim([60 65])

%legend(line_names3, 'FontSize', 16)
% hold off;

parallel_speeds = cat(1,parallel_speeds,0);
error_speeds = cat(1,error_speeds,0);
variables = table(heights, error_position, parallel_speeds, error_speeds, volume_shape);
writetable(variables,"bead4_shapes.csv")