
module probador ();


	reg Clock, Reset, Enable;
//PC_normal
	reg [9:0] D; //Entrada -wire
	wire [9:0] Q; //Salida -reg
//PC_+1
	reg [9:0] PC_entrada; //Entrada
	wire [9:0] PC_salida; // SAlida=E+1
// sALTO 
	reg [5:0] iSalto; // tamaño del branch
	reg [9:0] iNewPC; // PC_+1
	wire [9:0] oDirNueva; // nueva 
//
	wire [9:0] wPC_salida;

procesador #(8) josuerico
(
	.Clock(Clock),
	.Reset(Reset),
	.wPC_salida(wPC_salida)
);

FFD #(10) pc
(
	.Clock(Clock),
	.Reset(Reset),
	.Enable(Enable),
	.Q(Q),
	.D(D)
	
);	

ALU_PC #(10) pc_aumenta
(
	.Clock(Clock),
	.Enable(Enable),
	.PC_entrada(PC_entrada),
	.PC_salida(PC_salida)
);

branchDir salto
(
	.iSalto(iSalto),
	.iNewPC(iNewPC),
	.oDirNueva(oDirNueva)
);

    
	//Condicion inicial donde se genera la señal de reloj adecuada
	initial
		begin
			
			$monitor("PC_entrada+=%b",iSalto ,"\n InewPC=%b", wPC_salida,"\n PC_salida+1 :%b ",oDirNueva,$time);

			Clock=0; Reset=1; Enable=0;
			//posibles pruebas en las entradas en presentacion binaria
			
			//#10;
			//Enable=1;
			//#10;
			//PC_entrada=10'd1;
			//#10;
			//PC_entrada=10'd100;
			//#10;

			//Reset=1;
			//D=10'd3;
			//#25;
			//Reset=0;
			//Enable=1;
			//D=10'd3;
			//#10;
			//D=10'd253;

			iSalto = 6'b000111;
			iNewPC = 10'd7;
			//D=10'd3;
			//#25;
			//Reset=0;
			//Enable=1;
			//D=10'd3;
			//#10;
			//D=10'd253;	

		end
         always
		begin
			repeat(150)		
				begin
					#5 Clock=~Clock;		// se declara un ciclo de reloj cada 40 ps
				end
			$finish;
		end
	      
endmodule
