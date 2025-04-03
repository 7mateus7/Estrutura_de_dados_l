Program Pzim ;
Const
	max = 10;
Type
	TPilha = record
		dados : array[1..max]of integer;
		topo : integer;
	End;
Var
	pilha:TPilha;
	opc:integer;
	
Procedure inicializar(var p:TPilha);
	Begin
		p.topo:=0;
	End;

Function cheia(num,m:integer):boolean;
	Begin
		If num = m then
			cheia:=true
		Else
			cheia:=false;
	End;

Function vazia(n:integer):boolean;
	Begin
		If n = 0 then
			vazia:=true
		Else
			vazia:=false;	
	End;
	
Procedure inserir(var p:TPilha; maximo:integer);
	Begin
		CLRSCR;
		If not cheia(p.topo,maximo) then
			Begin
				p.topo:=p.topo +1;
				Writeln('Informe o seu número:');
				Readln(p.dados[p.topo]);
			End
		Else
			Writeln('Sua Pilha está cheia!');
	End;

Procedure remover(var p:TPilha);
Var
	i:integer;
	Begin
		CLRSCR;
		If not vazia(p.topo) then
			p.topo:=p.topo -1
		Else
			Writeln('Sua Pilha está vazia!');
	End;
	
Procedure consultar(var p:TPilha);
	Begin
		CLRSCR;
		If not vazia(p.topo) then
			Begin
				Writeln('O próximo número a ser removido será ',p.dados[p.topo]);
			End
		Else
			Writeln('Sua Pilha está Vazia!');
	End;
	
Procedure escrever(var p:TPilha);
Var i:integer;
	Begin
		CLRSCR;
		If not vazia(p.topo) then
			Begin
				For i:=1 to p.topo do
					Write(p.dados[i]:3);
				Writeln();	
			End
		Else
			Writeln('Sua Pilha está Vazia!');
	End;
	
Begin
	inicializar(pilha);
	opc:=0;
	While opc <> 5 do
		Begin
			Writeln('[1] - Inserir Pilha');
			Writeln('[2] - Remover Pilha');
			Writeln('[3] - Consultar Pilha');
			Writeln('[4] - Escrever Pilha');
			Readln(opc);
			Case opc of
				1:inserir(pilha,max);
				2:remover(pilha);
				3:consultar(pilha);
				4:escrever(pilha);
			Else
				Writeln('Opção Inválida');
			End;
		End;
End.