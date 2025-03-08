Program Pzim ;
Const
	N = 100;
Type
	pilha = array[1..N] of string;	
var
	frase:string[100];
	p:pilha;
	tamanho:integer;

Procedure inicializar(var n:integer);
	Begin
		n:=1;
	End;

Procedure le_frase(var f:string[100]; var tam:integer);
	Begin
		Readln(f);
		tam:=length(f);
	End;

Function v_cheia(t:integer):boolean;
	Begin
		If t > 100 do
			v_cheia:=true
		Else
			v_cheia:=false; 
	End; }

Procedure inserir(f:string;var vet:vetor; var tam:integer);
Var
	i:integer;
	Begin
		cheia:=v_cheia(tam);
		If not cheia then
			While (f[i] <> ' ') and (i <= tam) do
				i:=i +1;
			 
	End;
	
{Procedure escrever(vet:vetor; tam:integer);
Var

	End;}
	
Begin
	le_frase(frase,tamanho);
	inserir(frase,v,tamanho);
	//escrever(v,tamanho);
End.