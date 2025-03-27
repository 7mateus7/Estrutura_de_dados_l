Program Pzim ;
Const
	max_lista = 10;
Type
	lista = array[1..max_lista] of integer;
Var
	v_lista:lista;
	opc,tam_lista:integer;

Function v_cheia(tam_l,max_l:integer):boolean;
	Begin
		If tam_l >= max_l then
			v_cheia:=true
		Else
			v_cheia:=false; 	
	End;

Function v_vazia(tam_l:integer):boolean;
	Begin
		If tam_l = 0  then
			v_vazia:=true
		Else
			v_vazia:=false;
	End;
	
Procedure inserir_lista(Var vet:lista;Var tam:integer; max:integer);
Var
	cheia:boolean;
	num,i,j:integer;
	Begin
		CLRSCR;
		i:=1;
		cheia:=v_cheia(tam,max);
		If not cheia then
			Begin
				Writeln('Informe o seu n�mero:');
				Readln(num);
				While (num > vet[i]) and (i<=tam) do
				  i:=i +1;
				If num <> vet[i] then
					Begin
						For j:=tam downto i do
							vet[j+1]:=vet[j];
						tam:=tam +1;
						vet[i]:=num;
					End
				Else
					If num = vet[i] then
						Writeln('O n�mero ',num,' j� est� na lista!');
			End;
	End;

Procedure pesquisa(v_lista:lista; tam_l,num:integer; var ret:integer); 
Var
	i,fim,media:integer;
	Begin
		ret:=0;
		i:=1;
		fim:=tam_l;
		media:=(i+fim) div 2;
		If v_lista[media] = num then
			ret:=media
		Else
			While (i<=fim) and (v_lista[media] <> num) do
				Begin
					media:=(i+fim) div 2;
					If v_lista[media] = num then
						ret:=media
					Else
						If v_lista[media] < num then
							i:=media +1
						Else
							fim:=media -1;	
				End;
	End;

Procedure remove(var v_lista:lista; var tam_l:integer; posi:integer);
Var
	i:integer;
	Begin
		Writeln('Removendo o n�mero ',v_lista[posi]);
		For i:=1 to (tam_l -1) do
			v_lista[i]:=v_lista[i+1];
		tam_l:=tam_l -1;
	End;

Procedure remover_lista(Var vet:lista;Var tam:integer);
Var
	n,retorno:integer;
	vazia:boolean;
	Begin
		CLRSCR;
		vazia:=v_vazia(tam);
		If not vazia then
			Begin
				Writeln('Informe o n�mero que deseja remover:');
				Readln(n);
				pesquisa(vet,tam,n,retorno);
				If retorno <> 0 then
					remove(vet,tam,retorno)
				Else
					Writeln('O n�mero n�o est� contido na lista!');
			End;	
	End;

Procedure consultar(vet:lista; tam:integer);
Var
	num,retorno:integer;
	Begin
		If not v_vazia(tam) then
			Begin
				Writeln('Informe um n�mero:');
				Readln(num);
				pesquisa(vet,tam,num,retorno);
				If retorno <> 0 then
					Writeln('O n�mero est� informado na posi��o ',retorno)
				Else
					Writeln('O n�mero n�o est� inserido na lista');
			End
		Else
			Writeln('A lista est� vazia');	
	End;

Procedure escrever_lista(vet:lista; tam:integer);
Var
	vazia:boolean;
	i:integer;
	Begin
		CLRSCR;
		vazia:=v_vazia(tam);
		If not vazia then
			For i:=1 to tam do	
				Write('',vet[i]:3)
		Else
			Writeln('Sua lista est� vazia!');
		Writeln();
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
				1:inserir_lista(v_lista,tam_lista,max_lista);
				2:remover_lista(v_lista,tam_lista);
				3:consultar(v_lista,tam_lista);
				4:escrever_lista(v_lista,tam_lista);
			End;
		End;	
End.