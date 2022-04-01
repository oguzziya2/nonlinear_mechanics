function [N_symgrad] = get_shape_fnc_symgrad(quad_iterator, n_quad, ...
                                        element_node_number, node_coordinates)
                                    
%this is only for symgrad of vector valued field variable, velocity/displacement     

global dim
global n_ee_u

N_grad= zeros(element_node_number, dim); 

N_grad= get_shape_fnc_grad(quad_iterator, n_quad, element_node_number, ...
                      node_coordinates);
                  
N_symgrad=zeros(2,2,n_ee_u);

for  i=1:element_node_number
    
    if(dim ~=2)
        error('check following implementation')
    end
    
    N_symgrad(:,:,i*dim-1)=[ N_grad(i,1),  N_grad(i,2)/2; N_grad(i,2)/2 , 0          ];
        
    N_symgrad(:,:,i*dim)=  [ 0          ,  N_grad(i,1)/2; N_grad(i,1)/2 , N_grad(i,2)];
    
end

end

