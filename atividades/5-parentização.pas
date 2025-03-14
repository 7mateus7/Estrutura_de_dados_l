Program Pzim ;
Type
	pilha = array[1..100] of string;
Const
	N = 100;
Var
	parenteses:string[N];
	retorno:boolean;
	
Procedure le_parenteses(var p:string[100]);
	Begin
		Writeln('Informe a sua parentização');
		Readln(p);	
	End;

Function v_cheia(valor_topo,m:integer):boolean;
	Begin
		If valor_topo > m then
			v_cheia:=true
		Else
			v_cheia:=false;
	End;

Function v_vazia(valor_topo:integer):boolean;
	Begin
		If valor_topo = 0 then
			v_vazia:=true
		Else
			v_vazia:=false;
	End;

Procedure empilhar(par:string;var pi:pilha;max:integer;var top:integer);
Var	
	cheia:boolean;
	Begin
		cheia:=v_cheia(top,max);
		if not cheia then
			Begin
				top:=top +1;
				pi[top]:=par;
			End;
	End;

Procedure desempilhar(var top:integer;var v_retorno:boolean);
Var
	vazia:boolean;
	Begin
		vazia:=v_vazia(top);
		If not vazia then
			top:=top -1
		Else
			v_retorno:=false
	End;
	
Procedure verificar(pa:string; tam:integer;var reto:boolean);
Var
	p:pilha;
	topo,i:integer;
	cheia:boolean;
	Begin
		reto:=true;
		i:=1;
		topo:=0;
		cheia:=v_cheia(topo,tam);
		If not cheia then
			for i:=1 to length(pa) do
				Begin
					If pa[i] = '(' then
						empilhar(pa[i],p,tam,topo)
					Else
						If pa[i] = ')' then
							desempilhar(topo,reto)
				End
		Else
			Writeln('Sua pilha está cheia!');
		If topo <> 0 then
		reto:=false;
	End;
	
Begin
	le_parenteses(parenteses);
	verificar(parenteses,N,retorno);
	If retorno then
		Writeln('Sua parentização está correta :)')
	Else
		Writeln('Sua parentização está incorreta :('); 
End.