function A = FlaecheStern(n)
delta=pi()/n;
if mod(n,2)~=0
    A=n*(sin((n-1)*delta)*sin(delta))/(sin(delta)+sin((n-2)*delta));
else
    A=n*(sin((n-2)*delta)*sin(delta))/(sin(delta)+sin((n-3)*delta));
end

