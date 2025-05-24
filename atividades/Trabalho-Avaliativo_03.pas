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
						While (aux2_c^.proxCurso <> NIL) AND (aux2_c^.dadoCurso <> c) DO
							Begin
								ant_c:=aux2_c;
								aux2_c:=aux2_c^.proxCurso;
							End;
						If aux2_c^.dadoCurso = c THEN
							Begin
								NEW(aux_a);
								If aux_a = NIL then
									Writeln('Não foi possível cadastrar aluno. Motivo: Memória cheia')
								Else
									Begin
										leAluno(aluno);
										aux2_a:= aux2_c^.alunos;
										
										While (aux2_a <> NIL) AND (aux2_a^.nome <> aluno) DO
											Begin
												ant_a:=aux2_a;
												aux2_a:=aux2_a^.proxAluno;
											End;
											              	
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
				{2:
					Begin
						le_numero(num);
				 		remove(lista,num);
				 		Writeln('Removido o número ',num);
				 	End;
				3: 
					Begin
						le_numero(num);
						consulta(lista, num, retorno);
						informa(num, retorno);
					End; 
				4: escrever(lista);
				5: Writeln('Encerrando o programa...');
				Else
					Writeln('Opção Errada!');}
			End;
		End;
End.