function central_pt = centroid_polyhedron(K,shape_pts)
% https://nurnberg.maths.unitn.it/centroid.pdf

% e_d = e_x || e_y || e_z

% Volume = 1/6 sum_{i=1}^{N} [ a_i . n_hat_i ]

% vec{center} . e_d = 1/(2V) * sum_{i=1}^{N} [
% 1/24 * n_hat_i . e_d * ([(a_i + b_i).e_d]^2 + ...
%                         [(b_i + c_i).e_d]^2 + ...
%                         [(c_i + a_i).e_d]^2) ]

TR = triangulation(K,shape_pts);

N_triangles = size(TR.ConnectivityList,1);

volume = 0;
central_pt = [0 0 0];

for tr = 1:N_triangles
    a = TR.Points(TR.ConnectivityList(tr,1),:);
    b = TR.Points(TR.ConnectivityList(tr,2),:);
    c = TR.Points(TR.ConnectivityList(tr,3),:);
    
    n_hat = cross(b-a,c-a);
    
    volume = volume + dot(a,n_hat);
    central_pt = central_pt + n_hat .* ((a+b).^2 + (b+c).^2 + (c+a).^2);
end

volume = volume/6;
central_pt = central_pt ./ (2*volume*24);