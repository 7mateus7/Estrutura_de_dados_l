Program Pzim ;
Type
	lista = array[1..10] of integer;
Const 
	N :integer = 10;
Var
	opc,posi,elem:integer;
	v:lista;
	
Procedure inicializar (var posicao:integer);  //Define a posição da lista em 0.
	Begin
		posicao:=0;
	End;

Procedure le_ele(var elemento:integer); 	//Lê o elemento que será inserido ou posição que será removida da lista.
	Begin
		//Writeln('Informe o Elemento ou posição: ');
		Readln(elemento);
	End;

Function v_cheia(p:integer):boolean;	//Função que verifica se a lista está cheia
	Begin
		If p >= 10 then
			v_cheia:=true
		Else
			v_cheia:=false;	
	End;

Function v_vazia(p:integer):boolean;	//Função que verifica se a lista está vazia.
	Begin
		If p < 1 then
			v_vazia:=true
		Else
			v_vazia:=false;
	End;
	
Procedure inserir(var vet:lista; var posicao,elemento:integer);	//Procedimeto de inserir um número a lista
Var
	cheia:boolean;
	Begin
		CLRSCR;
		cheia:=v_cheia(posicao);	//Verifica se a lista não está cheia.
		le_ele(elem);					//Funçao que solicita a posição para remover o elemento.
		If not cheia then
			Begin
				posicao:=posicao +1;
				vet[posicao]:=elemento;
			End
		Else
			Writeln('Sua fila está Cheia');
	End;
	
Procedure remover(var vet:lista; var posicao,elemento:integer);	//Procedimento que remove um elemento da lista.
Var
	vazia:boolean;
	i,p:integer;
	Begin
		CLRSCR;
		vazia:=v_vazia(posicao);	//Função que verifica se a lista já não está vazia.
		If not vazia then
			Begin
				Writeln('Qual posiçao da fila você quer remover?');
				le_ele(p);	//Lê a posição da fila que será removido o elemento. 
				For i:=p to (posicao -1) do
					Begin
						vet[i]:= vet[i +1];		//Contador que passa os números para uma posição anterior após a remoção.	
					End;
				posicao:=posicao -1;
			End
		Else
			Writeln('A sua fila está Vazia!');
	End;	

Procedure consultar(vet:lista; posicao,elemento:integer);  //Procedimento que solicita e retorna o número correspondente a posição inserida.
Var
	p:integer;
	vazia:boolean;
	Begin
		CLRSCR;
		vazia:=v_vazia(posicao);
		If not vazia then
			Begin
				Writeln('Qual posição da fila você deseja consultar?');
				le_ele(p);  //Lê a posição da lista que será consultada.
				If (p < 1) or (p > 10)then
						Writeln('Número informado superior ao vetor [1-10]. Por favor, insira novamente!')
				Else
					If p > posicao then
						Writeln('A posição ',p,' está vazia!')
					Else
						Writeln('O elemento da posição ',p,' é ',vet[p]);  //Informe qual é o número correspondente a posição
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
				Writeln('Sua lista contém ',posicao,' elementos. Segue a lista:');		//Informe quantas posições tem a fila.
				For i:=1 to posicao do
					Write('',vet[i]:3);
				Writeln();
			End
		Else
			Writeln('Sua fila está vazia!');
	End;
			
Begin

	inicializar(posi);			//Inicializa a posiçao da lista em 0
	
	While opc <> 5 do					//Início do Menu
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
				5: Writeln('Saíndo...');
				Else
					Writeln('Número informado não disponível.Por favor, insira novamente.');
			End;
	End;
		
End.