function  result = is_p_eqn (eqn)

[dof, ~]= eqn_to_dof(eqn);
if dof==3
    result=true;
else
    result=false;
end

end

