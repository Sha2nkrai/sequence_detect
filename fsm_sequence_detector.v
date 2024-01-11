module fsm (
    input clk,
    input aresetn,    // Asynchronous active-low reset
    input x,
    output z ); 
    reg [1:0] NS ;
    reg [1:0] PS ;


    always@(*)
begin
    

case(PS)

2'b00: begin                                   //condition to jump to other states from 2'b00 state

          if(x==1)begin
			    NS<=2'b01;
				 
			 end 
			 else 
				 
                 NS<=2'b00;
      end 
2'b01: begin                                   //condition to jump to other states from 2'b01 state
          if(x==0)begin
			     NS<=2'b10;
				  
			 end
			 else 
			     
                 NS<=2'b01;
      end 

2'b10: begin                                     //condition to jump to other states from 2'b10 state
           if(x==1)begin
			      NS<=2'b01;
					
			  end
			  else
			      NS<=2'b00;
					
       end

endcase
        
end

    always@(posedge clk or negedge aresetn)begin               // this block is used to reset PS to 0 and also assign NS to PS
        if(aresetn==0)
            PS<=2'b00;
        else
            PS<=NS;
        
        
        
        
    end
 
    assign z=((PS==2'b10)&(x));                          ///this assign statement is used to make output(z) high 






endmodule

module test();                                        //this is the testbench for fsm
reg clk, aresetn,  x;
wire z; 
integer i;

fsm fs (.clk(clk),.x(x),.aresetn(aresetn),.z(z));               //this is the portmaping of clk,x,z and reset

initial begin 
$dumpvars();
end

always                                                 // this always block is used to create clock 
begin
#10
clk=~clk;

end
initial begin                                            // in this initial block customized inputs(X) are given to check overlapping and output
  clk=1'b0;
  
  @(posedge clk)x<=1'b1;
  @(posedge clk)x<=1'b0;
  @(posedge clk)x<=1'b1;
  @(posedge clk)x<=1'b0;
  @(posedge clk)x<=1'b1;
  @(posedge clk)x<=1'b0;
  @(posedge clk)x<=1'b0;
  @(posedge clk)x<=1'b1;
  @(posedge clk)x<=1'b1;
  #100 $finish;
end
initial begin
                                                // in this block reset is customized to create waveforms
aresetn=1'b0;
  #10
  aresetn=1'b1;
  #300
  aresetn=1'b0;
  $finish;
 end
endmodule
