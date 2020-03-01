clc
clear
close all
t=0:0.1:15;
x= sin(0.2*pi.*t);
ind=1:2:length(x);
xs=x(ind);

[y,xq]=quantizer(xs,16,1);

var_error=var(y-xs);
SQNR=(var_error.^-1)
x_encode=0:15;
y_encode=zeros(1,length(y));
for i=1:length(xq)
    ind2=find(y==xq(i));
    y_encode(ind2)=x_encode(i);
end

s=unique(y_encode);
p=zeros(1,length(s));
for i=1:length(s)
    tmp=length(find(y_encode==s(i)));
    pk=tmp/length(y);
    p(i)=pk;
end
Is=log2(1./p)
H=sum(p.*Is)
vk=ceil(Is);
L=sum(p.*vk)
efficiency=H./L
cr=(length(s))/L
dict = huffmandict(s,p); % Create dictionary.
hcode = huffmanenco(y_encode,dict); % Encode the data.
dhsig = huffmandeco(hcode,dict); % Decode the code.
y_decode=xq(dhsig+1);
plot(t,x,'b');
hold on 
plot(t(ind),y_decode,'r')
legend('original','output')
ylabel('magnitude');
xlabel('time')

