pi = [zeros(1,7);ones(1,7)];
b = [(6/7)*ones(1,7);(1/7)*ones(1,7)];
w = [1,1,1,1,1,1,10,1];
x = [2,0,0,0,0,0,0,1;0,2,0,0,0,0,0,1;0,0,2,0,0,0,0,1;0,0,0,2,0,0,0,1;0,0,0,0,2,0,0,1;0,0,0,0,0,2,0,1;0,0,0,0,0,0,1,2];
so = [1,2,3,4,5,6,7];
p = (1/6)*ones(1,6);
alpha = 0.01;
gamma = 0.99;
s = randi(7);
r = 0;
w1 = [w];

for i = 1:1000
    h = randsample([1;2],1,true,b(:,1));
    if h == 1
        temp = so(so~=s);
        %sd = randsample(temp,1,true,p);
        sd = randi(6);
    else
        sd = 7;
    end
    rho = pi(h,s)/b(h,s);
    del = r + gamma*v(x(sd,:),w) - v(x(s,:),w);
    del = del*alpha*rho;  
    w = w + del*x(s,:);
    s = sd;
    w1 = [w1;w];
end

figure;
plot(1:1000,w1(2:1001,8));
hold on;
plot(1:1000,w1(2:1001,7));
hold on;
plot(1:1000,w1(2:1001,6));
hold on;
plot(1:1000,w1(2:1001,5));
hold on;
plot(1:1000,w1(2:1001,4));
hold on;
plot(1:1000,w1(2:1001,3));
hold on;
plot(1:1000,w1(2:1001,2));
hold on;
plot(1:1000,w1(2:1001,1));
hold on;

function v1 = v(xi,wi)
    v1 = dot(wi,transpose(xi));
end


    
    