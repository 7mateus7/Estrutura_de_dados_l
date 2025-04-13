Program Pzim ;
Const
	max_mono = 10;
	max_color = 5;
	max_plotter = 3;
Type
	TFila = record
		dados : array[1..10] of integer;
		posicao : integer;
		entrante : integer;
		atendidas : integer;
		rejeitadas : integer;
	End;
Var
	fila_mono,fila_color,fila_plotter:TFila;
	opc,num:integer;

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

Procedure inicializa(var n:integer);
	Begin
		n:=0;
	End;

Procedure menu(var opcao:integer);
	Begin
		Writeln('Escolha a sua opção:');
		Writeln('[1] - Inserir');
		Writeln('[2] - Remover');
		Writeln('[3] - Consultar');
		Writeln('[4] - Sair');
		Readln(opcao)
	End;

Procedure opcoes(txt:string; Var numero:integer);
	Begin
		Writeln('Você deseja ',txt,' em qual das opções?');
		Writeln('[1] - MONO');
		Writeln('[2] - COLOR');
		Writeln('[3] - PLOTTER');
		REadln(numero);
	End;
	
Procedure inserir_fila(var f:TFila; max:integer; txt:string);
	Begin
		CLRSCR;
		If not cheia(f.posicao,max) then
			Begin
				f.entrante:=f.entrante +1;
				f.posicao:=f.posicao +1;
				f.dados[f.posicao]:=f.entrante;
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
	
Begin
	inicializa(opc);
	While opc <> 4 do
		Begin
			menu(opc);
			If opc = 1 then
				Begin 
					opcoes('Inserir fila',num);
					Case num of 
						1: inserir_fila(fila_mono,max_mono,'MONO');
						2: inserir_fila(fila_color,max_color,'COLOR'); 
						3: inserir_fila(fila_plotter,max_plotter,'PLOTTER');
					End
				End
			Else
				If opc = 2 then
					Begin
						opcoes('Remover Fila',num);
						Case num of
							1: remover_fila(fila_mono,'MONO');
							2: remover_fila(fila_color,'COLOR');
							3: remover_fila(fila_plotter,'PLOTTER');
						End
					End 
		End;
End.