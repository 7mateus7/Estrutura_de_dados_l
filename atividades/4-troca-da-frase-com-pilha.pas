Program Pzim ;
Const
	N = 100;
Type
	pilha = array[1..100] of string;
Var
	frase,resultado:string[N];

Procedure inicializar(var num:integer);
	Begin
		num:=0;
	End;

Function v_cheia(t,ma);

Function le_frase():string;
Var
	f:string;	
	Begin
		CLRSCR;
		Writeln('Informe a sua frase:');
		Readln(f);
		le_frase:=f;
	End;

Procedure p_empilhar(letra:string;var vetor:pilha;var top:integer;maximo:integer);
	Begin
		cheia:=v_cheia(top,maximo);
		top:=top +1;
		vetor[top]:=letra;	
	End;

Procedure desempilhar(vetor:pilha; var top:integer; var result:string);
	Begin
		While top > 0 do
			Begin
				result:= result + vetor[top];
				top:=top -1;
			End;
			result:= result + ' ';
	End;
	
Procedure empilhar(f:string; num:integer; var res:string[100]);
Var
	vet:pilha;
	topo,i:integer;
	Begin
		res:='';
		inicializar(topo);
		For i:=1 to length(f) do
			Begin
				If f[i] <> ' ' then
					p_empilhar(f[i],vet,topo,num)
				Else
						desempilhar(vet,topo,res);
			End;
		desempilhar(vet,topo,res);
	End;

Procedure escrever(resul:string);
	Begin
		CLRSCR;
		Writeln(resul);
	End;	
Begin
	frase:=Le_frase();
	empilhar(frase,N,resultado);
	escrever(resultado	);
End.