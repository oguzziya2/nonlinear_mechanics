%This code solves static stokes equation using q2q1 elements in 2d

clc
clear all
close all

%problem parameters 
mu = 1; 

global n_ed %number of element dofs
global n_el %number of elements
global n_en % max  of n_en 's
global n_en_u %number of displacement element nodes
global n_en_p  %number of pressure element nodes
global n_ee % number of equations of one element
global n_ee_u % number of disp eqns for one element
global n_ee_p % number of pressure eqns for one element
global n_quad_p % number of quad points for pressure elements
global n_quad_u  % number of quad points for disp elements
global n_np  %number of nodal points
global LM    %Loccation matrix
global G_soln %global solution matrix
global IEN % element nodes matrix 
global ID % destination matrix
global BC % dirichlet boundary  conditions
global node_coords % coordinates of the  nodes 
global dim  % number of spatial dimensions

dim=2;      % number of spatial dimensions
n_quad_p=9; % when these quad rules are not equal,
n_quad_u=9; % modify get_shp_fnc & get_JxW to account for that

% square [0,1]x[0,1]
%1: 4 element, clamped 4 sides. 
%2: 16 element, clamped 4 sides. 
%3: 64 element, clamped 4 sides. 
%4: 256 element, clamped 4 sides.
%5: 1024 element, clamped 4 sides. 
%6: 1 element, top and bottom clampled
%7: 1 element, left and right clampled
create_mesh (3); 

n_eq=max(ID(:));  % number of global equations

G_soln           = zeros(n_eq,1);
G_Res            = zeros(n_eq,1);
G_Tang           = zeros(n_eq,n_eq);
N_u_vec          = zeros(n_ee_u,2); %vector
N_p              = zeros(n_ee_p,1);
N_u_symgrad      = zeros(2,2,n_ee_u);
N_u_div          = zeros(n_ee_u,1);

tmp                      = ID(3,:);
pressure_eqn_numbers     = tmp(tmp>0)';
tmp                      = ID(1:2,:);
displacement_eqn_numbers = tmp(tmp>0);

for element_iterator=1:n_el
    E_Res=  zeros(n_ee,1);
    E_Tang= zeros(n_ee,n_ee);
    
    E_soln_u=get_element_displacements(element_iterator);
    E_soln_p=get_element_pressures(element_iterator);
    nodes_of_element= IEN (:,element_iterator);
    element_coords = node_coords(nodes_of_element,:);
    
    %calculate residual of pressure
    %loop on all quadrature points
    for quad_iterator_p=1:n_quad_p
        quad_iterator_u=quad_iterator_p; % using same quad rule
        
        %N_p is a vector for all shape functions, only this quad point
        N_p=get_shape_fnc_vals(quad_iterator_p,n_quad_p, n_en_p);
        
        %N_u is an array for all shape functions, only this quad point
        N_u=get_shape_fnc_vals(quad_iterator_u, n_quad_u, n_en_u);
        N_u=repelem(N_u,dim);%repeat each for x&y so that N_u is 16x1
        N_u_vec(1:2:end,1)= N_u(1:2:end);
        N_u_vec(2:2:end,2)= N_u(2:2:end);
        
        %get shape fnc symmetric gradient and divergence
        N_u_symgrad= get_shape_fnc_symgrad(quad_iterator_u,n_quad_u,...
            n_en_u, element_coords);
        N_u_div= get_shape_fnc_div(quad_iterator_u,n_quad_u, n_en_u, ...
            element_coords);
        
        %get  jacobian and integration weights
        JxW_p=get_JxW(quad_iterator_p,n_quad_p,n_en_p,element_coords);
        JxW_u=get_JxW(quad_iterator_u,n_quad_u,n_en_u,element_coords);

        quad_coords_u= get_quad_point_coords(quad_iterator_u, n_quad_u, ... 
            n_en_u,element_coords);
        
        %get body force vector at this quadrature point
        Force= get_force_vector(mu, quad_coords_u(1), quad_coords_u(2));
        %Force = get_force_test(mu, quad_coords_u(1), quad_coords_u(2)); 
        
        for i=1:n_ee
            
            %check if i is a pressure equation
            if (is_p_eqn(i) ~= 1)
                continue
            end
            
            %component index of i th eqn of element
            [~,~,ci]= eqn_to_dof(i);
           
            for j=1:n_ee 
                %component index of j th eqn of element
                [~,~,cj]= eqn_to_dof(j);
                
                %check if j is a disp or pressure equation
                if (is_p_eqn(j) == 1)
                    E_Tang(i,j)  = 0 + E_Tang(i,j) ;
                elseif (is_u_eqn(j) ==1 )
                    E_Tang(i,j)  = ...
                        -N_p(ci)*N_u_div(cj)*JxW_p + E_Tang(i,j);
                else
                    error('this element eqn doesnt belong to disp or pres')
                end
                
            end
            E_Res(i)= 0 + E_Res(i) ; %there is no rhs for presure eqns
        end
        
        for i=1:n_ee
            
            %check if i is a displacement equation
            if (is_u_eqn(i) ~= 1)
                continue
            end
            
            %component index and dof of i th eqn of element
            [cdof,~,ci]= eqn_to_dof(i);

            for j=1:n_ee 
                
                %component index of j th eqn of element
                [~,~,cj]= eqn_to_dof(j);
                
                %check if j is a disp/pressure equation
                if (is_u_eqn(j) == 1) 
                    E_Tang(i,j) =2 * mu * JxW_u *...
                        double_contract(N_u_symgrad(:,:,ci),...
                        N_u_symgrad(:,:,cj))...
                        + E_Tang(i,j);
                elseif (is_p_eqn(j) ==1 )
                    E_Tang(i,j) = ...
                        -N_u_div(ci) * N_p(cj) * JxW_u + E_Tang(i,j);
                else
                    error('this element eqn doesnt belong to disp or pres')
                end
                
            end
            E_Res(i)= (N_u_vec(ci,:)*Force')* JxW_u  +E_Res(i);
        end
    end
    
    
        
    %assemble element tangent and residual to global ones
    % i,j are eqn indices in element level
    % I,J are  "    "      " global  level
    for i=1:n_ee
        [dof_i, local_node_i] = eqn_to_dof(i);
        I=LM(dof_i,local_node_i,element_iterator);
        if (I==0)
            continue
        end
        
        for j=1:n_ee
            [dof_j, local_node_j] = eqn_to_dof(j);
            J= LM(dof_j,local_node_j,element_iterator);
            if (J==0)
                continue
            end
            
            G_Tang(I,J) = G_Tang(I,J) + E_Tang(i,j);
        end
        
        G_Res(I) = G_Res(I)+ E_Res(i);
    end
end

%Check for convergence with the updated residual
%Accept the solution if error is small


%if solution hasn't converged yet:
%solve the system to find increment of solution vector
K_mat= G_Tang(displacement_eqn_numbers,  displacement_eqn_numbers);
G_mat= G_Tang(displacement_eqn_numbers,  pressure_eqn_numbers);
GT_mat=G_Tang(pressure_eqn_numbers,      displacement_eqn_numbers); 
M_mat= G_Tang(pressure_eqn_numbers,      pressure_eqn_numbers);
F_mat= G_Res (displacement_eqn_numbers); 
H_mat= G_Res (pressure_eqn_numbers); 

%solve
% 1- solve for pressures
K_hat= GT_mat*inv(K_mat)*G_mat;
F_hat= GT_mat*inv(K_mat)*F_mat-H_mat;
Pressure_soln=  K_hat\F_hat; 

% 2- obtain displacements
Displacement_soln= K_mat\(F_mat-G_mat*Pressure_soln);

G_soln(displacement_eqn_numbers)=Displacement_soln;
G_soln(pressure_eqn_numbers)    =Pressure_soln;

%plot the displacement results.
%argument is the scaling of displacements. choose small
Plot_deformed_mesh(1.0); 

%calculate errors
L2_error_velocity = compare_results(n_quad_u);
% L2_error_velocity = compare_results_test(n_quad_u);



