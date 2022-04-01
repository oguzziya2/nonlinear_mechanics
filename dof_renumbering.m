function [index_map] = dof_renumbering(renumbering_type)

% run dof renumbering early in the FEM code after mesh creation and
% before any assemblies. Because this code doesnt renumber global 
% tangent and residual. and here we  keep global node numbers unchanged,
% just associated global eqn numbers are changed. 

% and this doesnt affect the element  dof order. 
% that info is in dof_to_eqn and eqn_to_dof.

index_map= zeros(2,2);

global ID

switch renumbering_type
    
    case 'component'
        
        ID_new= zeros(size (ID));
        
        tmp                      = ID(3,:);
        pressure_eqn_numbers     = tmp(tmp>0);
        tmp                      = ID(1:2,:);
        displacement_eqn_numbers = tmp(tmp>0);
        
        length_disp=length(displacement_eqn_numbers);
        length_pres=length(pressure_eqn_numbers);
        length_total=length_disp + length_pres;
        
        %new indices of disp and pressure eqns
        disp_new= 1:length_disp; %disp component comes first
        p_new=   (length_disp+1):length_total; %pres component comes second
        
        for i=1:length_disp
            [row,col] = find(ID == displacement_eqn_numbers(i)) ;
            ID_new(row,col) =disp_new(i);
        end
        
        for j=1:length_pres
            [row,col] = find(ID == pressure_eqn_numbers(j)) ;
            ID_new(row,col) = p_new(j);
        end
        
        ID= ID_new;
        
    case 'dof'
        error('this type of renumbering has not been implemented' )
    otherwise
        error('this type of renumbering has not been implemented' ) 
end

end

