Program Pzim ;
Const
	max_socio = 500;
	max_torcedor = 2200;
	max_visitantes = 300;
	max_estadio = 3000;
Type
	pilha = array[1..max_estadio] of integer;
Var
	torcedor,arquibancada:integer;
	pilha_socio:pilha;
Procedure le_torcedor(var torce:integer);
	Begin
		While (torce <> 1) and (torce <>2) do
			Begin
				CLRSCR;
				Writeln('Escolha a sua op��o:');
				Writeln('[1] - Torcedor do Santa Catarina:');	 
				Writeln('[2] - Torcedor Visitante:');
				Readln(torce);                                                         
				If (torce <> 1) and (torce <> 2) then
				Writeln('Op��o errada, por favor informe novamente!');
			End;
	End;

Procedure le_arquibancada(torce:integer;var arqui:integer);
Var
	opc:integer;
	Begin
		If torce = 2 then
			opc:=3
		Else
			Begin
				Writeln('S�cio torcedor?');
				Writeln('[1] - SIM');
				Writeln('[2] - N�O');
				Readln(opc);
			End;
			If opc = 1 then
				Begin
					Writeln('Arquibancada: Coberta - Setor S�CIO TORCEDOR');
					arqui:=1;
				End
			Else
				If opc = 2 then
					Begin
						Writeln('Escolha a arquibancada:');
						Writeln('[1] - Arquibancada Coberta');
						Writeln('[2] - Geral');
						Readln(arqui);
					End
				Else
					If opc = 3 then
						Begin
							Writeln('Arquibancada: Geral - Setor VISITANTE');
							arqui:=3;
						End
					Else
						Writeln('Op��o errada!');
	End;
Begin
	le_torcedor(torcedor);
	le_arquibancada(torcedor,arquibancada);
	//venda_ingresso(arquibancada,pilha_socio,);
End.