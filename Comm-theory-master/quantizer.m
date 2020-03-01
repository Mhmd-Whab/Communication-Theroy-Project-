function [ y,xq ] = quantizer( x,l,a )
delta=(2*a)/l;
xs=-a:delta:a;
xq=zeros(1,length(xs)-1);
for i=1:length(xs)-1
    xq(i)=(xs(i)+xs(i+1))/2;
end

y=zeros(1,length(x));
for i=1:length(x)
    for j=1:length(xs)
        t=xs(j);
        if x(i)<t
            y(i)=xq(j-1);
            break;
        end
    end
end

end

