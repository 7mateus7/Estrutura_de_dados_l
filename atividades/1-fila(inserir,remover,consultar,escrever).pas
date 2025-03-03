Program Pzim ;
Type
	vetor = array[1..6] of integer;
Var
	opc,qtd:integer;
	v:vetor;

Function v_cheia(numero:integer):boolean;  //Fun��o para validar se a fila est� cheia.
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

Procedure inserir(var vet:vetor; var num:integer);  //Procedimento para inserir um n�mero a fila ou retornar se ela est� cheia.
Var
	cheia:boolean;
	Begin
		CLRSCR;
		cheia:=v_cheia(num);
		If cheia = true then
			Begin
				num:= num +1;
				Writeln('Escreva o seu n�mero');
				Read(vet[num]);
				CLRSCR;	
			End
		Else
			Writeln('A fila est� cheia!');	
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
			Writeln('A fila est� vazia!');
	End;

Procedure consultar(vet:vetor; num:integer);			//Consulta o pr�ximo elemento da fila.
Var
	vazio:boolean;
	Begin
		CLRSCR;
		vazio:=v_vazio(num);
		If vazio = false then
			Writeln('A fila est� vazia. N�o h� elementos para consultar.')
		Else
			Writeln('O pr�ximo elemento da fila ser� ',vet[1]);
	End;

Procedure escrever(vet:vetor; num:integer);   //Escrever a fila
Var
	i:integer;
	vazio:boolean;
	Begin
		CLRSCR;
		vazio:=v_vazio(num);
		If vazio = false then
			Writeln('A fila est� vazia. Por favor, insira n�meros.')
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
								Writeln('Sa�ndo');
		End;
End.