ser=serial('COM3');
disp('Serialobjekt erzeugt');
set(ser,'BaudRate',9600);
set(ser,'DataBits',8);
set(ser,'Parity','none');
set(ser,'StopBits',1);
set(ser,'ReadAsyncMode','continuous');
set(ser,'Terminator','CR');

 

fopen(ser);

while(1)
    disp(fgetl(ser))
    wait(1000);
end

fclose(ser); 
delete(ser); 
clear ser; 