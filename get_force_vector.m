function [F] =  get_force_vector(mu ,x ,y)

% this force vector is from sec 4.1.1 of 
% " isogeometric analysis : stable elements for the 2d stokes equation"
% by Buffa et al. IJNMF 2011, 65:1407-1422

d2ux_dx2 = (2*exp(x)*(x.^2-1)+2*exp(x)*2*x)*(y.^2-y)*(2*y-1);
d2ux_dy2 = (2*exp(x)*(x-1).^2*x.^2)*(12*y-6); 

d2uy_dx2 = (-exp(x)*(x.^4 +10*x.^3 +19*x.^2 -6*x -6))*((y-1).^2*y.^2);
d2uy_dy2 = (-exp(x)*(x.^4 + 2*x.^3 - 5*x.^2 +2*x))*(12*y.^2 -12*y -2);

term1 = 456 +x.^2*(228-5*(y.^2-y)) +2*x*(-228+(y.^2-y)) +...
    2*x.^3*(-36+(y.^2-y)) +x.^4*(12+(y.^2-y)) ;
dterm1_dx = 2*x*(228-5*(y.^2-y)) +2*(-228+(y.^2-y)) +...
    6*x.^2*(-36+(y.^2-y)) +4*x.^3*(12+y.^2-y);
dp_dx = (y.^2-y)*(exp(x)*term1+ exp(x)*dterm1_dx);

term2 = -456 + exp(x)*term1; 
dterm2_dy = exp(x)*(x.^2*(-5*(2*y-1)) +2*x*(2*y-1) +2*x^3*(2*y-1) ...
    + x.^4*(2*y-1));
dp_dy =(2*y-1)*term2 + (y.^2-y)*dterm2_dy ; 

laplace_u = [ d2ux_dx2 + d2ux_dy2 ; d2uy_dx2 + d2uy_dy2] ;
grad_p = [dp_dx ; dp_dy];

F(1)= -mu*laplace_u(1) + grad_p (1);
F(2)= -mu*laplace_u(2) + grad_p (2);


end

% d2ux_dx2= ( 2*exp(x)*(x-1)*x + 2*exp(x)*x + 2*exp(x)*(x-1) ) * ...
%     (x+ (x-1) +2 +2) * (y.^2 -y) * (2*y -1);
% 
% d2ux_dy2= ( 2 * exp(x) * (x-1).^2 * x.^2 ) * (12*y -6);
% 
% d2uy_dx2= ( -exp(x) * ( x.^4  +10*x.^3 +19*x.^2 -6*x -6) * ...
%     ( y.^4 - 2*y.^3 +y.^2 ) );
% 
% d2uy_dy2= ( -exp(x) * (x.^4 + 2*x.^3 - 5*x.^2 + 2*x ) * ...
%     ( 12*y.^2 - 12*y +2) );
% 
% laplace_u = [ d2ux_dx2 + d2ux_dy2 ; d2uy_dx2 + d2uy_dy2] ;
% 
% 
% term1 = ( 456 + x.^2*(228-5*(y.^2-y)) + 2*x*(-228+(y.^2-y)) + ...
%     2*x.^3*(-36+(y.^2-y)) + x.^4*(12+(y.^2-y)) );
% 
% dterm1_dx = ( 2*x* (228-5*(y.^2-y)) + 2*(-228 + (y.^2-y)) + ...
%     +6*x.^2 *(-36+(y.^2-y)) + 4*x.^3*(12-(y.^2-y)) ) ;
% 
% dp_dx = (y.^2 -y) * ( exp (x) * term1 + exp(x) * dterm1_dx );
% 
% term2 = -456 + exp(x) * term1 ; 
% 
% dp_dy = (2*y-1)*term2 + (y.^2 -y) * ...
%     ( exp(x) * ( x.^4 +2*x.^3 -5*x.^2 +2*x )*(2*y-1) ); 