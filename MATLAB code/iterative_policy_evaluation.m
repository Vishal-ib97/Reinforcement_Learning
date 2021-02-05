function IB_homework2
    agg_policy = diag(ones(1,9));
    cons_policy = zeros(9);
    cons_policy(1,:) = 1;
    rand_policy = zeros(9);
    for i = 1:9
        for j = 1:9
            if i<=j
                rand_policy(i,j) = 1/j;
            end
        end
    end
    g1=sprintf('%g ', policy(agg_policy));
    fprintf('Values for aggessive policy : %s\n', g1);
    g2=sprintf('%g ', policy(cons_policy));
    fprintf('\n Values for conservative policy  : %s\n', g2);
    g3=sprintf('%g ', policy(rand_policy));
    fprintf('\n Values for random policy  : %s\n', g3);
end
function value = policy(p)
    theta = 0.00001;
    value = zeros(1,10);
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
end
    