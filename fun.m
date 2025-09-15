function f=fun(n)
for i=2:n/2;
    if rem(n,i)~=0
        disp('sushu');
    else
        disp('not sushu');
    end
end
