function [ output_args ,out_mat] = routh2( input_args )
%UNTITLED Summary of this function goes here
%   
% [A,B]=routh({'2*k' ;'5' ;'1*k'})
% A--> true /false statements
% B--> routh matrix
% s= whos('input_args', 'class');
% s.class


%%INIT
routh_matrix(length(input_args),length(input_args))=sym(0);

for i=1:length(input_args)
    input_args{i}=sym(input_args(i));
end


%%MATRIX AUSFÜLLEN
for zeile = 1:length(input_args)
    for spalte = 1:length(input_args)
        if zeile == 1
            try
            routh_matrix(zeile , spalte)=input_args(spalte*2-1);
            catch e
                if strcmp(e.identifier,'MATLAB:badsubscript')
                	routh_matrix(zeile , spalte)={'0'};
                end
            end
        elseif zeile == 2
            try
            routh_matrix(zeile , spalte)=input_args(spalte*2);
            catch e
                if strcmp(e.identifier,'MATLAB:badsubscript')
                	routh_matrix(zeile , spalte)={'0'};
                end
            end
        else %restliche Zeilen
             try
                    routh_matrix(zeile , spalte)=simplify(((...
                    routh_matrix(zeile-2 , spalte+1)*...
                    routh_matrix(zeile-1 , 1))-(...
                    routh_matrix(zeile-2 , 1)*...
                    routh_matrix(zeile-1 , spalte+1)))/(...
                    routh_matrix(zeile-1 , 1)));
            catch e
                if strcmp(e.identifier,'MATLAB:badsubscript')
                	routh_matrix(zeile , spalte)={'0'};
                end
            end
        end
    end %for spalte
end %for zeile
out_mat=routh_matrix;
%%Bedingungen
for zeile = 1:length(input_args)
     gleichung=routh_matrix(zeile , 1)>0;
end
