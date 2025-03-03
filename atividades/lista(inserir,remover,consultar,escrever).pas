Program Pzim ;

Const 
	N = 10;

Type
	vetor = array[1..N] of integer;

Var
	opc,qtd:integer;
	v:vetor;
	
Procedure inicializar(var posi:integer);	//Define o valor da posi��o da lista em 0.
	Begin
		posi:=0;
	End;

Function v_cheia(posicao,max:integer):boolean;	//Verifica se a lista esta cheia.
	Begin
		If posicao >= max then
			v_cheia:=true
		Else
			v_cheia:=false;
	End;

Function v_vazia(posicao,max:integer):boolean;	//Vrefica se a lista j� n�o est� cheia.
	Begin
		If posicao = 0 then
			v_vazia:=true
		Else
			v_vazia:=false;
	End;

Procedure le_elemento(var elemento:integer);	//l� o elemento que ser� inserido,removido ou consultado.
	Begin
		Writeln('Informe um n�mero:');
		Readln(elemento);
	End;

Procedure pesquisa(v:vetor; p,elem:integer; var retorno:integer);	//Procedimento para realizar a pesquisa bin�ria.
Var
	i,media :integer;
	Begin
		inicializar(retorno);	//Defino o valor do retorno em 0.
		i:=1;
		media:=(i+p) div 2;
		If elem = v[media] then
			retorno:=media
		Else
			Begin
				While (i <= p) and (v[media] <> elem) do
					Begin
						media:=(i+p) div 2;
						If v[media] = elem then
							retorno:= media
						Else                        
							If elem > v[media] then
								i:=media +1
							Else
								p:=media -1;
					End;
			End;  	
	End;

Procedure inserir(var vet:vetor; var posi:integer; num:integer);	//Procedimento para inserir um elemento a lista ou informar que ela est� cheia.
Var
	ele,i,j:integer;
	cheia:boolean;
		
	Begin
		CLRSCR;
		cheia:=v_cheia(posi,num); 
		If not cheia then
			Begin
				le_elemento(ele);
				i:=1;
				While (ele > vet[i]) and (i <= posi) do
					i:=i+1;
				If ele <> vet[i] then
					Begin
						For j:=posi downto i do
							vet[j+1]:=vet[j];
						vet[i]:=ele;
						posi:=posi +1;
					End
				Else
					Begin
						Writeln('O n�mero ',ele,' j� est� inserido na lista. Por favor, insira novamente.')
					End;	
			End
			Else
				Writeln('Sua lista est� cheia!');
	End;

Procedure remover(var vet:vetor; var posi:integer; num:integer);	//Procedimento para remover um elemento da lista ou informar que ela est� vazia.
Var
	reto,i,ele:integer;
	vazia:boolean;                               
	Begin
		CLRSCR;
		vazia:=v_vazia(posi,num);
		If not vazia then
			Begin
				le_elemento(ele);
				pesquisa(vet,posi,ele,reto);
				If reto <> 0 then
					Begin
						For i:=reto to (posi -1) do
							vet[i]:=vet[i+1];
						posi:=posi -1;
					End
				Else
						Writeln('O n�mero N�O est� inserido na lista!');
			End
		Else
			Writeln('A lista est� vazia.');                                             
	End;

Procedure consultar(vet:vetor; posi,num:integer);		//Procedimento para consultar um elemento por meio da pesquisa bin�ria ou informar que ela est� vazia.
Var
	reto,ele:integer;
	vazia:boolean;
	Begin
		CLRSCR;
		vazia:=v_vazia(posi,num);
		If not vazia then
			Begin
				le_elemento(ele);
				pesquisa(vet,posi,ele,reto);
				If reto <> 0 then
					Writeln('O n�mero ',ele,' est� inserido na lista, na posi��o ',reto)
				Else
					Writeln('O n�mero ',ele,' N�O est� inserido na lista.');
			End
		Else
			Writeln('Sua lista est� vazia.');		
	End;

Procedure escrever(vet:vetor; posi:integer; num:integer);		//Procedimento para escrever a lista ou informar que est� vazia.
Var
	i:integer;
	vazia:boolean;
	Begin
		CLRSCR;
		vazia:=v_vazia(posi,num);
		If not vazia then 
			Begin
				For i:=1 to posi do
					Write('',vet[i]:3);
			End;
		Writeln();
	End;
	
Begin
	inicializar(qtd);	//Procedimento que define o n�mero de posi��es em 0.
	While opc <> 5 do
		Begin
			Writeln('[1] - Inserir');	//In�cio menu
			Writeln('[2] - Remover');
			Writeln('[3] - Consultar');
			Writeln('[4] - Escrever');
			Writeln('[5] - Sair');
			Readln(opc);
			Case opc of
				1: inserir(v,qtd,N);
				2: remover(v,qtd,N);
				3: consultar(v,qtd,N);
				4: escrever(v,qtd,N);
				5: Writeln('Saindo...');	
			Else
				Writeln('N�mero informado est� fora dos par�metros [1-6]. Por favor, insira novamente!');
			End; 	//Final menu
		End;	  
End.