Program Pzim ;
Type
	tpdados = String;
	
	ptnodoAlunos = ^TlistaAlunos;	//Definição do ponteiro de alunos;
	TlistaAlunos = Record
		antAluno : ptnodoAlunos;
		nome : tpdados;
		proxAluno : ptnodoAlunos;
	End;
	
	ptnodoCurso = ^TlistaCursos;	//Definição do ponteiro de cursos;
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

Procedure leCurso(VAR c : String);	//Procedimento que lê a SIGLA do curso. (São permitidos no máximo 3 caracteres);
	Begin
		CLRSCR;
		Writeln('Informe a SIGLA do curso :');
		Readln(c);
		c:=upCase(c);
		If length(c) <> 3 Then
			Writeln('Não foi possível inserir aluno. Motivo : Sigla Informada Inválida.');
	End;

Procedure leAluno(VAR A : String); //Procedimento que lê o nome do aluno;
	Begin
		Writeln('Informe o nome do Aluno : ');
		Readln(A);
		A:=upCase(A);
	End;

Procedure pesquisa_curso(VAR l_curso, anterior_c : ptnodoCurso; curso_i : String); //Procedimento que pesquisa se determinado curso, que está por parâmetro está contido na lista de cursos;
	Begin
		While (l_curso <> NIL) AND (l_curso^.dadoCurso < curso_i) Do
			Begin
				anterior_c:=l_curso;
				l_curso:=l_curso^.proxCurso;	
			End; 		
	End;

Procedure pesquisa_aluno(VAR l_aluno, anterior_a : ptnodoAlunos; aluno_i : String); //Procedimento que pesquisa se determinado aluno, que está por parâmetro, está contido na lista de alunos de determinado curso;
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
		NEW(aux_c);	//Solicita a alocação de um novo espaço em memória para o registro de curso;
		If aux_c = NIL Then
			Writeln('Não foi possível cadastrar o aluno. Motivo : Memória cheia')
		Else
			Begin
				aux_c^.dadoCurso:=c; //Armezana o nome doo curos que está por parâmetro;
				aux_c^.alunos:=NIL; //Aponta a lista de alunos inicialmente para NIL;
				aux_c^.proxCurso:=NIL; //Inicialmente aponta o ponteiro do próximo curso para NIL;
			  aux_c^.antCurso:=NIL;
				
				aux2_c:=l; //Variáveis de auxílio;
				ant_c:=l;
				
				If aux2_c = NIL Then	//Lista está vazia;
					Begin
						Writeln('Curso ',c,' cadastrado.');
						l:= aux_c;
						l_fim:= aux_c;
					End
					
				Else
					Begin
							pesquisa_curso(aux2_c, ant_c, c); //Encontra quais os ponteiros que o programa deve realocar;
							If (aux2_c^.dadoCurso = c) Then //Se em algum momento algum elemento da lista de nomes de cursos for igual a variável 'c', então curso já está cadastrado;
								Writeln('Curso ',c,' já cadastrado.')
							Else
								If (aux2_c = ant_c) AND (aux2_c^.dadoCurso > c) Then	//Se o nome do curso que desejo cadastrar for < a primeira posição da lista de nomes de curso, então o mesmo passa a ser o primeiro. (EX: ADM* -> BSN);
									Begin
										aux_c^.proxCurso:=aux2_c;
										l:=aux_c;
										aux2_c^.antCurso:=aux_c;
										Writeln('Curso ',c,' cadastrado.');
									End
								Else
									If (aux2_c = NIL) AND (c > ant_c^.dadoCurso) Then //Se nenhum a minha lista de nome encontrar um nome que for > c, e minha variável c for > o último nome da lista, o curso é inserido no final da lista. (EX: ADM - BSN - FIS*);
										Begin
											ant_c^.proxCurso:=aux_c;
											aux_c^.antCurso:=ant_c;
											l_fim:=aux_c;
											Writeln('Curso ',c,' cadastrado.');
										End
									Else
										If (aux2_c <> NIL) AND (aux2_c^.dadoCurso > c) Then //Se em algum momento um curso contido na lista de cursos for > que a variável c, então o curso é inserido entre os dois cursos. (EX: ADM -> BSN* -> FIS)
											Begin
												aux_c^.proxCurso:=aux2_c;
												ant_c^.proxCurso:=aux_c;
												aux_c^.antCurso:=ant_c;
												aux2_c^.antCurso:=aux_c;
												Writeln('Curso ',c,' cadastrado.');
											End
						End;   	
			End;
			
			
		NEW(aux_a); //Solicita a alocação de um novo espaço em memória para o registro de aluno;
		If aux_a = NIL Then
			Writeln('Não foi possível cadastrar aluno. Motivo : Memória Cheia')
		Else
			Begin
				leAluno(aluno); //Procedimento para ler o nome do aluno;
				aux_a^.nome:=aluno; //Armazena o nome do aluno no ponteiro ^.nome
				aux_a^.proxAluno:=NIL; //Aponta para o próximo curso como NIL;
				aux_a^.antAluno:=NIL;
				
				If (aux2_c = NIL) or (aux2_c^.dadoCurso <> c) then 
        	aux2_c := aux_c;
				
				aux2_a:=aux2_c^.alunos; //Variáveis de auxílio
				ant_a:=aux2_c^.alunos;
				
				If aux2_c^.alunos = NIL Then //Caso a lista de alunos de determinado curso esteja vazia, a fila de alunos passa a apontar para o aluno inserido; 	
					Begin
						Writeln('Aluno ',aluno,' cadastrado.');
						aux2_c^.alunos:=aux_a
					End
				Else
					Begin
						pesquisa_aluno(aux2_a, ant_a, aluno); //Procedimento que realiza a pesquisa na lista de alunos de um determinado curso;
						
						If (aux2_a^.nome = aluno) AND (aux2_a <> NIL) then  //Caso algum nome contido na lista de alunos de determinado curso for = a variável aluno, então o aluno já está contido. (EX: Mateus -> Mateus);
							Begin
								Writeln('Não foi possível cadastrar o aluno. Motivo : Aluno já consta na lista de alunos do Curso ',aux2_c^.dadoCurso,'.');
							End
						Else
							If (aux2_a = ant_a) AND (aux2_a^.nome > aluno) Then //Caso o primeiro nome da lista de alunos for maior que o aluno que será cadastrado, então o aluno é cadastrado na primeira posição. (EX: André* -> Bernardo);
								Begin
									aux_a^.proxAluno:=aux2_a;
									aux2_c^.alunos:=aux_a;
									aux2_a^.antAluno:=aux_a;
									Writeln('Aluno ',aluno,' cadastrado.');
								End
							Else
								If (aux2_a = NIL) AND (ant_a^.nome < aluno) Then //Caso nenhum nome na lista de aluno de determinado curso seja > que o aluno que será inserido, então o aluno é cadastrado na última posição da lista. (EX: André - Bernardo -> Mateus*);
									Begin
										ant_a^.proxAluno:=aux_a;
										aux_a^.antAluno:=ant_a;
										Writeln('Aluno ',aluno,' cadastrado.');
									End
								Else                        
									If (aux2_a <> NIL) AND (aux2_a^.nome > aluno) Then //Caso em algum momento o nome contido na lista for > que o nome do aluno que será inserido, então o aluno é inserido entre os nomes. (EX: André -> Bernardo* -> Mateus);
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
		aux_c:=l; //Variáveis de auxílio;
		ant_c:=l;
		If aux_c = NIL Then
			Writeln('Não foi possível remover o aluno. Motivo : Lista vazia.')
		Else
			Begin
				leCurso(c); //Solicita o nome do curso que será removido;
				If length(c) = 3 Then
					Begin
						pesquisa_curso(aux_c, ant_c, c); //Pesquisa o nome do curso na lista de cursos cadastrados;
						If aux_c^.dadoCurso = c Then //Caso o procedimento encontre algum nome na lista de cursos que seja igual a variável c;
							Begin
								aux_a:=aux_c^.alunos; //Variáveis de auxílio; 
								ant_a:=aux_c^.alunos;
								
								If aux_c^.alunos = NIL Then //Caso a lista de alunos de determinado curso esteja vazia, é apresentado a mensagem;
									Writeln('Não foi possível remover o aluno. Motivo : Lista de alunos vazia.')
								Else
									Begin
										leAluno(aluno); //Lê o nome do aluno que deseja remover;
								
										While (aux_a^.proxAluno <> NIL) AND (aux_a^.nome <> aluno) Do  //Percore a lista de alunos do curso informado pelo usuário até chegar ao final ou encontrar um nome igual ao solicitado;
											Begin
												ant_a:=aux_a;
												aux_a:=aux_a^.proxAluno;
											End;
								
										If (aux_a^.nome <> aluno) Then //Caso nenhum nome na lista seja igual ao solicitado pelo usuário;
											Writeln('Não foi possível remover o aluno. Motivo : Aluno não cadastrado.')
										Else
											Begin
												If (ant_a	= aux_a) AND (aux_a^.nome = aluno) Then //Caso o primeiro nome da lista seja igual ao solicitado pelo usuário para remover;
													Begin
														Writeln('Aluno ',aux_a^.nome,' removido.');
														If aux_a^.proxAluno = NIL Then
															aux_c^.alunos:=NIL
														Else
															aux_c^.alunos:=aux_a^.proxAluno;
														DISPOSE(aux_a);
													End
												Else
													If (aux_a^.proxAluno = NIL) AND (aux_a^.nome = aluno) Then //Caso o último nome da lista de alunos seja igual ao solicitado pelo usuário;
														Begin
															ant_a^.proxAluno:=NIL;
															Writeln('Aluno ',aux_a^.nome,' removido.');
															DISPOSE(aux_a);
														End
													Else
														If (aux_a^.proxAluno <> NIL) AND (aux_a^.nome = aluno) Then //Caso o nome do aluno solicitado pelo usuário esteja no meio da lista;
															Begin
																ant_a^.proxAluno:=aux_a^.proxAluno;
																	Writeln('Aluno ',aux_a^.nome,' removido.');
																DISPOSE(aux_a);
															End
											End
									End
							End
						Else
							Writeln('Não foi possível remover o aluno. Motivo : Curso não encontrado.'); //Caso a sigla do curso informado pelo o usuário não seja encontrado;
					End
				Else
					Writeln('Não foi possível remover o aluno. Motivo : Sigla Informada Inválida.'); //Caso a sigla do curso seja <> de 3 caracteres;
			End;	
	End;

Procedure escreve_cursos_i(l : ptnodoCurso);
Var
	aux_c : ptnodoCurso;
	i : Integer;
	Begin
		CLRSCR;
		i:=0;
		aux_c:=l; //Variável de auxílio;
		If aux_c = NIL Then //Caso a lista de cursos esteja apontando para NIL, ou seja, está vazia;
			Writeln('Não foi possível escrever a Lista de Cursos. Motivo: Lista vazia')
		Else
			Begin
				While aux_c <> NIL Do //Enquanto não chegar ao final da lista;
					Begin
						i:=i +1;
						Write('',i,'-', aux_c^.dadoCurso,' ');
						aux_c:= aux_c^.proxCurso;
					End;
				Writeln();
				Writeln('Há ',i,' cursos cadastrados no momento.');
			End;
	End;

Procedure escreve_cursos_f(l : ptnodoCurso);
Var
	aux_c : ptnodoCurso;
	i : Integer;
	Begin
		CLRSCR;
		i:=0;
		aux_c:=l; //Variável de auxílio;
		If aux_c = NIL Then //Caso a lista de cursos esteja apontando para NIL, ou seja, está vazia;
			Writeln('Não foi possível escrever a Lista de Cursos. Motivo: Lista vazia')
		Else
			Begin
				While aux_c <> NIL Do //Enquanto não chegar ao final da lista;
					Begin
						i:=i +1;
						Write('',i,'-', aux_c^.dadoCurso,' ');
						aux_c:= aux_c^.antCurso;
					End;
				Writeln();
				Writeln('Há ',i,' cursos cadastrados no momento.');
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
		aux_c:=l; //Variável de auxílio;
		If aux_c = NIL Then //Caso a lista esteja = NIL, ou seja, está vazia;
			Writeln('Não foi possível escrever os alunos. Motivo: Lista Vazia.')
		Else
			Begin
				leCurso(c); //Solicita o nome do curso;
				If length(c) = 3 Then
					Begin
						pesquisa_curso(aux_c, ant, c); //Realiza a busca do curso informado em comparação a lista de cursos já cadastrados;
						
						If aux_c^.dadoCurso = c Then //Caso o curso esteja cadastrado;
							Begin
								aux_a:=aux_c^.alunos; //Variável de auxílio;
								If aux_a = NIL Then
									Writeln('Não foi possível escrever os alunos. Motivo: Lista de alunos vazia.') //Caso a lista de alunos do curso solicitado esteja = NIL, ou seja, vazia;
								Else
									Begin	
										While aux_a <> NIL Do
											Begin
												i:=i +1;
												Write('',i,'-',aux_a^.nome,' ');
												aux_a:=aux_a^.proxAluno;	
											End;
										WRITELN();
										Writeln('Há ',i,' alunos cadastrados no curso ',aux_c^.dadoCurso);
									End;	
							End
						Else
							Writeln('Não foi possível escrever os alunos. Motivo: Curso não Cadastrado') //Caso a sigla do curso informado ainda não esteja cadastrada;
					End
				Else
					Writeln('Não foi possívek escrever os alunos. Motivo: Sigla informada Inválida.'); //Caso a sigla do curso informado for <> de 3 caracteres;
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
		aux_c:=l; //Variável de auxílio;
		If aux_c = NIL Then //Caso a lista esteja = NIL, ou seja, está vazia;
			Writeln('Não foi possível escrever os alunos. Motivo: Lista Vazia.')
		Else
			Begin
				leCurso(c); //Solicita o nome do curso;
				If length(c) = 3 Then
					Begin
						pesquisa_curso(aux_c, ant, c); //Realiza a busca do curso informado em comparação a lista de cursos já cadastrados;
						
						If aux_c^.dadoCurso = c Then //Caso o curso esteja cadastrado;
							Begin
								aux_a:=aux_c^.alunos; //Variável de auxílio;
								If aux_a = NIL Then
									Writeln('Não foi possível escrever os alunos. Motivo: Lista de alunos vazia.') //Caso a lista de alunos do curso solicitado esteja = NIL, ou seja, vazia;
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
										Writeln('Há ',i,' alunos cadastrados no curso ',aux_c^.dadoCurso);
									End;	
							End
						Else
							Writeln('Não foi possível escrever os alunos. Motivo: Curso não Cadastrado') //Caso a sigla do curso informado ainda não esteja cadastrada;
					End
				Else
					Writeln('Não foi possívek escrever os alunos. Motivo: Sigla informada Inválida.'); //Caso a sigla do curso informado for <> de 3 caracteres;
			End
	End;

VAR
	lista, lista_fim : ptnodoCurso;
	opc : Integer;
	curso : String;
	
Begin	
	inicializa(lista);
	While opc <> 7 do //MENU (início);
		Begin
			Writeln('===============================');
			Writeln('   SISTEMA DE GESTÃO DE CURSOS  ');
			Writeln('===============================');
			Writeln();
			Writeln('[1] - Cadastro de Alunos');
			Writeln('[2] - Remover Alunos');
			Writeln('[3] - Escrever Cursos');
			Writeln('[4] - Escrever Cursos (FIM -> INÍCIO)');
			Writeln('[5] - Escrever Alunos');
			Writeln('[6] - Escrever Alunos (FIM -> INÍCIO)');
			Writeln('[7] - Encerrar Programa');
			Readln(opc);
			Case opc of
				1:
					Begin
						leCurso(curso); //Lê a SIGLA do curso;
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
					Writeln('Opção Errada!');
			End;
		End;	//MENU (fim);
End.