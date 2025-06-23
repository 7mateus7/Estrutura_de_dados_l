Program Pzim ;
Const								//Define as constantes com os valores máximos de cada fila;
	max_mono = 10;
	max_color = 5;
	max_plotter = 3;
Type
	TFila = record										//Define os elementos do descritor;
		dados : array[1..10] of string;
		posicao : integer;
		entrante : integer;
		atendidas : integer;
		rejeitadas : integer;
	End;
Var
	fila_mono,fila_color,fila_plotter:TFila; //Define as variáveis do tipo descritor;
	num:integer;	//Variável que retorna do procedimento quando o usuário seleciona a fila Mono, Color e Plotter;
	opc:string;  //Variável que armazena o opção escolhida no menu;

Function cheia(posi,m:integer):boolean; //Função que valida de a fila está cheia
	Begin
		If posi = m then
			cheia:=true
		Else
			cheia:=false;
	End;

Function vazia(posi:integer):boolean; //Função que valida se a fila está vazia;
	Begin
		If posi = 0 then
			vazia:=true
		Else
			vazia:=false;
	End;

Procedure menu(var opcao:string); //Procedimento que carrega o menu toda vez que solicitado
	Begin
		Writeln('Escolha a sua opção:');
		Writeln('[I] - Inserir');
		Writeln('[R] - Remover');
		Writeln('[C] - Consultar');
		Writeln('[E] - Escrever');
		Writeln('[S] - Sair');
		Readln(opcao);								//Variável quue lê e retorna para o procedimento a opção escolhida pelo usuário;
		opcao:=upcase(opcao);
	End;

Procedure opcoes(txt:string; Var numero:integer); //Procedimento que lê as opções de fila e retorna ao procedimento
	Begin
		numero:=0;
		While (numero <> 1) and (numero <> 2) and (numero <> 3 ) do
			Begin
				Writeln('Você deseja ',txt,' em qual das opções?');
				Writeln('[1] - MONO');
				Writeln('[2] - COLOR');
				Writeln('[3] - PLOTTER');
				Readln(numero);                          //Variável que lê a opção escolhida pelo usuário;
			End;
	End;
	
Procedure inserir_fila(var f:TFila; max:integer; txt:string); //Procedimento utilizado para inserir um número a fila;
	Begin
		CLRSCR;
		If not cheia(f.posicao,max) then
			Begin
				f.entrante:=f.entrante +1; //Acrescenta +1 aos entrantes;
				f.posicao:=f.posicao +1;  //Acrescenta +1 na posição da fila;
				Writeln('Informe o nome:');
				Readln(f.dados[f.posicao]); //Lê o nome do integrante da fila;
				Writeln('+1 elementos inserido na fila ',txt);
			End
		Else
			Begin
				Writeln('Sua fila está cheia!'); //Caso a fila esteja cheia, retornará esta mensagem;
				f.rejeitadas:=f.rejeitadas +1;  //Acrescente +1 aos rejeitados;
			End;
	End;

Procedure remover_fila(var f:TFila; txt:string); //Procedimento para remover um integrante da fila;
Var
	i:integer;
	Begin
		CLRSCR;
		If not vazia(f.posicao)then
			Begin
				Writeln('Removido a pessoa ',f.dados[1],' da fila ',txt); //Apresenta o nome do integrante;
				For i:=1 to (f.posicao -1) do
					f.dados[i]:=f.dados[i+1];
				f.posicao:=f.posicao -1;    //Retira uma posição da fila;
				f.atendidas:=f.atendidas +1;  //Acrescente +1 a aos atendidos;
			End	
		Else
			Writeln('A Fila ',txt,' está vazia!');  //Caso a fila esteja vazia, apresenta esta mensagem;
	End;

Procedure consultar_fila(f:TFila; txt:string; max:integer);  //Prcdedimento para consultar o estado da fila;
	Begin
		CLRSCR;
		Writeln('Consulta a Fila ',txt);
		Writeln(f.entrante,' pessoa(s) entraram na fila.');
		Writeln(f.atendidas,' pessoa(s) atendidas.');
		Writeln(f.rejeitadas,' pessoa(s) rejeitadas da fila.');
		Writeln('Há ',f.posicao,' pessoas na fila.');
		Writeln('A próxima pessoa na fila é ',f.dados[1]);
		Writeln('Ainda restam ',(max - f.posicao),' posições livres.');
		Writeln();		
	End;

Procedure escrever_fila(f:TFila; txt:string);  //Procedimento para escrever a fila;
Var
	i:integer;
	Begin
		CLRSCR;
		If not vazia(f.posicao) then
			Begin
				Writeln('A sua fila ',txt,' contém as seguintes pessoas:');
				For i:=1 to f.posicao do
					Writeln(f.dados[i]);
				Writeln();
			End
		Else
			Writeln('Sua fila está vazia!');  //Caso a fila esteja vazia, irá retornar esta mensagem;	
	End;
	
Begin  //PROGRAMA PRINCIPAL
	While opc <> 'S' do
		Begin
			menu(opc);
			If opc = 'I' then
				Begin 
					opcoes('Inserir fila',num);
					Case num of 
						1: inserir_fila(fila_mono,max_mono,'MONO');
						2: inserir_fila(fila_color,max_color,'COLOR'); 
						3: inserir_fila(fila_plotter,max_plotter,'PLOTTER');
					End
				End
			Else
				If opc = 'R' then
					Begin
						opcoes('Remover Fila',num);
						Case num of
							1: remover_fila(fila_mono,'MONO');
							2: remover_fila(fila_color,'COLOR');
							3: remover_fila(fila_plotter,'PLOTTER');
						End
					End 
				Else
					If opc = 'C' then
						Begin
							opcoes('Consultar Fila',num);
							Case num of
								1: consultar_fila(fila_mono,'MONO',max_mono);
								2: consultar_fila(fila_color,'COLOR',max_color);	
								3: consultar_fila(fila_plotter,'PLOTTER',max_plotter);
							End
						End
					Else
						If opc = 'E' then
							Begin
								opcoes('Escrever Fila',num);	
								Case num of
									1: escrever_fila(fila_mono,'MONO');
									2: escrever_fila(fila_color,'COLOR');
									3: escrever_fila(fila_plotter,'PLOTTER')
								End
							End
						Else
							Begin
								CLRSCR;
								Writeln('Opção Inválida. Por favor, insira novamante!');
							End;
		End;
End.