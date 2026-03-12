% plots: altitude ; parallel speed ; wavelength
% from csv files containing only those values


clear all
close all;

T = 19;
dt = 17;
clr2 = [.8 .8 0;   0 .8 .8;  1 0 1];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% the only variable that needs to be changed to plot different stuff:
% "beads-shapes", "beads" or "sticks"
what_plotting = "beads-shapes"; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

switch(what_plotting)
    case "beads-shapes"
        start_idx = [  1,  1];
        end_idx   = [ 19, 19];
        n_shapes = 2;
        n_dists  = 1;
        clr = [0 1 0;   0 0 1];
        line_names = [""; 2; ""; 4;];
        line_names_dist = [""; "D_{1-2}"];
        clr2 = [0 .8 .8];
        tbl = readtable("beads-shapes.csv");

        plot_volumes = true;

    case "beads"
        start_idx = [  1,  1,  1,  1,  4,  1,  3];
        end_idx   = [ 19, 19,  8, 19,  9, 19, 11];
        n_shapes = 7;
        n_dists  = 3;
        clr = [1 0 0;   0 1 0;  .8 .6 0;   0 0 1;...
               0 .8 .6; .2 .2 .2; .6 0 .8;];
        major_bulbs = [1 2 4 6];
        small_stuff = [3 5 7];
        line_names = [""; 1; ""; 2; ""; 3; ""; 4; ""; 5; ""; 6; ""; 7;];
        line_names_dist = [""; "D_{1-2}"; ""; "D_{2-4}"; ""; "D_{4-6}"];
        tbl = readtable("beads.csv");
        
        plot_volumes = false;

    case "sticks"
        start_idx = [  1,  1,  1];
        end_idx   = [ 19, 19, 19];
        n_shapes = 3;
        n_dists  = 2;
        clr = [1 0 0;   0 1 0; 0 0 1];
        line_names = [""; 1; ""; 2; ""; 4;];
        line_names_dist = [""; "D_{1-2}"; ""; "D_{2-4}"];
        tbl = readtable("sticks.csv");
        
        plot_volumes = false;

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

t_start_utc     = datetime(2025,4,3,21,5,33);
t_end_utc       = datetime(2025,4,3,21,10,39);
t_utc           = t_start_utc:seconds(17):t_end_utc;

inter_bulb_distance = zeros(3,T); % only bulbs [1 2 4 6]
error_inter_distance= zeros(3,T);

heights             = zeros(n_shapes,T);
displacements       = zeros(n_shapes,T-1,3);
distances           = zeros(n_shapes,T-1);
parallel_distances  = zeros(n_shapes,T-1);
speeds              = zeros(n_shapes,T-1);
parallel_speeds     = zeros(n_shapes,T-1);

total_displacement  = zeros(n_shapes,3);
total_distance      = zeros(n_shapes,1);

error_position      = zeros(n_shapes,T);
error_distances     = zeros(n_shapes,T-1,1);
error_speeds        = zeros(n_shapes,T-1,1);


figure;
hold on;
for s = 1:n_shapes
    
    h_s  = sprintf("heights_%d", s);
    ep_s = sprintf("error_position_%d", s)';
    heights(s,:)        = tbl.(h_s)';
    error_position(s,:) = tbl.(ep_s)';

    st = start_idx(s);
    en = end_idx(s);
    st_t = (st-1)*dt; % assumed that all values of dt are equal
    en_t = (en-1)*dt;

    t_start_utc     = datetime(2025,4,3,21,5,16 + 17*st);
    t_end_utc       = datetime(2025,4,3,21,5,16 + 17*en);
    t_utc_3           = t_start_utc:seconds(17):t_end_utc;
    
    

    x = t_utc_3;
    y = heights(  s,st:en);
    yerr = error_position(s,st:en);

    xconf = [x x(end:-1:1)];
    yconf = [y+yerr y(end:-1:1)-yerr(end:-1:1)];

    fill(xconf, yconf, clr(s,:), "FaceAlpha", .2, "EdgeColor","none");
    plot(x, y, "Color", clr(s,:));    

end

ymax = ceil(max(max(heights))/20)*20;
ylim([0 ymax]);
xlabel("time (UTC)")
ylabel("altitude (km)")
title(what_plotting)
legend(line_names, "Location", "southeast");
grid on;
hold off;

% t_start_utc_2   = datetime(2025,4,3,21,5, 33+17/2);
% t_end_utc_2     = datetime(2025,4,3,21,10,39-17/2);
% t_utc_2         = t_start_utc_2:seconds(17):t_end_utc_2;

figure;
hold on;
for s = 1:n_shapes
    st = start_idx(s);
    en = end_idx(s);
    st_t = (st-1)*dt; % start time
    en_t = (en-1)*dt; % end time

    t_start_utc_2     = datetime(2025,4,3,21,5,16 + 17*st + 17/2);
    t_end_utc_2       = datetime(2025,4,3,21,5,16 + 17*en - 17/2);
    t_utc_2           = t_start_utc_2:seconds(17):t_end_utc_2;

    x = t_utc_2; % linspace(st_t+h_dt, en_t-h_dt, en-st);

    ps_s = sprintf("parallel_speeds_%d", s);
    es_s = sprintf("error_speeds_%d", s)';
    ps_s_19 = tbl.(ps_s)';
    es_s_19 = tbl.(es_s)';
    parallel_speeds(s,:) = ps_s_19(1:18);
    error_speeds(s,:)    = es_s_19(1:18);

    y = parallel_speeds(s,st:en-1);
    yerr = error_speeds(s,st:en-1);

    xconf = [x x(end:-1:1)];
    yconf = [y+yerr y(end:-1:1)-yerr(end:-1:1)];

    fill(xconf, yconf, clr(s,:), "FaceAlpha", .2, "EdgeColor","none");
    plot(x, y, "Color", clr(s,:));    
end

xmin = datetime(2025,4,3,21,5,0);
xmax = datetime(2025,4,3,21,11,0);
plot([xmin xmax],[0 0],"Color",[0 0 0]); % horzontal black line at y=0

ylim([-1 3]);
xlabel("time (UTC)")
ylabel("parallel speed (km/s)")
title(what_plotting)
legend(line_names);
grid on;
hold off;



figure;
hold on;
ymax = 0;
for i = 1:n_dists
    ibd_s = sprintf("inter_bulb_distance_%d", i);
    eid_s = sprintf("error_inter_distance_%d", i)';
    inter_bulb_distance(i,:)    = tbl.(ibd_s)';
    error_inter_distance(i,:)   = tbl.(eid_s)';

    x = t_utc;
    y = inter_bulb_distance(i,:);
    yerr = error_inter_distance(i,:);

    xconf = [x x(end:-1:1)];
    yconf = [y+yerr y(end:-1:1)-yerr(end:-1:1)];
    ymax = max(max(yconf,ymax));

    fill(xconf, yconf, clr2(i,:), "FaceAlpha", .2, "EdgeColor","none");
    plot(x, y, "Color", clr2(i,:), "LineWidth", 1);   
end

ymax = ceil(ymax/50)*50;
ylim([0 ymax]);
xlabel("time (UTC)")
ylabel(strcat("distance between ",what_plotting," (km)"))
title(what_plotting)
legend(line_names_dist);
grid on;
hold off;


if plot_volumes
    volume_bead2 = tbl.volume_shape_1;
    volume_bead4 = tbl.volume_shape_2;

    figure;
    hold on
    yyaxis left
    plot(x, volume_bead2, "Color", [0 1 0], "LineWidth", 1, 'LineStyle', '-');
    plot(x, volume_bead4, "Color", [0 0 1], "LineWidth", 1, 'LineStyle', '-');
    ymax = 20000;
    ylim([0 ymax])
    ylabel("Volume of bead (km^3)")
    xlabel("time (UTC)")
    legend("2", "4")
    
    yyaxis right
    ylabel("Equivalent sphere radius (km)");
    Rmax = (ymax *3/4) ^ (1/3);
    ylim([0 Rmax]);
    grid on;
    hold off;
end