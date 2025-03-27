Program Pzim ;
Const
	max = 50;
Type
	pilha = array[1..max] of integer;
Var
	num,tamanho:integer;
	p:pilha;
	opcao:integer;
	
Procedure LeNumero(var n:integer);
	Begin
		Writeln('Informe o seu número:');
		Readln(n);
	End;

Function cheia(tam_p,tam_max:integer):boolean;
	Begin
		If tam_p >= tam_max then
			cheia:=true
		Else
			cheia:=false;
	End;

Procedure converter(var v:pilha; var t:integer; num,base:integer);
Var
	divi:integer;
	Begin
		divi:=num;
		While divi > 0 do
			Begin
				t:=t +1;
				v[t]:=divi mod base;
				divi:=divi div base;
			End;		
	End;

Procedure convercao(n,maximo:integer;var vet:pilha; var tam:integer; var opc:integer);
	Begin
		If not cheia(tam,maximo) then
			Begin
				Writeln('Informe a base decial que deseja converter:');
				Writeln('1 - Binária');
				Writeln('2 - Octal');
				Writeln('3 - Hexadecial');
				Readln(opc);
				Case opc of
					1: converter(vet,tam,n,2);
					2: converter(vet,tam,n,8);
					3: converter(vet,tam,n,16)
				End;
			End
	Else
		Writeln('Sua pilha está cheia!');
	End;

Procedure apresenta(vet:pilha; tam:integer; opc:integer);
Var
	i:integer;
	Begin
		CLRSCR;
		Case opc of
			1: Writeln('A conversão na base Binária');
			2: Writeln('A conversão na base Octal');
			3: Writeln('A conversão na base Hexadecimal');
		End;
		Writeln();	
		For i:=tam downto 1 do
			Write(vet[i]);
	End;
	
Begin
	LeNumero(num);
	convercao(num,max,p,tamanho,opcao);
	apresenta(p,tamanho,opcao)
End.