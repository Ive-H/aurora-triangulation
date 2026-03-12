% This program calculates the "closest_pt" connecting lines,
% and plots them alongside the original lines

% close all
% clc

loc = readtable("original_locations.csv"); % [Lapua=1, Alajarvi=2, Miekankoski=3, Uurainen=4, Hankasalmi=5, Juva=6]
% [N_deg, N_min, N_sec, E_deg, E_min, E_sec]
ori = readtable("orientations/bulb_centers/sticks/7_49-16.csv");
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

figure;
surf(px(th,ph), py(th,ph), pz(th), map_image, "LineStyle", "none");
% plots a section of the Earth's surface

hold on;

N = size(ori,1);        % number of orientations
Nl = 7;                 % number of locations
Nlu = size(unique(ori.loc),1); % number of locations in this ori file
clr = [1 0 0; .5 .5 0; 0 1 0; 0 .5 .5; 0 0 1; .5 0 .5; .4 .4 .4];    % line color per location

j = 1;
newloc = ones(Nl,1);            % list of moments that 'loc' switches
line_names = strings(N,1);      % for the legend
dist = 1e6*ones(N,3);           % list of distances to the closest lines



for i = (1:N)

    for l = (2:Nl)
        if i == find(ori.loc == l,1)
            j = l;
            newloc(j) = i;
        end
    end
    % assuming that the orientations are grouped by location, j=loc_number

    theta = rad(loc.N_deg(j),loc.N_min(j),loc.N_sec(j));
    phi   = rad(loc.E_deg(j),loc.E_min(j),loc.E_sec(j));
    
    psi   = rad(ori.p_deg(i),ori.p_min(i),ori.p_sec(i));
    lambda= rad(ori.l_deg(i),ori.l_min(i),ori.l_sec(i));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    [X,Y,Z] = line_eq(theta,phi,psi,lambda);
    fplot3(X,Y,Z,[0,600],'Color',clr(j,:),'LineStyle','-','LineWidth',(3.5-abs(j-3))/2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
    % % plotting points where the lines intersect an altitude of 110km
    % L = distance_at_110km(lambda);
    % scatter3(X(L),Y(L),Z(L));


    if i <= N/2
        k = i + N/2;
        x  = closest_pt(loc, ori, i, j, k, ori.loc(k));
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %s = ori{t}.bulb_number(i); % shape index number
        s = i;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        dist(s,1) = x(3); % length of connecting line
        dist(s,2) = i;    % index of line 1
        dist(s,3) = k;    % index of line 2
    end

    % k_vals = find(ori.loc ~= j); % indices of all lines of the other locations
    % for w = 1:size(k_vals,1)
    %     k = k_vals(w);
    %     % need to do this (~= instead of >) 
    %     % because 1 line can have multiple closest lines
    %     x  = closest_pt(loc, ori, i, j, k, ori.loc(k));
    % 
    %     if abs(x(3)) < abs(dist(i,1)) & isempty(find(dist(1:i-1,3) == i & dist(1:i-1,2) == k, 1))
    %         % only save the lowest value & skip duplicates
    %         dist(i,1) = x(3);
    %         dist(i,2) = i;
    %         dist(i,3) = k;
    %     end
    % end
end

dist = dist(dist(:,1) ~= 1e6,:); % deleting all the 'null' entries
heights = zeros(size(dist,1),1);
R_E = 6371;

for m = 1:size(dist,1)
    i = dist(m,2);
    k = dist(m,3);
    [Xd,Yd,Zd] = closest_pt2(loc, ori, i, ori.loc(i), k, ori.loc(k));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    fplot3(Xd,Yd,Zd,[min(dist(m,1),0),max(dist(m,1),0)],"k",'LineWidth',2);
    %scatter3(Xd(dist(m,1)/2), Yd(dist(m,1)/2), Zd(dist(m,1)/2));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    heights(m) = (  Xd(dist(m,1)/2)^2 + Yd(dist(m,1)/2)^2 + Zd(dist(m,1)/2)^2  )^(1/2)  - R_E;
end
daspect([1 1 1])

% giving 1 line of each location a legend
for l = 2:Nl
    line_names(newloc(l)+1) = loc.name(l);
end
line_names(1) = ""; % surf plot of earth
line_names(2) = "Lapua";
legend(line_names)

daspect([1 1 1])
%view([78.8 0.6]);
view([186 3.2]);
xlim([2400 2900])
ylim([1100 1700])
zlim([5500 6000])


hold off;