function IB_homework3
    rand_policy = zeros(9);
    for i = 1:9
        for j = 1:9
            if i<=j
                rand_policy(i,j) = 1/j;
            end
        end
    end
    policy_eval(rand_policy);
    [value,p] = value_iter(rand_policy);
    g1=sprintf('%g  ',value);
    fprintf('Value iteration - Values: %s\n', g1);
    disp('Value iteration - Policy:');
    disp(p);
    
end
function [v,pn] = policy_eval(p)
    theta = 0.00001;
    value = zeros(1,9);
    while true
        del = 0;
        for state = 1:9
            v1 = 0;
            for ai = 1:9
                reward = ai;
                if state-reward>0 && state+reward<10
                    v1 = v1 + p(ai,state)*(0.9*(reward + value(state+reward))+ 0.1*(value(state-reward)-reward));
                elseif state-reward>0 && state+reward>=10
                    v1 = v1 + p(ai,state)*(0.9*(reward + 0)+ 0.1*(value(state-reward)-reward));
                elseif state-reward<=0 && state+reward<10
                    v1 = v1 + p(ai,state)*(0.9*(reward + value(state+reward))+ 0.1*(0-reward));
                elseif state-reward<=0 && state+reward>=10
                    v1 = v1 + p(ai,state)*(0.9*(reward + 0)+ 0.1*(0-reward));
                end
            end
            del = max(del, abs(v1  - value(state)));
            value(state) = v1;
        end
        if (del<theta)
            break;
        end
    end
    [pn, flag] = policy_improv(value,p);
    if flag
        v = value;
        g1=sprintf('%g  ',v);
        fprintf('Policy iteration - Values: %s\n', g1);
        disp('Policy iteration - Policy:');
        disp(pn);
    else
        policy_eval(pn);
    end
end

function [pn, flag]= policy_improv(value, p)
    flag = 1;
    oa = p;
    for state = 1:9
        %oa = p(:,state);
        q = [];
        for ai = 1:state
            reward = ai;
            if state-reward>0 && state+reward<10
                q(ai) = (0.9*(reward + value(state+reward))+ 0.1*(value(state-reward)-reward));
            elseif state-reward>0 && state+reward>=10
                q(ai) = (0.9*(reward + 0)+ 0.1*(value(state-reward)-reward));
            elseif state-reward<=0 && state+reward<10
                q(ai) = (0.9*(reward + value(state+reward))+ 0.1*(0-reward));
            elseif state-reward<=0 && state+reward>=10
                q(ai) = (0.9*(reward + 0)+ 0.1*(0-reward));
            end
        end
        [G,I] = max(q);
        na = find(q==G);
        p(:,state) = zeros(length(p(:,state)),1);
        if length(na)>1
            for j = 1:length(na)
                p(na(j),state) = 1/length(na);
            end
        else
            p(na,state) = 1;
        end
        
    end
    if ~isequal(oa,p)
        flag = 0;
    end
    pn = p;
end

function [value,p] = value_iter(p)
    theta = 0.00001;
    value = zeros(1,9);
    while true
        del = 0;
        for state = 1:9
            v = [];
            for ai = 1:9
                reward = ai;
                if state-reward>0 && state+reward<10
                    v(ai) = (0.4*(reward + value(state+reward))+ 0.6*(value(state-reward)-reward));
                elseif state-reward>0 && state+reward>=10
                    v(ai) = (0.4*(reward + 0)+ 0.6*(value(state-reward)-reward));
                elseif state-reward<=0 && state+reward<10
                    v(ai) = (0.4*(reward + value(state+reward))+ 0.6*(0-reward));
                elseif state-reward<=0 && state+reward>=10
                    v(ai) = (0.4*(reward + 0)+ 0.6*(0-reward));
                end
            end
            [v1,I1] = max(v);
            del = max(del, abs(v1 - value(state)));
            value(state) = v1;
        end
        
        
        for state = 1:9
            q = [];
            for ai = 1:state
                reward = ai;
                if state-reward>0 && state+reward<10
                    q(ai) = (0.4*(reward + value(state+reward))+ 0.6*(value(state-reward)-reward));
                elseif state-reward>0 && state+reward>=10
                    q(ai) = (0.4*(reward + 0)+ 0.6*(value(state-reward)-reward));
                elseif state-reward<=0 && state+reward<10
                	q(ai) = (0.4*(reward + value(state+reward))+ 0.6*(0-reward));
                elseif state-reward<=0 && state+reward>=10
                    q(ai) = (0.4*(reward + 0)+ 0.6*(0-reward));
                end
            end
            [G,I] = max(q);
            na = find(q==G);
            p(:,state) = zeros(length(p(:,state)),1);
            if length(na)>1
                for j = 1:length(na)
                    p(na(j),state) = 1/length(na);
                end
            else
                p(na,state) = 1;
            end
        end
        
        if (del<theta)
            break;
        end
    end
 end
    