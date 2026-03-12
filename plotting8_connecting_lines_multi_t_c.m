% This program calculates the "closest_pt" connecting lines,
% and plots the midpoint of each connecting line,
% for each timestep.

clear ori
% close all
% clc

loc = readtable("original_locations.csv"); % [Lapua=1, Alajarvi=2, Miekankoski=3, Uurainen=4, Hankasalmi=5, Juva=6]
% [N_deg, N_min, N_sec, E_deg, E_min, E_sec]

% ori{1} = readtable("orientations/bulb_centers/5_33-16.csv");   % 1,2,3,4, ,6
% ori{2} = readtable("orientations/bulb_centers/7_32-16.csv");   % 1,2,3,4,5,6,7
% ori{3} = readtable("orientations/bulb_centers/10_39-16.csv");  % 1,2, ,4, ,6
% T = 3;
% start_idx = [  1,  1,  1,  1,  2,  1,  2];
% end_idx   = [  3,  3,  2,  3,  2,  3,  2];
% n_shapes = 7;
% clr = [1 0 0; 0 1 0; 0 0 1;];

ori{1} = readtable("orientations/bulb_centers/5_33-16.csv");   % 1,2,3,4, ,6
ori{2} = readtable("orientations/bulb_centers/5_50-16.csv");   % 1,2,3,4, ,6
ori{3} = readtable("orientations/bulb_centers/6_07-16.csv");   % 1,2,3,4, ,6,7
ori{4} = readtable("orientations/bulb_centers/6_24-16.csv");   % 1,2,3,4,5,6,7
ori{5} = readtable("orientations/bulb_centers/6_41-16.csv");   % 1,2,3,4,5,6,7
ori{6} = readtable("orientations/bulb_centers/6_58-16.csv");   % 1,2,3,4,5,6,7
ori{7} = readtable("orientations/bulb_centers/7_15-16.csv");   % 1,2,3,4,5,6,7
ori{8} = readtable("orientations/bulb_centers/7_32-16.csv");   % 1,2,3,4,5,6,7
ori{9} = readtable("orientations/bulb_centers/7_49-16.csv");   % 1,2, ,4,5,6,7
ori{10} = readtable("orientations/bulb_centers/8_06-16.csv");  % 1,2, ,4, ,6,7
ori{11} = readtable("orientations/bulb_centers/8_23-16.csv");  % 1,2, ,4, ,6,7
ori{12} = readtable("orientations/bulb_centers/8_40-16.csv");  % 1,2, ,4, ,6
ori{13} = readtable("orientations/bulb_centers/8_57-16.csv");  % 1,2, ,4, ,6
ori{14} = readtable("orientations/bulb_centers/9_14-16.csv");  % 1,2, ,4, ,6
ori{15} = readtable("orientations/bulb_centers/9_31-16.csv");  % 1,2, ,4, ,6
ori{16} = readtable("orientations/bulb_centers/9_48-16.csv");  % 1,2, ,4, ,6
ori{17} = readtable("orientations/bulb_centers/10_05-16.csv"); % 1,2, ,4, ,6
ori{18} = readtable("orientations/bulb_centers/10_22-16.csv"); % 1,2, ,4, ,6
ori{19} = readtable("orientations/bulb_centers/10_39-16.csv"); % 1,2, ,4, ,6
T = 19;
start_idx = [  1,  1,  1,  1,  4,  1,  3];
end_idx   = [ 19, 19,  8, 19,  9, 19, 11];
n_shapes = 7;
clr = [1 0 0;   0 1 0;  .8 .6 0;   0 0 1;...
       0 .8 .6; .2 .2 .2; .6 0 .8;];
dt = ones(T-1,1)*17;

% ori{1} = readtable("orientations/bulb_centers/8_40-16.csv");  % 1,2, ,4, ,6
% ori{2} = readtable("orientations/bulb_centers/8_57-16.csv");  % 1,2, ,4, ,6
% ori{3} = readtable("orientations/bulb_centers/9_14-16.csv");  % 1,2, ,4, ,6
% ori{4} = readtable("orientations/bulb_centers/9_31-16.csv");  % 1,2, ,4, ,6
% ori{5} = readtable("orientations/bulb_centers/9_48-16.csv");  % 1,2, ,4, ,6
% ori{6} = readtable("orientations/bulb_centers/10_05-16.csv"); % 1,2, ,4, ,6
% ori{7} = readtable("orientations/bulb_centers/10_22-16.csv"); % 1,2, ,4, ,6
% ori{8} = readtable("orientations/bulb_centers/10_39-16.csv"); % 1,2, ,4, ,6
% T = 8;
% start_idx = [  1,  1,  1,  1];
% end_idx   = [ 19, 19, 19, 19];
% n_shapes = 4;
% clr = [1 0 0;   0 1 0;  .8 .6 0;   0 0 1;...
%        0 .8 .6; .2 .2 .2; .6 0 .8;];
% dt = ones(T-1,1)*17;
% [loc, p_deg, p_min, p_sec, l_deg, l_min, l_sec]




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



inter_bulb_distance = zeros(3,T); % only bulbs [1 2 4 6]
error_inter_distance= zeros(3,T);
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

error_position      = zeros(n_shapes,T);
error_distances     = zeros(n_shapes,T-1);
error_speeds        = zeros(n_shapes,T-1);
error_theta         = zeros(n_shapes,T);
error_phi           = zeros(n_shapes,T);

sigma_degrees = 1; 
sigma_seconds = 3;

theta0 = rad(loc.N_deg(1),loc.N_min(1),loc.N_sec(1));
phi0 =   rad(loc.E_deg(1),loc.E_min(1),loc.E_sec(1));
Lapua_loc = [px(theta0,phi0) py(theta0,phi0) pz(theta0)];

start_time_UTC = datetime(2025,4,3,21,5,33,'TimeZone','UTC');

for t = 1:T
    N = size(ori{t},1);        % number of orientations
    Nl = 7;                 % number of locations
    
    Nlu = size(unique(ori{t}.loc),1); % number of locations in this ori file
    
    j = 1;
    newloc = ones(Nl,1);            % list of moments that 'loc' switches
    line_names = strings(N,1);      % for the legend
    dist = zeros(n_shapes,3);     % list of distances to the closest lines
    
    
    
    for i = (1:N)
    
        for l = (2:Nl)
            if i == find(ori{t}.loc == l,1)
                j = l;
                newloc(j) = i;
            end
        end
        % assuming that the orientations are grouped by location, j=loc_number
        
        if i <= N/2
            k = i + N/2;
            x  = closest_pt(loc, ori{t}, i, j, k, ori{t}.loc(k));
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            s = ori{t}.bulb_number(i); % shape index number
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            dist(s,1) = x(3); % length of connecting line
            dist(s,2) = i;    % index of line 1
            dist(s,3) = k;    % index of line 2
        end
    end

    % dist = dist(dist(:,1) ~= 1e6,:); % deleting all the 'null' entries
    
    R_E = 6371;
    
    for s = 1:n_shapes
        if dist(s,1) == 0
            %disp(["t = " int2str(t) "s = " int2str(s) "skipped"]);
            continue % skips this current iteration of the loop
        end
        %disp(["t = " int2str(t) "s = " int2str(s) " NOT skipped"]);
        
        i = dist(s,2);
        k = dist(s,3);
        [Xd,Yd,Zd] =        closest_pt2(loc, ori{t}, i, ori{t}.loc(i), k, ori{t}.loc(k));
        %[d,Xs,Ys,Zs] = positions_at_110km(loc, ori{t}, i, ori{t}.loc(i), k, ori{t}.loc(k));

        center_pt(s,t,:) = [Xd(dist(s,1)/2) Yd(dist(s,1)/2) Zd(dist(s,1)/2)];
        % center_pt_h1(s,t,:) = [Xs(1) Ys(1) Zs(1)];
        % center_pt_h2(s,t,:) = [Xs(2) Ys(2) Zs(2)];

        x = center_pt(s,t,1);
        y = center_pt(s,t,2);
        z = center_pt(s,t,3);
        r = norm(squeeze(center_pt(s,t,:)));
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        scatter3(x,     y,     z,     20, clr(ori{t}.bulb_number(i),:), 'filled');  % clr(t,:) % [1 0 0], 'filled'); % 
        
        % R = vecnorm([Xs(1) Ys(1) Zs(1)],2);
        % h = R-R_E;
        % % disp(R-R_E);
        % scatter3(Xs(1), Ys(1), Zs(1), 20, clr(ori{t}.bulb_number(i),:), '*')
        % scatter3(Xs(3), Ys(3), Zs(3), 20, clr(ori{t}.bulb_number(i),:), '*')
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        theta_pt(s,t) = asind(z/r);
        phi_pt(s,t) = atand(y/x);  % [x>0]
        
        
        R_E = 6371;
        heights(s,t) = norm(squeeze(center_pt(s,t,:))) - R_E;
        
        error1  = abs(dist(s,1)/2); % just to get an idea how far off
        error2  = norm(Lapua_loc' - squeeze(center_pt(s,t,:))) * sind(sigma_degrees);
        if error1 > error2
            disp("dist/2 > degree err")
            disp("t = ")
            disp(t)
            disp("i = ")
            disp(i)
        end
        error_position(s,t) = max(error1,error2);
        
        % error_{A/B} = A/B * ( (error_A / A)^2 + (error_B / B)^2 )^(1/2)
        
        % error_A/A = 2^(1/2) * (error_A / A)

        

        % error_{A/B} = A/B * ( (error_A / A)^2 + (error_A / B)^2 )^(1/2)
        error_z_div_r = z/r * ( (error_position(s,t)/z)^2 + (error_position(s,t)/r)^2 )^(1/2);
        error_y_div_x = y/x * ( (error_position(s,t)/y)^2 + (error_position(s,t)/x)^2 )^(1/2);

        % error of arcsin(x) = error_x / (1 - x^2)^(1/2);
        error_theta(s,t) = error_z_div_r / (1 - (z/r)^2)^(1/2);
        % error of arctan(x) = error_x / (1 + x^2);
        error_phi(s,t) = error_y_div_x / (1 + (y/x)^2);

        %if t > 1
        if t > start_idx(s) && t <= end_idx(s)
            displacements(s,t-1,:) = center_pt(s,t,:)-center_pt(s,t-1,:);
            distances(s,t-1) = norm(squeeze(displacements(s,t-1,:)));
            speeds(s,t-1) = distances(s,t-1)/dt(t-1);
            start_time_UTC = start_time_UTC + dt(t-1)/86400;

            error_distances(s,t-1) = (error_position(s,t-1)^2 + error_position(s,t)^2) ^ (1/2);
        
            % v = x/t -> σ_v = |v|* sqrt[ (σ_x/x)^2 + (σ_t/t)^2 - 2*σ_xt/x*t ]
            % σ_xt = 0 (covariance between distance & time)
        
            error_speeds(s,t-1) = norm(speeds(s,t-1)) * ((error_distances(s,t-1)/distances(s,t-1))^2 + (sigma_seconds/dt(t-1))^2 )^(1/2);
        end
        
    end
    inter_bulb_distance(1,t)  = norm(squeeze(center_pt(1,t,:) - center_pt(2,t,:)));
    inter_bulb_distance(2,t)  = norm(squeeze(center_pt(2,t,:) - center_pt(4,t,:)));
    inter_bulb_distance(3,t)  = norm(squeeze(center_pt(4,t,:) - center_pt(6,t,:)));
    error_inter_distance(1,t) = (error_position(1,t)^2 + error_position(2,t)^2) ^ (1/2);
    error_inter_distance(2,t) = (error_position(2,t)^2 + error_position(4,t)^2) ^ (1/2);
    error_inter_distance(3,t) = (error_position(4,t)^2 + error_position(6,t)^2) ^ (1/2);

    % inter_bulb_distance(2,t)  = norm(squeeze(center_pt(2,t,:) - center_pt(3,t,:)));
    % error_inter_distance(2,t) = (error_position(2,t)^2 + error_position(3,t)^2) ^ (1/2);
end

% daspect([1 1 1])
% 
% scatter3_legend = strings(1,1+5+5+6);
% scatter3_legend = cat(2, scatter3_legend, ["1" "2" "3" "4" "5" "6" "7"]);
% legend(scatter3_legend, "Position", [0.837,0.321,0.065,0.198]);
% 
% hold off;

for s = 1:n_shapes

    total_displacement(s,:) = center_pt(s,end_idx(s),:) - center_pt(s,start_idx(s),:);   % vector
    total_distance(s) = norm(total_displacement(s,:));               % scalar

    for t = start_idx(s):end_idx(s)-1
        parallel_distances(s,t,:) = dot(squeeze(displacements(s,t,:)), total_displacement(s,:)) / total_distance(s);
        parallel_speeds(s,t)    = parallel_distances(s,t)/dt(t);


    end
end

Dt = sum(dt);                               % total time elapsed
h_dt = Dt/(2*(T-1));                         % half of averaged dt

avg_inter_bulb_distance  = mean(inter_bulb_distance,2);
avg_error_inter_distance = mean(error_inter_distance,2);

avg_heights              = zeros(n_shapes,1);
avg_error_position       = zeros(n_shapes,1);

avg_parallel_speeds      = zeros(n_shapes,1);
avg_error_speeds         = zeros(n_shapes,1);

for s = 1:n_shapes
    avg_heights(s)              = mean(nonzeros(heights(s,:)));
    avg_error_position(s)       = mean(nonzeros(error_position(s,:)));
    
    avg_parallel_speeds(s)      = mean(nonzeros(parallel_speeds(s,:)));
    avg_error_speeds(s)         = mean(nonzeros(error_speeds(s,:)));
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
line_names1 = strings(1,1);
line_names2 = strings(1,1);

major_bulbs = [1 2 4 6];
small_stuff = [3 5 7];


t_start_utc     = datetime(2025,4,3,21,5,33);
t_end_utc       = datetime(2025,4,3,21,10,39);
t_utc           = t_start_utc:seconds(17):t_end_utc;


figure;
hold on;
for i = 1:4
    s = major_bulbs(i); %1:n_shapes

    st = start_idx(s);
    en = end_idx(s);
    st_t = (st-1)*dt(1); % assumed that all values of dt are equal
    en_t = (en-1)*dt(1);


    x1 = t_utc; %linspace(st_t, 	 en_t,      en-st+1);
    %x2 = t_utc_2;
    y1 = heights(  s,st:en);
    %y2 = distances(s,st:en-1);
    y1err = error_position(s,st:en);
    %y2err = error_distances(s,st:en-1);

    x1conf = [x1 x1(end:-1:1)];
    %x2conf = [x2 x2(end:-1:1)];
    y1conf = [y1+y1err y1(end:-1:1)-y1err(end:-1:1)];
    %y2conf = [y2+y2err y2(end:-1:1)-y2err(end:-1:1)];

    fill(x1conf, y1conf, clr(s,:), "FaceAlpha", .2, "EdgeColor","none");
    %fill(x2conf, y2conf, clr(s,:), "FaceAlpha", .2, "EdgeColor","none");
    plot(x1, y1, "Color", clr(s,:), "LineWidth", 1);    
    %plot(x2, y2, "Color", clr(s,:));
    % plot(linspace(st_t+h_dt, en_t-h_dt, en-st), parallel_distances(s,st:en-1), "Color", clr(s,:), "LineStyle", ":");

    line_names1 = cat(1,line_names1,["";int2str(s)]);%; ""]);
    % line_names1 = cat(1,line_names1,["heights"+int2str(s); "distances"+int2str(s); "||-distances"+int2str(s)]);
end
line_names1 = line_names1(2:size(line_names1,1)); % delete the empty string at the start


ymax = ceil(max(max(heights))/20)*20;
ylim([0 ymax]);
xlabel("time (UTC)")
ylabel("altitude (km)")
legend(line_names1, "Location", "southeast");
grid on;
hold off;




figure;
hold on;
line_names1 = strings(1,1);
for i = 1:3
    s = small_stuff(i); %1:n_shapes

    st = start_idx(s);
    en = end_idx(s);
    st_t = (st-1)*dt(1); % assumed that all values of dt are equal
    en_t = (en-1)*dt(1);

    t_start_utc     = datetime(2025,4,3,21,5,16 + 17*st);
    t_end_utc       = datetime(2025,4,3,21,5,16 + 17*en);
    t_utc_3          = t_start_utc:seconds(17):t_end_utc;


    x1 = t_utc_3; % linspace(st_t, 	 en_t,      en-st+1);
    %x2 = linspace(st_t+h_dt, en_t-h_dt, en-st);
    y1 = heights(  s,st:en);
    %y2 = distances(s,st:en-1);
    y1err = error_position(s,st:en);
    %y2err = error_distances(s,st:en-1);

    x1conf = [x1 x1(end:-1:1)];
    %x2conf = [x2 x2(end:-1:1)];
    y1conf = [y1+y1err y1(end:-1:1)-y1err(end:-1:1)];
    %y2conf = [y2+y2err y2(end:-1:1)-y2err(end:-1:1)];

    fill(x1conf, y1conf, clr(s,:), "FaceAlpha", .2, "EdgeColor","none");
    %fill(x2conf, y2conf, clr(s,:), "FaceAlpha", .2, "EdgeColor","none");
    plot(x1, y1, "Color", clr(s,:), "LineWidth", 1);    
    %plot(x2, y2, "Color", clr(s,:));
    % plot(linspace(st_t+h_dt, en_t-h_dt, en-st), parallel_distances(s,st:en-1), "Color", clr(s,:), "LineStyle", ":");

    line_names1 = cat(1,line_names1,["";int2str(s)]);%; ""]);
    % line_names1 = cat(1,line_names1,["heights"+int2str(s); "distances"+int2str(s); "||-distances"+int2str(s)]);
end
line_names1 = line_names1(2:size(line_names1,1)); % delete the empty string at the start

xmin = datetime(2025,4,3,21,5,0);
xmax = datetime(2025,4,3,21,11,0);
xlim([xmin xmax]);
ylim([0 ymax]);
xlabel("time (UTC)")
ylabel("altitude (km)")
legend(line_names1, "Location", "southeast");
grid on;
hold off;

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% t_start_utc_2   = datetime(2025,4,3,21,5, 33+17/2);
% t_end_utc_2     = datetime(2025,4,3,21,10,39-17/2);
% t_utc_2         = t_start_utc_2:seconds(17):t_end_utc_2;
% 
% figure;
% hold on;
% for i = 1:4
%     s = major_bulbs(i); %1:n_shapes
% 
%     st = start_idx(s);
%     en = end_idx(s);
%     st_t = (st-1)*dt(1); % start time
%     en_t = (en-1)*dt(1); % end time
% 
%     x = t_utc_2;%linspace(st_t+h_dt, en_t-h_dt, en-st);
% 
%     y = parallel_speeds(s,st:en-1);
%     yerr = error_speeds(s,st:en-1);
% 
%     xconf = [x x(end:-1:1)];
%     yconf = [y+yerr y(end:-1:1)-yerr(end:-1:1)];
% 
%     fill(xconf, yconf, clr(s,:), "FaceAlpha", .2, "EdgeColor","none");
%     plot(x, y, "Color", clr(s,:), "LineWidth", 1);    
% 
%     line_names2 = cat(1,line_names2,[""; int2str(s)]);
%     % line_names2 = cat(1,line_names2,["speeds"+int2str(s); "||-speeds"+int2str(s)]);
% end
% line_names2 = line_names2(2:size(line_names2,1)); % delete the empty string at the start
% % xlim([0 xmax]);
% xlabel("time (UTC)")
% ylabel("parallel speed (km/s)")
% ylim([-1 3]);
% 
% plot([xmin xmax],[0 0],"Color",[0 0 0]); % horzontal black line at y=0
% 
% legend(line_names2);
% grid on;
% hold off;
% 
% 
% figure;
% hold on;
% line_names2 = strings(1,1);
% for i = 1:3
%     s = small_stuff(i); %1:n_shapes
% 
%     st = start_idx(s);
%     en = end_idx(s);
%     st_t = (st-1)*dt(1); % start time
%     en_t = (en-1)*dt(1); % end time
% 
%     t_start_utc_2     = datetime(2025,4,3,21,5,16 + 17*st + 17/2);
%     t_end_utc_2       = datetime(2025,4,3,21,5,16 + 17*en - 17/2);
%     t_utc_4           = t_start_utc_2:seconds(17):t_end_utc_2;
% 
% 
%     x = t_utc_4; % linspace(st_t+h_dt, en_t-h_dt, en-st);
% 
%     y = parallel_speeds(s,st:en-1);
%     yerr = error_speeds(s,st:en-1);
% 
%     xconf = [x x(end:-1:1)];
%     yconf = [y+yerr y(end:-1:1)-yerr(end:-1:1)];
% 
%     fill(xconf, yconf, clr(s,:), "FaceAlpha", .2, "EdgeColor","none");
%     plot(x, y, "Color", clr(s,:), "LineWidth", 1);    
% 
%     line_names2 = cat(1,line_names2,[""; int2str(s)]);
%     % line_names2 = cat(1,line_names2,["speeds"+int2str(s); "||-speeds"+int2str(s)]);
% end
% line_names2 = line_names2(2:size(line_names2,1)); % delete the empty string at the start
% 
% xlim([xmin xmax]);
% xlabel("time (UTC)")
% ylabel("parallel speed (km/s)")
% ylim([-1 3]);
% 
% plot([xmin xmax],[0 0],"Color",[0 0 0]); % horzontal black line at y=0
% 
% legend(line_names2);
% grid on;
% hold off;
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% figure;
% hold on;
% ymax = 0;
% clr2 = [.8 .8 0;   0 .8 .8;  1 0 1];
% for i = 1:3
%     x = t_utc; %linspace(0, Dt, T);
% 
%     y = inter_bulb_distance(i,:);
%     yerr = error_inter_distance(i,:);
% 
%     xconf = [x x(end:-1:1)];
%     yconf = [y+yerr y(end:-1:1)-yerr(end:-1:1)];
%     ymax = max(max(yconf,ymax));
% 
%     fill(xconf, yconf, clr2(i,:), "FaceAlpha", .2, "EdgeColor","none");
%     plot(x, y, "Color", clr2(i,:), "LineWidth", 1);   
%     %errorbar(linspace(0, Dt, T), inter_bulb_distance(i,:), error_inter_distance(i,:));
% end
% %xmax = ceil(Dt/20)*20;
% %xlim([0 xmax]);
% ymax = ceil(ymax/50)*50;
% ylim([0 ymax]);
% xlabel("time (UTC)")
% ylabel("distance between beads (km)")
% legend([""; "D_{1-2}"; ""; "D_{2-4}"; ""; "D_{4-6}";]);
% grid on;
% hold off;
% 
% f = figure;
% f.Position = [2.6 41.8 1200 750];
% hold on
% 
% % with Mercator scaling correction:
% surf(ph .*180./pi, th .*180./pi, zeros(size(th)), map_image, "LineStyle", "none")
% view(2);
% 
% line_names3 = strings(1,1);
% 
% hold on;
% for s = 1:n_shapes
%     st = start_idx(s);
%     en = end_idx(s);
% 
%     for t = st:en-1
%         A = [  phi_pt(s,t)-error_phi(s,t)     phi_pt(s,t)-error_phi(s,t)     phi_pt(s,t+1)+error_phi(s,t+1)      phi_pt(s,t+1)+error_phi(s,t+1) ];
%         B = [theta_pt(s,t)-error_theta(s,t) theta_pt(s,t)+error_theta(s,t) theta_pt(s,t+1)+error_theta(s,t+1)  theta_pt(s,t+1)-error_theta(s,t+1)];
%         % C = [phi_pt(s,t)+error_phi(s,t)     phi_pt(s,t)+error_phi(s,t)     phi_pt(s,t+1)-error_phi(s,t+1)     phi_pt(s,t+1)-error_phi(s,t+1)];
%         % D = [theta_pt(s,t)+error_theta(s,t) theta_pt(s,t)-error_theta(s,t) theta_pt(s,t+1)-error_theta(s,t+1) theta_pt(s,t+1)+error_theta(s,t+1)];
%         fill(A, B, clr(s,:), "FaceAlpha", .2, "EdgeColor","none");
%         line_names3 = cat(1,line_names3,"");
%     end
%     plot(phi_pt(s,st:en),theta_pt(s,st:en), "Color", clr(s,:));
%     line_names3 = cat(1,line_names3, int2str(s));
% end
% xlabel("Longitude");
% ylabel("Latitude");
% xlim([21 37])
% ylim([60 65])
% legend(line_names3, 'FontSize', 12)
% hold off;


% % save variables to csv file:
% 
% heights = heights';
% error_position = error_position';
% parallel_speeds = cat(1,parallel_speeds',[0 0 0 0 0 0 0]);
% error_speeds    = cat(1,error_speeds',   [0 0 0 0 0 0 0]);
% inter_bulb_distance = inter_bulb_distance';
% error_inter_distance = error_inter_distance';
% 
% writetable(table(heights, error_position, parallel_speeds, error_speeds, inter_bulb_distance, error_inter_distance), "beads.csv");