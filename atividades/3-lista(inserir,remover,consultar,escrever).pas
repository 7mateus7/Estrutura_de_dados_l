Program Pzim ;

Const 
	N = 10;

Type
	vetor = array[1..N] of integer;

Var
	opc,qtd:integer;
	v:vetor;
	
Procedure inicializar(var posi:integer);	//Define o valor da posição da lista em 0.
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

Function v_vazia(posicao,max:integer):boolean;	//Vrefica se a lista já não está cheia.
	Begin
		If posicao = 0 then
			v_vazia:=true
		Else
			v_vazia:=false;
	End;

Procedure le_elemento(var elemento:integer);	//lê o elemento que será inserido,removido ou consultado.
	Begin
		Writeln('Informe um número:');
		Readln(elemento);
	End;

Procedure pesquisa(v:vetor; p,elem:integer; var retorno:integer);	//Procedimento para realizar a pesquisa binária.
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

Procedure inserir(var vet:vetor; var posi:integer; num:integer);	//Procedimento para inserir um elemento a lista ou informar que ela está cheia.
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
						Writeln('O número ',ele,' já está inserido na lista. Por favor, insira novamente.')
					End;	
			End
			Else
				Writeln('Sua lista está cheia!');
	End;

Procedure remover(var vet:vetor; var posi:integer; num:integer);	//Procedimento para remover um elemento da lista ou informar que ela está vazia.
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
						Writeln('O número NÃO está inserido na lista!');
			End
		Else
			Writeln('A lista está vazia.');                                             
	End;

Procedure consultar(vet:vetor; posi,num:integer);		//Procedimento para consultar um elemento por meio da pesquisa binária ou informar que ela está vazia.
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
					Writeln('O número ',ele,' está inserido na lista, na posição ',reto)
				Else
					Writeln('O número ',ele,' NÃO está inserido na lista.');
			End
		Else
			Writeln('Sua lista está vazia.');		
	End;

Procedure escrever(vet:vetor; posi:integer; num:integer);		//Procedimento para escrever a lista ou informar que está vazia.
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
	inicializar(qtd);	//Procedimento que define o número de posições em 0.
	While opc <> 5 do
		Begin
			Writeln('[1] - Inserir');	//Início menu
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
				Writeln('Número informado está fora dos parâmetros [1-6]. Por favor, insira novamente!');
			End; 	//Final menu
		End;	  
End.