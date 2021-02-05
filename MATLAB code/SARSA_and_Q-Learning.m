srs = sarsa();
srs1 = qlearn();
srs2 = exp_sarsa();
figure;
x = 1:500;
plot(x,srs);
hold on;
plot(x,srs1);
hold on;
plot(x,srs2);
function srs = sarsa()
    alpha  = 0.5;
    epsilon = 0.1;
    g =0;
    for k = 1:4
        q(k,:) = {[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]};
        %q(k,:) = {[randn(),randn(),randn(),randn()],[randn(),randn(),randn(),randn()],[randn(),randn(),randn(),randn()],[randn(),randn(),randn(),randn()],[randn(),randn(),randn(),randn()],[randn(),randn(),randn(),randn()],[randn(),randn(),randn(),randn()],[randn(),randn(),randn(),randn()],[randn(),randn(),randn(),randn()],[randn(),randn(),randn(),randn()],[randn(),randn(),randn(),randn()],[randn(),randn(),randn(),randn()]};
    end
    %q(4,:) = {[randn(),randn(),randn(),randn()],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]}; 
    sb =[];
    srs = [];
    d = {[0,-1],[-1,0],[0,1],[1,0]};
    c = 0;
    b = 1;
    while b<=30
        b = b+1;
        sr = [];
        c = 0;
        while c<500
            count = 0;
            s1 = 4;
            s2 = 1;
            r1 = 0;
            if rand()<=(1-epsilon)
                [G,I] = max(q{s1,s2});
                a = I;
            else
                a = randi(4);
            end
            while true
                if s1+d{1,a}(1)>0 && s2+d{1,a}(2)>0 && s1+d{1,a}(1)<=4 && s2+d{1,a}(2)<=12
                    if s1+d{1,a}(1)==4 && s2+d{1,a}(2)>1 && s2+d{1,a}(2)<12
                        r = -100;
                        ns1 = 4;
                        ns2 = 1;
                        g = g+1;
                    else
                        r = -1;
                        ns1 = s1+d{1,a}(1);
                        ns2 = s2+d{1,a}(2);
                    end
                else
                    r = -1;
                    ns1 = s1;
                    ns2 = s2;
                end
                r1 = r1 +r;  

                if rand()<=1-epsilon
                    [ma,O] = max(q{ns1,ns2});
                    na = O;
                else
                    na = randi(4);
                end
                q{s1,s2}(a) = q{s1,s2}(a) + alpha*(r + q{ns1,ns2}(na) - q{s1,s2}(a));
                s1 = ns1;
                s2 = ns2;
                a = na;
                count = count + 1;
                if s1 == 4 && s2 == 12
                    break;
                end
            end
            c = c + 1;
            sr = [sr,r1];

        end
        sb = [sb;sr];
        
    end
    
    sb = mean(sb,1);
    for o = 1:10
        srs(o) = sb(o);
    end
    for o = 11:500
        srs(o) = mean(sb(o-10:o));
    end
end

function srs1 = qlearn()

    alpha  = 0.5;
    epsilon = 0.1;
    srs1 = [];
    sb1 = [];
    for k = 1:4
        q(k,:) = {[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]};
        %q(k,:) = {[randn(),randn(),randn(),randn()],[randn(),randn(),randn(),randn()],[randn(),randn(),randn(),randn()],[randn(),randn(),randn(),randn()],[randn(),randn(),randn(),randn()],[randn(),randn(),randn(),randn()],[randn(),randn(),randn(),randn()],[randn(),randn(),randn(),randn()],[randn(),randn(),randn(),randn()],[randn(),randn(),randn(),randn()],[randn(),randn(),randn(),randn()],[randn(),randn(),randn(),randn()]};
    end
    %q(4,:) = {[randn(),randn(),randn(),randn()],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]}; 
    
    d = {[0,-1],[-1,0],[0,1],[1,0]};
    c = 0;
    b= 0;
    while b<30
        b=b+1;
        sr1 =[];
        c =0;
        while c<500

            s1 = 4;
            s2 = 1;
            r1 = 0;
            while true
                if rand()<=(1-epsilon)
                    [G,I] = max(q{s1,s2});
                    a = I;
                else
                    a = randi(4);
                end

                if s1+d{1,a}(1)>0 && s2+d{1,a}(2)>0 && s1+d{1,a}(1)<=4 && s2+d{1,a}(2)<=12
                    if s1+d{1,a}(1)==4 && s2+d{1,a}(2)>1 && s2+d{1,a}(2)<12
                        r = -100;
                        ns1 = 4;
                        ns2 = 1;
                    else
                        r = -1;
                        ns1 = s1+d{1,a}(1);
                        ns2 = s2+d{1,a}(2);
                    end
                else
                    r = -1;
                    ns1 = s1;
                    ns2 = s2;
                end
                r1 = r1 +r; 
                [f,p] = max(q{ns1,ns2});
                q{s1,s2}(a) = q{s1,s2}(a) + alpha*(r + f - q{s1,s2}(a));
                s1 = ns1;
                s2 = ns2;

                if s1 == 4 && s2 == 12
                    break;
                end
            end
            sr1 = [sr1,r1];
            c = c+1;
        end
        sb1 = [sb1;sr1];
    end
    
    sb1 = mean(sb1,1);
    for o = 1:10
        srs1(o) = sb1(o);
    end
    for o = 11:500
        srs1(o) = mean(sb1(o-10:o));
    end
   
end

function srs2 = exp_sarsa()
    alpha  = 0.5;
    epsilon = 0.1;
    gamma = 1;
    srs2 = [];
    for k = 1:4
        q(k,:) = {[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]};
        %q(k,:) = {[randn(),randn(),randn(),randn()],[randn(),randn(),randn(),randn()],[randn(),randn(),randn(),randn()],[randn(),randn(),randn(),randn()],[randn(),randn(),randn(),randn()],[randn(),randn(),randn(),randn()],[randn(),randn(),randn(),randn()],[randn(),randn(),randn(),randn()],[randn(),randn(),randn(),randn()],[randn(),randn(),randn(),randn()],[randn(),randn(),randn(),randn()],[randn(),randn(),randn(),randn()]};
    end
    %q(4,:) = {[randn(),randn(),randn(),randn()],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]}; 
    sb2 = [];
    d = {[0,-1],[-1,0],[0,1],[1,0]};
    c = 0;
    b=0;
    while b<30
        b = b+1;
        sr2 = [];
        c =0;
        while c<500

            s1 = 4;
            s2 = 1;
            r1 = 0;
            count = 0;

            while true
                if rand()<=(1-epsilon)
                    [G,I] = max(q{s1,s2});
                    a = I;
                else
                    a = randi(4);
                end

                if s1+d{1,a}(1)>0 && s2+d{1,a}(2)>0 && s1+d{1,a}(1)<=4 && s2+d{1,a}(2)<=12
                    if s1+d{1,a}(1)==4 && s2+d{1,a}(2)>1 && s2+d{1,a}(2)<12
                        r = -100;
                        ns1 = 4;
                        ns2 = 1;
                    else
                        r = -1;
                        ns1 = s1+d{1,a}(1);
                        ns2 = s2+d{1,a}(2);
                    end
                else
                    r = -1;
                    ns1 = s1;
                    ns2 = s2;
                end
                r1 = r1 +r; 
                count = count + 1;
                if ns1 == 4 && ns2 == 12
                    break;
                end
                ex = 0;
                e = ones(1,4)*(0.1/3);
                [m,i] = max(q{ns1,ns2});
                e(i) = 0.9;
                for k = 1:4
                    ex = ex + e(k)*q{ns1,ns2}(k);
                end

                q{s1,s2}(a) = q{s1,s2}(a) + alpha*(r + gamma*(ex) - q{s1,s2}(a));
                s1 = ns1;
                s2 = ns2;
            end
            sr2 = [sr2,r1];
            c = c+1;
        end
        sb2 = [sb2;sr2];
    end
    sb2 = mean(sb2,1);
    
    for o = 1:10
        srs2(o) = sb2(o);
    end
    for o = 11:500
        srs2(o) = mean(sb2(o-10:o));
    end
end
   
    

    

    
    


