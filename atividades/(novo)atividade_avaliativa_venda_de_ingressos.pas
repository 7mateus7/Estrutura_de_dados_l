Program Pzim ;
Const
	max_torcedor_geral = 700; //Definição de Constantes do número de torcedores.
	max_torcedor = 1500;                    
	max_socio = 500;                                             
	max_visitante = 300;
	
	max_arquibancada = 2000; 	//Define o valor máximo da Arquibancada para ser disponibilizado nas listas de ingressos.
	
	valor_socio = 50; 					//Define os valores dos ingressos dos respectivos tipos de torcedores.
	valor_torcedor = 100;
	valor_torcedor_geral = 40;
	valor_visitante = 80;
Type
	pilha = array[1..1500] of integer;         //Definindo o tamanho das pilhas, filas e Listas.
	fila = array[1..1500] of integer;
	lista = array[1..2000]of integer;
Var
	opc,resposta:integer;  //Variável que lê a opção do MENU.
	
	arrecadacao_socio,arrecadacao_torcedor,arrecadacao_torcedor_geral,arrecadacao_visitante,arrecadacao_total:integer; //Variáveis que armazena tanto o faturamento por setor quanto o faturamento total  

	tam_pilha_socio, tam_pilha_torcedor, tam_pilha_torcedor_geral, tam_pilha_visitante:integer;		//Variáveis das pilhas de ingressos de cada setor do estádio.
	                                                                                                                                                                   
	tam_fila_socio,tam_fila_torcedor, tam_fila_torcedor_geral, tam_fila_visitante:integer;		//Variáveis que determinam o tamanho das filas em seus respctivos setores.
	
	tam_lista_arquibancada, tam_lista_torcedor_geral, tam_lista_visitante :integer;  //Variáveis que determinam a lista de lugares vagos em seus respectivos setores.
		
	pilha_socio, pilha_torcedor, pilha_torcedor_geral, pilha_visitante:pilha; //Variáveis que determinas as pilha de ingressos disponíveis pela Federação.
	
	fila_socio, fila_torcedor, fila_torcedor_geral, fila_visitante:fila; //Variaveis que determinam as filas onde os torcedores estão sendo alocados.
	
	lista_arquibancada, lista_torcedor_geral, lista_visitante :lista; //Variáveis que armazenam as listas com as cadeiras disponíveis.
	
Procedure inicializar(var n:integer); //Inicializa determinada variável em zero.
	Begin
		n:=0;
	End;
		
Procedure iniciar_pilha(max_pilha:integer; pilha_atual:pilha; var tam_pilha:integer);  //Insere os ingressos nas pilhas disponibilizados pela Federação. 
Var
	i:integer;
	Begin
		For i:=1 to max_pilha do
			pilha_atual[i]:=i;
		tam_pilha:=max_pilha;	
	End;

Function v_cheia(tam,tam_max:integer):boolean;  //Verifica se determinada fila,pilha ou lista está com a sua capacidade máxima.
	Begin
		If tam >= tam_max then
			v_cheia:=true
		Else
			v_cheia:=false;	 
	End;
	
Function v_vazia(tam:integer):boolean; //Verifica se determinada fila,pilha ou lista está com o seu tamanho igual a zero.
	Begin
		If tam = 0 then
			v_vazia:=true
	  Else
	  	v_vazia:=false;
	End;

Procedure iniciar_lista(var lista_atual:lista;var tam_lista:integer; tam_max:integer );  //Insere todos as cadeiras nas listas.
Var
	i:integer;
	Begin
		If tam_lista = 0 then
			tam_lista:=1;
		For i:=tam_lista to tam_max do
			lista_atual[i]:=i;
		tam_lista:=tam_max;	
	End;

Procedure inserir_fila(var fila_atual:fila;var tam_atual:integer; maximo_fila:integer; texto:string);  //Insere um torcedor na fila assim que o procedimento e chamado.
Var
	cheia:boolean;
	Begin
		CLRSCR;
		cheia:=v_cheia(tam_atual,maximo_fila);
		If not cheia then
			Begin
				tam_atual:=tam_atual +1;
				fila_atual[tam_atual]:=random(10000);  //Define um número aleatório para o novo torcedor que entrou na fila. (ID)
				Writeln('+1 Torcedor na fila de ',texto);
			End
		Else
			Writeln('Sua fila está com a capacidade Máxima'); //Retorna esta mensagem caso a fila atinja a sua capacide máxima.
	End;

Procedure remover_fila(var fila_remove:fila; var tam_fila_remove:integer);  //Procedimento de remover o torcedor da fila após a compra de seu ingresso.
Var
	i:integer;
	Begin
		For i:=1 to (tam_fila_remove-1) do
			fila_remove[i]:=fila_remove[i+1];
		tam_fila_remove:=tam_fila_remove -1;
	End;

Procedure remover_pilha(var pilha_remover:pilha;var tam_pilha_remove:integer; var vazia:boolean; txt:string); //Procedimento de remover um ingresso da pilha, após a compra do torcedor.
	Begin
		vazia:=v_vazia(tam_pilha_remove);
		If not vazia then
			tam_pilha_remove:=tam_pilha_remove -1
		Else
			Writeln('Não há ingressos disponíveis no setor ',txt); //Mensagem apresentada caso a pilha de ingressos do setor seja igual a zero.
	End;

Procedure pesquisa (lista_pesq:lista; tam_lista_pesq,n:integer; var ret:integer); //Procecimento que realiza a pesquisa binária após a escolha da cadeira.
Var
	i,final,media:integer;
	Begin
		inicializar(ret); //Define a variavel 'ret' em zero. Caso ela retorne do procedimento o mesmo valor, significa que o número não foi encontrado.
		i:=1;
		final:=tam_lista_pesq;
		media:=(i + final) div 2;
		If lista_pesq[media] = n then
			ret:=media
		Else
			While (i<=final) and (lista_pesq[media] <> n) do
				Begin
					media:=(i+final) div 2;
					If lista_pesq[media] = n then
						ret:=media
					Else
						If lista_pesq[media] < n then
							i:=media +1
						Else
							final:=media -1
				End;
	End;

Procedure remove_lista(var lista_remove:lista; var tam_lista_remove:integer; posicao:integer); //Caso a cadeira desejada esteja disponível, ela é removida da lista com este procedimento.
Var
	i:integer;
	Begin
		For i:=posicao to (tam_lista_remove -1) do
			lista_remove[i]:=lista_remove[i+1];
		tam_lista_remove:= tam_lista_remove -1;
	End;

Procedure cadeira(var lista_atual:lista; var tam_lista_atual:integer; txt:string; fila_torcida:fila; posicao:integer); //Procedimento que força o torcedor a escolher uma cadeira vaga.
Var
	i,numero,retorno:integer;
	vazia:boolean;
	Begin
		Writeln();
		inicializar(retorno);
		vazia:=v_vazia(tam_lista_atual);
		If not vazia then
			While retorno = 0 do
				Begin
					For i:=1 to tam_lista_atual do  //Apresenta a lista de cadeiras vagas para o usuário.
						Begin
							Write('',lista_atual[i]:5);
							If i mod 30 = 0 then
								Writeln();
						End;
					Writeln();
					Writeln('Escolha a cadeira do torcedor ',fila_torcida[posicao],' do setor ',txt,':'); //Solicita a cadeira desejada.
					Readln(numero);
					pesquisa(lista_atual,tam_lista_atual,numero,retorno); //Realiza a pesquisa binária.
					If retorno <> 0 then
						remove_lista(lista_atual,tam_lista_atual,retorno) //Remove da lista caso a cadeira esteja disponível.
					Else
						Begin
							CLRSCR;
							Writeln('Cadeira Indisponível!'); //Apresenta esta mensagem caso a cadeira não esteja disponível.
						End;
				End;		
	End;

Procedure venda(var fila_venda:fila;var tam_fila_atual:integer; texto:string; //Procedimento principal do programa, onde todos os processos são realizados.
								var pilha_atual:pilha;var tam_pilha_atual:integer;
								var lista_atual:lista; var tam_lista_atual:integer);
Var
	fila_vazia,ingresso:boolean;
	lugar:integer;
	Begin
		While not v_vazia(tam_fila_atual) do //Indica que enquanto a fila não esteja vazia, ele seguirá realzando este processo.
			Begin
				CLRSCR;
					remover_pilha(pilha_atual,tam_pilha_atual,ingresso,texto); //Se caso houver ingressos disponível, ele irá remover neste procedimento. 
					If not ingresso then //Retorna o valor do procedimento 'v_vazia', onde se caso ainda tenha ingressos disponíveis o processo continuará.					
						cadeira(lista_atual,tam_lista_atual,texto,fila_venda,tam_fila_atual); //O torcedor escolhe sua cadeira.
					remover_fila(fila_venda,tam_fila_atual); //Remove o torcedor da fila  
			End;		
		Writeln('Fila ',texto,' vazia!'); //Caso a fila esteja vazia, apresenta está mensagem.
	End;

Procedure faturamento(tam_pilha_ingresso,max_pilha,valor:integer;Var total_setor:integer; txt:string); //Procedimento de verifiar quantos ingressos foram vendidos e realizar a sua conversão em dinheiro.
Var
	qtd:integer;
	Begin
		qtd:=max_pilha - tam_pilha_ingresso; //Verifica a quantidade de ingressos vendido com base na (quantidade que foi disponibilizada - quantidade que tem atualmente na pilha).
		total_setor:=total_setor + (qtd * valor); //Realiza a conversão para verificar quantos reais foram faturados em determinado tipo de torcedor. (total vendido * valor ingresso)
		Writeln('--------------------------------------------------------------------');
		Writeln('Foram vendidos ',qtd,' ingressos no setor ',txt);
		Writeln();
		Writeln('Gerando um faturamento de R$',total_setor);
		Writeln();
		Writeln('--------------------------------------------------------------------');		
	End;
	
Procedure faturamento_total(total_socio,total_torcedor,total_geral,total_visitante:integer); //Realiza a soma dos faturamentos dos setores distintos.
Var
	soma:integer;
	Begin
		soma:=total_socio + total_torcedor + total_geral + total_visitante; 
		Writeln('Renda Total = R$',soma);
	End;	
	
Begin
	TextColor(6); //Define a cor da fonte para Laranja(6).

	inicializar(opc);
	
	iniciar_pilha(max_socio, pilha_socio, tam_pilha_socio); //Inicializa as pilhas de ingressos disponibilizados pela Federação.
	iniciar_pilha(max_torcedor, pilha_torcedor, tam_pilha_torcedor);
	iniciar_pilha(max_torcedor_geral, pilha_torcedor_geral, tam_pilha_torcedor_geral);
	iniciar_pilha(max_visitante, pilha_visitante, tam_pilha_visitante);	
	
	iniciar_lista(lista_arquibancada,tam_lista_arquibancada,max_arquibancada); //Inicializa as listas de cadeiras disponíveis.
	iniciar_lista(lista_torcedor_geral,tam_lista_torcedor_geral,max_torcedor_geral);
	iniciar_lista(lista_visitante,tam_lista_visitante,max_visitante);
	
	While opc <> 7 do //Inicio MENU
		Begin
			Writeln('[1] - +1 Torcedor - Sócio Torcedor');
			Writeln('[2] - +1 Torcedor - Setor Arquibancada Coberta [Torcedor]');
			Writeln('[3] - +1 Torcedor - Setor Geral [Torcedor]');
			Writeln('[4] - +1 Torcedor - Visitantes'); 
			Writeln('[5] - Esvaziar Filas');
			Writeln('[6] - Faturamento');
			Writeln('[7] - Sair do Programa');
			Readln(opc);
			Case opc of
				1: inserir_fila(fila_socio,tam_fila_socio,max_socio,'Sócio Torcedor'); //Caso o número seja de [1-4], o programa irá inserir +1 torcedor a sua respectiva fila.
				2: inserir_fila(fila_torcedor,tam_fila_torcedor,max_torcedor,'Aquibancada Coberta [Torcedor]');
				3: inserir_fila(fila_torcedor_geral,tam_fila_torcedor_geral, max_torcedor_geral,'Arquibancada Geral [Torcedor]' );
				4: inserir_fila(fila_visitante,tam_fila_visitante,max_visitante,'Visitantes');
				5:Begin //Caso o número inserido seja o 5, o procedimento inicializa a venda de ingressos até que elas estejam vazias.
						venda(fila_socio,tam_fila_socio,'Sócio Torcedor',pilha_socio,tam_pilha_socio,lista_arquibancada,tam_lista_arquibancada); //Priorizando a fila de Sócio torcedores.
						If v_vazia(tam_pilha_socio) and (tam_fila_socio >= 0) then //Caso não haja mais lugares disponíveis, o sócio é encaminhado a fila de Torcedor Arquibancada. 
							tam_fila_torcedor:=tam_fila_torcedor +1;
							
						venda(fila_torcedor,tam_fila_torcedor,'Setor Arquibancada Coberta',pilha_torcedor,tam_pilha_torcedor,lista_arquibancada,tam_lista_arquibancada); //Venda de ingresso para o setor Arquibancada Coberta.
						venda(fila_torcedor_geral,tam_fila_torcedor_geral,'Setor Geral',pilha_torcedor_geral,tam_pilha_torcedor_geral,lista_torcedor_geral,tam_lista_torcedor_geral); //Venda de ingresso Arquibancada Geral.
						venda(fila_visitante,tam_fila_visitante,'Visitantes',pilha_visitante,tam_pilha_visitante,lista_visitante,tam_lista_visitante); //Venda de ingresso Visitantes.
					End;
				6: Begin
						CLRSCR;
							faturamento(tam_pilha_socio,max_socio,valor_socio,arrecadacao_socio,'Sócio Torcedor'); //Verifica o faturamento do setor de Sócio Torcedor.
							faturamento(tam_pilha_torcedor,max_torcedor,valor_torcedor,arrecadacao_torcedor,'Arquibancada Coberta [Torcedor]'); //Verifica o faturamento do setor Arquibancada Coberte.
							faturamento(tam_pilha_torcedor_geral,max_torcedor_geral,valor_torcedor_geral,arrecadacao_torcedor_geral,'Arquibancada Geral [Torcedor]'); //Verifica o faturamento do setor Arquibancada Geral.
							faturamento(tam_pilha_visitante,max_visitante,valor_visitante,arrecadacao_visitante,'Visitante'); //Verifica o faturamento da Arquibancada Geral,
							faturamento_total(arrecadacao_socio,arrecadacao_torcedor,arrecadacao_torcedor_geral,arrecadacao_visitante) //Realiza a somatoria dos faturamentos.
					End;
				7: Writeln('Encerrando o Programa'); //Mensagem exibida caso o usuário deseja encerrar o programa.
				Else
					Writeln('Opção Inválida'); //Mensagem exibida caso o número informado for diferente de [1-7].
			End;
		End;	
End.