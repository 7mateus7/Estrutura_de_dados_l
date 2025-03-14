Program Pzim ;
Const
	N = 100;
Type
	fila = array[1..N]of integer;
	pi = array[1..N] of integer;
Var
	opc,topo_p,topo_i,topo_pilha:integer;
	fila_p,fila_i:fila;
	pilha:pi;
	
Procedure inicializar(var n:integer);
	Begin
		n:=1;
	End;
	
Procedure le_numero(var n:integer);
	Begin
		//Writeln('Informe o seu número:');
		Readln(n);
	End;
	
Function v_cheia(t,limite:integer):boolean;
	Begin
		If t > limite then
			v_cheia:=true
		Else
			v_cheia:=false;
	End;
	
Function v_vazia(t:integer):boolean;
	Begin
		If t = 0 then
			v_vazia:=true
		Else
			v_vazia:=false; 
	End;

Procedure inserir(n,maximo:integer; var fi:fila; var tam:integer);
Var
	cheia:boolean;
	Begin
		cheia:=v_cheia(tam,maximo);
		If not cheia then
			Begin
				tam:=tam +1;
				fi[tam]:=n;
			End
		Else
			Writeln('Sua fila está cheia');
	End;

Procedure validar(num,max:integer;var f_p,f_i:fila;var t_p,t_i:integer);
	Begin
		CLRSCR;
		If num = 0 then
			Writeln('Saindo...')
		Else
			If num mod 2 = 0 then
				inserir(num,max,f_p,t_p)
			Else
				inserir(num,max,f_i,t_i)
	End;

Procedure escrever_f(f:fila; top:integer);
Var
	i:integer;
	Begin
		For i:=1 to top do
			Write(f[i]:3);
		Writeln();
	End;

Procedure remove(var r_fila:fila; var tamanho_fila,tamanho_pilha:integer; var i_pilha:pi);
Var
	vazia:boolean;
	i:integer;
	Begin
		vazia:=v_vazia(tamanho_fila);
		If not vazia then
			Begin
				If r_fila[1] > 0 then
					Begin
						tamanho_pilha:= tamanho_pilha +1;
						i_pilha[tamanho_pilha]:=r_fila[1]
					End
				Else
					Begin
						vazia:=v_vazia(tamanho_pilha);
						If not vazia then
							tamanho_pilha:=tamanho_pilha -1
					End;
				For i:=1 to (tamanho_fila -1) do
					r_fila[i]:=r_fila[i+1];
				tamanho_fila:= tamanho_fila -1;
			End
	End;

Procedure empilhar(var f_i,f_p:fila; var t_p,t_i,t_pilha:integer; var pil:pi);
Var
	vazia_p,vazia_i:boolean;
	Begin
		vazia_p:=v_vazia(t_p);
		vazia_i:=v_vazia(t_i);
		While (not vazia_i) or (not vazia_p) do
			Begin
				remove(f_i,t_i,t_pilha,pil);
				remove(f_p,t_p,t_pilha,pil);
				vazia_p:=v_vazia(t_p);
				vazia_i:=v_vazia(t_i);	 
			End;  
	End;

Procedure escrever_p(pil:pi; tam:integer);
Var
	i:integer;
	Begin
		For i:=1 to tam do
			Write(pil[i]:3);
		Writeln();
	End;

Begin
	inicializar(opc);
	Writeln('Informe um número');
	While opc <> 0 do
		Begin
			le_numero(opc);
			validar(opc,N,fila_p,fila_i,topo_p,topo_i);
			Writeln('Informe um número:');
		End;
			Writeln('Fila dos números pares:');
			escrever_f(fila_p,topo_p);
			Writeln('Filado dos números ímpares:');
			escrever_f(fila_i,topo_i);
			empilhar(fila_i,fila_p,topo_p,topo_i,topo_pilha,pilha);
			Writeln('Sua pilha:');
			escrever_p(pilha,topo_pilha);
End.