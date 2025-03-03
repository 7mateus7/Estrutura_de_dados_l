Program Pzim ;
Type
	vetor = array[1..6] of integer;
Var
	opc,qtd:integer;
	v:vetor;

Function v_cheia(numero:integer):boolean;  //Fun��o para validar se a pilha est� cheia.
	Begin
		If numero >= 6 then
			v_cheia:=false
		Else
			v_cheia:=true;
	End;

Function v_vazio(numero:integer):boolean;		//Fun��o para validar se a pilha est� vazia.
	Begin
		If numero < 1 then
			v_vazio:=false
		Else
			v_vazio:=true;
	End;

Procedure inserir(var vet:vetor; var num:integer);  //Procedimento para inserir um n�mero a pilha ou retornar se ela est� cheia.
Var
	cheia:boolean;
	Begin
		CLRSCR;
		cheia:=v_cheia(num);	//Vereifica se a pilha j� est� cheia
		If cheia = true then
			Begin
				num:= num +1;
				Writeln('Escreva o seu n�mero');
				Read(vet[num]);
				CLRSCR;	
			End
		Else
			Writeln('A pilha est� cheia!');	
	End;

Procedure remover(var vet:vetor; var num:integer);   //Remover o �ltimo elemento da pilha
Var
	vazio:boolean;
	i:integer;
	Begin
		CLRSCR;
		vazio:=v_vazio(num);	//Verifica se a pilha j� n�o est� vazia.
		If vazio = true then
			Begin
				Writeln('Removendo');
				num:=num -1;
			End
		Else	
			Writeln('A pilha est� vazia!');
	End;

Procedure consultar(vet:vetor; num:integer);			//Consulta o pr�ximo elemento a ser removido da pilha.
Var
	vazio:boolean;
	Begin
		CLRSCR;
		vazio:=v_vazio(num);	//verifica se a pilha j� est� vazia.
		If vazio = false then
			Writeln('A pilha est� vazia. N�o h� elementos para consultar.')
		Else
			Writeln('O pr�ximo elemento da pilha ser� ',vet[num]);
	End;

Procedure escrever(vet:vetor; num:integer);   //Procedimento para escrever a pilha
Var
	i:integer;
	vazio:boolean;
	Begin
		CLRSCR;
		vazio:=v_vazio(num);	//Verifica se a pilha j� n�o est� vazia.
		If vazio = false then
			Writeln('A pilha est� vazia. Por favor, insira n�meros.')
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
			Case opc of 		//Utilizando Case para a estrutura do Menu.
				1: inserir(v,qtd);
				2: remover(v,qtd);
				3: consultar(v,qtd);
				4: escrever(v,qtd);
				5: Writeln('Saindo...');
				Else
					Writeln('N�mero inserido inv�lido. Por favor, insira novamente.');
			End;
		End;
End.