%这里是解如下三个方程的方程组
%a*x1+b*y1+c=0
%a*x2+b*y2+c=0
%a^2+b^2=1
%返回系数[a b c]
function line=Mytls(data)
    x = data(1, :);
    y = data(2, :);

    k=(y(1)-y(2))/(x(1)-x(2));      %直线斜率，有些情况肯定需要个别判断，这里忽略了
    a=sqrt(1-1/(1+k^2));
    b=sqrt(1-a^2);

    if k>0          %如果斜率大于0，a,b异号
       b=-b; 
    end
    
    c=-a*x(1)-b*y(1);
    line=[a b c];
end