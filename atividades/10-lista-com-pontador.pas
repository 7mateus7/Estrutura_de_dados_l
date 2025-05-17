Program Pzim ;
type
	Tpdados = Integer; 
	Ptnodo = ^Tlista;
	Tlista = Record
		dado : Tpdados;
		prox : ptnodo;
	End;
	
Var
	lista:ptnodo;
	opc, num, retorno : integer;
	
Procedure inicializa(VAR l:ptnodo);
	Begin
		l:=NIL;
	End;
	
Procedure le_numero(VAR n:Integer);
	Begin
		CLRSCR;
		Writeln('Informe um número:');
		Readln(n);
	End;

Procedure insere(VAR l:ptnodo; n:integer);
Var
	aux, aux2, ant:ptnodo;	
	Begin
		NEW(aux);
		If aux = NIL then
			Writeln('Não foi possível inserir elemento. Motivo: Memória cheia')
		Else
			Begin
				If l = NIL then
					Begin
						aux^.dado:=n;
						aux^.prox:=NIL;
						l:=aux;
					End
				Else
					Begin
						aux2:=l;
						ant:=l;
						While (aux2^.prox <> NIL) and (n > aux2^.dado) do
							Begin
								ant:=aux2;
								aux2:=aux2^.prox;
							End;
						If aux2^.dado = n then
							Writeln('Não foi possível inserir o elemento. Motivo: Número já informado.')
						Else
							If (aux2 = l) AND (n < aux2^.dado) then
								Begin
									aux^.dado:=n;
									aux^.prox:=aux2;
									l:=aux;
								End 
							Else
								If (aux2^.prox = NIL) AND (aux2^.dado < n) then
									Begin
										aux^.dado:=n;
										aux^.prox:=NIL;
										aux2^.prox:=aux;
									End
								Else
									Begin
										aux^.dado:=n;
										aux^.prox:=aux2;
										ant^.prox:=aux;
									End
						End 
			End;
	End;

Procedure remove(VAR l:ptnodo; VAR n:Integer);
Var
	aux, ant : ptnodo;
	Begin
	aux:=l;
	ant:=l;
	If l = NIL then
		Writeln('Não foi possível remover elemento. Motivo: Fila vazia.')
	Else
		Begin
			While (aux^.dado <> n) AND (aux^.prox <> NIL) do
				Begin
					ant:=aux;
					aux:=aux^.prox;
				End;
			If aux^.dado <> n then
				Writeln('Elemento NÃO encontrado :(')
				Else
					If (l = aux) AND (aux^.prox = NIL) then
						Begin
							If aux^.dado = n then
								Begin
									l:=NIL;
									DISPOSE(aux);
								End	
						End
					Else
						If (l = aux) AND (aux^.prox <> NIL) THEN
							Begin
								l:=aux^.prox;
								DISPOSE(aux);
							End	
					Else
						Begin
							ant^.prox:= aux^.prox;
							DISPOSE(aux);	
						End		
				
			End;
	End;

Procedure consulta(l:ptnodo; n:integer;VAR r:integer);
Var
	aux : ptnodo;
	i : Integer;
	Begin
		aux:=l;
		If aux = NIL then
			Writeln('Não foi possível consultar o elemento. Motivo: Lista Vazia')
		Else
			Begin
				While (aux^.dado <> n) AND (aux <> NIL) do
					Begin
						aux:=aux^.prox;
						i:=i +1;
					End;
				If aux^.dado = n Then
					Begin
						i:=i +1;
						r:=i;
					End
				Else
					If aux =  NIL then
						r:=0;		
			End;
	End;
	
Procedure escrever(l:ptnodo);
Var
	aux:ptnodo;
	Begin
		CLRSCR;
		aux:=l;
		If aux = NIL then
			Writeln('Não foi possível escrever a lista. Motivo: Lista vazia.')
		Else
			Begin
				While aux <> NIL do
					Begin
						Write(' ',aux^.dado);
						aux:=aux^.prox;
					End;
			End;
	End;

Procedure informa(n, r : Integer);
	Begin
		CLRSCR;
		If r = 0 Then
			Writeln('O número ',n,' não está informado na lista.')
		Else
			Writeln('O número ',n, ' está informado na lista, na POSIÇÃO ',r);
	End;
		
Begin	
	inicializa(lista);
	While opc <> 5 do
		Begin
			Writeln();
			Writeln('[1] - Inserir Lista');
			Writeln('[2] - Remover Lista');
			Writeln('[3] - Consultar Lista');
			Writeln('[4] - Escrever');
			Writeln('[5] - Encerrar Programa');
			Readln(opc);
			Case opc of
				1:
					Begin
						le_numero(num);
				 		insere(lista,num);
				 	End;
				2:
					Begin
						le_numero(num);
				 		remove(lista,num);
				 		Writeln('Removido o número ',num);
				 	End;
				3: 
					Begin
						le_numero(num);
						consulta(lista, num, retorno);
						informa(num, retorno);
					End; 
				4: escrever(lista);
				5: Writeln('Encerrando o programa...');
				Else
					Writeln('Opção Errada!');
			End;
		End;
End.