function V = HeatEquation(n,b,w)
h = b/(n+1);
x = h:h:b-h;
A1 = toeplitz([4;-1; zeros(n-2, 1)], [4; -1; zeros(n-2,1)]);
A2 = -1*eye(n);
A3 = zeros(n);
% Genarate matrix T[n^2,n^2]
T=[];
X=[];
Y=[];
for i=1:n
    B=[];
    for j=1:n
        X=[X x(i)];
        Y=[Y x(j)];
        if i==j
            B=[B A1];
        elseif i==j+1 || j==i+1
            B=[B A2];
        else
            B=[B A3];
        end
    end
    T=[T;B];
end
F=fxy(X,Y,w)';
V=T\F;


