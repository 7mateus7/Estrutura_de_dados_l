program FilaComPonteiros;

type
  PNo = ^TNo;
  TNo = record
    valor: Integer;
    prox: PNo;
  end;

  TFila = record
    frente, tras: PNo;
  end;

procedure InicializarFila(var fila: TFila);
begin
  fila.frente := nil;
  fila.tras := nil;
end;

procedure Enfileirar(var fila: TFila; valor: Integer);
var
  novo: PNo;
begin
  New(novo);
  novo^.valor := valor;
  novo^.prox := nil;

  if fila.frente = nil then
  begin
    fila.frente := novo;
    fila.tras := novo;
  end
  else
  begin
    fila.tras^.prox := novo;
    fila.tras := novo;
  end;
end;

procedure Desenfileirar(var fila: TFila; var valor: Integer);
var
  temp: PNo;
begin
  if fila.frente <> nil then
  begin
    valor := fila.frente^.valor;
    temp := fila.frente;
    fila.frente := fila.frente^.prox;

    if fila.frente = nil then
      fila.tras := nil;

    Dispose(temp);
  end
  else
    WriteLn('Fila vazia!');
end;

var
  fila: TFila;
  valor: Integer;
begin
  InicializarFila(fila);

  Enfileirar(fila, 10);
  Enfileirar(fila, 20);
  Enfileirar(fila, 30);

  Desenfileirar(fila, valor);
  WriteLn('Desenfileirado: ', valor); // Deve imprimir 10

  Desenfileirar(fila, valor);
  WriteLn('Desenfileirado: ', valor); // Deve imprimir 20

  Desenfileirar(fila, valor);
  WriteLn('Desenfileirado: ', valor); // Deve imprimir 30

  Desenfileirar(fila, valor); // Deve imprimir "Fila vazia!"
end.
