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

Procedure inicializa(Var l: ptnodoCurso); //Inicializa a lista adicionando o valor NIL a mesma;
	Begin
		l:= NIL;
	End;

Procedure leCurso(VAR c: String); //Procedimento que lê a sigla do curso do aluno;
	Begin
		CLRSCR;
		Writeln('Informe a sigla do Curso');
		Readln(c);
		If length(c) = 3 then
			c:= UpCase(c)
		Else
			Writeln('Curso não encontrado.');
	End;

Procedure leAluno(VAR A : String);	//Lê o nome do aluno e deixa o mesmo com todas as letras MAIUSCULAS
	Begin
		Writeln('Informe o nome do aluno: ');
		Readln(A);
		A:= UpCase(A);
	End;

Procedure pesquisa_curso(VAR auxiliar_c, anterior_c :ptnodoCurso; curso:String);
	Begin
		While (auxiliar_c <> NIL) AND (auxiliar_c^.dadoCurso < curso) DO
			Begin
				anterior_c:= auxiliar_c;
				auxiliar_c:= auxiliar_c^.proxCurso;
			End;
	End;
	
Procedure pesquisa_aluno(VAR auxiliar_a, anterior_a :ptnodoAlunos; A:String);
	Begin
		While (auxiliar_a <> NIL) AND (auxiliar_a^.nome <> A) DO
			Begin
				anterior_a:= auxiliar_a;
				auxiliar_a:= auxiliar_a^.proxAluno;
			End;
	End;

Procedure inserir(VAR l : ptnodoCurso; c : String);	//Procedimento de Inserir na Lista. CURSO/ALUNOS
Var
	aux_c, aux2_c, ant_c: ptnodoCurso;  //Variáveis auxiliares para curso;
	aux_a, aux2_a, ant_a : ptnodoAlunos; //variáveis auxiliares para auluno;
	aluno : String;  //Nome do aluno;
	Begin
			If l = NIL Then //Se caso a lista estiver vazia;
				Begin
					NEW(aux_c);
					If aux_c = NIL then
						Writeln('Não foi possível cadastrar curso. Motivo: Memória cheia')
					Else
						Begin
							aux_c^.dadoCurso:=c;
							aux_c^.proxCurso:=NIL;
							l:=aux_c;
							Writeln('Curso ',c,' cadastrado.');
						End;
							NEW(aux_a);
							If aux_a = NIL then
								Writeln('Não foi possível cadastrar aluno. Motivo: Memória cheia')
							Else
								Begin
									leAluno(aluno);
									aux_a^.nome:=aluno;
									aux_a^.proxAluno := NIL;
									aux_c^.alunos := aux_a;
								End;
				End
					Else //Caso a lista já contenha curso
					Begin
						aux2_c:=l;
						ant_c:=l;
						pesquisa_curso(aux2_c, ant_c, c);
						
						If (aux2_c^.dadoCurso = c) THEN
							Begin
								NEW(aux_a);
								If aux_a = NIL then
									Writeln('Não foi possível cadastrar aluno. Motivo: Memória cheia')
								Else
									Begin
										leAluno(aluno);
										aux2_a:= aux2_c^.alunos;
										
										pesquisa_aluno(aux2_a, ant_a, aluno);
											              	
										If (aux2_a <> NIL) THEN
											Writeln('Não foi possível cadastrar aluno. Motivo: Aluno já cadastrado')
											
										Else
											Begin
												aux_a^.nome:=aluno;
												aux_a^.proxAluno:=NIL;
												If aux2_c^.alunos = NIL THEN
													aux2_c^.alunos:=aux_a
												Else
													ant_a^.proxAluno:=aux_a;
											End
									End
							End
					
						Else 	//Caso ainda não contenha o curso;
							Begin
								If (aux2_c^.proxCurso = NIL) THEN
									Begin
										new(aux_c);
										If aux_c = NIL then
											Writeln('Não foi possível cadastrar curso. Motivo: Memória cheia')
										Else
											Begin
												aux_c^.dadoCurso:=c;
												aux_c^.proxCurso:=NIL;
												ant_c^.proxCurso:=aux_c;
											  Writeln('Curso ',c,' cadastrado.');
												NEW(aux_a);
												If aux_a = NIL then
													Writeln('Não foi possível cadastrar aluno. Motivo: Memória cheia')
												Else
													Begin
														leAluno(aluno);
														aux2_a:= aux_c^.alunos;
														aux_a^.nome:=aluno;
														aux_a^.proxAluno:=NIL;
														aux_c^.alunos:=aux_a;
													End;
											End;
									End;
							End; 
					End;	
	End;

Procedure remover(VAR l : ptnodoCurso; c : String);
	Begin
	
	End;
	
Procedure escreve_cursos(l : ptnodoCurso);
Var
	aux_c : ptnodoCurso;
	Begin
		CLRSCR;
		aux_c:=l;
		If aux_c = NIL Then
			Writeln('Não foi possível escrever os cursos. Motivo: Lista de Cursos vazia.')
		Else
			Begin
				While aux_c <> NIL DO
					Begin
						Write(' ',aux_c^.dadoCurso);
						aux_c:=aux_c^.proxCurso;
					End;
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
			Writeln('Não foi possível escrever os alunos. Motivo: Lista de Alunos vazia.')
		Else
			Begin
				leCurso(c);
				If length(c) = 3 Then
					Begin
						pesquisa_curso(aux_c, ant, c);
						If aux_c^.dadoCurso = c Then
							Begin
								aux_a:=aux_c^.alunos;
								While aux_a <> NIL DO
									Begin
										Write(' ',aux_a^.nome);
										aux_a:=aux_a^.proxAluno;
									End;
							End
						Else
							Writeln('Não foi possível escrever os alunos. Motivo: Curso inválido,');	
					End
				Else
					Writeln('Não foi possível escrever os alunos. Motivo: Curso inválido,');
			End;
		WRITELN();
	End;

VAR
	lista, aux : ptnodoCurso;
	curso : String;
	opc : Integer;
		
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
				2:
					Begin
						leCurso(curso);
				 		If length(curso) = 3 Then
				 			remover(lista, curso);
				 	End;
				3: escreve_cursos(lista);
				
				4: escreve_alunos(lista);
				
				5: Writeln('Encerrando o programa...');
				Else
					Writeln('Opção Errada!');
			End;
		End;
End.