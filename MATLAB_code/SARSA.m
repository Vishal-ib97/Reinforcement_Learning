alpha  = 0.5;
epsilon = 0.1;
f = 0;
for k = 1:7
    q(k,:) = {[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]};
end
time_step = [];
d = {[0,-1],[-1,0],[0,1],[1,0]};
w = zeros(7,10);
tim = [];
for h = 1:10
    for g = 1:7
        if h ==4 || h==5 || h==6 || h==9
            w(g,h) = -1;
        elseif h==7 || h==8 
            w(g,h) = -2;
        end
    end
end
%w(2,7) = 1;
%w(2,8) = 1;
c = 0;
while c<200
    count = 0;
    s1 = 4;
    s2 = 1;
    r = 0;
    if rand()<=(1-epsilon)
        [G,I] = max(q{4,1});
        m = find(q{4,1}==G);
        e = randi(length(m));
        a = m(e);
    else
        a = randi(4);
    end
    while true
        r = -1;
        if s1+d{1,a}(1)>0 && s2+d{1,a}(2)>0 && s1+d{1,a}(1)<=7 && s2+d{1,a}(2)<=10
            if s1+d{1,a}(1)+w(s1,s2)>0 && s1+d{1,a}(1)+w(s1,s2)<=7 
                ns1 = s1+d{1,a}(1)+w(s1,s2);
                ns2 = s2+d{1,a}(2);
            elseif s1+d{1,a}(1)+w(s1,s2)+1>0 && w(s1,s2)==2
                ns1 = s1+d{1,a}(1)+w(s1,s2)+1;
                ns2 = s2+d{1,a}(2);
            else    
                ns1 = s1+d{1,a}(1);
                ns2 = s2+d{1,a}(2);
            end
        else
            ns1 = s1;
            ns2 = s2;
        end
        
        if rand()<=1-epsilon
            [ma,O] = max(q{ns1,ns2});
            sm = find(q{ns1,ns2}==ma);
            a1 = randi(length(sm));
            na = sm(a1);
        else
            na = randi(4);
        end
        q{s1,s2}(a) = q{s1,s2}(a) + alpha*(r + q{ns1,ns2}(na) - q{s1,s2}(a));
        s1 = ns1;
        s2 = ns2;
        a = na;
        count = count + 1;
        f = f+1;
        if s1 == 4 && s2 == 8
            break;
        end
    end
    c = c + 1;
    if c==1
        time_step = [zeros(1,count-1), c];
    else
        time_step = [time_step, ones(1,count)*c];
    end
    
end
figure;
tim = 1:length(time_step);
plot(tim,time_step);
    
    

        
   

    
    
            
            
        
        
        
        
            
