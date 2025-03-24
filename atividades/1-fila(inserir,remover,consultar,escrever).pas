Program Pzim ;
Const
	tam_max = 10;
Type
	fila = array[1..tam_max] of integer;
Var
	vetor:fila;
	tam_vetor,opc:integer;

Function v_cheia(posi,max:integer):boolean;
	Begin
		If posi >= max then
			v_cheia:=true
		Else
			v_cheia:=false;
	End;

Function v_vazia(posi:integer):boolean;
	Begin
		If posi = 0 then
			v_vazia:=true
		Else
			v_vazia:=false;
	End;
		
Procedure le_fila(Var vet:fila; var posicao:integer; maximo:integer);
Var
	cheia:boolean;
	n:integer;
	Begin
		CLRSCR;
		cheia:=v_cheia(posicao,maximo);
		If not cheia then
			Begin	
				Writeln('Informe o seu número:');
				Readln(n);
				posicao:=posicao +1;
				vet[posicao]:=n;
			End
		Else
			Writeln('Sua fila está cheia');
	End;
	
Procedure remove_fila(var vet:fila; var posicao:integer);
Var
	vazia:boolean;
	i:integer;
	Begin
		CLRSCR;
		vazia:=v_vazia(posicao);
		If not vazia then
			Begin
				For i:=1 to (posicao -1) do
					vet[i]:=vet[i+1];
				posicao:=posicao -1;
				Writeln('Número removido!');
			End
		Else
			Writeln('Sua fila está vazia!');
	End;	

Procedure consulta(vet:fila; posicao:integer);
Var	
	vazia:boolean;
	Begin  
		CLRSCR;
		vazia:=v_vazia(posicao);
		If not vazia then
			Writeln('O próximo número a ser removido será: ',vet[1])
		Else
			Writeln('Sua fila está vazia!');
	End;

Procedure escrever(vet:fila; posicao:integer);
Var
	vazia:boolean;
	i:integer;
	Begin
		CLRSCR;
		vazia:=v_vazia(posicao);
		If not vazia then
			Begin
				For i:=1 to posicao do
					Write('',vet[i]:3);
			End
		Else
			Writeln('Sua fial está vazia!');		
	End;
		 
Begin
	While opc <> 5 do
		Begin
			Writeln();
			Writeln('[1] - Inserir Fila');
			Writeln('[2] - Remover Fila');
			Writeln('[3] - Consultar Fila');
			Writeln('[4] - Escrever');
			Writeln('[5] - Encerrar Programa');
			Readln(opc);
			Case opc of
				1: le_fila(vetor,tam_vetor,tam_max);
				2: remove_fila(vetor,tam_vetor);
				3: consulta(vetor,tam_vetor); 
				4: escrever(vetor,tam_vetor);
				5: Writeln('Encerrando o programa...');
				Else
					Writeln('Opção Errada!');
			End;
		End;
End.