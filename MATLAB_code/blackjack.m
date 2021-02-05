for i = 1:21
    if i == 20 || i == 21
        p(i,:) = {[0,1],[0,1],[0,1],[0,1],[0,1],[0,1],[0,1],[0,1],[0,1],[0,1]};
    elseif i<=11
        p(i,:) = {[],[],[],[],[],[],[],[],[],[]};
    else
        p(i,:) = {[1,0],[1,0],[1,0],[1,0],[1,0],[1,0],[1,0],[1,0],[1,0],[1,0]};
    end
end

for j = 1:21
    q(j,:) = {[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0]};
end

for k = 1:21
    ret(k,:) = {{[],[]},{[],[]},{[],[]},{[],[]},{[],[]},{[],[]},{[],[]},{[],[]},{[],[]},{[],[]}};
end

z = noace_nohit();
for i = 1:21
    fprintf(' %.0f,%.0f,%.0f,%.0f,%.0f,%.0f,%.0f,%.0f,%.0f,%.0f',z{i,:})
    fprintf('\n');
end
m = noace_hit();
for i = 1:21
    fprintf(' %.0f,%.0f,%.0f,%.0f,%.0f,%.0f,%.0f,%.0f,%.0f,%.0f',m{i,:})
    fprintf('\n');
end
v = ace_nohit();
for i = 1:21
    fprintf(' %.0f,%.0f,%.0f,%.0f,%.0f,%.0f,%.0f,%.0f,%.0f,%.0f',v{i,:})
    fprintf('\n');
end
u = ace_hit();
for i = 1:21
    fprintf(' %.0f,%.0f,%.0f,%.0f,%.0f,%.0f,%.0f,%.0f,%.0f,%.0f',u{i,:})
    fprintf('\n');
end





function p = noace_nohit()
    for i = 1:21
        if i == 20 || i == 21
            p(i,:) = {[0,1],[0,1],[0,1],[0,1],[0,1],[0,1],[0,1],[0,1],[0,1],[0,1]};
        elseif i<=11
            p(i,:) = {[],[],[],[],[],[],[],[],[],[]};
        else
            p(i,:) = {[1,0],[1,0],[1,0],[1,0],[1,0],[1,0],[1,0],[1,0],[1,0],[1,0]};
        end
    end

    for j = 1:21
        q(j,:) = {[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0]};
    end

    for k = 1:21
        ret(k,:) = {{[],[]},{[],[]},{[],[]},{[],[]},{[],[]},{[],[]},{[],[]},{[],[]},{[],[]},{[],[]}};
    end
    %ret2 = [];

    for L = 1:5000000
        %ret2 = [];
        e = {};
        %so1 = randi([12,21],1);
        ra = randi([1,13],1);
        if ra == 11 || ra == 12 || ra == 13
            a = 10;
        else
            a = ra;
        end
        so1 = a + 11;
        %sum = [];
        sum = [so1];
        %so22 = randi([1,10],1);
        ra = randi([1,13],1);
        if ra == 11 || ra == 12 || ra == 13
            so22 = 10;
        else
            so22 = ra;
        end
        %ds = [];
        d = [so22];
        ds = [so22];
        ao = find(p{so1,so22}==1);
        e = {[so1,so22,ao]};
        while p{so1,so22}(1)==1
            %w = randi([1,10],1);
            ra = randi([1,13],1);
            if ra == 11 || ra == 12 || ra == 13
                w = 10;
            else
                w = ra;
            end
            so1 = so1+w;
            sum = [sum,so1];

                %so2 = so2;
                %so2 = randi([1,10],1);
                %ds = ds + so2;
            %e{end} = [e{end},rp];
            if so1<=21
                e = [e(:)',{[so1,so22,find(p{so1,so22}==1)]}];
                ds = [ds,so22];
            else
                ds = [ds so22];
                break;
            end

        end
        flagesh = 1;
        fe = 1;
        if so1<=21
            while flagesh == 1
                %so2 = randi([1,10],1);
                ra = randi([1,13],1);
                if ra == 11 || ra == 12 || ra == 13
                    so2 = 10;
                else
                    so2 = ra;
                end
                d = [d,so2];
                ds1 = ds(length(ds));
                ds = [ds,ds1+so2];
                poly = find(d==1);
                if isempty(poly)==0 && fe == 1 
                    if ds(length(ds))+10 <= 21
                        ds(length(ds)) = ds(length(ds)) + 10;
                        fe = 0;
                    end
                end

                if ds(length(ds))<17 
                    e = [e(:)',{[so1,so2,find(p{so1,so2}==1)]}];
                    flagesh = 1;
                else
                    flagesh = 0;
                end
            end
        end
        rp = zeros(1,length(e));
        if so1>21
            rp(length(rp)) = -1;
        elseif so1>ds(length(ds))&&so1<=21
            rp(length(rp)) = 1;
        elseif so1<ds(length(ds))
            if ds(length(ds))<=21
                rp(length(rp)) = -1;
            else
                rp(length(rp)) = 1;
            end
        elseif so1 == ds(length(ds))
            rp(length(rp)) = 0;

        end
        g = 0;
        for x = length(e):-1:1
            g = g + rp(x);
            flag = 0;

            for h = 1:x-1
                if e{1,h} == e{1,x}
                %if sola(h)==sola(x) && sola2(h)==sola2(x) && sola3(h)==sola3(x)
                    flag = 0;
                    break;
                else
                    flag = 1;
                end
            end


            if flag == 1
                at = e{1,x}(3);
                %ret2 = [ret2,g];
                ret{e{1,x}(1),e{1,x}(2)}{1,e{1,x}(3)} = [ret{e{1,x}(1),e{1,x}(2)}{1,e{1,x}(3)},g];
                %ret{e{1,x}(1),e{1,x}(2)}{1,e{1,x}(3)}
                q{e{1,x}(1),e{1,x}(2)}(e{1,x}(3)) = mean(ret{e{1,x}(1),e{1,x}(2)}{1,e{1,x}(3)});
                %q{e{1,x}(1),e{1,x}(2)}(at) = mean(ret2);
                [G,I] = max(q{e{1,x}(1),e{1,x}(2)});

                %na = find(q{e{1,x}(1),e{1,x}(2)} == G);

                p{e{1,x}(1),e{1,x}(2)}(I) = 1;
                if I==1
                    p{e{1,x}(1),e{1,x}(2)}(2) = 0;
                elseif I==2
                    p{e{1,x}(1),e{1,x}(2)}(1) = 0;
                end
            end
        end

    end
    
end

function p = noace_hit()
    for i = 1:21
        if i == 20 || i == 21
            p(i,:) = {[0,1],[0,1],[0,1],[0,1],[0,1],[0,1],[0,1],[0,1],[0,1],[0,1]};
        elseif i<=11
            p(i,:) = {[],[],[],[],[],[],[],[],[],[]};
        else
            p(i,:) = {[1,0],[1,0],[1,0],[1,0],[1,0],[1,0],[1,0],[1,0],[1,0],[1,0]};
        end
    end

    for j = 1:21
        q(j,:) = {[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0]};
    end

    for k = 1:21
        ret(k,:) = {{[],[]},{[],[]},{[],[]},{[],[]},{[],[]},{[],[]},{[],[]},{[],[]},{[],[]},{[],[]}};
    end
    %ret2 = [];

    for L = 1:5000000
        %ret2 = [];
        e = {};
        %so1 = randi([12,21],1);
        ra = randi([1,13],1);
        if ra == 11 || ra == 12 || ra == 13
            a = 10;
        else
            a = ra;
        end
        so1 = a + 11;
        %sum = [];
        sum = [so1];
        %so22 = randi([1,10],1);
        ra = randi([1,13],1);
        if ra == 11 || ra == 12 || ra == 13
            so22 = 10;
        else
            so22 = ra;
        end
        %ds = [];
        d = [so22];
        ds = [so22];
        ao = find(p{so1,so22}==1);
        e = {[so1,so22,ao]};
        while p{so1,so22}(1)==1
            %w = randi([1,10],1);
            ra = randi([1,13],1);
            if ra == 11 || ra == 12 || ra == 13
                w = 10;
            else
                w = ra;
            end
            so1 = so1+w;
            sum = [sum,so1];

                %so2 = so2;
                %so2 = randi([1,10],1);
                %ds = ds + so2;
            %e{end} = [e{end},rp];
            if so1<=21
                e = [e(:)',{[so1,so2,find(p{so1,so22}==1)]}];
                ds = [ds,so22];
            else
                ds = [ds so22];
                break;
            end

        end
        flagesh = 1;
        fe = 1;
        fla = 0;
        if so1<=21
            while flagesh == 1
                %so2 = randi([1,10],1);
                ra = randi([1,13],1);
                if ra == 11 || ra == 12 || ra == 13
                    so2 = 10;
                else
                    so2 = ra;
                end
                d = [d,so2];
                ds1 = ds(length(ds));
                ds = [ds,ds1+so2];
                poly = find(d==1);
                if isempty(poly)==0 && fe == 1 
                    if ds(length(ds))+10 <= 21
                        ds(length(ds)) = ds(length(ds)) + 10;
                        fe = 0;
                        if ds(length(ds)) == 17
                            fla = 1;
                        else
                            fla = 0;
                        end
                    end
                end

                if ds(length(ds))<17 || fla == 1 
                    e = [e(:)',{[so1,so2,find(p{so1,so2}==1)]}];
                    flagesh = 1;
                else
                    flagesh = 0;
                end
            end
        end
        rp = zeros(1,length(e));
        if so1>21
            rp(length(rp)) = -1;
        elseif so1>ds(length(ds))&&so1<=21
            rp(length(rp)) = 1;
        elseif so1<ds(length(ds))
            if ds(length(ds))<=21
                rp(length(rp)) = -1;
            else
                rp(length(rp)) = 1;
            end
        elseif so1 == ds(length(ds))
            rp(length(rp)) = 0;

        end
        g = 0;
        for x = length(e):-1:1
            g = g + rp(x);
            flag = 0;

            for h = 1:x-1
                if e{1,h} == e{1,x}
                %if sola(h)==sola(x) && sola2(h)==sola2(x) && sola3(h)==sola3(x)
                    flag = 0;
                    break;
                else
                    flag = 1;
                end
            end


            if flag == 1
                at = e{1,x}(3);
                %ret2 = [ret2,g];
                ret{e{1,x}(1),e{1,x}(2)}{1,e{1,x}(3)} = [ret{e{1,x}(1),e{1,x}(2)}{1,e{1,x}(3)},g];
                %ret{e{1,x}(1),e{1,x}(2)}{1,e{1,x}(3)}
                q{e{1,x}(1),e{1,x}(2)}(e{1,x}(3)) = mean(ret{e{1,x}(1),e{1,x}(2)}{1,e{1,x}(3)});
                %q{e{1,x}(1),e{1,x}(2)}(at) = mean(ret2);
                [G,I] = max(q{e{1,x}(1),e{1,x}(2)});

                %na = find(q{e{1,x}(1),e{1,x}(2)} == G);

                p{e{1,x}(1),e{1,x}(2)}(I) = 1;
                if I==1
                    p{e{1,x}(1),e{1,x}(2)}(2) = 0;
                elseif I==2
                    p{e{1,x}(1),e{1,x}(2)}(1) = 0;
                end
            end
        end

    end
   
end

function p = ace_nohit()
    for i = 1:21
        if i == 20 || i == 21
            p(i,:) = {[0,1],[0,1],[0,1],[0,1],[0,1],[0,1],[0,1],[0,1],[0,1],[0,1]};
        elseif i<=11
            p(i,:) = {[1,0],[1,0],[1,0],[1,0],[1,0],[1,0],[1,0],[1,0],[1,0],[1,0]};
        else
            p(i,:) = {[1,0],[1,0],[1,0],[1,0],[1,0],[1,0],[1,0],[1,0],[1,0],[1,0]};
        end
    end

    for j = 1:21
        q(j,:) = {[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0]};
    end

    for k = 1:21
        ret(k,:) = {{[],[]},{[],[]},{[],[]},{[],[]},{[],[]},{[],[]},{[],[]},{[],[]},{[],[]},{[],[]}};
    end
    %ret2 = [];

    for L = 1:5000000
        %ret2 = [];
        e = {};
        ra = randi([1,13],1);
        if ra == 11 || ra == 12 || ra == 13
            a = 10;
        else
            a = ra;
        end

        ra = randi([1,13],1);
        if ra == 11 || ra == 12 || ra == 13
            b = 10;
        else
            b = ra;
        end
        pc = [a,b];
        %b = randi([1,10],1);
        %so1 = randi([11,21],1);
        so1 = a+b;
        pf =0;
        pcf1 = find(pc==1);
        if isempty(pcf1)==0
            if so1 + 10 <= 21
                so1 = so1 + 10;
                pf = 1;
            end
        end
        %sum = [];
        sum = [so1];
        %so22 = randi([1,10],1);
        ra = randi([1,13],1);
        if ra == 11 || ra == 12 || ra == 13
            so22 = 10;
        else
            so22 = ra;
        end
        %ds = [];
        d = [so22];
        ds = [so22];
        ao = find(p{so1,so22}==1);
        e = {[so1,so22,ao]};
        fp = 1;
        while p{so1,so22}(1)==1
            ra = randi([1,13],1);
            if ra == 11 || ra == 12 || ra == 13
                w = 10;
            else
                w = ra;
            end
            pc = [pc,w];
            %w = randi([1,10],1);
            so1 = so1+w;
            pcf = find(pc==1);
            if isempty(pcf)==0 && pf~=1 && fp == 1 
                if so1+10 <= 21
                    so1 = so1 + 10;
                    fp = 0;
                end
            end

            sum = [sum,so1];

                %so2 = so2;
                %so2 = randi([1,10],1);
                %ds = ds + so2;
            %e{end} = [e{end},rp];
            if so1<=21
                e = [e(:)',{[so1,so22,find(p{so1,so22}==1)]}];
                ds = [ds,so22];
            else
                ds = [ds so22];
                break;
            end

        end
        flagesh = 1;
        fe = 1;
        if so1<=21
            while flagesh == 1
                ra = randi([1,13],1);
                if ra == 11 || ra == 12 || ra == 13
                    so2 = 10;
                else
                    so2 = ra;
                end
                %so2 = randi([1,10],1);
                d = [d,so2];
                ds1 = ds(length(ds));
                ds = [ds,ds1+so2];
                poly = find(d==1);
                if isempty(poly)==0 && fe == 1 
                    if ds(length(ds))+10 <= 21
                        ds(length(ds)) = ds(length(ds)) + 10;
                        fe = 0;
                    end
                end

                if ds(length(ds))<17 
                    e = [e(:)',{[so1,so2,find(p{so1,so2}==1)]}];
                    flagesh = 1;
                else
                    flagesh = 0;
                end
            end
        end
        rp = zeros(1,length(e));
        if so1>21
            rp(length(rp)) = -1;
        elseif so1>ds(length(ds))&&so1<=21
            rp(length(rp)) = 1;
        elseif so1<ds(length(ds))
            if ds(length(ds))<=21
                rp(length(rp)) = -1;
            else
                rp(length(rp)) = 1;
            end
        elseif so1 == ds(length(ds))
            rp(length(rp)) = 0;

        end
        g = 0;
        for x = length(e):-1:1
            g = g + rp(x);
            flag = 0;

            for h = 1:x-1
                if e{1,h} == e{1,x}
                %if sola(h)==sola(x) && sola2(h)==sola2(x) && sola3(h)==sola3(x)
                    flag = 0;
                    break;
                else
                    flag = 1;
                end
            end


            if flag == 1
                at = e{1,x}(3);
                %ret2 = [ret2,g];
                ret{e{1,x}(1),e{1,x}(2)}{1,e{1,x}(3)} = [ret{e{1,x}(1),e{1,x}(2)}{1,e{1,x}(3)},g];
                %ret{e{1,x}(1),e{1,x}(2)}{1,e{1,x}(3)}
                q{e{1,x}(1),e{1,x}(2)}(e{1,x}(3)) = mean(ret{e{1,x}(1),e{1,x}(2)}{1,e{1,x}(3)});
                %q{e{1,x}(1),e{1,x}(2)}(at) = mean(ret2);
                [G,I] = max(q{e{1,x}(1),e{1,x}(2)});

                %na = find(q{e{1,x}(1),e{1,x}(2)} == G);

                p{e{1,x}(1),e{1,x}(2)}(I) = 1;
                if I==1
                    p{e{1,x}(1),e{1,x}(2)}(2) = 0;
                elseif I==2
                    p{e{1,x}(1),e{1,x}(2)}(1) = 0;
                end
            end
        end

    end
   
end

function p = ace_hit()
    for i = 1:21
        if i == 20 || i == 21
            p(i,:) = {[0,1],[0,1],[0,1],[0,1],[0,1],[0,1],[0,1],[0,1],[0,1],[0,1]};
        elseif i<=11
            p(i,:) = {[1,0],[1,0],[1,0],[1,0],[1,0],[1,0],[1,0],[1,0],[1,0],[1,0]};
        else
            p(i,:) = {[1,0],[1,0],[1,0],[1,0],[1,0],[1,0],[1,0],[1,0],[1,0],[1,0]};
        end
    end

    for j = 1:21
        q(j,:) = {[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0]};
    end

    for k = 1:21
        ret(k,:) = {{[],[]},{[],[]},{[],[]},{[],[]},{[],[]},{[],[]},{[],[]},{[],[]},{[],[]},{[],[]}};
    end
    %ret2 = [];

    for L = 1:5000000
        %ret2 = [];
        e = {};
        ra = randi([1,13],1);
        if ra == 11 || ra == 12 || ra == 13
            a = 10;
        else
            a = ra;
        end

        ra = randi([1,13],1);
        if ra == 11 || ra == 12 || ra == 13
            b = 10;
        else
            b = ra;
        end
        pc = [a,b];
        %b = randi([1,10],1);
        %so1 = randi([11,21],1);
        so1 = a+b;
        pf =0;
        pcf1 = find(pc==1);
        if isempty(pcf1)==0
            if so1 + 10 <= 21
                so1 = so1 + 10;
                pf = 1;
            end
        end
        %sum = [];
        sum = [so1];
        %so22 = randi([1,10],1);
        ra = randi([1,13],1);
        if ra == 11 || ra == 12 || ra == 13
            so22 = 10;
        else
            so22 = ra;
        end
        %ds = [];
        d = [so22];
        ds = [so22];
        ao = find(p{so1,so22}==1);
        e = {[so1,so22,ao]};
        fp = 1;
        while p{so1,so22}(1)==1
            ra = randi([1,13],1);
            if ra == 11 || ra == 12 || ra == 13
                w = 10;
            else
                w = ra;
            end
            pc = [pc,w];
            %w = randi([1,10],1);
            so1 = so1+w;
            pcf = find(pc==1);
            if isempty(pcf)==0 && pf~=1 && fp == 1 
                if so1+10 <= 21
                    so1 = so1 + 10;
                    fp = 0;
                end
            end

            sum = [sum,so1];

                %so2 = so2;
                %so2 = randi([1,10],1);
                %ds = ds + so2;
            %e{end} = [e{end},rp];
            if so1<=21
                e = [e(:)',{[so1,so22,find(p{so1,so22}==1)]}];
                ds = [ds,so22];
            else
                ds = [ds so22];
                break;
            end

        end
        flagesh = 1;
        fe = 1;
        fla = 0;
        if so1<=21
            while flagesh == 1
                ra = randi([1,13],1);
                if ra == 11 || ra == 12 || ra == 13
                    so2 = 10;
                else
                    so2 = ra;
                end
                %so2 = randi([1,10],1);
                d = [d,so2];
                ds1 = ds(length(ds));
                ds = [ds,ds1+so2];
                poly = find(d==1);
                if isempty(poly)==0 && fe == 1 
                    if ds(length(ds))+10 <= 21
                        ds(length(ds)) = ds(length(ds)) + 10;
                        fe = 0;
                        if ds(length(ds)) == 17
                            fla = 1;
                        else
                            fla = 0;
                        end
                    end
                end

                if ds(length(ds))<17 || fla == 1 
                    e = [e(:)',{[so1,so2,find(p{so1,so2}==1)]}];
                    flagesh = 1;
                else
                    flagesh = 0;
                end
            end
        end
        rp = zeros(1,length(e));
        if so1>21
            rp(length(rp)) = -1;
        elseif so1>ds(length(ds))&&so1<=21
            rp(length(rp)) = 1;
        elseif so1<ds(length(ds))
            if ds(length(ds))<=21
                rp(length(rp)) = -1;
            else
                rp(length(rp)) = 1;
            end
        elseif so1 == ds(length(ds))
            rp(length(rp)) = 0;

        end
        g = 0;
        for x = length(e):-1:1
            g = g + rp(x);
            flag = 0;

            for h = 1:x-1
                if e{1,h} == e{1,x}
                %if sola(h)==sola(x) && sola2(h)==sola2(x) && sola3(h)==sola3(x)
                    flag = 0;
                    break;
                else
                    flag = 1;
                end
            end


            if flag == 1
                at = e{1,x}(3);
                %ret2 = [ret2,g];
                ret{e{1,x}(1),e{1,x}(2)}{1,e{1,x}(3)} = [ret{e{1,x}(1),e{1,x}(2)}{1,e{1,x}(3)},g];
                %ret{e{1,x}(1),e{1,x}(2)}{1,e{1,x}(3)}
                q{e{1,x}(1),e{1,x}(2)}(e{1,x}(3)) = mean(ret{e{1,x}(1),e{1,x}(2)}{1,e{1,x}(3)});
                %q{e{1,x}(1),e{1,x}(2)}(at) = mean(ret2);
                [G,I] = max(q{e{1,x}(1),e{1,x}(2)});

                %na = find(q{e{1,x}(1),e{1,x}(2)} == G);

                p{e{1,x}(1),e{1,x}(2)}(I) = 1;
                if I==1
                    p{e{1,x}(1),e{1,x}(2)}(2) = 0;
                elseif I==2
                    p{e{1,x}(1),e{1,x}(2)}(1) = 0;
                end
            end
        end

    end
end

