function [N] = get_shape_fnc_vals(quad_iterator,n_quad,node_number)

%modify  this so that N is a vector for vector fields

N=zeros(node_number,1); 

[xi, nu] = get_xi_nu(quad_iterator,n_quad);

switch node_number
    
    case 8
        N(5)= 1/2 * (1-xi.^2) * (1-nu);
        N(6)= 1/2 * (1-nu.^2) * (1+xi);
        N(7)= 1/2 * (1-xi.^2) * (1+nu);
        N(8)= 1/2 * (1-nu.^2) * (1-xi);
        
        N(1)= 1/4 * (1-xi) * (1-nu) - 1/2 * (N(5)+N(8));
        N(2)= 1/4 * (1+xi) * (1-nu) - 1/2 * (N(5)+N(6));
        N(3)= 1/4 * (1+xi) * (1+nu) - 1/2 * (N(6)+N(7));
        N(4)= 1/4 * (1-xi) * (1+nu) - 1/2 * (N(7)+N(8));
    
    case 4
        N(1)= 1/4 * (1-xi) * (1-nu);
        N(2)= 1/4 * (1+xi) * (1-nu);
        N(3)= 1/4 * (1+xi) * (1+nu);
        N(4)= 1/4 * (1-xi) * (1+nu);
        
    otherwise
        error('shape functions are only defined for 8 node element for now')
       
end

end

