Program Pzim ;
Const
	max_mono = 10;
	max_color = 5;
	max_plotter = 3;
Type
	TFila = record
		dados : array[1..10] of string;
		posicao : integer;
		entrante : integer;
		atendidas : integer;
		rejeitadas : integer;
	End;
Var
	fila_mono,fila_color,fila_plotter:TFila;
	num:integer;
	opc:string;

Function cheia(posi,m:integer):boolean;
	Begin
		If posi = m then
			cheia:=true
		Else
			cheia:=false;
	End;

Function vazia(posi:integer):boolean;
	Begin
		If posi = 0 then
			vazia:=true
		Else
			vazia:=false;
	End;

Procedure menu(var opcao:string);
	Begin
		Writeln('Escolha a sua opção:');
		Writeln('[I] - Inserir');
		Writeln('[R] - Remover');
		Writeln('[C] - Consultar');
		Writeln('[E] - Escrever');
		Writeln('[S] - Sair');
		Readln(opcao);
		opcao:=upcase(opcao);
	End;

Procedure opcoes(txt:string; Var numero:integer);
	Begin
		numero:=0;
		While (numero <> 1) and (numero <> 2) and (numero <> 3 ) do
			Begin
				Writeln('Você deseja ',txt,' em qual das opções?');
				Writeln('[1] - MONO');
				Writeln('[2] - COLOR');
				Writeln('[3] - PLOTTER');
				Readln(numero);
			End;
	End;
	
Procedure inserir_fila(var f:TFila; max:integer; txt:string);
	Begin
		CLRSCR;
		If not cheia(f.posicao,max) then
			Begin
				f.entrante:=f.entrante +1;
				f.posicao:=f.posicao +1;
				Writeln('Informe o nome:');
				Readln(f.dados[f.posicao]);
				Writeln('+1 elementos inserido na fila ',txt);
			End
		Else
			Begin
				Writeln('Sua fila está cheia!');
				f.rejeitadas:=f.rejeitadas +1;
			End;
	End;

Procedure remover_fila(var f:TFila; txt:string);
Var
	i:integer;
	Begin
		CLRSCR;
		If not vazia(f.posicao)then
			Begin
				Writeln('Removido a pessoa ',f.dados[1],' da fila ',txt);
				For i:=1 to (f.posicao -1) do
					f.dados[i]:=f.dados[i+1];
				f.posicao:=f.posicao -1;
				f.atendidas:=f.atendidas +1;
			End	
		Else
			Writeln('A Fila ',txt,' está vazia!');
	End;

Procedure consultar_fila(f:TFila; txt:string; max:integer);
	Begin
		CLRSCR;
		Writeln('Consulta a Fila',txt);
		Writeln(f.entrante,' pessoas entraram na fila.');
		Writeln(f.atendidas,' pessoas foram atendidas.');
		Writeln(f.rejeitadas,' pessoas foram rejeitadas da fila.');
		Writeln('Há ',f.posicao,' pessoas na fila.');
		Writeln('A próxima pessoa na fila é ',f.dados[1]);
		Writeln('Ainda restam ',(max - f.posicao),' posições livres.');
		Writeln();		
	End;

Procedure escrever_fila(f:TFila; txt:string);
Var
	i:integer;
	Begin
		CLRSCR;
		Writeln('A sua fila ',txt,' contém as seguintes pessoas:');
		For i:=1 to f.posicao do
			Writeln(f.dados[i]);
		Writeln();	
	End;
	
Begin
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