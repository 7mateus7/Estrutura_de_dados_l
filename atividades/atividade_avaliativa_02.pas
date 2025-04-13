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
	opc:integer;

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
	While opc <> 7 do
		Begin
			Writeln('Escolha uma opção:');
			Writeln('-------------------------------------------');
			Writeln('| Inserir na Fila   | Remover da Fila     |');
			Writeln('-------------------------------------------');
			Writeln('| [1] Mono          | [4] Mono            |');
			Writeln('| [2] Colorida      | [5] Colorida        |');
			Writeln('| [3] Plotter       | [6] Plotter         |');
			Writeln('-------------------------------------------');
			Writeln('| [7] Sair                                |');
			Writeln('-------------------------------------------');
			Readln(opc);
			Case opc of
				1: inserir_fila(fila_mono,max_mono,'MONO');
				2: inserir_fila(fila_color,max_color,'COLOR');
				3: inserir_fila(fila_plotter,max_plotter,'PLOTTER');
				4: remover_fila(fila_mono,'MONO');
				5: remover_fila(fila_color,'COLOR');
				6: remover_fila(fila_plotter,'PLOTTER');
			End;
		End;
End.