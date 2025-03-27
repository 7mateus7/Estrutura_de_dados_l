Program Pzim ;
Const
	N = 10;
Type
	pilha = array[1..N] : integer;
Var
	num:integer;
	p_b,p_o,p_h:pilha;
	
Procedure le_numero(var n:integer);
	Begin
		Writeln('Informe um número:');
		Readln(n);
	End;

Procedure conversao(n:integer;var p_bi,p_oc,p_he:pilha; var tam_b,tam_o,tam_h:integer);
Var
	binario:integer;
	Begin
		binario:=n;
		while binario > 0 then
			Begin
				tam_b:=tam_b +1;
				p_bi[tam_b]:=binario mod 2;
				binario:= binario div 2;
			End;
	End;

Begin
  le_numero(num);
  conversao(num,p_b,p_o,p_h,t_b,t_o,t_h);
End.
