function [ output_args ,out_mat, output_equ] = routh( input_args ,param )
%ROUTH 
% function [ output_args ,out_mat] = routh( input_args ,param )
% input_args Koeffizienten des Nennerpolynoms
% Aufruf:
% [A,B]=routh({'2*k' ;'5' ;'1*k'},param)
% A--> true /false statements
% B--> routh matrix
% param == 1 oder 'out' erzeugt eine ausgabe

routh_matrix(length(input_args),length(input_args))={'0'};
try 5==param;
catch e
    if strcmp(e.identifier,'MATLAB:inputArgUndefined')
        param=0;
    else throw(e);
    end
end
    
%ausfüllen der Routh_Matrix
for zeile = 1:length(input_args)
    for spalte = 1:length(input_args)
        %%%ERSTE ZEILE
        if zeile == 1
            try
                routh_matrix(zeile , spalte)=input_args(spalte*2-1);
            catch e
                if strcmp(e.identifier,'MATLAB:badsubscript')
                	routh_matrix(zeile , spalte)={'0'};
                else throw(e);
                end
            end
        %%%ZWEITE ZEILE
        elseif zeile == 2
            try
            routh_matrix(zeile , spalte)=input_args(spalte*2);
            catch e
                if strcmp(e.identifier,'MATLAB:badsubscript')
                	routh_matrix(zeile , spalte)={'0'};
                else throw(e);
                end
            end
        else
        %%%UND DER GANZE REST
            %Berechnung
            try
                routh_matrix(zeile , spalte)={['(((',...
                    routh_matrix{zeile-2 , spalte+1},')*(',...
                    routh_matrix{zeile-1 , 1},'))-((',...
                    routh_matrix{zeile-2 , 1},')*(',...
                    routh_matrix{zeile-1 , spalte+1},')))/((',...
                    routh_matrix{zeile-1 , 1},'))']};
            catch e
                if strcmp(e.identifier,'MATLAB:badsubscript')
                	routh_matrix(zeile , spalte)={'0'};
                else throw(e);
                end
            end

       
        end
    end
end
%Ergebniss
for zeile = 1:length(input_args)
    for spalte = 1:length(input_args)
        out_mat(zeile , spalte)=...
            simplify(sym(routh_matrix{zeile , spalte}));
    end
end

false_erkanntgr=0;
false_erkanntkl=0;
for zeile = 1:length(input_args)
    output_args_str(zeile)={[routh_matrix{zeile, 1},'>0']};
    output_argsgr(zeile)=simplify(sym(output_args_str{zeile}));
      if simplify(sym('2<1'))==output_argsgr(zeile)
          false_erkanntgr=1;
      end
end

for zeile = 1:length(input_args)
    output_args_str(zeile)={[routh_matrix{zeile, 1},'<0']};
    output_argskl(zeile)=simplify(sym(output_args_str{zeile}));
      if simplify(sym('2<1'))==output_argskl(zeile)
          false_erkanntkl=1;
      end
end

if false_erkanntkl&&(~false_erkanntgr)
	output_args=output_argsgr;
end
if false_erkanntgr&&(~false_erkanntkl)
    output_args=output_argskl;
end
if false_erkanntgr&&false_erkanntkl
    output_args=[];
    fprintf('Keine Lösung gefunden');

end
if (~false_erkanntgr)&&(~false_erkanntkl)
    if output_argskl==output_argskl
        output_args=output_argskl;
    end
    if output_argsgr==output_argsgr
        output_args=output_argsgr;
    end
end
if strcmp(num2str(param),'1') || strcmp(param,'out')
    pretty(out_mat);
    pretty(output_args);
end
end
