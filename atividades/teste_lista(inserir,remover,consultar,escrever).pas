Program Pzim ;
Type
	lista = array[1..10] of integer;
Const 
	N :integer = 10;
Var
	opc,posi,elem:integer;
	v:lista;
	
Procedure inicializar (var posicao:integer);  //Define a posi��o da lista em 0.
	Begin
		posicao:=0;
	End;

Procedure le_ele(var elemento:integer); 	//L� o elemento que ser� inserido ou posi��o que ser� removida da lista.
	Begin
		//Writeln('Informe o Elemento ou posi��o: ');
		Readln(elemento);
	End;

Function v_cheia(p:integer):boolean;	//Fun��o que verifica se a lista est� cheia
	Begin
		If p >= 10 then
			v_cheia:=true
		Else
			v_cheia:=false;	
	End;

Function v_vazia(p:integer):boolean;	//Fun��o que verifica se a lista est� vazia.
	Begin
		If p < 1 then
			v_vazia:=true
		Else
			v_vazia:=false;
	End;
	
Procedure inserir(var vet:lista; var posicao,elemento:integer);	//Procedimeto de inserir um n�mero a lista
Var
	cheia:boolean;
	Begin
		CLRSCR;
		cheia:=v_cheia(posicao);	//Verifica se a lista n�o est� cheia.
		le_ele(elem);					//Fun�ao que solicita a posi��o para remover o elemento.
		If not cheia then
			Begin
				posicao:=posicao +1;
				vet[posicao]:=elemento;
			End
		Else
			Writeln('Sua fila est� Cheia');
	End;
	
Procedure remover(var vet:lista; var posicao,elemento:integer);	//Procedimento que remove um elemento da lista.
Var
	vazia:boolean;
	i,p:integer;
	Begin
		CLRSCR;
		vazia:=v_vazia(posicao);	//Fun��o que verifica se a lista j� n�o est� vazia.
		If not vazia then
			Begin
				Writeln('Qual posi�ao da fila voc� quer remover?');
				le_ele(p);	//L� a posi��o da fila que ser� removido o elemento. 
				For i:=p to (posicao -1) do
					Begin
						vet[i]:= vet[i +1];		//Contador que passa os n�meros para uma posi��o anterior ap�s a remo��o.	
					End;
				posicao:=posicao -1;
			End
		Else
			Writeln('A sua fila est� Vazia!');
	End;	

Procedure consultar(vet:lista; posicao,elemento:integer);  //Procedimento que solicita e retorna o n�mero correspondente a posi��o inserida.
Var
	p:integer;
	vazia:boolean;
	Begin
		CLRSCR;
		vazia:=v_vazia(posicao);
		If not vazia then
			Begin
				Writeln('Qual posi��o da fila voc� deseja consultar?');
				le_ele(p);  //L� a posi��o da lista que ser� consultada.
				If (p < 1) or (p > 10)then
						Writeln('N�mero informado superior ao vetor [1-10]. Por favor, insira novamente!')
				Else
					If p > posicao then
						Writeln('A posi��o ',p,' est� vazia!')
					Else
						Writeln('O elemento da posi��o ',p,' � ',vet[p]);  //Informe qual � o n�mero correspondente a posi��o
			End;
	End;

Procedure escrever(vet:lista; posicao:integer);  //Escreve a fila baseado no tamanho da mesma.
Var
	i:integer;
	vazia:boolean;
	Begin
		CLRSCR;
		vazia:=v_vazia(posicao);
		If not vazia then
			Begin
				Writeln('Sua lista cont�m ',posicao,' elementos. Segue a lista:');		//Informe quantas posi��es tem a fila.
				For i:=1 to posicao do
					Write('',vet[i]:3);
				Writeln();
			End
		Else
			Writeln('Sua fila est� vazia!');
	End;
			
Begin

	inicializar(posi);			//Inicializa a posi�ao da lista em 0
	
	While opc <> 5 do					//In�cio do Menu
		Begin			
			Writeln('[1] - Inserir');
			Writeln('[2] - Remover');
			Writeln('[3] - Consultar');
			Writeln('[4] - Escrever');
			Writeln('[5] - Sair');
			Read(opc);
			
			Case opc of 
				1: inserir(v,posi,elem);
				2: remover(v,posi,elem);
				3: consultar(v,posi,elem);
				4: escrever(v,posi); 
				5: Writeln('Sa�ndo...');
				Else
					Writeln('N�mero informado n�o dispon�vel.Por favor, insira novamente.');
			End;
	End;
		
End.