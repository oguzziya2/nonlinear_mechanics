function [C] = double_contract(A,B)
%this function calculates double contract between last two 
% indices of A and first two indices of B

    assert(isequal(size(A),size(B)), 'sizes of two matrices are not same')
    C = sum(dot(A,B));

end
