function [N_div] = get_shape_fnc_div(quad_iterator, n_quad,...
                             element_node_number, node_coordinates)
                                    
%this is only for div of vector valued field variable, velocity/displacement     

global dim
global n_ee_u

N_grad= zeros(element_node_number, dim); 

N_grad= get_shape_fnc_grad(quad_iterator,n_quad, element_node_number, ...
                      node_coordinates);
                  
N_div=zeros(n_ee_u,1);

for  i=1:element_node_number
    
    if(dim ~=2)
        error('check following implementation')
    end
    
    N_div(i*dim-1)= N_grad(i,1);
    N_div(i*dim)= N_grad(i,2);
    
end

end

