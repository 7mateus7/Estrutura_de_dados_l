Program Pzim ;
Type
	ptnodo = ^Tpilha;
	Tpilha = Record
		dado : integer;
		prox : ptnodo;
	End;

Var
	pilha : ptnodo;
	opc, num : integer; 
	
Procedure inicializa(p:ptnodo);
	Begin
		p:= NIL;
	End;

Procedure le_numero (VAR n:integer);
	Begin
		Writeln('Informe um número:');
		Readln(n);
	End;

Procedure insere(VAR p:ptnodo; elem:integer);
Var
	aux, aux2:ptnodo;
	Begin
		CLRSCR;
		NEW(aux);
		If aux =  NIL then
			Writeln('MEMÓRIA CHEIA!')
		Else
			Begin
				aux^.dado:=elem;
				aux^.prox:=NIL;
				If p = NIL then
					Begin
						//aux.dado:= elem;
						//aux.prox:=NIL;
						p:=aux;	
					End
				Else
					Begin
						aux2:=p;
						While aux2^.prox <> NIL do
							aux2:=aux2^.prox;
						//aux^.dado:=elem;
						//aux^.prox:=NIL;
						aux2^.prox:=aux;
					End;
			End;
	End;

Procedure remove(VAR p:ptnodo;VAR elem:integer);
Var
	aux, ant:ptnodo;
	Begin
		CLRSCR;
		elem:=0;
		aux:=p;
		If aux = NIL then
			Writeln('PILHA VAZIA')
		Else
			Begin
				ant:=p;
				While aux^.prox <> NIL do
					Begin 
						ant:=aux;
						aux:=aux^.prox;
					End;
				elem:=aux^.dado;
				If ant = aux then
					p:= NIL
				Else
					Begin 
						ant^.prox:= NIL;
						DISPOSE(aux);	
					End
			End;
	End;

Procedure consulta(p:ptnodo);
VAR
	aux:ptnodo;
	Begin
		CLRSCR;
		aux:=p;
		If aux = NIL then
			Writeln('PILHA VAZIA!')
		Else
			Begin
				While aux^.prox <> NIL do
					aux:=aux^.prox;
				Writeln('O próximo n° a ser removido é igual a ',aux^.dado);
			End;
	End;

Procedure escrever(p:ptnodo);
Var
	aux:ptnodo;
	Begin
		CLRSCR;
		aux:=p;
		If aux = NIL then
			Writeln('PILHA VAZIA!')
		Else
			Begin
				While aux <> NIL do
					Begin			
						Write(' ',aux^.dado);
						aux:=aux^.prox;
					End;
			End;
			Writeln();
	End;
			
Begin
	inicializa(pilha);
	While opc <> 5 do
		Begin
			Writeln();
			Writeln('[1] - Inserir Pilha');
			Writeln('[2] - Remover Pilha');
			Writeln('[3] - Consultar Pilha');
			Writeln('[4] - Escrever');
			Writeln('[5] - Encerrar Programa');
			Readln(opc);
			Case opc of
				1:Begin
						le_numero(num);
				 		insere(pilha, num);
					End;
				2:Begin
				 		remove(pilha, num);
				 		If num <> 0 then
				 			Writeln('Removendo N° ',num);
				  End;
				3: consulta(pilha); 
				4: escrever(pilha);
				5: Writeln('Encerrando o programa...');
				Else
					Writeln('Opção Errada!');
			End;
		End;
End.