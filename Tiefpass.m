function [ output_args ] = tiefpass( input_args )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

t_max =         input_args(1);      %s
wa =            input_args(2);   %Hz
wg =            input_args(3);    %Hz
n=              input_args(4);

for i=2:n+1
    a(i) = 2*fqverh*(...
                    (sin(fqverh*2*(i-1)*pi())  ) ...
                   /(  2*pi()*(i-1)*fqverh   ) ...
                   );
end
end

