% This program is mostly unused, besides in timelapse_plot.m
% it's also not much different from plotting6

% This program creates a shape out of the intersections of the lines
% most of the calculations for that are done in the function
% "intersection_shape"
% only works with 2 locations at the moment

% for multiple timesteps
% and multiple shapes

% close all
% clear ori
% clc

% loc = readtable("original_locations.csv");
% [N_deg, N_min, N_sec, E_deg, E_min, E_sec]

% % Lapua-Juva (all-sky cam)
% ori{1} = readtable("orientations\bulb2-5_33-16.csv");
% ori{2} = readtable("orientations\bulb2-6_07-16.csv");
% ori{3} = readtable("orientations\bulb2-6_41-16.csv");
% ori{4} = readtable("orientations\bulb2a-6_41-16.csv");
% ori{5} = readtable("orientations\bulb2-7_15-16.csv");
% ori{6} = readtable("orientations\bulb2a-7_15-16.csv");
% T = 6;
% dt = [34 34 0 34 0];
% clr = [1 0 0; .5 .5 0; 0 1 0; 0 1 0; 0 .5 .5;  0 .5 .5]; 
% line_names = [""; "5:33"; "6:07"; "6:41"; ""; "7:15"; ""];



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
% n_shapes = 2;
% T = 10;
% dt = ones(T-1,1)*17;
% clr = [1 0 0;   0 1 0;    0 0 1;...
%        .8 .2 0; 0 .8 .2; .2 0 .8;...
%        .6 .4 0; 0 .6 .4; .4 0 .6; .6 .6 .6;];
% time_labels = [""; "8:06"; "8:23"; "8:40"; "8:57"; "9:14"; ...
%                   "9:32"; "9:48"; "10:05"; "10:22"; "10:39"; ...
%                   ""; ""; ""; ""; ""; ""; ""; ""; ""; ""];


% % all 6 locations
% ori{1} = readtable("orientations/bulb2-7_32-16.csv");
% ori{2} = readtable("orientations/bulb2-7_42.csv");
% ori{3} = readtable("orientations/bulb2-8_10.csv");
% ori{4} = readtable("orientations/bulb2-8_17-13.csv");
% ori{5} = readtable("orientations/bulb2-8_43.csv");
% ori{6} = readtable("orientations/bulb2-9_07-14.csv");
% ori{7} = readtable("orientations/bulb2-9_14.csv");
% % [loc, p_deg, p_min, p_sec, l_deg, l_min, l_sec]
% T = 7;
% % dt = [7, 28, 7, 26, 24, 7, 23]; % time difference between each ori{n}
% clr = [1 0 0; .5 .5 0; 0 1 0; 0 .5 .5; 0 0 1; .5 0 .5; .5 .5 .5; 0 0 0];    % line color per time
% n_shapes = 1;
  

% % all shapes ; 8:17 ; Lapua-Miekankoski
% ori{1} = readtable("orientations\bulb2-8_17-13.csv");
% ori{2} = readtable("orientations\stick2-8_17-13.csv");
% ori{3} = readtable("orientations\bulb3-8_17-13.csv");
% ori{4} = readtable("orientations\stick3-8_17-13.csv");
% %ori{5} = readtable("orientations\bulb4-8_17-13.csv");
% ori{5} = readtable("orientations\stick4-8_17-13.csv");
% ori{6} = readtable("orientations\bulb4a-8_17-13.csv");
% ori{7} = readtable("orientations\bulb4b-8_17-13.csv");
% ori{8} = readtable("orientations\bulb4c-8_17-13.csv");
% ori{9} = readtable("orientations\bulb4d-8_17-13.csv");
% n_shapes = 1;
% 
% % ori{7} = readtable("orientations\bulb4-8_17-16.csv");
% % ori{8} = readtable("orientations\stick4-8_17-16.csv");
% % ori{9} = readtable("orientations\bulb4-8_17-36.csv");
% % ori{10} = readtable("orientations\stick4-8_17-36.csv");
% T = 9;
% clr = [1 0 0; .5 0 0; 0 1 0; 0 .5 0; 0 0 .5;  .4 0 1;  0 .4 1;  .3 .3 1;  .6 .6 1; ];
% line_names = [""; "b2"; "s2"; "b3"; "s3"; "s4-13"; "b4a-13"; "b4b-13"; "b4c-13"; "b4d-13"]; %"b4-16"; "s4-16"];% "b4-36"; "s4-36";];
% dt = [1 1 1 1 1 1 1 1];





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
f.Position = [150 150 900 600];
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


center_pt           = zeros(n_shapes,T,3);
theta_pt            = zeros(n_shapes,T);
phi_pt              = zeros(n_shapes,T);
heights             = zeros(n_shapes,T);
displacements       = zeros(n_shapes,T-1,3);
distances           = zeros(n_shapes,T-1);
parallel_distances  = zeros(n_shapes,T-1);
speeds              = zeros(n_shapes,T-1);
parallel_speeds     = zeros(n_shapes,T-1);

total_displacement  = zeros(n_shapes,3);
total_distance      = zeros(n_shapes,1);

for s = 1:n_shapes
    real_time = datetime(2025,4,3,21,8,6,'TimeZone','UTC');
    for t = 1:T
        n = (t-1)*n_shapes + s; % ori{n} index 
        % n = [1,3,5, ... (T-1)*n_shapes  + s , 2,4, ... T*(n_shapes-1) + s]

        disp("n")
        disp(n)

        j = 1;
        N = size(ori{n},1);             % number of orientations
        dist = 1e6*ones(N,3);
    
        theta = zeros(N,1);
        phi   = zeros(N,1);
        psi   = zeros(N,1);
        lambda= zeros(N,1);
    
        for i = (1:N)
    
            for l = (2:Nl)
                if i == find(ori{n}.loc == l,1)
                    j = l;
                end
            end
            % assuming that the orientations are grouped by location, j=loc_number
            
            theta(i) = rad(loc.N_deg(j),loc.N_min(j),loc.N_sec(j));
            phi(i)   = rad(loc.E_deg(j),loc.E_min(j),loc.E_sec(j));
        
            psi(i)   = rad(ori{n}.p_deg(i),ori{n}.p_min(i),ori{n}.p_sec(i));
            lambda(i)= rad(ori{n}.l_deg(i),ori{n}.l_min(i),ori{n}.l_sec(i));
        end
        N1 = find(ori{n}.loc ~= ori{n}.loc(1),1)-1;
        N2 = N-N1;
    
        shape_pts = intersection_shape(theta, phi, psi, lambda, N1, N2);
    
        K = convhull(shape_pts(:,1), shape_pts(:,2), shape_pts(:,3));
        
        trisurf(K, shape_pts(:,1), shape_pts(:,2), shape_pts(:,3),'FaceAlpha',0.2,'FaceColor',clr(t,:),'LineStyle','none');
        
        center_pt(s,t,:) = centroid_polyhedron(K,shape_pts); % mean(shape_pts,1);
        scatter3(center_pt(s,t,1), center_pt(s,t,2), center_pt(s,t,3), 20, [1 0 0]);
        
        
        theta_pt(s,t) = asind( center_pt(s,t,3) / norm(squeeze(center_pt(s,t,:))) );    % arcsin(z/r) 
        phi_pt(s,t) = atand( center_pt(s,t,2) / center_pt(s,t,1) );                     % arctan(y/x) [x>0]
        
        
        R_E = 6371;
        heights(s,t) = ( center_pt(s,t,1)^2 + center_pt(s,t,2)^2 + center_pt(s,t,3)^2 ) ^ (1/2) - R_E;
        
        if t ~= 1
            displacements(s,t-1,:) = center_pt(s,t,:)-center_pt(s,t-1,:);
            distances(s,t-1) = norm(squeeze(displacements(s,t-1,:)));
            speeds(s,t-1) = distances(s,t-1)/dt(t-1);
            real_time = real_time + dt(t-1)/86400;
        end
    end
    total_displacement(s,:) = center_pt(s,T,:) - center_pt(s,1,:);   % vector
    total_distance(s) = norm(total_displacement(s,:));               % scalar
    
    for t = 1:T-1
        parallel_distances(s,t,:) = dot(squeeze(displacements(s,t,:)), total_displacement(s,:)) / total_distance(s);
        parallel_speeds(s,t)      = parallel_distances(s,t)/dt(t);
    end

    % scatter3(center_pt(s,:,1), center_pt(s,:,2), center_pt(s,:,3),20,clr(t,:),'filled');
end
Dt = sum(dt);                                % total time elapsed
h_dt = Dt/(2*(T-1));                         % half of averaged dt

daspect([1 1 1])
% legend(time_labels);

% hold off;

% line_names1 = strings(1,1);
% line_names2 = strings(1,1);
% 
% figure;
% subplot(2,1,1);
% hold on;
% 
% for s = 1:n_shapes
%     plot(linspace(0, 	Dt,      T),   heights(s,:), ...
%          linspace(h_dt, Dt-h_dt, T-1), distances(s,:), ...
%          linspace(h_dt, Dt-h_dt, T-1), parallel_distances(s,:));
% 
%     line_names1 = cat(1,line_names1,["heights"+int2str(s); "distances"+int2str(s); "||-distances"+int2str(s)]);
% end
% line_names1 = line_names1(2:size(line_names1,1)); % delete the empty string at the start
% xmax = ceil(Dt/20)*20;
% xlim([0 xmax]);
% ylabel("km")
% legend(line_names1);
% hold off;
% 
% 
% subplot(2,1,2); 
% hold on;
% for s = 1:n_shapes
%     plot(linspace(h_dt, Dt-h_dt, T-1), speeds(s,:), ...
%          linspace(h_dt, Dt-h_dt, T-1), parallel_speeds(s,:));
% 
%     line_names2 = cat(1,line_names2,["speeds"+int2str(s); "||-speeds"+int2str(s)]);
% end
% line_names2 = line_names2(2:size(line_names2,1)); % delete the empty string at the start
% xlim([0 xmax]);
% xlabel("time passed (s)")
% ylabel("km/s")
% legend(line_names2);
% hold off;
% 
% 
% figure;
% subplot(2,1,1);
% hold on;
% 
% for s = 1:n_shapes
%     plot(phi_pt(s,:),theta_pt(s,:));
% end
% xlabel("Longitude");
% ylabel("Latitude");
% 
% hold off;
% 
% 
% subplot(2,1,2); 
% hold on;
% 
% for s = 1:n_shapes
%     plot(MLT(s,:),theta_mag(s,:));
% end
% xlabel("MLT");
% ylabel("Magnetic Latitude");
% hold off;