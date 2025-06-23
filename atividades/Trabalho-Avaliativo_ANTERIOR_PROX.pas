Program Pzim ;
Type
	tpdados = String;
	
	ptnodoAlunos = ^TlistaAlunos;	//Defini��o do ponteiro de alunos;
	TlistaAlunos = Record
		antAluno : ptnodoAlunos;
		nome : tpdados;
		proxAluno : ptnodoAlunos;
	End;
	
	ptnodoCurso = ^TlistaCursos;	//Defini��o do ponteiro de cursos;
	TlistaCursos = Record
		antCurso : ptnodoCurso;
		dadoCurso : tpdados;
		alunos : ptnodoAlunos;
		proxCurso : ptnodoCurso;
	End;

Procedure inicializa(VAR l : ptnodoCurso); //Procedimento que aponta a lista para NIL;
	Begin
		l:= NIL;
	End;

Procedure leCurso(VAR c : String);	//Procedimento que l� a SIGLA do curso. (S�o permitidos no m�ximo 3 caracteres);
	Begin
		CLRSCR;
		Writeln('Informe a SIGLA do curso :');
		Readln(c);
		c:=upCase(c);
		If length(c) <> 3 Then
			Writeln('N�o foi poss�vel inserir aluno. Motivo : Sigla Informada Inv�lida.');
	End;

Procedure leAluno(VAR A : String); //Procedimento que l� o nome do aluno;
	Begin
		Writeln('Informe o nome do Aluno : ');
		Readln(A);
		A:=upCase(A);
	End;

Procedure pesquisa_curso(VAR l_curso, anterior_c : ptnodoCurso; curso_i : String); //Procedimento que pesquisa se determinado curso, que est� por par�metro est� contido na lista de cursos;
	Begin
		While (l_curso <> NIL) AND (l_curso^.dadoCurso < curso_i) Do
			Begin
				anterior_c:=l_curso;
				l_curso:=l_curso^.proxCurso;	
			End; 		
	End;

Procedure pesquisa_aluno(VAR l_aluno, anterior_a : ptnodoAlunos; aluno_i : String); //Procedimento que pesquisa se determinado aluno, que est� por par�metro, est� contido na lista de alunos de determinado curso;
	Begin
		While (l_aluno <> NIL) AND (l_aluno^.nome < aluno_i) Do
			Begin
				anterior_a:=l_aluno;
				l_aluno:=l_aluno^.proxAluno;
			End;
	End;

Procedure inserir (VAR l, l_fim : ptnodoCurso; c : String); //Procedimento que insere e valida cursos e alunos;
Var
	aux_c, aux2_c, ant_c : ptnodoCurso;
	aux_a, aux2_a, ant_a : ptnodoAlunos;
	aluno : String;
	Begin
		CLRSCR;
		NEW(aux_c);	//Solicita a aloca��o de um novo espa�o em mem�ria para o registro de curso;
		If aux_c = NIL Then
			Writeln('N�o foi poss�vel cadastrar o aluno. Motivo : Mem�ria cheia')
		Else
			Begin
				aux_c^.dadoCurso:=c; //Armezana o nome doo curos que est� por par�metro;
				aux_c^.alunos:=NIL; //Aponta a lista de alunos inicialmente para NIL;
				aux_c^.proxCurso:=NIL; //Inicialmente aponta o ponteiro do pr�ximo curso para NIL;
			  aux_c^.antCurso:=NIL;
				
				aux2_c:=l; //Vari�veis de aux�lio;
				ant_c:=l;
				
				If aux2_c = NIL Then	//Lista est� vazia;
					Begin
						Writeln('Curso ',c,' cadastrado.');
						l:= aux_c;
						l_fim:= aux_c;
					End
					
				Else
					Begin
							pesquisa_curso(aux2_c, ant_c, c); //Encontra quais os ponteiros que o programa deve realocar;
							If (aux2_c^.dadoCurso = c) Then //Se em algum momento algum elemento da lista de nomes de cursos for igual a vari�vel 'c', ent�o curso j� est� cadastrado;
								Writeln('Curso ',c,' j� cadastrado.')
							Else
								If (aux2_c = ant_c) AND (aux2_c^.dadoCurso > c) Then	//Se o nome do curso que desejo cadastrar for < a primeira posi��o da lista de nomes de curso, ent�o o mesmo passa a ser o primeiro. (EX: ADM* -> BSN);
									Begin
										aux_c^.proxCurso:=aux2_c;
										l:=aux_c;
										aux2_c^.antCurso:=aux_c;
										Writeln('Curso ',c,' cadastrado.');
									End
								Else
									If (aux2_c = NIL) AND (c > ant_c^.dadoCurso) Then //Se nenhum a minha lista de nome encontrar um nome que for > c, e minha vari�vel c for > o �ltimo nome da lista, o curso � inserido no final da lista. (EX: ADM - BSN - FIS*);
										Begin
											ant_c^.proxCurso:=aux_c;
											aux_c^.antCurso:=ant_c;
											l_fim:=aux_c;
											Writeln('Curso ',c,' cadastrado.');
										End
									Else
										If (aux2_c <> NIL) AND (aux2_c^.dadoCurso > c) Then //Se em algum momento um curso contido na lista de cursos for > que a vari�vel c, ent�o o curso � inserido entre os dois cursos. (EX: ADM -> BSN* -> FIS)
											Begin
												aux_c^.proxCurso:=aux2_c;
												ant_c^.proxCurso:=aux_c;
												aux_c^.antCurso:=ant_c;
												aux2_c^.antCurso:=aux_c;
												Writeln('Curso ',c,' cadastrado.');
											End
						End;   	
			End;
			
			
		NEW(aux_a); //Solicita a aloca��o de um novo espa�o em mem�ria para o registro de aluno;
		If aux_a = NIL Then
			Writeln('N�o foi poss�vel cadastrar aluno. Motivo : Mem�ria Cheia')
		Else
			Begin
				leAluno(aluno); //Procedimento para ler o nome do aluno;
				aux_a^.nome:=aluno; //Armazena o nome do aluno no ponteiro ^.nome
				aux_a^.proxAluno:=NIL; //Aponta para o pr�ximo curso como NIL;
				aux_a^.antAluno:=NIL;
				
				If (aux2_c = NIL) or (aux2_c^.dadoCurso <> c) then 
        	aux2_c := aux_c;
				
				aux2_a:=aux2_c^.alunos; //Vari�veis de aux�lio
				ant_a:=aux2_c^.alunos;
				
				If aux2_c^.alunos = NIL Then //Caso a lista de alunos de determinado curso esteja vazia, a fila de alunos passa a apontar para o aluno inserido; 	
					Begin
						Writeln('Aluno ',aluno,' cadastrado.');
						aux2_c^.alunos:=aux_a
					End
				Else
					Begin
						pesquisa_aluno(aux2_a, ant_a, aluno); //Procedimento que realiza a pesquisa na lista de alunos de um determinado curso;
						
						If (aux2_a^.nome = aluno) AND (aux2_a <> NIL) then  //Caso algum nome contido na lista de alunos de determinado curso for = a vari�vel aluno, ent�o o aluno j� est� contido. (EX: Mateus -> Mateus);
							Begin
								Writeln('N�o foi poss�vel cadastrar o aluno. Motivo : Aluno j� consta na lista de alunos do Curso ',aux2_c^.dadoCurso,'.');
							End
						Else
							If (aux2_a = ant_a) AND (aux2_a^.nome > aluno) Then //Caso o primeiro nome da lista de alunos for maior que o aluno que ser� cadastrado, ent�o o aluno � cadastrado na primeira posi��o. (EX: Andr�* -> Bernardo);
								Begin
									aux_a^.proxAluno:=aux2_a;
									aux2_c^.alunos:=aux_a;
									aux2_a^.antAluno:=aux_a;
									Writeln('Aluno ',aluno,' cadastrado.');
								End
							Else
								If (aux2_a = NIL) AND (ant_a^.nome < aluno) Then //Caso nenhum nome na lista de aluno de determinado curso seja > que o aluno que ser� inserido, ent�o o aluno � cadastrado na �ltima posi��o da lista. (EX: Andr� - Bernardo -> Mateus*);
									Begin
										ant_a^.proxAluno:=aux_a;
										aux_a^.antAluno:=ant_a;
										Writeln('Aluno ',aluno,' cadastrado.');
									End
								Else                        
									If (aux2_a <> NIL) AND (aux2_a^.nome > aluno) Then //Caso em algum momento o nome contido na lista for > que o nome do aluno que ser� inserido, ent�o o aluno � inserido entre os nomes. (EX: Andr� -> Bernardo* -> Mateus);
										Begin
											aux_a^.proxAluno:=aux2_a;
											ant_a^.proxAluno:=aux_a;
											aux_a^.antAluno:=ant_a;
											aux2_a^.antAluno:=aux_a;
											Writeln('Aluno ',aluno,' cadastrado.');
										End
					End;
			End		
	End;
	
Procedure remover (VAR l : ptnodoCurso);
VAR
	aux_c, ant_c : ptnodoCurso;
	aux_a, ant_a : ptnodoAlunos;
	c, aluno : String;
	Begin
		aux_c:=l; //Vari�veis de aux�lio;
		ant_c:=l;
		If aux_c = NIL Then
			Writeln('N�o foi poss�vel remover o aluno. Motivo : Lista vazia.')
		Else
			Begin
				leCurso(c); //Solicita o nome do curso que ser� removido;
				If length(c) = 3 Then
					Begin
						pesquisa_curso(aux_c, ant_c, c); //Pesquisa o nome do curso na lista de cursos cadastrados;
						If aux_c^.dadoCurso = c Then //Caso o procedimento encontre algum nome na lista de cursos que seja igual a vari�vel c;
							Begin
								aux_a:=aux_c^.alunos; //Vari�veis de aux�lio; 
								ant_a:=aux_c^.alunos;
								
								If aux_c^.alunos = NIL Then //Caso a lista de alunos de determinado curso esteja vazia, � apresentado a mensagem;
									Writeln('N�o foi poss�vel remover o aluno. Motivo : Lista de alunos vazia.')
								Else
									Begin
										leAluno(aluno); //L� o nome do aluno que deseja remover;
								
										While (aux_a^.proxAluno <> NIL) AND (aux_a^.nome <> aluno) Do  //Percore a lista de alunos do curso informado pelo usu�rio at� chegar ao final ou encontrar um nome igual ao solicitado;
											Begin
												ant_a:=aux_a;
												aux_a:=aux_a^.proxAluno;
											End;
								
										If (aux_a^.nome <> aluno) Then //Caso nenhum nome na lista seja igual ao solicitado pelo usu�rio;
											Writeln('N�o foi poss�vel remover o aluno. Motivo : Aluno n�o cadastrado.')
										Else
											Begin
												If (ant_a	= aux_a) AND (aux_a^.nome = aluno) Then //Caso o primeiro nome da lista seja igual ao solicitado pelo usu�rio para remover;
													Begin
														Writeln('Aluno ',aux_a^.nome,' removido.');
														If aux_a^.proxAluno = NIL Then
															aux_c^.alunos:=NIL
														Else
															aux_c^.alunos:=aux_a^.proxAluno;
														DISPOSE(aux_a);
													End
												Else
													If (aux_a^.proxAluno = NIL) AND (aux_a^.nome = aluno) Then //Caso o �ltimo nome da lista de alunos seja igual ao solicitado pelo usu�rio;
														Begin
															ant_a^.proxAluno:=NIL;
															Writeln('Aluno ',aux_a^.nome,' removido.');
															DISPOSE(aux_a);
														End
													Else
														If (aux_a^.proxAluno <> NIL) AND (aux_a^.nome = aluno) Then //Caso o nome do aluno solicitado pelo usu�rio esteja no meio da lista;
															Begin
																ant_a^.proxAluno:=aux_a^.proxAluno;
																	Writeln('Aluno ',aux_a^.nome,' removido.');
																DISPOSE(aux_a);
															End
											End
									End
							End
						Else
							Writeln('N�o foi poss�vel remover o aluno. Motivo : Curso n�o encontrado.'); //Caso a sigla do curso informado pelo o usu�rio n�o seja encontrado;
					End
				Else
					Writeln('N�o foi poss�vel remover o aluno. Motivo : Sigla Informada Inv�lida.'); //Caso a sigla do curso seja <> de 3 caracteres;
			End;	
	End;

Procedure escreve_cursos_i(l : ptnodoCurso);
Var
	aux_c : ptnodoCurso;
	i : Integer;
	Begin
		CLRSCR;
		i:=0;
		aux_c:=l; //Vari�vel de aux�lio;
		If aux_c = NIL Then //Caso a lista de cursos esteja apontando para NIL, ou seja, est� vazia;
			Writeln('N�o foi poss�vel escrever a Lista de Cursos. Motivo: Lista vazia')
		Else
			Begin
				While aux_c <> NIL Do //Enquanto n�o chegar ao final da lista;
					Begin
						i:=i +1;
						Write('',i,'-', aux_c^.dadoCurso,' ');
						aux_c:= aux_c^.proxCurso;
					End;
				Writeln();
				Writeln('H� ',i,' cursos cadastrados no momento.');
			End;
	End;

Procedure escreve_cursos_f(l : ptnodoCurso);
Var
	aux_c : ptnodoCurso;
	i : Integer;
	Begin
		CLRSCR;
		i:=0;
		aux_c:=l; //Vari�vel de aux�lio;
		If aux_c = NIL Then //Caso a lista de cursos esteja apontando para NIL, ou seja, est� vazia;
			Writeln('N�o foi poss�vel escrever a Lista de Cursos. Motivo: Lista vazia')
		Else
			Begin
				While aux_c <> NIL Do //Enquanto n�o chegar ao final da lista;
					Begin
						i:=i +1;
						Write('',i,'-', aux_c^.dadoCurso,' ');
						aux_c:= aux_c^.antCurso;
					End;
				Writeln();
				Writeln('H� ',i,' cursos cadastrados no momento.');
			End;
	End;

Procedure escreve_alunos_i(l : ptnodoCurso);
Var
	c : String;
	aux_c, ant : ptnodoCurso;
	aux_a : ptnodoAlunos;
	i : Integer;
	Begin
		CLRSCR;
		aux_c:=l; //Vari�vel de aux�lio;
		If aux_c = NIL Then //Caso a lista esteja = NIL, ou seja, est� vazia;
			Writeln('N�o foi poss�vel escrever os alunos. Motivo: Lista Vazia.')
		Else
			Begin
				leCurso(c); //Solicita o nome do curso;
				If length(c) = 3 Then
					Begin
						pesquisa_curso(aux_c, ant, c); //Realiza a busca do curso informado em compara��o a lista de cursos j� cadastrados;
						
						If aux_c^.dadoCurso = c Then //Caso o curso esteja cadastrado;
							Begin
								aux_a:=aux_c^.alunos; //Vari�vel de aux�lio;
								If aux_a = NIL Then
									Writeln('N�o foi poss�vel escrever os alunos. Motivo: Lista de alunos vazia.') //Caso a lista de alunos do curso solicitado esteja = NIL, ou seja, vazia;
								Else
									Begin	
										While aux_a <> NIL Do
											Begin
												i:=i +1;
												Write('',i,'-',aux_a^.nome,' ');
												aux_a:=aux_a^.proxAluno;	
											End;
										WRITELN();
										Writeln('H� ',i,' alunos cadastrados no curso ',aux_c^.dadoCurso);
									End;	
							End
						Else
							Writeln('N�o foi poss�vel escrever os alunos. Motivo: Curso n�o Cadastrado') //Caso a sigla do curso informado ainda n�o esteja cadastrada;
					End
				Else
					Writeln('N�o foi poss�vek escrever os alunos. Motivo: Sigla informada Inv�lida.'); //Caso a sigla do curso informado for <> de 3 caracteres;
			End
	End;

Procedure escreve_alunos_f(l : ptnodoCurso);
Var
	c : String;
	aux_c, ant : ptnodoCurso;
	aux_a : ptnodoAlunos;
	i : Integer;
	Begin
		CLRSCR;
		aux_c:=l; //Vari�vel de aux�lio;
		If aux_c = NIL Then //Caso a lista esteja = NIL, ou seja, est� vazia;
			Writeln('N�o foi poss�vel escrever os alunos. Motivo: Lista Vazia.')
		Else
			Begin
				leCurso(c); //Solicita o nome do curso;
				If length(c) = 3 Then
					Begin
						pesquisa_curso(aux_c, ant, c); //Realiza a busca do curso informado em compara��o a lista de cursos j� cadastrados;
						
						If aux_c^.dadoCurso = c Then //Caso o curso esteja cadastrado;
							Begin
								aux_a:=aux_c^.alunos; //Vari�vel de aux�lio;
								If aux_a = NIL Then
									Writeln('N�o foi poss�vel escrever os alunos. Motivo: Lista de alunos vazia.') //Caso a lista de alunos do curso solicitado esteja = NIL, ou seja, vazia;
								Else
									Begin
										While aux_a^.proxAluno <> NIL Do
											aux_a:=aux_a^.proxAluno;	
										While aux_a <> NIL Do
											Begin
												i:=i +1;
												Write('',i,'-',aux_a^.nome,' ');
												aux_a:=aux_a^.antAluno;	
											End;
										WRITELN();
										Writeln('H� ',i,' alunos cadastrados no curso ',aux_c^.dadoCurso);
									End;	
							End
						Else
							Writeln('N�o foi poss�vel escrever os alunos. Motivo: Curso n�o Cadastrado') //Caso a sigla do curso informado ainda n�o esteja cadastrada;
					End
				Else
					Writeln('N�o foi poss�vek escrever os alunos. Motivo: Sigla informada Inv�lida.'); //Caso a sigla do curso informado for <> de 3 caracteres;
			End
	End;

VAR
	lista, lista_fim : ptnodoCurso;
	opc : Integer;
	curso : String;
	
Begin	
	inicializa(lista);
	While opc <> 7 do //MENU (in�cio);
		Begin
			Writeln('===============================');
			Writeln('   SISTEMA DE GEST�O DE CURSOS  ');
			Writeln('===============================');
			Writeln();
			Writeln('[1] - Cadastro de Alunos');
			Writeln('[2] - Remover Alunos');
			Writeln('[3] - Escrever Cursos');
			Writeln('[4] - Escrever Cursos (FIM -> IN�CIO)');
			Writeln('[5] - Escrever Alunos');
			Writeln('[6] - Escrever Alunos (FIM -> IN�CIO)');
			Writeln('[7] - Encerrar Programa');
			Readln(opc);
			Case opc of
				1:
					Begin
						leCurso(curso); //L� a SIGLA do curso;
						If length(curso) = 3 Then //Aceita somente 3 caracteres;
				 			inserir(lista,lista_fim, curso);
				 	End;
				2: remover(lista);
				
				3: escreve_cursos_i(lista);
				
				4: escreve_cursos_f(lista_fim);
				
				5: escreve_alunos_i(lista);
				
				6: escreve_alunos_f(lista);
				
				7: Writeln('Encerrando o programa...');
				Else
					Writeln('Op��o Errada!');
			End;
		End;	//MENU (fim);
End.