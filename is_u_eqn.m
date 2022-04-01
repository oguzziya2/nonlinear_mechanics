function  result = is_u_eqn (eqn)

[dof, ~]= eqn_to_dof(eqn);
if ((dof==1)||(dof==2))
    result=true;
else
    result=false;
end

end
