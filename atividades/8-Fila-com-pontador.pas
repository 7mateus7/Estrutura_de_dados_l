Program Pzim ;
Type 
	tipo_inf = integer;
	ptnodo = ^Tfila; //Reserva um espaço de memória para fila
	Tfila = record //Register com as informações que serão armazenadas no ponteiro 
		dado:tipo_inf; //Dados do tipo integer;
		prox:ptnodo //Dados do próximo ponteiro
	End;
Var
	fila:ptnodo;  //Define a fila como uma estrutura que pode armazenar dados e o próximo elemento;
	opc:integer;  //Variavel paara o menu;

Procedure inicializa(VAR f:ptnodo); //Procededimento que inicializa a fila e define ela como NIL(vazia);
	Begin
		f:=nil;
	End;

Procedure insere(VAR f:ptnodo); //Procedimento para inserir dados a fila
Var
	num:integer;  //Variavel utilizada para ler os elementos inserido pelo usuário;
	aux,aux2:ptnodo; //Variáaveis auxiliares que copiam os dados da fila;
	Begin
		CLRSCR;
		new(aux);  //Aloca um espaço de memória para o ponteiro aux;
		If aux = nil then //Se a variável receber o valor Nil(vazia), então a memória está cheia;
			Writeln('Sua memória está cheia!')
		Else //Se não caso for o primeiro número deve ser a variável fila deve receber os valores definidos em AUX;
			If f = nil then
				Begin
					Writeln('Informe o seu número:');
					Readln(num);
					aux^.dado:=num; //É adicionado o elemento a fila, somente na parte de dados;
					aux^.prox:=nil; //É adicionado a posição a fila, somente na parte da posição;
					fila:=aux; //Fila recebe a estrutura aux inteira;
				End			
			Else
				Begin
					aux2:=f; //É criada a variável de auxílio 02, recebendo a estrutura da fila inteira;
					While aux2^.prox <> nil do //Percorre a fila de ponteiros para encontrar o último elemento
						aux2:=aux2^.prox;
					Writeln('Informe o seu número:');
					Readln(num);
					aux^.dado:=num;	//O novo apontador AUX recebe no seu campo dado o elemento inserido; 
					aux^.prox:=nil; //O AUX^.prox aponta para NIL(vazia);
					aux2^.prox:=aux; //O último ponteiro da fila começa a apontar para o novo elemento da fila, ou seja, aponta para o NOVO último elemento;
				End;
	End;

Procedure remove(VAR f:ptnodo); //Procedimento para remover um número da FILA
Var
	aux:ptnodo; //Variávek AUX recebe o tipo 'ptnodo';
	Begin
		CLRSCR;
		If f = nil then //Se a fila estiver NIL, então ela está vazia
			Writeln('Fila Vazia')
		Else
			Begin
				aux:=f; //Variável AUX aponta para o mesmo local de 'f';
				Writeln('Removendo o número ',f^.dado); //Apresenta a mensagem na tela do número que está sendo removido;
				f:=aux^.prox; //Variável 'f' aponta para o próximo elemento da fila;
				dispose(aux); //É removido a variável AUX;
			End;
	End;
	
Procedure consulta(VAR f:ptnodo); //
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