Program Pzim ;
Const
	max_torcedor_geral = 700;
	max_torcedor = 1500;
	max_socio = 500;
	max_visitante = 300;
Type
	pilha = array[1..3000] of integer;
	fila = array[1..3000] of integer;
Var
	tam_socio, tam_torcedor, tam_torcedor_geral, tam_visitante:integer;
	
	opc,tam_fila_socio,tam_fila_torcedor, tam_fila_torcedor_geral, tam_fila_visitante:integer;
	
	pilha_socio, pilha_torcedor, pilha_torcedor_geral, pilha_visitante:pilha;
	
	fila_socio, fila_torcedor, fila_torcedor_geral, fila_visitante:fila;
	
Procedure inicializar(var n:integer);
	Begin
		n:=0;
	End;
		
Procedure iniciar_pilha(max_pilha:integer; pilha_atual:pilha; var tam_pilha:integer);
Var
	i:integer;
	Begin
		For i:=1 to max_pilha do
			pilha_atual[i]:=i;
		tam_pilha:=max_pilha;	
	End;

Function v_cheia(tam,tam_max:integer):boolean;
	Begin
		If tam > tam_max then
			v_cheia:=true
		Else
			v_cheia:=false;	 
	End;
	
Function v_vazia(tam:integer):boolean;
	Begin
		If tam = 0 then
			v_vazia:=true
	  Else
	  	v_vazia:=false;
	End;

Procedure inserir_fila(var fila_atual:fila;var tam_atual:integer; maximo_fila:integer; texto:string);
Var
	cheia:boolean;
	Begin
		CLRSCR;
		cheia:=v_cheia(tam_atual,maximo_fila);
		If not cheia then
			Begin
				tam_atual:=tam_atual +1;
				fila_atual[tam_atual]:=random(10000);
				Writeln('+1 Torcedor na fila de ',texto);
			End;
	End;

Procedure remover_fila(var fila_remove:fila; var tam_fila_remove:integer); 
Var
	i:integer;
	Begin
		For i:=1 to (tam_fila_remove-1) do
			fila_remove[i]:=fila_remove[i+1];
		tam_fila_remove:=tam_fila_remove -1;
	End;

Procedure remover_pilha(var pilha_remover:pilha;var tam_pilha_remove:integer);
Var
	vazia:boolean;
	Begin
		vazia:=v_vazia(tam_pilha_remove);
		If not vazia then
			tam_pilha_remove:=tam_pilha_remove -1
		Else
			Writeln('Não há ingressos disponíveis');
	End;

Procedure venda(var fila_venda:fila;var tam_fila_atual:integer; texto:string;var pilha_atual:pilha;var tam_pilha_atual:integer);
Var
	vazia:boolean;
	Begin
		vazia:=v_vazia(tam_fila_atual);
		While not vazia do
			Begin
				CLRSCR;
				vazia:=v_vazia(tam_fila_atual);
				If not vazia then
					Begin
						remover_pilha(pilha_atual,tam_pilha_atual);
						//Writeln('Realizado venda no setor ',texto);
						remover_fila(fila_venda,tam_fila_atual);
					End
				Else
					Writeln('A fila do setor de ',texto,' está vazia!');
			End;
		WRITELN();			
	End;
	
Begin
	inicializar(opc);
	
	iniciar_pilha(max_socio, pilha_socio, tam_socio);
	iniciar_pilha(max_torcedor, pilha_torcedor, tam_torcedor);
	iniciar_pilha(max_torcedor_geral, pilha_torcedor_geral, tam_torcedor_geral);
	iniciar_pilha(max_visitante, pilha_visitante, tam_visitante);	
	
	While opc <> 6 do
		Begin
			Writeln('[1] - +1 Torcedor - Sócio Torcedor');
			Writeln('[2] - +1 Torcedor - Setor Arquibancada Coberta');
			Writeln('[3] - +1 Torcedor - Setor Geral');
			Writeln('[4] - +1 Torcedor - Visitantes'); 
			Writeln('[5] - Vender Ingressos');
			Writeln('[6] - Encerrar Vendas');
			Readln(opc);
			If opc = 1 then
				inserir_fila(fila_socio,tam_fila_socio,max_socio,'Sócio Torcedor')
			Else
				If opc = 2 then
					inserir_fila(fila_torcedor,tam_fila_torcedor,max_torcedor,'Aquibancada Coberta')
				Else
					If opc = 3 then
						inserir_fila(fila_torcedor_geral,tam_fila_torcedor_geral, max_torcedor_geral,'Arquibancada Geral' )
					Else
						If opc = 4 then
							inserir_fila(fila_visitante,tam_fila_visitante,max_visitante,'Visitantes')
						Else
							If opc = 5 then
								Begin
									venda(fila_socio,tam_fila_socio,'Sócio Torcedor',pilha_socio,tam_socio);
									venda(fila_torcedor,tam_fila_torcedor,'Setor Arquibancada Coberta',pilha_torcedor,tam_torcedor);
									venda(fila_torcedor_geral,tam_fila_torcedor_geral,'Setor Geral',pilha_torcedor_geral,tam_torcedor_geral);
									venda(fila_visitante,tam_fila_visitante,'Visitantes',pilha_visitante,tam_visitante);
								End
		End;	
End.