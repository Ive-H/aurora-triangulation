% plots inter-bulb distance of the 3D shapes
% requires cached data from plotting6
% all lines with "ori{n} = ..." and "clear ori" in plotting6 
% need to be commented out before running this
%
% legacy naming convention, so: bulb2 -> bead4 ; bulb3 -> bead2.
loc = readtable("original_locations.csv");

file_names_shape = ["orientations/bulb2-5_33-16.csv" "orientations/bulb3-5_33-16.csv"; ...
                    "orientations/bulb2-5_50-16.csv" "orientations/bulb3-5_50-16.csv"; ...
                    "orientations/bulb2-6_07-16.csv" "orientations/bulb3-6_07-16.csv"; ...
                    "orientations/bulb2-6_24-16.csv" "orientations/bulb3-6_24-16.csv"; ...
                    "orientations/bulb2-6_41-16.csv" "orientations/bulb3-6_41-16.csv"; ...
                    "orientations/bulb2-6_58-16.csv" "orientations/bulb3-6_58-16.csv"; ...
                    "orientations/bulb2-7_15-16.csv" "orientations/bulb3-7_15-16.csv"; ...
                    "orientations/bulb2-7_32-16.csv" "orientations/bulb3-7_32-16.csv"; ...
                    "orientations/bulb2-7_49-16.csv" "orientations/bulb3-7_49-16.csv"; ...
                    "orientations/bulb2-8_06-16.csv" "orientations/bulb3-8_06-16.csv"; ...
                    "orientations/bulb2-8_23-16.csv" "orientations/bulb3-8_23-16.csv"; ...
                    "orientations/bulb2-8_40-16.csv" "orientations/bulb3-8_40-16.csv"; ...
                    "orientations/bulb2-8_57-16.csv" "orientations/bulb3-8_57-16.csv"; ...
                    "orientations/bulb2-9_14-16.csv" "orientations/bulb3-9_14-16.csv"; ...
                    "orientations/bulb2-9_31-16.csv" "orientations/bulb3-9_31-16.csv"; ...
                    "orientations/bulb2-9_48-16.csv" "orientations/bulb3-9_48-16.csv"; ...
                    "orientations/bulb2-10_05-16.csv" "orientations/bulb3-10_05-16.csv"; ...
                    "orientations/bulb2-10_22-16.csv" "orientations/bulb3-10_22-16.csv"; ...
                    "orientations/bulb2-10_39-16.csv" "orientations/bulb3-10_39-16.csv";];
T = 19;
dt = ones(T-1,1)*17;
line_names = [""; "5:33"; "5:50"; "6:07"; "6:24"; "6:41"; "6:58"; "7:15"; ...
                  "7:32"; "7:49"; "8:06"; "8:23"; "8:40"; "8:57"; ...
                  "9:14"; "9:31"; "9:48"; "10:05"; "10:22"; "10:39"];
clear ori
for u = 1:19
    ori{u} = readtable(file_names_shape(u,1));
end
plotting6_convhull_multi_t;

center_pt_prev = center_pt;
error_position_prev = error_position;

clear ori
for u = 1:19
    ori{u} = readtable(file_names_shape(u,2));
end
plotting6_convhull_multi_t;

inter_bulb_distance = zeros(T,1);
error_inter_distance = zeros(T,1);

t_start_utc     = datetime(2025,4,3,21,5,33);
t_end_utc       = datetime(2025,4,3,21,10,39);
t_utc           = t_start_utc:seconds(17):t_end_utc;

for t = 1:T
    inter_bulb_distance(t)  = norm(squeeze(center_pt(t,:) - center_pt_prev(t,:)));
    error_inter_distance(t) = (error_position(t)^2 + error_position_prev(t)^2) ^ (1/2);
end

x = t_utc; %linspace(0, Dt, T);

y = inter_bulb_distance(:)';
yerr = error_inter_distance(:)';

xconf = [x x(end:-1:1)];
yconf = [y+yerr y(end:-1:1)-yerr(end:-1:1)];
ymax = ceil(max(yconf)/20)*20;

figure;
hold on;

fill(xconf, yconf, [0 .8 .8], "FaceAlpha", .2, "EdgeColor","none");
plot(x, y, "Color", [0 .8 .8], "LineWidth", 1);   
ylim([0 ymax]);
grid on;
legend(["", "D_{2-4}"], "Location", "southeast");
xlabel("time (UTC)")
ylabel("distance (km)")
ylim([0 200]);

avg_inter_bulb_distance  = mean(inter_bulb_distance);
avg_error_inter_distance = mean(error_inter_distance);