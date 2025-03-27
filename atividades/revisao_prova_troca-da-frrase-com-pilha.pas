Program Pzim ;
Type
	pilha = array[1..100] of string;
Var
	frase,frase_final:string[100];
	p:pilha;
	tamanho:integer;

Function cheia(t:integer):boolean;
	Begin
		If t > 100 then
			cheia:=true
		Else
			cheia:=false
	End;

Procedure le_frase(var f:string[100]);
	Begin
		Writeln('Informe a sua frase:');
		Readln(f);
	End;

Procedure p_empilha(letra:string;var vetor:pilha; var t:integer);
	Begin
		t:=t +1;
		vetor[t]:=letra;		
	End;

Procedure desempilha(var vetor:pilha; var t:integer; var res:string);
	Begin
		While t >= 1 do
			Begin
				res:=res + vetor[t];
				t:=t -1;
			End;
		res:= res + ' '
	End;
	
Procedure empilha(f:string; var vet:pilha; var tam:integer; var resultado:string);
Var	
	i:integer;
	Begin
		If not cheia(tam) then
			Begin
				For i:=1 to length(f) do
					If f[i] <> ' ' then
						p_empilha(f[i],vet,tam)
					Else
						desempilha(vet,tam,resultado);
			End
		Else
			Writeln('Sua pilha está cheia!');
		desempilha(vet,tam,resultado);
	End;

Procedure escreve(f:string);
	Begin
		Writeln('Sua frase com as letras invertidas:');
		Writeln(frase_final);
	End;
	
Begin
	le_frase(frase);
	empilha(frase,p,tamanho,frase_final);
	escreve(frase_final);
End.