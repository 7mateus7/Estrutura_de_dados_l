Program Pzim ;
Type tipo_inf = integer;
	ptnodo = ^Tfila; //Reserva um espaço de memória para fila
	Tfila = record //Register com as informações que serão armazenadas no ponteiro 
		dado:tipo_inf; //Dados do tipo integer;
		prox:ptnodo //Dados do próximo ponteiro
	End;
Var
	fila:ptnodo;
	opc:integer;

Procedure inicializa(VAR f:ptnodo);
	Begin
		f:=nil;
	End;

Procedure insere(VAR f:ptnodo);
Var
	num:integer;
	aux,aux2:ptnodo;
	Begin
		CLRSCR;
		new(aux);
		If aux = nil then
			Writeln('Sua memória está cheia!')
		Else
			If f = nil then
				Begin
					Writeln('Informe o seu número:');
					Readln(num);
					aux^.dado:=num;
					aux^.prox:=nil;
					fila:=aux;
				End			
			Else
				Begin
					aux2:=f;
					While aux2^.prox <> nil do
						aux2:=aux2^.prox;
					Writeln('Informe o seu número:');
					Readln(num);
					aux^.dado:=num;
					aux^.prox:=nil;
					aux2^.prox:=aux;
				End;
	End;

Procedure remove(VAR f:ptnodo);
Var
	aux:ptnodo;
	Begin
		CLRSCR;
		If f = nil then
			Writeln('Fila Vazia')
		Else
			Begin
				aux:=f;
				Writeln('Removendo o número ',aux^.dado);
				fila:=aux^.prox;
				dispose(aux);
			End;
	End;
	
Procedure consulta(VAR f:ptnodo);
Var
	aux:ptnodo;
	Begin
		CLRSCR;
		aux:=f;
		If f = nil then
			Writeln('Sua fila está vazia')
		Else
			Writeln('O próximo número para ser removido será ',aux^.dado);
	End;
	
Procedure escrever(VAR f:ptnodo);
Var
	aux:ptnodo;
	Begin
		CLRSCR;
		aux:=f;
		If aux = nil then
			Writeln('Fila Vazia')
		Else
			While aux <> nil do
				Begin
					Write(' ',aux^.dado);
					aux:=aux^.prox;
				End;
			Writeln();
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
				1: insere(fila);
				2: remove(fila);
				3: consulta(fila); 
				4: escrever(fila);
				5: Writeln('Encerrando o programa...');
				Else
					Writeln('Opção Errada!');
			End;
		End;		
End.