program archivos;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  Console,
  Librerias;

Type
   Registro_de_alumnos = Record
                           Matricula      : string[9];
                           Nombre         : string[50];
                           Edad           : byte;
                           Estatura       : real;
                           Sexo           : char;
                         end;
var
  Archivo,
  Archivo_2        : text;
  Archivo_bin,
  Archivo_bin_2    : File of Registro_de_alumnos;

  Nombre_archivo   : string[50];

  Registro         : Registro_de_alumnos;

  Matricula        : string[9];
  Nombre           : string[50];
  Edad             : byte;
  Estatura         : real;
  Sexo             : char;
  i,
  Num_Reg          : byte;

  procedure inicializa_variables;
  begin
    Matricula  := '';
    Nombre     := '';
    Edad       := 0;
    Estatura   := 0;
    Sexo       :=' ';
  end;

  function elima_espacios_derechos_de_cadena(cadena:string):string;
   begin
     repeat
       if cadena[length(cadena)]=' ' then delete(cadena,length(cadena),1);
     until cadena[length(cadena)]<>' ' ;
     elima_espacios_derechos_de_cadena := cadena;
   end;

  procedure edita_datos(Color_fondo, Color_letra:byte);
  var
    Y : byte;

    procedure transfiere_variable_a_cadena;
    begin
      case Y of
        1: cadena := Matricula;
        2: cadena := Nombre;
        3: if Edad<>0 then Str(Edad,cadena) else cadena :='';
        4: if Estatura<>0 then Str(Estatura:1:2,Cadena) else cadena:='';
        5: if Sexo<>' ' then Cadena := Sexo else cadena:='';
      end;
    end;

    procedure transfiere_cadena_a_variable;
    begin
      case Y of
        1: Matricula := Cadena;
        2: Nombre    := Cadena;
        3: if cadena<>'' then Val(cadena, Edad, Codigo_de_error);
        4: if cadena<>'' then Val(cadena, Estatura, Codigo_de_error);
        5: if cadena<>'' then Sexo:=Cadena[1];
      end;
    end;

    procedure despliega_valores;
    begin
      Str(Num_Reg,cadena);
      Cadena := 'Registro ['+cadena+']';
      Escribe_texto(30,8,1,15,cadena);

      Escribe_texto(30,10,1,14,Matricula);
      Escribe_texto(30,11,1,14,Nombre   );
      if Edad<>0 then Str(Edad,cadena) else cadena:='';
      Escribe_texto(30,12,1,14,Cadena);
      if Estatura<>0 then Str(Estatura:1:2,cadena) else cadena :='';
      Escribe_texto(30,13,1,14,Cadena);
      if Sexo in ['F','M'] then cadena:= Sexo else cadena := '';
      Escribe_texto(30,14,1,14,Cadena);
    end;

    procedure Despliega_texto_datos;
    begin
      Escribe_texto(20,10,1,15,'Matricula:');
      Escribe_texto(20,11,1,15,'Nombre   :');
      Escribe_texto(20,12,1,15,'Edad     :');
      Escribe_texto(20,13,1,15,'Estatura :');
      Escribe_texto(20,14,1,15,'Sexo     :');
    end;

    procedure dato_anterior;
    begin
      if Y>1 then
      begin
        Transfiere_cadena_a_variable;
        dec(Y);
        Transfiere_variable_a_cadena;
      end
      else sonido(300,200);
    end;

    procedure dato_siguiente;
    begin
      if Y<5 then
      begin
        Transfiere_cadena_a_variable;
        inc(Y);
        Transfiere_variable_a_cadena;
      end
      else sonido(300,200);
    end;
  begin
      Despliega_texto_datos;
      despliega_valores;
      Y := 1;
      Transfiere_variable_a_cadena;
      repeat
        Escribe_texto(30,9+Y,Color_Fondo,Color_letra,cadena);
        Tecla := ReadKey;
        Case tecla of
          #0      : begin
                      Tecla := ReadKey;
                      case tecla of
                        #72 : Dato_anterior;
                        #80 : Dato_Siguiente;

                        #60 : begin
                                Transfiere_cadena_a_variable;
                                Tecla := #1;
                              end;
                        #73 : Tecla := #2;
                        #81 : Tecla := #3;
                      end;
                    end;
          '0'..'9': if Y in [1,3,4] then cadena:= cadena+Tecla else sonido(300,200);
          'A'..'Z',
          'a'..'z',
          '¤','¥',
          ' '     : case Y of
                      2 : cadena:=cadena+tecla;
                      5 : if Upcase(tecla) in ['F','M'] then
                            if cadena='' then cadena:=Upcase(Tecla) else sonido(300,200)
                          else sonido(300,200);
                      else sonido(300,200);
                    end;
          '.'     : case Y of
                       2 : cadena := cadena+tecla;
                       4 : begin
                            if not existe_punto then cadena:=cadena+tecla else sonido(300,200);
                           end;
                       else sonido(300,200);
                    end;
          '-'     : case Y of
                      1 : if length(cadena)=7 then cadena:= cadena + tecla else sonido(300,200);
                      else sonido(300,200);
                    end;
          #8      : begin
                      Delete(Cadena,Length(cadena),1);
                      Escribe_texto(30,9+Y,Color_Fondo,Color_letra,cadena+' ');
                    end;
          #13     : Dato_siguiente;
          #27     : transfiere_cadena_a_variable;

          else sonido(300,200);
        end;
      until Tecla in [#27,#1..#3];

  end;

  procedure crea_archivo_de_texto;
  begin
    Plantilla(1,15,15);
    Escribe_texto(15,12,1,15,'Nombre del archivo a crear:');
    readln(Nombre_Archivo);

    assign(archivo, Nombre_Archivo);

    rewrite(archivo);

    Tecla :=#12;

    while Tecla<>#27 do
    begin
      inc(Num_Reg);
      Plantilla(1,15,15);
      Escribe_texto(10,23,1,15,'Esc');
      Escribe_texto(14,23,1,14,'Terminar');
      Escribe_texto(25,23,1,15,'F2');
      Escribe_texto(28,23,1,14,'Guardar y avanzar');
      inicializa_variables;
      edita_datos(1,14);

     if tecla=#1 then
     writeln(archivo, Matricula,' ':10-length(matricula), Nombre,' ':50-(length(Nombre)),
                      Edad:4, Estatura:6:2, Sexo:3);

    end;

    Close(archivo);

  end;

  procedure Lee_archivo_de_texto;
  begin
    Plantilla(1,15,15);
    Escribe_texto(15,12,1,15,'Nombre del archivo a leer:');
    readln(Nombre_Archivo);

    assign(archivo, Nombre_Archivo);

    reset(archivo);

    ClrScr;
    while not eof(archivo) do
    begin

      readln(archivo, matricula, tecla, Nombre, Edad, estatura,
                      tecla, tecla,Sexo);
      Nombre :=  elima_espacios_derechos_de_cadena(nombre);
      writeln(Matricula,' ':2,Nombre,' ':50-length(nombre),
              Edad:4, estatura:6:2,Sexo:4);
    end;
    Close(archivo);

    pausa(30,25,0,20);

  end;

  procedure edita_archivo_de_texto;
  begin
    Plantilla(1,15,15);
    Escribe_texto(15,12,1,15,'Nombre del archivo a editar:');
    readln(Nombre_Archivo);

    assign(archivo, Nombre_Archivo);

    reset(archivo);

    assign(archivo_2,'Tempo.txt');
    rewrite(archivo_2);

    Num_Reg := 0;
    while not eof (archivo) do
    begin
      Plantilla(1,15,15);
      Escribe_texto(10,23,1,15,'Esc');
      Escribe_texto(14,23,1,14,'Salir');
      Escribe_texto(25,23,1,15,'F2/AvPag/RePag');
      Escribe_texto(41,23,1,14,'Guardar y avanzar');

      readln(archivo, matricula, tecla, Nombre, Edad, estatura,
                      tecla, tecla,Sexo);

      Nombre :=  elima_espacios_derechos_de_cadena(nombre);

      Edita_datos(1,14);

      if tecla in [#2,#3] then Tecla := #1;

      case tecla of
        #1 : writeln(archivo_2, Matricula,' ':10-length(matricula), Nombre,' ':50-(length(Nombre)),
                              Edad:4, Estatura:6:2, Sexo:3);

        #27: begin
               writeln(archivo_2, Matricula,' ':10-length(matricula), Nombre,' ':50-(length(Nombre)),
                                Edad:4, Estatura:6:2, Sexo:3);

               while not eof(archivo) do
               begin
                 readln(archivo, matricula, tecla, Nombre, Edad, estatura,
                                 tecla, tecla,Sexo);
                 writeln(archivo_2, Matricula,' ':10-length(matricula), Nombre,' ':50-(length(Nombre)),
                                  Edad:4, Estatura:6:2, Sexo:3);
               end;
               Close(archivo);
               Close(archivo_2);
               erase(archivo);
               Rename(archivo_2,Nombre_Archivo);
               exit;
             end;
      end;

    end;

    Close(archivo);
    Close(archivo_2);
    erase(archivo);
    Rename(archivo_2,Nombre_Archivo);

    Escribe_texto(25,23,1,20,'            Fin de archivo       ');
    gotoXY(12,23);
    Tecla:=Readkey;
  end;


  procedure crea_archivo_binario;
  begin
    Tecla := #12;
    Plantilla(1,15,15);
    Escribe_texto(15,12,1,15,'Nombre del archivo a crear:');
    readln(Nombre_Archivo);

    assign(archivo_bin, Nombre_Archivo);

    rewrite(archivo_bin);

    while Tecla<>#27 do
    begin
      Plantilla(1,15,15);
      Escribe_texto(10,23,1,15,'Esc');
      Escribe_texto(14,23,1,14,'Terminar');
      Escribe_texto(25,23,1,15,'F2');
      Escribe_texto(28,23,1,14,'Guardar y avanzar');
      inicializa_variables;

      Edita_datos(1,14);

      Registro.Matricula := Matricula;
      Registro.Nombre    := Nombre;
      Registro.Edad      := Edad;
      Registro.Estatura  := Estatura;
      Registro.Sexo      := Sexo;

     if tecla=#1 then write(archivo_bin, Registro);
    end;

    Close(archivo_bin);

  end;

  procedure Lee_archivo_binario;
  begin
    Plantilla(1,15,15);
    Escribe_texto(15,12,1,15,'Nombre del archivo a leer:');
    readln(Nombre_Archivo);

    assign(archivo_bin, Nombre_Archivo);

    reset(archivo_bin);

    ClrScr;

    while not eof(archivo_bin) do
    begin

      read(archivo_bin, Registro);

      with Registro do
         writeln(Matricula,' ':2,Nombre,' ':50-length(nombre), Edad:4, estatura:6:2,Sexo:4);
    end;
    Close(archivo_bin);

    pausa(30,25,0,20);

  end;

  procedure edita_archivo_binario;

    procedure siguiente;
    begin
      if FilePos(archivo_bin)<FileSize(Archivo_bin)-1  then seek(archivo_bin,FilePos(archivo_bin)+1)
      else sonido(300,200);
    end;

    procedure Anterior;
    begin
      if FilePos(archivo_bin)>0 then seek(archivo_bin,FilePos(archivo_bin)-1)
      else sonido(300,200);
    end;

  begin
    Plantilla(1,15,15);
    Escribe_texto(15,12,1,15,'Nombre del archivo a editar:');
    readln(Nombre_Archivo);

    assign(archivo_bin, Nombre_Archivo);

    reset(archivo_bin);

    while not eof (archivo_bin) do
    begin
      Num_Reg := FilePos(archivo_bin)+1;
      Plantilla(1,15,15);
      Escribe_texto(10,23,1,15,'Esc');
      Escribe_texto(14,23,1,14,'Salir');
      Escribe_texto(23,23,1,15,'F2');
      Escribe_texto(26,23,1,14,'Guardar');
      Escribe_texto(37,23,1,15,'AvPag');
      Escribe_texto(43,23,1,14,'Siguiente');
      Escribe_texto(57,23,1,15,'RePag');
      Escribe_texto(63,23,1,14,'Anterior');

      read(archivo_bin,registro);
      seek(Archivo_bin,FilePos(Archivo_bin)-1); {regresa a la posici¢n del registro que se est  editando}

      Matricula := Registro.Matricula;
      Nombre    := Registro.Nombre;
      Edad      := Registro.edad;
      Estatura  := Registro.Estatura;
      Sexo      := Registro.sexo;

      Edita_datos(1,14);

      Registro.Matricula := Matricula;
      Registro.Nombre    := Nombre;
      Registro.Edad      := Edad;
      Registro.Estatura  := Estatura;
      Registro.Sexo      := Sexo;

      case tecla of
        #1 : begin
               write(archivo_bin,Registro);
               seek(archivo_bin, FilePos(archivo_bin)-1);
             end;
        #2 : Anterior;
        #3 : Siguiente;

        #27: begin
               Close(Archivo_bin);
               exit;
             end;
      end;

    end;
    Close(archivo_bin);
  end;



  procedure archivos_de_texto;

     procedure despliega_menu;
     begin
       Escribe_texto(25, 9,7,1,'ARCHIVOS DE TEXTO');
       Texto_de_opcion[1] := '1. Crear archivo';
       Texto_de_opcion[2] := '2. Leer  archivo';
       Texto_de_opcion[3] := '3. Editar archivo';
       Texto_de_opcion[4] := '4. Menu anterior';
       for i:=1 to 4 do  Escribe_texto(25,10+i,7,0,Texto_de_opcion[i]);
       Escribe_texto(24,16,7,0,'Seleccione su opcion:');
     end;

     {******** inicia cuerpo del procedimiento archivos de texto ******** }
  begin
    repeat
      Plantilla(1,15,15);
      Dibuja_cuadro(23,9,52,21,0,0);
      Dibuja_cuadro(21,8,50,20,7,7);
      despliega_menu;

      selector_vertical(25,11,7,0,0,15,4,45,16, opcion);

      case opcion of
        1    : Crea_archivo_de_texto;
        2    : Lee_archivo_de_texto;
        3    : Edita_archivo_de_texto;
        4    : exit;
      end; {fin del case}
    until opcion=100;
  end;

  procedure archivos_binarios;

     procedure despliega_menu;
     begin
       Escribe_texto(25, 9,7,0,'ARCHIVOS BINARIOS');
       Texto_de_opcion[1] := '1. Crear archivo';
       Texto_de_opcion[2] := '2. Leer archivo';
       Texto_de_opcion[3] := '3. Editar archivo';
       Texto_de_opcion[4] := '4. Menu anterior';
       for i:=1 to 4 do  Escribe_texto(25,10+i,7,0,Texto_de_opcion[i]);
       Escribe_texto(24,16,7,0,'Seleccione su opcion:');
     end;

     {******** inicia cuerpo del procedimiento archivos de texto ******** }
  begin
    repeat
     Plantilla(1,15,15);
      Dibuja_cuadro(23,9,52,21,0,0);
      Dibuja_cuadro(21,8,50,20,7,7);
      despliega_menu;

      selector_vertical(25,11,7,0,0,15,4,45,16, opcion);

      case opcion of
        1    : Crea_archivo_binario;
        2    : Lee_archivo_binario;
        3    : Edita_archivo_binario;
        4    : exit;
      end; {fin del case}
    until opcion=100;
  end;

  procedure manejo_De_archivos;

     procedure despliega_menu;
     begin
       Escribe_texto(25, 9,7,1,'MANEJO DE ARCHIVOS');
       Texto_de_opcion[1] := '1. Archivos de texto';
       Texto_de_opcion[2] := '2. Archivos_binarios';
       Texto_de_opcion[3] := '3. Terminar';
       for i:=1 to 3 do  Escribe_texto(25,10+i,7,0,Texto_de_opcion[i]);
       Escribe_texto(24,15,7,0,'Seleccione su opcion:');
     end;

     {******** inicia cuerpo del procedimiento archivos de texto ******** }
  begin
    repeat
      Plantilla(1,15,15);
      Dibuja_cuadro(23,9,52,21,0,0);
      Dibuja_cuadro(21,8,50,20,7,7);
      despliega_menu;

      selector_vertical(25,11,7,0,0,15,3,45,15, opcion);

      case opcion of
        1    : Archivos_de_texto;
        2    : Archivos_binarios;
        3    : exit;
      end; {fin del case}
    until opcion=100;
  end;

begin
   Manejo_de_archivos;
end.
