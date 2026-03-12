% This program just plots the lines

% close all

loc = readtable("original_locations.csv"); % [Lapua=1, Alajarvi=2, Miekankoski=3]
% [N_deg, N_min, N_sec, E_deg, E_min, E_sec]
% ori = readtable("orientations/shape-23_59_30-67.csv");
ori = readtable("orientations/bulb_centers/5_33-16.csv");   % 1,2,3,4, ,6
% [loc, p_deg, p_min, p_sec, l_deg, l_min, l_sec]

th1 = rad(loc.N_deg(1) + 2,0,0);
th2 = rad(loc.N_deg(3) - 1,0,0);
ph1 = rad(loc.E_deg(1) - 1,0,0);
ph2 = rad(loc.E_deg(3) + 5,0,0);
% th1 = rad(50,0,0);
% th2 = rad(60,0,0);
% ph1 = rad(-30,0,0);
% ph2 = rad(-60,0,0);

[th,ph] = meshgrid(linspace(th1, th2, 20), linspace(ph1, ph2, 10));

%[X_cd,Y_cd,Z_cd] = magnetic_coordinates(th,ph);

figure;
%surf(X_cd, Y_cd, Z_cd);
surf(px(th,ph), py(th,ph), pz(th));
% plots a section of the Earth's surface

hold on;

N = size(ori,1);        % number of orientations
Nl = 7;                 % number of locations
clr = [1 0 0; .5 .5 0; 0 1 0; 0 .5 .5; 0 0 1; .5 0 .5; 0 0 0];    % line color per location

j = 1;
newloc = ones(Nl,1);            % list of moments that 'loc' switches
line_names = strings(N,1);      % for the legend
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

    [X,Y,Z] = line_eq(theta,phi,psi,lambda);
    fplot3(X,Y,Z,[0,400],'Color',clr(j,:));%+[0 ori.bulb(i)/3 0],'Linewidth',(ori.bulb(i)*2+2)/6 );
    %                                    );%
    
    
end
daspect([1 1 1])
% giving 1 line of each location a legend
for l = (2:Nl)
    line_names(newloc(l)+1) = loc.name(l);
end
line_names(1) = ""; % surf plot of earth
line_names(2) = "Lapua";
legend(line_names)

hold off;