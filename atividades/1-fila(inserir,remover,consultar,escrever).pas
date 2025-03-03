Program Pzim ;
Type
	vetor = array[1..6] of integer;
Var
	opc,qtd:integer;
	v:vetor;

Function v_cheia(numero:integer):boolean;  //Função para validar se a fila está cheia.
	Begin
		If numero >= 6 then
			v_cheia:=false
		Else
			v_cheia:=true;
	End;

Function v_vazio(numero:integer):boolean;
	Begin
		If numero < 1 then
			v_vazio:=false
		Else
			v_vazio:=true;
	End;

Procedure inserir(var vet:vetor; var num:integer);  //Procedimento para inserir um número a fila ou retornar se ela está cheia.
Var
	cheia:boolean;
	Begin
		CLRSCR;
		cheia:=v_cheia(num);
		If cheia = true then
			Begin
				num:= num +1;
				Writeln('Escreva o seu número');
				Read(vet[num]);
				CLRSCR;	
			End
		Else
			Writeln('A fila está cheia!');	
	End;

Procedure remover(var vet:vetor; var num:integer);   //Remover o primeiro elemento
Var
	vazio:boolean;
	i:integer;
	Begin
		CLRSCR;
		vazio:=v_vazio(num);
		If vazio = true then
			Begin
				For i:=1 to (num-1) do
					vet[i]:=vet[i+1];
				num:=num -1;
			End
		Else	
			Writeln('A fila está vazia!');
	End;

Procedure consultar(vet:vetor; num:integer);			//Consulta o próximo elemento da fila.
Var
	vazio:boolean;
	Begin
		CLRSCR;
		vazio:=v_vazio(num);
		If vazio = false then
			Writeln('A fila está vazia. Não há elementos para consultar.')
		Else
			Writeln('O príximo elemento da fila será ',vet[1]);
	End;

Procedure escrever(vet:vetor; num:integer);   //Escrever a fila
Var
	i:integer;
	vazio:boolean;
	Begin
		CLRSCR;
		vazio:=v_vazio(num);
		If vazio = false then
			Writeln('A fila está vazia. Por favor, insira números.')
		Else
			Begin
				For i:=1 to num do
					Write('',vet[i]:3);
				Writeln();
			End;
	End;
	
Begin
	qtd:=0;
	While opc <> 5 do			//Menu
		Begin
			Writeln('[1] - Inserir');
			Writeln('[2] - Remover');
			Writeln('[3] - Consultar');
			Writeln('[4] - Escrever');
			Writeln('[5] - Sair');
			Readln(opc);
			If opc = 1 then
				inserir(v,qtd)
			Else
				If opc = 2 then
					remover(v,qtd)
				Else
					If opc = 3 then
						consultar(v,qtd)
					Else
						If opc = 4 then
							escrever(v,qtd)
						Else
							If opc = 5 then
								Writeln('Saíndo');
		End;
End.