%�����ǽ������������̵ķ�����
%a*x1+b*y1+c=0
%a*x2+b*y2+c=0
%a^2+b^2=1
%����ϵ��[a b c]
function line=Mytls(data)
    x = data(1, :);
    y = data(2, :);

    k=(y(1)-y(2))/(x(1)-x(2));      %ֱ��б�ʣ���Щ����϶���Ҫ�����жϣ����������
    a=sqrt(1-1/(1+k^2));
    b=sqrt(1-a^2);

    if k>0          %���б�ʴ���0��a,b���
       b=-b; 
    end
    
    c=-a*x(1)-b*y(1);
    line=[a b c];
end