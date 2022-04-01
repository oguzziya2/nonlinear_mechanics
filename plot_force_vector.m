mu =1 

x= 0:0.01:1;
y= 0:0.01:1;
[X,Y] = meshgrid (x,y) ;

z=zeros(length(x), length(y) ,2 );
for  i =1:length(x)
    for j =1:length(y)
        
        z(i,j,:)= force_vector( mu , x(i), y(j) );
        
    end
end

figure(1)
surf (X,Y,z(:,:,1))

figure(2)
surf (X,Y,z(:,:,2))