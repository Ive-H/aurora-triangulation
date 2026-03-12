# aurora triangulation

Accompanying code created for my internship project called "Triangulation of Auroral Beads Using Citizen Scientist Photos".
The timelapses used in this project:
https://www.taivaanvahti.fi/observations/show/133558 (Lapua, Finland)
https://www.taivaanvahti.fi/observations/show/134547 (Juva, Finland)

If you only want to reproduce the plots of altitude, parallel speed, wavelength, (volume), then "plot_from_csvs.m" can be used for that.
That program simply uses the files in "data_plots/...", which only contains the data for those plots.



The way that development went, is that I started with "plotting1",
and whenever I wanted to make a major change, I copied the entire code, 
and called it "plotting{n+1}", with n being the previous number used.

In the report itself, "plotting3_connecting_lines.m" and "plotting5_convhull.m" were used in the methods section,
"plotting6_convhull_multi_t.m" was used for the results of the 3D shapes from the contours,
"plotting8_connecting_lines_multi_t_c.m" was used for the bead center points method, and "8a" for the 'sticks' center points.


The "original_locations.csv" file is a list of locations and their Latitude & Longitude,
and for "viewpoint.m" specifically, I added a viewing direction (p_center_, l_center_, star_name), a zoom_factor and a rotation.

Columns of original_locations.csv":
N_deg, N_min, N_sec, E_deg, E_min, E_sec, name
degrees, arcminutes, arcseconds (North/East), location name


The "orientations/... .csv" files each contain a list of angles (Azimuth & Altitude)
Each of the contour method files ("bulb_") contain the angles for the contour of a single bead, for a single timestep.
Each of the center pt method files "orientations/bulb_centers/..." contain one angle for each bead/stick, for a single timestep.

Columns of the "orientations/... .csv" files:
loc, p_deg, p_min, p_sec, l_deg, l_min, l_sec, star_name
location number (index for "original_locations.csv"),
 degrees, arcminutes, arcseconds (p = Azimuth / l = Altitude), name of the star


The name of each file refers to the time and locations used: 
e.g. 8_40-16.csv: 21:08:40 UTC, locations 1 & 6 (Lapua & Juva)

The code doesn't use this filename data, it's simply an organising method.
The time is hardcoded in the code.

The numbering convention in orientations/bulb_centers/... is consistent with the report.
The numbering convention in orientations/... is not consistent with the report, as they were made earlier on, and deemed a waste of time to change after.

orientations/...  ->	orientations/bulb_centers/...
_____________________________________________________________
bulb4		  ->	1
bulb3		  ->	2
bulb2		  ->	4
bulb1		  ->	6



