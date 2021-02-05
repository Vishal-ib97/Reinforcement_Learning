clc;
close all;
c = 2; 
tic;
for n=1:2000
    A = zeros(10,1000);
    R = zeros(10,1000); 
    Q = zeros(10,1000); 
    Au = zeros(10,1000);
    Ru = zeros(10,1000); 
    Qu = zeros(10,1000);
    for i=1:10
        a(i)= normrnd(0,1);        
    end
   
    ra= randi(10);
    
    %for e-greedy
    A(ra,1)=1;
    R(ra,1)= normrnd(a(ra),1);
    
    %for ucb
    Au(ra,1)=1;
    Ru(ra,1)= normrnd(a(ra),1);
    
    for t=2:1000
        
        for i=1:10
            if nnz(A(i,:))~=0
                Q(i,t)= sum(R(i,:))/nnz(A(i,:));
            else
                Q(i,t)=0;
            end
            if nnz(Au(i,:))~=0
                Qu(i,t) = (sum(Ru(i,:))/nnz(Au(i,:))) + c*sqrt(log(t)/nnz(Au(i,:)));
            else
                Qu(i,t)=0;
            end
            
        end
        
        
        [G,I]= max(Q(:,(t-1)));
        K= find(Q(:,(t-1))==G);
        r= randi(length(K));
        k= K(r);
        if (0.9>=rand())
            %for e-greedy
            A(k,t)=1;
            R(k,t)= normrnd(a(k),1);  
            %for ucb
            Au(k,t)=1;
            Ru(k,t)= normrnd(a(k),1); 
            
        else
            %for e-greedy
            o = randi(10);
            A(o,t)=1;
            R(o,t)= normrnd(a(o),1); 
            
            %for ucb
            Qu(k,:) = [];
            [Gu,Iu] =  max(Qu(:,(t-1)));
            w = find(Qu(:,(t-1))==Gu);
            e = randi(length(w));
            d = w(e);
            Au(d,t)=1;
            Ru(d,t)= normrnd(a(d),1); 
            
        end
        
    end
RG(n,:)=sum(R);
RGu(n,:) = sum(Ru);
end

for t=1:1000
    Avg(t)= mean(RG(:,t));
    Avgu(t) = mean(RGu(:,t));
end
t=1:1000;
plot(t,Avg)
hold on;
plot(t,Avgu)
ylabel('Average Reward');
xlabel('Steps');
toc;
