function [quad_coords] = get_quad_point_coords(...
    quad_iterator,n_quad, node_number,element_coords)


N= get_shape_fnc_vals(quad_iterator,n_quad,node_number);

quad_coords=zeros(2,1);

quad_coords(1)= N(:)' * element_coords(:,1); 
quad_coords(2)= N(:)' * element_coords(:,2); 


end

