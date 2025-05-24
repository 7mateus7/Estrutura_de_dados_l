Program Pzim ;
Type
	tpdados = String;
	
	ptnodoAlunos = ^TlistaAlunos;
	TlistaAlunos = Record
		nome : tpdados;
		proxAluno : ptnodoAlunos;
	End;
	
	ptnodoCurso = ^TlistaCursos;
	TlistaCursos = Record
		dadoCurso : tpdados;
		alunos : ptnodoAlunos;
		proxCurso : ptnodoCurso;
	End;

Procedure inicializa(VAR l : ptnodoCurso);
	Begin
		l:= NIL;
	End;

Procedure leCurso(VAR c : String);
	Begin
		CLRSCR;
		Writeln('Informe a SIGLA do seu curso:');
		Readln(c);
		c:=upCase(c);
		If length(c) <> 3 Then
			Writeln('Não foi possível inserir aluno. Motivo : Curso não encontrado.');
	End;

Procedure leAluno(VAR A : String);
	Begin
		Writeln('Informe o nome do Aluno: ');
		Readln(A);
		A:=upCase(A);
	End;

Procedure pesquisa_curso(VAR l_curso, anterior_c : ptnodoCurso; curso_i : String);
	Begin
		While (l_curso <> NIL) AND (l_curso^.dadoCurso < curso_i) Do
			Begin
				anterior_c:=l_curso;
				l_curso:=l_curso^.proxCurso;	
			End; 		
	End;

Procedure pesquisa_aluno(VAR l_aluno, anterior_a : ptnodoAlunos; aluno_i : String);
	Begin
		While (l_aluno <> NIL) AND (l_aluno^.nome < aluno_i) Do
			Begin
				anterior_a:=l_aluno;
				l_aluno:=l_aluno^.proxAluno;
			End;
	End;

Procedure inserir (VAR l : ptnodoCurso; c : String);
Var
	aux_c, aux2_c, ant_c : ptnodoCurso;
	aux_a, aux2_a, ant_a : ptnodoAlunos;
	aluno : String;
	Begin
		CLRSCR;
		NEW(aux_c);
		If aux_c = NIL Then
			Writeln('Não foi possível cadastrar o aluno. Motivo: Memória cheia')
		Else
			Begin
				aux_c^.dadoCurso:=c;
				aux_c^.alunos:=NIL;
				aux_c^.proxCurso:=NIL;
				
				aux2_c:=l;
				ant_c:=l;
				
				If aux2_c = NIL Then
					Begin
						Writeln('Curso ',c,' cadastrado.');
						l:= aux_c
					End
					
				Else
					Begin
							pesquisa_curso(aux2_c, ant_c, c);
							If (aux2_c^.dadoCurso = c) Then
								Writeln('Curso já cadastrado!')
							Else
								If (aux2_c = ant_c) AND (aux2_c^.dadoCurso > c) Then
									Begin
										aux_c^.proxCurso:=aux2_c;
										l:=aux_c;
										aux2_c:=aux2_c^.proxCurso;
										Writeln('Curso ',c,' cadastrado.');
									End
								Else
									If (aux2_c = NIL) AND (c > ant_c^.dadoCurso) Then
										Begin
											ant_c^.proxCurso:=aux_c;
											Writeln('Curso ',c,' cadastrado.');
										End
									Else
										If (aux2_c <> NIL) AND (aux2_c^.dadoCurso > c) Then
											Begin
												aux_c^.proxCurso:=aux2_c;
												ant_c^.proxCurso:=aux_c;
												Writeln('Curso ',c,' cadastrado.');
											End
						End;   	
			End;
			
			
		NEW(aux_a);
		If aux_a = NIL Then
			Writeln('Não foi possível cadastrar aluno. Motivo: Memória Cheia')
		Else
			Begin
				leAluno(aluno);
				aux_a^.nome:=aluno;
				aux_a^.proxAluno:=NIL;
				
				
				If (aux2_c = NIL) or (aux2_c^.dadoCurso <> c) then
        	aux2_c := aux_c;
				
				aux2_a:=aux2_c^.alunos;
				ant_a:=aux2_c^.alunos;
				
				If aux2_c^.alunos = NIL Then 	
					Begin
						Writeln('Aluno ',aluno,', cadastrado');
						aux2_c^.alunos:=aux_a
					End
				Else
					Begin
						pesquisa_aluno(aux2_a, ant_a, aluno);
						
						If (aux2_a^.nome = aluno) AND (aux2_a <> NIL) then
							Begin
								Writeln('Não foi possível cadastrar o aluno. Motivo: Aluno já consta na lista.');
							End
						Else
							If (aux2_a = ant_a) AND (aux2_a^.nome > aluno) Then
								Begin
									aux_a^.proxAluno:=aux2_a;
									aux2_c^.alunos:=aux_a;
									Writeln('Aluno ',aluno,', cadastrado');
								End
							Else
								If (aux2_a = NIL) AND (ant_a^.nome < aluno) Then
									Begin
										ant_a^.proxAluno:=aux_a;
										Writeln('Aluno ',aluno,' cadastrado!');
									End
								Else
									If (aux2_a <> NIL) AND (aux2_a^.nome > aluno) Then
										Begin
											aux_a^.proxAluno:=aux2_a;
											ant_a^.proxAluno:=aux_a;
											Writeln('Aluno ',aluno,' cadastrado!');
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
		aux_c:=l;
		ant_c:=l;
		If aux_c = NIL Then
			Writeln('Não foi possível remover aluno. Motivo: Lista vazia.')
		Else
			Begin
				leCurso(c);
				If length(c) = 3 Then
					Begin
						pesquisa_curso(aux_c, ant_c, c);
						If aux_c^.dadoCurso = c Then
							Begin
								aux_a:=aux_c^.alunos;
								ant_a:=aux_c^.alunos;
								
								If aux_c^.alunos = NIL Then
									Writeln('Não foi possível escrever os alunos. Motivo: Lista de alunos vazia.')
								Else
									Begin
										leAluno(aluno);
								
										While (aux_a^.proxAluno <> NIL) AND (aux_a^.nome <> aluno) Do
											Begin
												ant_a:=aux_a;
												aux_a:=aux_a^.proxAluno;
											End;
								
										If (aux_a^.nome <> aluno) Then
											Writeln('Não foi possível remover o aluno. Motivo: Aluno não cadastrado.')
										Else
											Begin
												If (ant_a	= aux_a) AND (aux_a^.nome = aluno) Then
													Begin
														Writeln('Aluno ',aux_a^.nome,' removido.');
														If aux_a^.proxAluno = NIL Then
															aux_c^.alunos:=NIL
														Else
															aux_c^.alunos:=aux_a^.proxAluno;
														DISPOSE(aux_a);
													End
												Else
													If (aux_a^.proxAluno = NIL) AND (aux_a^.nome = aluno) Then
														Begin
															ant_a^.proxAluno:=NIL;
															Writeln('Aluno ',aux_a^.nome,' removido.');
															DISPOSE(aux_a);
														End
													Else
														If (aux_a^.proxAluno <> NIL) AND (aux_a^.nome = aluno) Then
															Begin
																ant_a^.proxAluno:=aux_a^.proxAluno;
																	Writeln('Aluno ',aux_a^.nome,' removido.');
																DISPOSE(aux_a);
															End
											End
									End
							End
						Else
							Writeln('Não foi possível remover o aluno. Motivo: Curso não encontrado.');
					End
				Else
					Writeln('Não foi possível remover o aluno. Motivo: Curso não cadastrado.');
			End;	
	End;

Procedure escreve_cursos(l : ptnodoCurso);
Var
	aux_c : ptnodoCurso;
	Begin
		CLRSCR;
		aux_c:=l;
		If aux_c = NIL Then
			Writeln('Não foi possível escrer os cursos. Motivo: Lista vazia')
		Else
			Begin
				While aux_c <> NIL Do
					Begin
						Write(' ',aux_c^.dadoCurso);
						aux_c:= aux_c^.proxCurso;
					End
			End;
		WRITELN();
	End;

Procedure escreve_alunos(l : ptnodoCurso);
Var
	c : String;
	aux_c, ant : ptnodoCurso;
	aux_a : ptnodoAlunos;
	Begin
		CLRSCR;
		aux_c:=l;
		If aux_c = NIL Then
			Writeln('Não foi possível escrever os alunos. Motivo: Lista Vazia.')
		Else
			Begin
				leCurso(c);
				If length(c) = 3 Then
					Begin
						pesquisa_curso(aux_c, ant, c);
						
						If aux_c^.dadoCurso = c Then
							Begin
								aux_a:=aux_c^.alunos;
								If aux_a = NIL Then
									Writeln('Não foi possível escrever os alunos. Motivo: Lista de alunos vazia.')
								Else
									Begin	
										While aux_a <> NIL Do
											Begin
												Write(' ',aux_a^.nome);
												aux_a:=aux_a^.proxAluno;	
											End
									End;	
							End
						Else
							Writeln('Não foi possívek escrever os alunos. Motivo: Curso não Cadastrado')
					End
				Else
					Writeln('Não foi possívek escrever os alunos. Motivo: Curso não Cadastrado');
			End
	End;

VAR
	lista : ptnodoCurso;
	opc : Integer;
	curso : String;
	
Begin	
	inicializa(lista);
	While opc <> 5 do
		Begin
			Writeln();
			Writeln('[1] - Cadastro de Alunos');
			Writeln('[2] - Remover Alunos');
			Writeln('[3] - Escrever Cursos');
			Writeln('[4] - Escrever Alunos');
			Writeln('[5] - Encerrar Programa');
			Readln(opc);
			Case opc of
				1:
					Begin
						leCurso(curso);
						If length(curso) = 3 Then
				 			inserir(lista, curso);
				 	End;
				2: remover(lista);
				3: escreve_cursos(lista);
				
				4: escreve_alunos(lista);
				
				5: Writeln('Encerrando o programa...');
				Else
					Writeln('Opção Errada!');
			End;
		End;
End.