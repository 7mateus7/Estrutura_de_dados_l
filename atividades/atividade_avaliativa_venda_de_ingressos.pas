Program Pzim ;
Const
	max_socio = 500;
	max_torcedor_geral = 700;
	max_torcedor_arquibancada = 1500;			//Defini��o dos valores m�ximos das pilhas de torcedores comuns, s�cios-torcedores e visitantes
	max_visitantes = 300;
	max_estadio = 3000;
Type
	pilha = array[1..max_estadio] of integer;		//Defini��o do type PILHA para utiliza��o em procedimentos
	fila = array[1..max_estadio] of integer; 
Var
	tam_fila,torcedor,arquibancada,tam_socio,tam_torcedor_geral,tam_torcedor_arquibancada:integer; 		//Defini��o de todas as vari�veis de escopo global e de n�meros inteiros
	pilha_socio:pilha;
	pilha_torcedor_geral:pilha;
	pilha_torcedor_arquibancada:pilha;  		//Defini��o das vari�veis de pilha como: pilha s�cio-torcedores,torcedores geral, torcedores visitantes
	fila_torcedor:fila;
	retorno:boolean;		//Defini��o da vari�vel que defini se o processo continuar� ou ser� interrompido

Procedure iniciar_fila(var fila_atual:fila;var tam_atual:integer; max_fila:integer); //Adiciona o n�mero m�ximo do est�dio(3000) em uma fila de espera.
Var
	i:Integer;
	Begin
	tam_atual:=max_fila;	
		for i:=1 to tam_atual do
			fila_atual[i]:=i;
	End;

Procedure iniciar_variavel(var pilha_atual:pilha; var tam_atual:integer; tam_max:integer);	//Encrementa todas as posi��es das pilhas de ingressos. Ex: pilha visitantes = 300.
Var
	i:integer;
	Begin
		tam_atual:=tam_max;
		For i:=1 to tam_max do
			pilha_atual[i]:=i;
	End;

Function v_cheia(tam_atual,tam_maximo:integer):boolean;	//Verifica se a pilha est� cheia
	Begin
		If tam_atual = tam_maximo then
			v_cheia:=true
		Else
			v_cheia:=false;
	End;

Function v_vazia(tam_atual:integer):boolean;	//Verifica se a pilha est� vazia
	Begin
		If tam_atual = 0 then
			v_vazia:=true
		Else
			v_vazia:=false; 
	End;

Procedure le_torcedor(var torce:integer);	//O usu�rio informa se o torcedor � torcedor do Santa ou da torcida visiante
	Begin
		While (torce <> 1) and (torce <>2) do
			Begin
				CLRSCR;
				Writeln('Escolha a sua op��o:');
				Writeln('[1] - Torcedor do Santa Catarina:');	 
				Writeln('[2] - Torcedor Visitante:');
				Readln(torce);                                                         
				If (torce <> 1) and (torce <> 2) then
				Writeln('Op��o errada, por favor informe novamente!'); //Caso o usu�rio informar um n�mero diferente de 1 e 2, est� mensagem � exibida
			End;
	End;

Procedure le_arquibancada(torce:integer;var arqui:integer);	//Define em qual arquibancada o torcedor ir� se acomodar, com base nas retri��es.
Var
	opc,n:integer;
	Begin
		CLRSCR;
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
						Readln(n);
						If n = 1 then
							Begin
								Writeln('Arquibancada: Coberta - Setor Torcedor');
								arqui:=2
							End
						Else
							If n = 2 then
								Begin
									Writeln('Arquibancada: Geral - Setor Torcedor');
									arqui:=3;
								End
							Else
								Writeln('Op��o errada!')
					End
				Else
					If opc = 3 then
						Begin
							Writeln('Arquibancada: Geral - Setor VISITANTE');
							arqui:=4;
						End
					Else
						Writeln('Op��o errada!');
	End;

Procedure remover_pilha(var pilha_atual:pilha; var tam_atual:integer; max_pilha:integer); 	//Remove uma posi��o na pilha de ingressos determinada
	Begin
		Writeln('Ingresso ',pilha_atual[tam_atual],' vendido.');
		tam_atual:=tam_atual -1;
	End;

Procedure remover_fila(var r_fila:fila; var tamanho:integer);
Var
	i:integer;
	Begin
		For i:=1 to (tamanho -1) do
			r_fila[i]:=r_fila[i+1];
		tamanho:= tamanho -1;
	End;
	
Procedure venda(var pilha_venda:pilha; var tam_pilha:integer; max_pilha:integer; var reto:boolean;var fila_atual:fila; var tam_fila_atual:integer);
Var
	vazia:boolean;
	opc:integer;
	Begin
		Writeln;
		vazia:=v_vazia(tam_pilha);
		If not vazia then
			Begin
				Writeln('Torcedor: ',fila_atual[1]);	
				remover_pilha(pilha_venda,tam_pilha,max_pilha);
				remover_fila(fila_atual,tam_fila_atual);
				Writeln('Ainda restram ',(tam_pilha),' ingressos vagos.');
			End	
		Else
			Writeln('Todos os lugares est�o ocupados!');
			
		Writeln();
		
		Writeln('Deseja continuar as vendas?');
		Writeln('[1] - SIM');
		Writeln('[2] - N�O');
		Readln(opc);
		If opc = 1 then
			reto:=true
		Else	
			if opc = 2 then
				reto:=false
			Else
				Writeln('op��o errada!');
	End;
Begin
	iniciar_fila(fila_torcedor,tam_fila,max_estadio);	
	
	retorno:=true;
	
	iniciar_variavel(pilha_socio,tam_socio,max_socio);
	iniciar_variavel(pilha_torcedor_arquibancada,tam_torcedor_geral,max_torcedor_geral);
	iniciar_variavel(pilha_torcedor_geral,tam_torcedor_arquibancada,max_torcedor_arquibancada);
	
	le_torcedor(torcedor);
	While retorno do
		Begin
			le_arquibancada(torcedor,arquibancada);
			Case arquibancada of
				1: venda(pilha_socio,tam_socio,max_socio,retorno,fila_torcedor,tam_fila);
				2: venda(pilha_torcedor_arquibancada,tam_torcedor_arquibancada,max_torcedor_arquibancada,retorno,fila_torcedor,tam_fila);	
			End;
		End;
End.