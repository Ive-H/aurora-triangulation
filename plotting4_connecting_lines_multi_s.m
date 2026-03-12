% This program plots only the "closest_pt" connecting lines,
% for multiple timesteps
% unused in project, but nice initial visualisation idea

% close all
clear ori
% clc

loc = readtable("original_locations.csv");
% [N_deg, N_min, N_sec, E_deg, E_min, E_sec]


ori{1} = readtable("orientations/bulb2-6_18.csv");
ori{2} = readtable("orientations/bulb2-7_23.csv");
ori{3} = readtable("orientations/bulb2-8_30.csv");
ori{4} = readtable("orientations/bulb2-9_36.csv");
ori{5} = readtable("orientations/bulb2-10_42.csv");
% [loc, p_deg, p_min, p_sec, l_deg, l_min, l_sec]
T = 5;
dt = [66, 66, 66, 66]; % time difference between each ori{t}
clr = [1 0 0; .5 .5 0; 0 1 0; 0 .5 .5; 0 0 1];       

th1 = rad(loc.N_deg(1) + 2,0,0);
th2 = rad(loc.N_deg(3) - 1,0,0);
ph1 = rad(loc.E_deg(1) - 1,0,0);
ph2 = rad(loc.E_deg(3) + 5,0,0);

[th,ph] = meshgrid(linspace(th1, th2, 10), linspace(ph1, ph2, 10));

figure;
surf(px(th,ph), py(th,ph), pz(th));
% plots a section of the Earth's surface

hold on;

Nl = 7;                 % number of locations

% T times case:
% 
% for t = 1:T
%   use ori{t} instead of ori


line_names = strings(1,1);          % for the legend


avgX = zeros(T,1);
avgY = zeros(T,1);
avgZ = zeros(T,1);
heights = zeros(T,1);
distances = zeros(T-1,1);
speeds = zeros(T-1,1);
for t = (1:T)
    j = 1;
    N = size(ori{t},1);             % number of orientations
    dist = 1e6*ones(N,3);
    line_names = cat(1,line_names,int2str(t));
    line_names = cat(1,line_names,strings(N,1));
    for i = (1:N)

        for l = (2:Nl)
            if i == find(ori{t}.loc == l,1)
                j = l;
            end
        end
        % assuming that the orientations are grouped by location, j=loc_number
        
        % compare line i from loc j with all lines k from loc ~= j
        k_vals = find(ori{t}.loc ~= j); 
        for w = 1:size(k_vals,1)
            k = k_vals(w);
            % need to do this (~= instead of >) 
            % because 1 line can have multiple closest lines

            % angles are calculated inside closest_pt, from
            x = closest_pt(loc, ori{t}, i, j, k, ori{t}.loc(k));
            %             (loc, orie , i1,j1,i2,j2)
            if abs(x(3)) < abs(dist(i,1)) & isempty(find(dist(1:i-1,3) == i & dist(1:i-1,2) == k, 1))
                % only save the lowest value & skip duplicates
                dist(i,1) = x(3);
                dist(i,2) = i;
                dist(i,3) = k;
            end
        end
    end

    dist = dist(dist(:,1) ~= 1e6,:); % deleting all the 'null' entries
    weight = 0;
    R_E = 6371;
    
    for m = 1:size(dist,1)
        i = dist(m,2);
        k = dist(m,3);
        [Xd,Yd,Zd] = closest_pt2(loc, ori{t}, i, ori{t}.loc(i), k, ori{t}.loc(k));
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        fplot3(Xd,Yd,Zd,[min(dist(m,1),0),max(dist(m,1),0)],"Color",clr(t,:),"LineWidth",2);
        %scatter3(Xd(dist(m,1)/2), Yd(dist(m,1)/2), Zd(dist(m,1)/2),"Color",clr(t,:));
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        avgX(t) = avgX(t) + Xd(dist(m,1)/2);
        avgY(t) = avgY(t) + Yd(dist(m,1)/2);
        avgZ(t) = avgZ(t) + Zd(dist(m,1)/2);

        % % weighted average based on how far away the line intersections are
        % avgX(t) = avgX(t) + Xd(dist(m,1)/2) / abs(dist(m,1));  % w_i = 1/dist(m,1)
        % avgY(t) = avgY(t) + Yd(dist(m,1)/2) / abs(dist(m,1));
        % avgZ(t) = avgZ(t) + Zd(dist(m,1)/2) / abs(dist(m,1));
        % weight = weight + 1/abs(dist(m,1));
        
    end
    avgX(t) = avgX(t) / size(dist,1);
    avgY(t) = avgY(t) / size(dist,1);
    avgZ(t) = avgZ(t) / size(dist,1);

    % avgX(t) = avgX(t)  / (weight); % w_i = 1/dist(m,1)
    % avgY(t) = avgY(t)  / (weight);
    % avgZ(t) = avgZ(t)  / (weight);

    heights(t) = (  avgX(t)^2 + avgY(t)^2 + avgZ(t)^2  )^(1/2)  - R_E;
    if t ~= 1
        distances(t-1) = ((avgX(t)-avgX(t-1))^2 + (avgY(t)-avgY(t-1))^2 + (avgZ(t)-avgZ(t-1))^2)^(1/2);
        speeds(t-1) = distances(t-1)/dt(t-1);
    end
end
scatter3(avgX,avgY,avgZ,50,clr);
daspect([1 1 1])
legend(line_names);

hold off;

figure;
subplot(2,1,1);
plot(linspace(1,T,T),heights,linspace(1,T-1,T-1),distances)
legend("heights","distances")
ylabel("km")

subplot(2,1,2); 
plot(linspace(1,T-1,T-1),speeds);
ylabel("km/s")
legend("speeds")