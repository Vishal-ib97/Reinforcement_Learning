p = zeros(1002,1002);
for j = 2:1001
    if j<=101
        for t = 2:j-1
            p(j,t) = 1/100;
        end
        p(j,1) = (102-j)/100;
        for t = j+1:j+100
            p(j,t) = 1/100;
        end
    elseif j>=902
        for g = j+1:1001
            p(j,g) = 1/100;
        end
        p(j,1002) = (j-901)/100;
        for g = j-100:j-1
            p(j,g) = 1/100;
        end
    else
        for k = j-100:j-1
            p(j,k) = 1/100;
        end
        for k = j+1:j+100
            p(j,k) = 1/100;
        end
    end
end
theta = 0.00001;
value = zeros(1,1002);

while true
    del = 0;
    for s = 2:1001
        v1 = 0;
        %o = 0;
        for sd = 1:1002
            if sd == 1
                v1 = v1 + (0.5*(p(s,sd)*(value(sd)-1)));
            elseif sd == 1002
                v1 = v1 + (0.5*(p(s,sd)*(value(sd)+ 1)));
            else
                v1 = v1 + (0.5*(p(s,sd)*(value(sd))));
            end
        end
        del = max(del,abs(v1 - value(s)));
        value(s) = v1;
    end
    if(del<theta)
        break;
    end
end
w = zeros(1,10);
vc = [w(1)*ones(1,100),w(2)*ones(1,100),w(3)*ones(1,100),w(4)*ones(1,100),w(5)*ones(1,100),w(6)*ones(1,100),w(7)*ones(1,100),w(8)*ones(1,100),w(9)*ones(1,100),w(10)*ones(1,100)];
al = 0.00002;
x = 1;
while x <=100000
    x = x+1;
    s = [];
    s = [s,500];
    a = [];
    r = [];
    while true
        u = s(length(s));
        a1 = randi(2);
        if u == 1001
            if a1 == 1
                sd = randsample(u-100:u-1,1,true,p(u,u-100:u-1));
            else
                sd = 1002;
            end
                
        elseif u <=101
            if a1 == 1
                sd = randsample(1:u-1,1,true,p(u,1:u-1));
            else
                sd = randsample(u+1:100+u,1,true,p(u,u+1:u+100));
            end
        elseif u>=902
            if a1 == 1
                sd = randsample(u-100:u-1,1,true,p(u,u-100:u-1));
            else
                sd = randsample(u+1:1002,1,true,p(u,u+1:1002));
            end
        else
            if a1 == 1
                sd = randsample(u-100:u-1,1,true,p(u,u-100:u-1));
            else
                sd = randsample(u+1:u+100,1,true,p(u,u+1:u+100));
            end
        end
            
        s = [s,sd];
        if sd == 1 
            r1 = -1;
            r = [r,r1];
            break;
        elseif sd == 1002
            r1 = 1;
            r = [r,r1];
            break;
        else 
            r1 = 0;
        end
        r = [r,r1];
    end
    for t = 1:length(s)-1
        if s(t) ~= 1000 && s(t)~=1001
            y = fix(s(t)/100)+1;
        else
            y = 10;
        end
        if sd == 1
            g = -1;
        else
            g = 1;
        end
        w(y) = w(y) + al*(g - w(y));    
    end
end

vc = [w(1)*ones(1,100),w(2)*ones(1,100),w(3)*ones(1,100),w(4)*ones(1,100),w(5)*ones(1,100),w(6)*ones(1,100),w(7)*ones(1,100),w(8)*ones(1,100),w(9)*ones(1,100),w(10)*ones(1,100)];

w = zeros(1,11);
al = 0.00002;
x = 1;
while x <=100000 
    x = x+1;
    u = 500;
    sd = 0;
    while true
        a1 = randi(2);
        if u == 1001
            if a1 == 1
                sd = randsample(u-100:u-1,1,true,p(u,u-100:u-1));
            else
                sd = 1002;
            end
                
        elseif u <=101
            if a1 == 1
                sd = randsample(1:u-1,1,true,p(u,1:u-1));
            else
                sd = randsample(u+1:100+u,1,true,p(u,u+1:u+100));
            end
        elseif u>=902
            if a1 == 1
                sd = randsample(u-100:u-1,1,true,p(u,u-100:u-1));
            else
                sd = randsample(u+1:1002,1,true,p(u,u+1:1002));
            end
        else
            if a1 == 1
                sd = randsample(u-100:u-1,1,true,p(u,u-100:u-1));
            else
                sd = randsample(u+1:u+100,1,true,p(u,u+1:u+100));
            end
        end
            
        if sd == 1 
            r1 = -1;
        elseif sd == 1002
            r1 = 1;
        else 
            r1 = 0;
        end
        
        if u ~= 1000 && u~=1001
            y = fix(u/100)+1;
        else
            y = 10;
        end
        
        if sd ~= 1000 && sd ~= 1001
            i = fix(sd/100)+1;
        else
            i = 10;
        end
        
        w(y) = w(y) + al*(r1 + w(i)-w(y));
        u = sd;
        if sd == 1 || sd == 1002
            break;
        end
        
    end
end

vc1 = [w(1)*ones(1,100),w(2)*ones(1,100),w(3)*ones(1,100),w(4)*ones(1,100),w(5)*ones(1,100),w(6)*ones(1,100),w(7)*ones(1,100),w(8)*ones(1,100),w(9)*ones(1,100),w(10)*ones(1,100)];
figure;
plot(value(2:1001));
hold on;
plot(vc);
hold on;
plot(vc1);
        
        
    
    
    
    