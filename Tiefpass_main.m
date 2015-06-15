close all;
clear all;
clc;
%%Koeffizienten
t_max =         1;      %s  
wa =            500;   %Hz
wg =            100;    %Hz
n=              3;

origfreq=900;

amplit = 1;
%%%Filterkoeffizienten2
%%a_0 ~ a(1)
%%a_1 ~ a(2)
%%etc.

fqverh= wg/wa ;
a(n+1) =    0;
a(1) =      2*fqverh;

for i=2:n+1
    a(i) = (...
                    (sin(fqverh*2*(i-1)*pi())  ) ...
                   /(  pi()*(i-1)   ) ...
                   );
end
a=[0.5,.3125,0,-0.0625,0];

%für Hochpass
% a(1)=1-a(1);
% for i=2:n+1
%     a(i)=0-a(i);
% end
%%%Originalfunktion
j = 0;
origfreq=origfreq*2*pi();
orig(t_max * wa) = 0;
zeit(t_max * wa) = 0;
length(orig)
for i=0 : 1/wa : t_max
    j=j+1;
    orig(j) = amplit * sin(i*origfreq);
    zeit(j) = j / wa;
end
%%Gang
k=0;
orig_gang(ceil(t_max * wa*pi())) = 0;
frq_gang(ceil(t_max * wa*pi())) = wa/2;
orig_tmp(ceil(t_max * wa*pi())) = 0;
ffreq_tmp(length(orig_gang))=0;
for origfreq=1:2:wa*pi()
    j = 0;
    k=k+1;
    for i=0 : 1/wa : t_max
        j=j+1;
        orig_tmp(j) = amplit * sin(i*origfreq);
    end
    
    
    for i=1 : length(orig_gang)
    try
        ffreq_tmp(i) = a(1) * orig_tmp(i);
        if n>1
            for j=1:n
                ffreq_tmp(i) = ffreq_tmp(i) + a(j+1)*(orig_tmp(i+j)+orig_tmp(i-j));
            end
        end
    catch e
        if ( strcmp(e.identifier,'MATLAB:badsubscript'))
            ffreq_tmp(i) = 0;
        end
    end
    end

    clc
    wa*pi()/origfreq
    frq_gang(k)=origfreq/pi()/2;
    orig_gang(k)=max(ffreq_tmp);
end
figure()
%%%Filterfunktion
ffreq(length(orig))=0;
for i=1 : length(orig)
    try
        ffreq(i) = a(1) * orig(i);
        if n>1
            for j=1:n
                ffreq(i) = ffreq(i) + a(j+1)*(orig(i+j)+orig(i-j));
            end
        end
    catch e
        if ( strcmp(e.identifier,'MATLAB:badsubscript'))
            ffreq(i) = 0;
        end
    end
end
%%%plot
hold on;
    plot (zeit,ffreq,'r');
    plot (zeit,orig);
    axis([0 t_max -2*amplit 2*amplit]) 
hold off;
figure();
plot(frq_gang,orig_gang);