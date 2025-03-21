Program Pzim ;
Const
	max_socio = 500;
	max_torcedor_geral = 700;
	max_torcedor_arquibancada = 1500;			//Definição dos valores máximos das pilhas de torcedores comuns, sócios-torcedores e visitantes
	max_visitante = 300;
	max_estadio = 3000;
Type
	pilha = array[1..max_estadio] of integer;		//Definição do type PILHA para utilização em procedimentos
	fila = array[1..max_estadio] of integer; 
	lista = array[1..max_estadio] of integer;
Var
	tam_fila,torcedor,arquibancada,tam_socio,tam_torcedor_geral,tam_torcedor_arquibancada,tam_visitante, tam_lista_socio:integer; 		//Definição de todas as variáveis de escopo global e de números inteiros
	pilha_socio:pilha;
	pilha_torcedor_geral:pilha;
	pilha_torcedor_arquibancada:pilha;  		//Definição das variáveis de pilha como: pilha sócio-torcedores,torcedores geral, torcedores visitantes
	pilha_visitante:pilha;
	fila_torcedor:fila;
	lista_socio:lista;
	retorno:boolean;		//Definição da variável que defini se o processo continuará ou será interrompido

Procedure iniciar_fila(var fila_atual:fila;var tam_atual:integer; max_fila:integer); //Adiciona o número máximo do estádio(3000) em uma fila de espera.
Var
	i:Integer;
	Begin
	tam_atual:=max_fila;	
		for i:=1 to tam_atual do
			fila_atual[i]:=i;
	End;

Procedure iniciar_variavel(var pilha_atual:pilha; var tam_atual:integer; tam_max:integer);	//Encrementa todas as posições das pilhas de ingressos. Ex: pilha visitantes = 300.
Var
	i,n:integer;
	Begin
		tam_atual:=tam_max;
		i:=tam_max;
		While i >= 1 do
			Begin
				n:=n +1;
				pilha_atual[n]:=i;
				i:=i -1;
			End;
	End;

Procedure iniciar_lista(var lista_atual:lista; tam_maximo:integer; var tam_lista:integer);
Var
	i:integer;
	Begin
		tam_lista:=tam_maximo;
		For i:=1 to tam_maximo do
			Begin
				lista_atual[i]:=i;
			End;
	End;

Function v_cheia(tam_atual,tam_maximo:integer):boolean;	//Verifica se a pilha está cheia
	Begin
		If tam_atual = tam_maximo then
			v_cheia:=true
		Else
			v_cheia:=false;
	End;

Function v_vazia(tam_atual:integer):boolean;	//Verifica se a pilha está vazia
	Begin
		If tam_atual = 0 then
			v_vazia:=true
		Else
			v_vazia:=false; 
	End;

Procedure le_torcedor(var torce:integer);	//O usuário informa se o torcedor é torcedor do Santa ou da torcida visiante
	Begin
				CLRSCR;
				torce:=0;
				While (torce <> 1) and (torce <> 2) do
				Begin
					Writeln('Escolha a sua opção:');
					Writeln('[1] - Torcedor do Santa Catarina:');	 
					Writeln('[2] - Torcedor Visitante:');
					Readln(torce);                                                         
					If (torce <> 1) and (torce <> 2) then
						Writeln('Opção errada, por favor informe novamente!'); //Caso o usuário informar um número diferente de 1 e 2, está mensagem é exibida
				End;
	End;

Procedure le_arquibancada(torce:integer;var arqui:integer);	//Define em qual arquibancada o torcedor irá se acomodar, com base nas retrições.
Var
	opc,n:integer;
	Begin
		//CLRSCR;
		If torce = 2 then //Torcedor visitante é defininido automaticamente para o de visitante
			opc:=3
		Else
			Begin
				Writeln('Sócio torcedor?');
				Writeln('[1] - SIM');
				Writeln('[2] - NÃO');
				Readln(opc);
			End;
			If opc = 1 then
				Begin
					Writeln('Arquibancada: Coberta - Setor SÓCIO TORCEDOR');		//O sócio-torcedor também já recebe sua arquibancada pré determinada segunda as normativas
					arqui:=1;
				End
			Else
				If opc = 2 then
					Begin
						Writeln('Escolha a arquibancada:');  //Torcedor comum pode escolher entre arquibancada geral e arquibancada coberta
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
								Writeln('Opção errada!')
					End
				Else
					If opc = 3 then
						Begin
							Writeln('Arquibancada: Geral - Setor VISITANTE');
							arqui:=4;
						End
					Else
						Writeln('Opção errada!');
	End;

Procedure remover_pilha(var pilha_atual:pilha; var tam_atual:integer; max_pilha:integer); 	//Remove uma posição na pilha de ingressos determinada.
	Begin
		Writeln('Ingresso ',pilha_atual[tam_atual],' vendido.');
		tam_atual:=tam_atual -1;
	End;

Procedure remover_fila(var r_fila:fila; var tamanho:integer);		//Remove o torcedor da fila após a compra do seu ingresso
Var
	i:integer;
	Begin
		For i:=1 to (tamanho -1) do
			r_fila[i]:=r_fila[i+1];
		tamanho:= tamanho -1;
	End;

{Procedure pesquisa(lista_pesquisa:pilha; tamanho_pilha_p:integer; n:integer; var ret:integer);
Var
	i,final,media:integer;
	Begin
		ret:=0;
		i:=1;
		final:=tamanho_pilha_p;
		media:= (i + final) div 2;
		If lista_pesquisa[media] = n then
			ret:=true;
		While (i<final) and (lista_pesquisa[media] <> n) do
			Begin
				media:=(i + final) mod 2;
				If lista_pesquisa[media] = n then
					ret:=media
				Else
					If lista_pesquisa[media] < n then
						i:=media +1
					Else
						final:=media -1	
			End;
	End;}

Procedure apresentar(lista_atual:lista; max_lista:integer);
Var
	i:integer;
	Begin
		For i:=1 to max_lista do
			Begin
				Write('',lista_atual[i]:4,' Disponível'); 
				If i mod 10 = 0 then
					Writeln();
			End;
	End;

Procedure local(var lista_local:lista; var tam_lista_local:integer);
Var 
	num:integer;
	retorno:integer;
	Begin
		apresentar(lista_local,tam_lista_local);
		Writeln('Esclha a sua cadeira');
		
		//pesquisa(lista_local,tam_lista_local,num, retorno);
	End;
	
Procedure venda(var pilha_venda:pilha; var tam_pilha:integer; max_pilha:integer; var reto:boolean;var fila_atual:fila; var tam_fila_atual:integer; var lista_atual:lista; var tam_lista:integer);
Var
	vazia:boolean;                  //Procedimento de escolha e venda de um lugar
	opc:integer;
	Begin
		CLRSCR;
		vazia:=v_vazia(tam_pilha);
		If not vazia then
			Begin
				Writeln('Torcedor: ',fila_atual[1]);	
				remover_pilha(pilha_venda,tam_pilha,max_pilha);
				local(lista_atual, tam_lista);
				remover_fila(fila_atual,tam_fila_atual);
				Writeln('Ainda restram ',(tam_pilha),' ingressos vagos no setor.');
			End	
		Else
			Writeln('Todos os lugares estão ocupados!');
			
		Writeln();
		
		Writeln('Deseja continuar as vendas?');		//Solicita se o usuário deseja continuar o processo
		Writeln('[1] - SIM');
		Writeln('[2] - NÃO');
		Readln(opc);
		If opc = 1 then
			reto:=true
		Else	
			if opc = 2 then
				reto:=false
			Else
				Writeln('opção errada!');
	End;
Begin
	iniciar_fila(fila_torcedor,tam_fila,max_estadio);	//Define a fila de torcedores
	
	retorno:=true; //Define o inicio do processo
	
	iniciar_variavel(pilha_socio,tam_socio,max_socio); //inicia a pilha de sócios-torcedores
	iniciar_variavel(pilha_torcedor_arquibancada,tam_torcedor_arquibancada,max_torcedor_arquibancada);	//Inicia a pilha de torcedores na Geral
	iniciar_variavel(pilha_torcedor_geral,tam_torcedor_geral,max_torcedor_geral);	//Inicia a pilha de torcedores na Arquibancada Coberta
	iniciar_variavel(pilha_visitante,tam_visitante,max_visitante);
	
	iniciar_lista(lista_socio,max_socio,tam_lista_socio);
	While retorno do
		Begin
			le_torcedor(torcedor);	//Define qual tipo de torcedor. Visitante/Torcedor do Santa 
			le_arquibancada(torcedor,arquibancada); //Defina as arquibancadas
			Case arquibancada of
				1: venda(pilha_socio, tam_socio,max_socio, retorno,fila_torcedor, tam_fila, lista_socio, tam_lista_socio); //Procedimento de venda e escolha do lugar
				//2: venda(pilha_torcedor_arquibancada,tam_torcedor_arquibancada,max_torcedor_arquibancada,retorno,fila_torcedor,tam_fila);	
				//3: venda(pilha_torcedor_geral,tam_torcedor_geral,max_torcedor_geral,retorno,fila_torcedor,tam_fila);
				//4: venda(pilha_visitante,tam_visitante,max_visitante,retorno,fila_torcedor,tam_fila);
			End;
		End;
End.