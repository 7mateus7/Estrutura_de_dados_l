Program Pzim ;
Type
	tpDados = integer;
	ptnodo = ^Tfila;
	Tfila = record
		dado : tpDados;
		prox :  ptnodo;
	End;

Var
	fila : ptnodo;
	opc, num : integer;

Procedure inicializa(VAR f:ptnodo);
	Begin
		f:=NIL;
	End;
		
Procedure le_numero(VAR n: integer);
	Begin
		CLRSCR;
		Writeln('Informe um n�mero:');
		Readln(n);
	End;

Procedure insere(VAR f:ptnodo; n:integer);
Var
	aux, aux2: ptnodo;
	Begin
		CLRSCR;
		NEW(aux);
		If aux = NIL then
			Writeln('Mem�ria Cheia!')
		Else
			Begin
				aux^.dado:=n;
				aux^.prox:=NIL;
				If f = NIL then
					f:=aux
				Else
					Begin
						aux2:=f;
						While aux2^.prox <> NIL do
							aux2:=aux2^.prox;
						aux2^.prox:=aux;
					End;
			End;
	End;

Procedure remove(VAR f:ptnodo; VAR n:integer);
Var
	aux:ptnodo;
	
	Begin
		CLRSCR;
		n:=0;
		If f = NIL then
			Writeln('N�o foi poss�vel remover elementos. Motivo: FILA VAZIA')
		Else
			Begin
				aux:=f;
				f:=aux^.prox;
				n:=aux^.dado;
				DISPOSE(aux);			
			End;
	End;

Procedure consulta(f:ptnodo);
Var
	aux : ptnodo;		
	Begin
		CLRSCR;
		aux:=f;
		If f = NIL then
			Writeln('N�o foi poss�vel consultar elementos. Motivo: FILA VAZIA')
		Else
			Writeln('O pr�ximo n�mero a ser removido ser� ',aux^.dado);		
	End;
	
Procedure escrever(f:ptnodo);
Var
	aux:ptnodo;
	Begin
		CLRSCR;
		aux:=f;
		If aux = NIL then
			Writeln('N�o � poss�vel escrever a fila. Motivo: FILA VAZIA')
		Else
			Begin
				While aux <> NIL do
					Begin
						Write(' ',aux^.dado);
					  aux:=aux^.prox;
					End;
			End;
		WRITELN();
	End;	
	
Begin
	inicializa(fila);
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
				1:
					Begin
						le_numero(num);
				 		insere(fila,num);
				 	End;
				2:
					Begin
				 		remove(fila,num);
				 		Writeln('Removido o n�mero ',num);
				 	End;
				3: consulta(fila); 
				4: escrever(fila);
				5: Writeln('Encerrando o programa...');
				Else
					Writeln('Op��o Errada!');
			End;
		End;	
End.