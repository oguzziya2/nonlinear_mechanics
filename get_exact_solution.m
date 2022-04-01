function [u] = get_exact_solution(x ,y)
%this solution vector is from sec 4.1.1 of 
% " isogeometric analysis : stable elements for the 2d stokes equation"
% by Buffa et al. IJNMF 2011, 65:1407-1422

%its force vector is  defined in get_force_vector function. 

u(1)= 2*exp(x)*(x-1).^2*x.^2*(y.^2-y)*(2*y-1);
u(2)= -exp(x)*(x-1)*x*(x.^2+3*x-2)*(y-1).^2*y.^2;

end

