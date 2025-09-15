function f=fib(n)
if n==0
    f=0;
else if n==1
        f=1;
else
    f=fib(n-1)+fib(n-2);
end
end