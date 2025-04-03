Program Pzim ;
Const
	max = 10;
Type
	TFila = record
		dados: array[1..max] of integer;
		topo:integer
	End;
Var
	fila: TFila;
	opc:integer;

Function cheia(top,m:integer):boolean;
	Begin
		If top = m then
			cheia:=true
		Else
			cheia:=false;
	End;

Function vazia(top:integer):boolean;
	Begin
		If top = 0 then
			vazia:=true
		Else
			vazia:=false	
	End;

Procedure inicializar(f:TFila);
	Begin
		f.topo:=0;		
	End;

Procedure inserir(var f:TFila; maximo:integer);
	Begin
		CLRSCR;
		If not cheia(f.topo,maximo) then
			Begin
				f.topo:=f.topo +1;
				Writeln('Informe o seu número de posição ',f.topo);
				Readln(f.dados[f.topo]);
			End
		Else	
			Writeln('Sua Fila está Cheia!');
	End;

Procedure remover(var f:TFila);
Var
	i:integer;
	Begin
		CLRSCR;
		If not vazia(f.topo) then
			Begin
				Writeln('Removendo o número ',f.dados[1]);
				For i:=1 to (f.topo -1) do
					f.dados[i]:=f.dados[i+1];
				f.topo:=f.topo -1;
			End	
		Else
			Writeln('Sua Fial está Vazia!');
	End;

Procedure consultar(f:TFila);
	Begin
		CLRSCR;
		If not vazia(f.topo) then
			Writeln('O próximo número a ser removido será ',f.dados[1])
		Else
			Writeln('Sua Fila está Vazia!');
	End;

Procedure escrever(f:TFila);
Var
	i:integer;
	Begin
		CLRSCR;
		If not vazia(f.topo) then
			Begin
				For i:=1 to f.topo do
					Write(f.dados[i]:3);
				Writeln();
			End
		Else
			Writeln('Sua Fila está Vazia!');
	End;
	
Begin
	inicializar(fila);
	opc:=0;
	While opc <> 5 do
		Begin
			Writeln('[1] - Inserir Pilha');
			Writeln('[2] - Remover Pilha');
			Writeln('[3] - Consultar Pilha');
			Writeln('[4] - Escrever Pilha');
			Readln(opc);
			Case opc of
				1:inserir(fila,max);
				2:remover(fila);
				3:consultar(fila);
				4:escrever(fila);
				5:Writeln('Saindo...');
			Else
				Writeln('Opção Inválida');
			End;
		End;
End.