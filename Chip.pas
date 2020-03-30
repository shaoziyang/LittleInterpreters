{ KEYWORDS: VERSION }
{ VERSION: 1.8 }
{ 1.8 / 20.8.2002
  - TBasic.Destroy cleans up variables
  - fixed varptr matching in token parser. variable names are case-insensitive now
  - fixed uninitialized memory blocks obtained by New()
  - fixed power operator (^) to work correctly with 0
  - default extension for LOAD/SAVE command's argument is .BAS
  1.7 / 6.8.2002
  - LOAD command supports unix text files (only LF terminated)
  - function LEFT$ added
  - DEF FN added 
  1.6 / 2.8.2002
  - varrec internal structures reworked. new 'valref' structure included.
    as a side effect, array and simple variable can share name. eg. A$ and A$(2)
    are two distinct memory areas bound together in the varrec associated with
    name 'A$'
  1.5
  - DECLARE statement extended with mapping function calls to program calls.
    function parameters are passed as program arguments in a format declared by
    the statement
  1.4
  - DECLARE statement allowing dynamic function mapping (from external libraries)
  1.3
  - support for plug-in external functions with stdcall, fastcall and cdecl
    calling conventions. core functions were taken from Alexander Baranovsky's
    PasScript interpreter
  1.2
  - basic interpreter wrapped up into a class, thus allowing co-existence of
    multiple interpreters at the same time
  1.1
  - Chipmunk BASIC 1.0 by David Gillespie made Delphi compatible.
    char* management converted to strings and escape() converted to classic
    exceptions
}
unit Chip;

interface
uses Windows,Dialogs,SysUtils,Classes;

{ TUNE: }

 const
  vkNone                  =0;

  vkFastCall              =0 shl 5;
  vkStdCall               =1 shl 5;

  vkMaskCall              =1 shl 5;

  vkByVal                 =0 shl 7;
  vkByRef                 =1 shl 7;
  vkMaskBy                =1 shl 7;

  vkConst                 =1 shl 6;
  vkOptional              =1 shl 4;

  vkMaskType              =$FF and not (vkMaskCall or vkOptional);

  vkString                =1;
  vkInteger               =2;
  vkPChar                 =3;

  vkHandle                =vkInteger;

 type
  TValueKind=integer;
  ArrayOfValueKind=string;      // chr()+chr()..
  TFuncDef=class
   descriptor:string;
   obj:TObject;
   offset:pointer;
   cmdFormat:string;
  end;
  TInterpreter=class
  protected
   FLibs:TList;
   FFuncs:TStrings;

   function FindFunc(const preview:string; const buffer:string; var start:integer):integer;
   procedure InternalMap(const symbolName:string; outValue:TValueKind; const inValue:ArrayOfValueKind; obj:TObject; offset:pointer; const cmdFormat:string);
   procedure NewFunction(const symbolName:string; index:integer);virtual;
  public
   constructor Create;virtual;
   destructor Destroy;override;

   procedure MapShell(const symbolName:string; outValue:TValueKind; const inValue:ArrayOfValueKind; const cmdFormat:string);
   procedure MapLib(const symbolName:string; outValue:TValueKind; const inValue:ArrayOfValueKind; const libName:string; const entryPoint:string);
   procedure Map(const symbolName:string; outValue:TValueKind; const inValue:ArrayOfValueKind; offset:pointer);
   procedure MapMethod(const symbolName:string; outValue:TValueKind; const inValue:ArrayOfValueKind; obj:TObject; offset:pointer);
   procedure Run(ACommand:string);virtual;abstract;
   procedure Chat;virtual;abstract;
  end;

 const
  checking = true;

  varnamelen = 20;
  maxdims = 4;

 type
 varnamestring = string[varnamelen];

 tokenkinds = (tokvar, toknum, tokstr, tokfunc, toksnerr,

               tokplus, tokminus, toktimes, tokdiv, tokup, toklp, tokrp,
               tokcomma, toksemi, tokcolon, tokeq, toklt, tokgt,
               tokle, tokge, tokne,

               tokand, tokor, tokxor, tokmod, toknot, toksqr, toksqrt, toksin,
               tokcos, toktan, tokarctan, toklog, tokexp, tokabs, toksgn,
               tokstr_, tokval, tokchr_, tokasc, toklen, tokmid_, tokleft, tokint, tokrnd,

               tokrem, toklet, tokprint, tokinput, tokgoto, tokif, tokend,
               tokstop, tokfor, toknext, tokwhile, tokwend, tokgosub,
               tokreturn, tokread, tokdata, tokrestore, tokon,
               tokcommon,tokdim,tokdef,

               toklist, tokrun, toknew, tokload, tokmerge, toksave, tokbye,
               tokdel, tokdeclare, tokrenum,

               tokthen, tokelse, tokto, tokstep);

 float = double;        // TUNE: TODO:
 numptr = ^float;
 basicstring = packed record
  size:integer;
  data:pointer
 end;
 stringptr=^basicstring;
 numarray = array[0..(maxint div sizeof(float))-1] of float;
 numarrayptr = ^numarray;
 strarray = array[0..(maxint div sizeof(basicstring))-1] of basicstring;
 strarrayptr = ^strarray;

 strref=packed record base:strarrayptr; index:integer end;
 numref=packed record base:numarrayptr; index:integer end;

 tokenptr = ^tokenrec;
 lineptr = ^linerec;
 varptr = ^varrec;
 loopptr = ^looprec;

 tokenrec =
    packed record
       next : tokenptr;
       case kind : tokenkinds of
          tokvar : (vp : varptr);
          toknum : (num : float);
          tokstr, tokrem : (sptr2 : PChar);
          tokfunc: ( fi: integer );
          toksnerr : (snch : char);
    end;

 linerec =
    packed record
       num, num2 : integer;
       txt : tokenptr;
       next : lineptr;
    end;

 vartype=(vNumber,vString);

 numvarrec=packed record
   value:float;
   ref:numref;
   base:numarrayptr;
 end;

 strvarrec=packed record
   value:basicstring;
   ref:strref;
   base:strarrayptr;
 end;

 funcrecptr = ^funcrec;

 varrec =
    packed record
       name : varnamestring;
       next : varptr;
       dims : array [1..maxdims] of integer;
       numdims : 0..maxdims;

       func: funcrecptr;

       case kind:vartype of
       vNumber: ( num:numvarrec );
       vString: ( str:strvarrec );
    end;

 numvalrec=packed record
   value:float
 end;
 strvalrec=packed record
   value:string
 end;
 valrec =packed record
      kind:vartype;
      num:numvalrec;
      str:strvalrec;
    end;
 valref=packed record
      case kind:vartype of
      vNumber: ( num:numref );
      vString: ( str:strref )
   end;

 funcrec = packed record
   tok: tokenptr;
   dims : array [1..maxdims] of valref;
   numdims : 0..maxdims;
 end;

 loopkind = (forloop, whileloop, gosubloop);
 looprec =
    packed record
       next : loopptr;
       homeline : lineptr;
       hometok : tokenptr;
       case kind : loopkind of
          forloop :
             ( ref : valref;
               max, step : float );
    end;


type
 EBasic=class(Exception)
 public
  escapecode:integer;
  constructor Create(AnEscapeCode:integer; const msg:string);
 end;

 TBasicPrintEvent = procedure(Sender: TObject; msg: string) of object;

 PStream=^TextFile;
 TGetFileNameEvent=function(Sender:TObject; const fileName:string; new:boolean):string of object;
 TBasicClass=class of TBasic;
 TBasic=class(TInterpreter)
 protected
  inbuf : string;

  linebase : lineptr;
  varbase : varptr;
  loopbase : loopptr;

  curline : integer;
  stmtline, dataline : lineptr;
  stmttok, datatok, buf : tokenptr;

  exitflag : boolean;
  t : tokenptr;
 private
  FPrint: TBasicPrintEvent;
 protected
  FOnGetFileName:TGetFileNameEvent;
  procedure cmdend;
  procedure cmdnew;
  procedure cmdload(merging : boolean; name : string);
  procedure cmdsave(const name:string);
 protected
  procedure restoredata;
  procedure clearloops;
  procedure clearvars;
//  procedure listtokens(var f : text; buf : tokenptr);
  procedure listtokens(buf : tokenptr);
  procedure parseinput(var buf : tokenptr);
  procedure exec;
  procedure parse(const inbuf :string; var buf : tokenptr);
  procedure NewFunction(const symbolName:string; index:integer);override;
 public
  function ExpandFileName(const fileName:string; new:boolean):string;
 protected
  procedure CallShellSub(const cmd:string);virtual;
  function CallShellFunction(const cmd:string):string;virtual;
 protected
  Commons:TStrings;
  procedure initvarfromenv(v:varptr);
 public
  constructor Create;override;
  destructor Destroy;override;

  procedure LoadFromFile(const fileName:string);
  procedure SaveToFile(const fileName:string);
  procedure Run(ACommand:string);override;
  procedure Chat;override;
 protected
  BreakFlag: Boolean;
  procedure CheckBreak;
 public
  procedure SetBreak; virtual;
 public
  Environment:TStrings;
  input,output:PStream;
  procedure ExportCommons(Env:TStrings);
  property OnGetFileName:TGetFileNameEvent read FOnGetFileName write FOnGetFileName;
  property OnPrint: TBasicPrintEvent write FPrint;

 end;

implementation
(*
X
X                             Chipmunk BASIC 1.0
X                               David Gillespie
X
X
X       --------------------------------------------------------------
X
X
X
X
X   COMMANDS
X
X
X      LIST line(s)
X
X         List the specified program lines.  For example,
X
X               LIST 10, 100-200
X
X         lists line 10, and lines 100 through 200, inclusive.
X
X
X      RUN [line]
X
X         Begin execution of the program at the first line, or at the
X         specified line.  All variables are cleared.
X
X
X      RUN file[,line]
X
X         Load and run a program.  For example,
X
X               RUN "FOO", 30
X
X         loads a program from the file FOO.TEXT and begins execution at
X         line 30.
X
X
X      NEW
X
X         Erase the program in memory.
X
X
X      LOAD file
X
X         Load a program into memory.  The program previously in memory is
X         erased.  The file name should be in quotes; a .TEXT extension is
X         automatically added.  Files contain ASCII listings of the programs.
X         All lines in the file must begin with a line number, but line
X         numbers do not need to be in increasing order.
X
X
X      MERGE file
X
X         Load a program into memory.  The previous program remains in
X         memory; if a line exists in both programs, the newly loaded
X         line is kept.
X
X
X      SAVE file
X
X         Save the program in memory to a file.
X
X
X      BYE
X
X         Return to the operating system.
X
X
X      DEL line(s)
X
X         Delete the specified program lines.  Line numbers may be
X         separated by commas and dashes as in LIST.  If used inside
X         a program, DEL will terminate execution only if it deletes
X         the line on which it appears.
X
X
X      RENUM [start[,inc]]
X
X         Renumber program lines.  By default, the new sequence is 10,20,30,...
X         The first argument is a new initial line number; the second argument
X         is the increment between line numbers.
X
X
X
X
X   STATEMENTS
X
X      REM comment
X
X         A remark; ignored.  Comments may contain any characters except
X         that REM can not be immediately followed by an alphanumeric
X         character.
X
X
X      [LET] var = expr
X
X         Assign a value to a variable.  Variable names contain up to 20
X         significant characters, consisting of upper- and lower-case
X         letters, digits, underscores, and dollar signs.  Variable names
X         are case-sensitive.  Variables hold real numbers normally, or
X         strings of up to 255 characters if their names end with $.
X
X         Examples:
X
X               LET X=20
X               X$="FOO"
X               X$=X$+"BAR"
X
X
X      DIM var(dimensions), ...
X
X         Allocate memory for arrays.  Arrays may have up to 4 dimensions,
X         ranging from 0 to the value specified in the DIM statement.
X         The same name must not be used for both a simple variable and
X         an array.
X
X         If an array is used before it is dimensioned, each dimension
X         is set to 10.
X
X         Example:
X
X               INPUT "How many elements? "; x
X               DIM array(x,1)
X               FOR i=1 TO x : INPUT array(i,0), array(i,1) : NEXT
X
X
X      PRINT items
X
X         Print the items on the screen.  Items may be either numeric
X         or string expressions, and may be separated by commas, semicolons,
X         or nothing.
X
X         Numbers are normally terminated by spaces.  To avoid this space,
X         convert the number to a string with STR$.
X
X         The line is terminated by a CR/LF, unless the item list ends
X         with a comma or semicolon.
X
X         The word PRINT may be abbreviated as a question mark.
X
X         Examples:
X
X               PRINT "1+2=", 1+2
X               PRINT X$ "=" Z$;
X               ? x; y+z
X
X
X      INPUT [prompt;] vars
X
X         If a prompt string is given, it is printed.  Otherwise, a
X         question mark is printed.  The computer then waits for values
X         for each variable to be entered.  If several variables are
X         listed, their names must be separated by commas.
X
X         If the variables are numeric, their values may be entered
X         on separate lines, or combined with commas.  Any numeric expression
X         is a valid response.
X
X         If the variables are strings, each string is typed on a separate
X         line.  The characters typed are copied verbatim into the string.
X
X         String and numeric variables may be not mixed in a single
X         INPUT statement.
X
X         Examples:
X
X            INPUT X$
X            INPUT "Type 3 numbers: "; X, Y, Z
X
X
X      GOTO line
X
X         Begin executing statements at the specified line.  The line
X         number may be any numeric expression.
X
X         The word GO TO may be used instead of GOTO if preferable.
X
X
X      IF condition THEN line/statements ELSE line/statements
X
X         If the condition is true (i.e., the numeric expression has a
X         non-zero value), the statements following the word THEN are
X         executed.  Otherwise, the statements following ELSE are
X         executed.  If there is no ELSE clause, execution proceeds
X         to the next line in the program.
X
X         A line number may be used after either THEN or ELSE, for an
X         implied GOTO statement.
X
X
X      END
X
X         Terminate the program.  An END statement is not required.
X
X
X      STOP
X
X         Terminate the program with an identifying "Break" message.
X
X
X      FOR var = first TO last [STEP inc]
X      {statements}
X      NEXT [var]
X
X         Execute {statements} repeatedly while the variable counts from
X         "first" to "last," incrementing by 1, or by the STEP value if
X         given.  If the STEP value is negative, the variable counts
X         downward.
X
X         If "first" is greater than "last" (or less than if STEP is
X         negative), execution proceeds directly to the NEXT statement,
X         without executing the body of the loop at all.
X
X         The variable name is optional on the NEXT statement.
X
X
X      WHILE [condition]
X      {statements}
X      WEND [condition]
X
X         Execute {statements} repeatedly until the WHILE condition (if
X         given) becomes false, or until the WEND condition becomes true.
X         This structure can emulate Pascal's WHILE-DO and REPEAT-UNTIL,
X         or even both at once.  If no conditions are given, the loop will
X         never terminate unless the Evil GOTO is used.
X
X
X      GOSUB line
X      RETURN
X
X         Execute the statements beginning at the specified line, then
X         when RETURN is reached, return to the statement following the
X         GOSUB.
X
X
X      READ vars
X      DATA values
X      RESTORE line
X
X         Read numeric or string values from the DATA statements.  Reading
X         begins at the first DATA statement in the program and proceeds
X         to the last.  Reading past the end the last DATA statement
X         generates an error.
X
X         The DATA values must be either numeric or string expressions,
X         according to the type of variable being read.  Reading the wrong
X         kind of expression produces a Syntax Error.
X
X         The RESTORE statement causes the next READ to re-use the first
X         DATA statement in the program, or the first DATA statement on
X         or after a particular line.
X
X
X      ON expr GOTO line, line, ...
X      ON expr GOSUB line, line, ...
X
X         If the expression's value, rounded to an integer, is N, go to
X         the Nth line number in the list.  If N is less than one or is
X         too large, execution continues at the next statement after
X         the ON-GOTO or ON-GOSUB.
X
X
X
X   NUMERIC EXPRESSIONS
X
X      x AND y
X
X         Logical AND of two integers.
X
X
X      x OR y
X
X         Logical OR of two integers.
X
X
X      x XOR y
X
X         Logical XOR of two integers.
X
X
X      NOT x
X
X         Logical complement of an integer.
X
X
X      INT x
X
X
X      x+y, x-y, x*y, x/y, x^y, -x
X
X         Typical floating-point arithmetic operations.
X
X
X      x=y, x<y, x>y, x<=y, x>=y, x<>y
X
X         Comparisons; result is 1 if true, 0 if false.
X
X
X      x MOD y
X
X         Modulo of two integers.
X
X
X      SQR x
X
X         Square of X.  Note that parentheses are not required if a function's
X         argument is a single entitity; for example, SQR SIN X needs no
X         parentheses, but SQR(1+X) does.
X
X
X      SQRT x
X
X         Square root of X.
X
X
X      SIN x, COS x, TAN x, ARCTAN x
X
X         Typical trig functions, in radians.
X
X
X      LOG x, EXP x
X
X         Natural logarithm, and e the power X.
X
X
X      ABS x
X
X         Absolute value of X.
X
X
X      SGN x
X
X         Sign of X:  1 if X is positive, 0 if zero, -1 if negative.
X
X
X      VAL x$
X
X         Value of the expression contained in the string X$.  For example,
X         VAL "1+2" yields 3.  X$ may be a single string literal, variable,
X         or function, or a string expression in parentheses.
X
X
X      ASC x$
X
X         ASCII code of the first character in X$, or 0 if X$ is null.
X
X
X      LEN x$
X
X         Number of characters in X$.
X
X
X      Precedence:      Parentheses
X                        Functions  (incl. NOT and unary minus)
X                            ^
X                        *, /, MOD
X                          +, -
X                   =, <, >, <=, >=, <>
X                           AND
X                         OR, XOR
X
X
X
X   STRING EXPRESSIONS
X
X      "string" or 'string'
X
X         String literal.  Single quotes are converted to double quotes
X         internally.
X
X
X      x$+y$
X
X         Concatenation.  Result must be 255 characters or less.
X
X
X      x$=y$, x$<y$, x$>y$, x$<=y$, x$>=y$, x$<>y$
X
X         String comparisons; result is 1 if true, 0 if false.
X
X
X      STR$(x)
X
X         The number X expressed as a string of digits.  No leading or
X         trailing spaces are included; scientific notation is used
X         if the absolute values is greater than 1E12 or less than 1E-2.
X
X
X      CHR$(x)
X
X         The character whose ASCII code is X.
X
X
X      MID$(x$, y)
X      MID$(x$, y, z)
X
X         (Parentheses required.)  The substring consisting of the first
X         Z characters starting at position Y of string X$.  Position 1
X         is the first character of the string.  If Z is omitted, 255
X         is used, i.e., the entire right part of the string.
X
X
X      LEFT$(x$, y)
X
X         same as MID$(x$, 1, y)
X
X   CONVENTIONS
X
X      Multiple statements may be written on a line, separated by colons:
X
X            10 INPUT X : PRINT X : STOP
X
X
X      There is actually no difference between commands and statements;
X      both can be used in or out of programs at will.  Certain commands,
X      such as NEW, will, of course, halt program execution.
X
X
X      Line numbers may be any integer from 1 to MAXINT.
X
X
X      To delete a line use DEL, or type its line number alone:
X
X            10
X
X
X      Press CLR I/O to halt program execution.  [This is not supported
X      by p2c's translation!]  To leave BASIC, use the BYE command.
X
X
X      Keywords must be written in all upper- or all lower-case; they are
X      always converted to upper-case internally.  Spaces are ignored in
X      the input except between quotes.  Square brackets are converted to
X      parentheses.  Missing closing quotes at the end of the line are
X      added, as in the command:
X
X            SAVE "PROGRAM
X
X
X
X
*)

procedure string2basicstring(var v:basicstring; const value:string);
var n:integer;
begin
 if v.data<>nil then begin
  FreeMem(v.data);
  v.data:=nil
 end;
 n:=Length(value);
 v.size:=n;
 if n<>0 then begin
  GetMem(v.data,n);
  Move(value[1],v.data^,n)
 end
end;

function basicstring2string(var v:basicstring):string;
begin
 if v.size=0 then
  Result:=''
 else begin
  SetLength(Result,v.size);
  Move(v.data^,Result[1],v.size)
 end
end;

procedure _setvarrec2string(var v:varrec; const value:string);
begin
 v.str.ref.base:=nil;
 string2basicstring(v.str.value,value)
end;

procedure _setvarrec2float(var v:varrec; value:float);
begin
 v.num.ref.base:=nil;
 v.num.value:=value
end;

function _varrec2string(var v:varrec):string;
var p:stringptr;
begin
 if v.str.ref.base<>nil then
  p:=@v.str.ref.base^[v.str.ref.index]
 else
  p:=@v.str.value;

 Result:=basicstring2string(p^)
end;

function _valref2string(var ref:valref):string;
begin
 Result:=basicstring2string(ref.str.base^[ref.str.index])
end;

function valrefMaps(var ref:valref; var v:varrec):boolean;
begin
 Result:=ref.kind=v.kind;
 if not Result then exit;
 case ref.kind of
 vNumber:
  Result:=(ref.num.index=0) and (ref.num.base=@v.num.value);

 vString:
  Result:=(ref.str.index=0) and (ref.str.base=@v.str.value);

 else assert(false)
 end
end;

procedure varrec2valref(var v:varrec; var ref:valref);
begin
 case v.kind of
 vNumber:
  begin
   ref.kind:=vNumber;
   if v.num.ref.base=nil then begin
    ref.num.base:=@v.num.value;
    ref.num.index:=0
   end else begin
    ref.num:=v.num.ref
   end
  end;

 vString:
  begin
   ref.kind:=vString;
   if v.str.ref.base=nil then begin
    ref.str.base:=@v.str.value;
    ref.str.index:=0
   end else begin
    ref.str:=v.str.ref
   end
  end;

 else assert(false)
 end;
end;

procedure _assignstring2varrec(var v:varrec; const value:string);
var p:stringptr;
begin
 if v.str.ref.base<>nil then
  p:=@v.str.ref.base^[v.str.ref.index]
 else
  p:=@v.str.value;

 string2basicstring(p^,value)
end;

procedure _assignstring2valref(var ref:valref; const value:string);
begin
 string2basicstring(ref.str.base^[ref.str.index],value)
end;

procedure _assignfloat2varrec(var v:varrec; value:float);
var p:numptr;
begin
 if v.num.ref.base<>nil then
  p:=@v.num.ref.base^[v.num.ref.index]
 else
  p:=@v.num.value;

 p^:=value
end;

procedure _assignfloat2valref(var ref:valref; value:float);
begin
 ref.num.base^[ref.num.index]:=value
end;

function _varrec2float(var v:varrec):float;
var p:numptr;
begin
 if v.num.ref.base<>nil then
  p:=@v.num.ref.base^[v.num.ref.index]
 else
  p:=@v.num.value;

 Result:=p^
end;

function _valref2float(var ref:valref):float;
begin
 Result:=ref.num.base^[ref.num.index]
end;

procedure valref2valrec(var ref:valref; var n:valrec);
begin
 n.kind:=ref.kind;
 case n.kind of
 vNumber:
  n.num.value:=_valref2float(ref);

 vString:
  n.str.value:=_valref2string(ref);
  
 else assert(false)
 end
end;

procedure valrec2valref(var ref:valref; var n:valrec);
begin
 assert(n.kind=ref.kind);
 case n.kind of
 vNumber:
  _assignfloat2valref(ref,n.num.value);

 vString:
  _assignstring2valref(ref,n.str.value);
  
 else assert(false)
 end
end;

procedure clearvar(var v:varrec);
var dim:integer;
var i:integer;
begin
  if v.numdims<>0 then begin
   dim:=1;
   for i:=1 to v.numdims do dim:=dim*v.dims[i];

   case v.kind of
   vNumber:
    begin
     FreeMem(v.num.base);
     v.num.base:=nil
    end;

   vString:
    begin
     for i:=dim-1 downto 0 do
      string2basicstring(v.str.base^[i],'');

     FreeMem(v.str.base);
     v.str.base:=nil
    end;

   else assert(false)
   end;

   v.numdims:=0
  end;

  case v.kind of
  vNumber: _setvarrec2float(v,0);
  vString: _setvarrec2string(v,'');
  else assert(false)
  end;

  if v.func<>nil then begin
   FreeMem(v.func);
   v.func:=nil
  end
end;

type
 TFuncDefs=class(TList)
 protected
  function GetItem(index:integer):TFuncDef;
 public
  destructor Destroy;override;
  property Items[index:integer]:TFuncDef read GetItem;
 end;

 function TFuncDefs.GetItem;
 begin
  Result:=TFuncDef(inherited Get(index))
 end;

 destructor TFuncDefs.Destroy;
 var i:integer;
 begin
  for i:=Count-1 downto 0 do
   Items[i].Free;
  inherited 
 end;

 constructor TInterpreter.Create;
 begin
  inherited Create;
  FFuncs:=TStringList.Create;
  TStringList(FFuncs).Sorted:=true;
  FLibs:=TList.Create
 end;

 function TInterpreter.FindFunc;
 var buf:string;
 var n:integer;
 var ln:integer;
 begin
  if TStringList(FFuncs).Find(preview,Result) then exit;

  n:=FFuncs.Count;
  ln:=length(preview);
  while Result<n do begin
   buf:=FFuncs[Result];

   if CompareText(preview,Copy(buf,1,ln))<>0 then break;

   if CompareText(buf,Copy(buffer,start-ln,length(buf)))=0 then begin
    inc(start,length(buf)-ln);
    exit
   end;

   inc(Result)
  end;
  Result:=-1
 end;

 procedure TInterpreter.MapMethod;
 begin
  InternalMap(symbolName,outValue,inValue,obj,offset,'')
 end;

 procedure TInterpreter.Map;
 begin
  InternalMap(symbolName,outValue,inValue,nil,offset,'')
 end;

 procedure escape(code:integer; const msg:string);
 begin
  raise EBasic.Create(code,msg)
 end;

procedure errormsg(s : string);
    begin
       escape(42,s);
    end;

 procedure TInterpreter.MapShell;
 begin
  InternalMap(symbolName,outValue,inValue,nil,nil,cmdFormat)
 end;

 procedure TInterpreter.MapLib;
 var lib:THandle;
 var offset:pointer;
 begin
  lib:=LoadLibrary(PChar(libName));
  if lib=0 then
   offset:=nil
  else
   offset:=GetProcAddress(lib,PChar(entryPoint));
  if lib<>0 then FLibs.Add(pointer(lib));
  InternalMap(symbolName,outValue,inValue,nil,offset,'')
 end;

 procedure TInterpreter.NewFunction;
 begin
 end;

 procedure TInterpreter.InternalMap;
 var descriptor:string;
 var i:integer;
 var flag:integer;
 var size:integer;
 var fd:TFuncDef;
 var fl:TFuncDefs;
 begin
  size:=Length(inValue);
  flag:=outValue and (not vkConst);
  if size=0 then
   descriptor:=chr(flag)
  else begin
   SetLength(descriptor,1+size);
   descriptor[1]:=chr(flag);
   for i:=1 to size do begin
    flag:=ord(inValue[i]);

    if (flag and vkByRef)<>0 then flag:=flag and (not vkConst);

    descriptor[1+i]:=chr(flag)
   end
  end;

  fd:=TFuncDef.Create;
  fd.descriptor:=descriptor;
  fd.obj:=obj;
  fd.offset:=offset;
  fd.cmdFormat:=cmdFormat;

  i:=FFuncs.IndexOf(symbolName);
  if i<0 then begin
   fl:=TFuncDefs.Create;
   FFuncs.AddObject(symbolName,fl);
   fl.Add(fd);
   NewFunction(UpperCase(symbolName),integer(fl))
  end else begin
   fl:=TFuncDefs(FFuncs.Objects[i]);
   for i:=fl.Count-1 downto 0 do
    if fl.Items[i].descriptor=descriptor then begin
     fl.Items[i].Free;
     fl.Delete(i);
     break
    end;
   fl.Add(fd);
  end;

 end;

 destructor TInterpreter.Destroy;
 var i:integer;
 begin
  for i:=FFuncs.Count-1 downto 0 do
   FFuncs.Objects[i].Free;
  FFuncs.Free;
  for i:=FLibs.Count-1 downto 0 do FreeLibrary(THandle(FLibs[i]));
  FLibs.Free;
  inherited;
 end;

constructor EBasic.Create;
begin
 inherited Create(msg);
 escapecode:=AnEscapeCode
end;

const ts=#1;
const tokenNames:array [tokenkinds] of string=(
 '',                    // tokvar
 '',                    // toknum
 '',                    // tokstr
 '',                    // tokfunc
 '',                    // toksnerr

 '+',                   // tokplus
 '-',                   // tokminus
 '*',                   // toktimes
 '/',                   // tokdiv
 '^',                   // tokup
 '('+ts+'[',            // toklp
 ')'+ts+']',            // tokrp
 ',',                   // tokcomma
 ';',                   // toksemi
 ':',                   // tokcolon
 '=',                   // tokeq
 '<',                   // toklt
 '>',                   // tokgt,
 '<=',                  // tokle
 '>=',                  // tokge
 '<>',                  // tokne

 'AND',                 // tokand
 'OR',                  // tokor
 'XOR',                 // tokxor
 'MOD',                 // tokmod
 'NOT',                 // toknot
 'SQR',                 // toksqr
 'SQRT',                // toksqrt
 'SIN',                 // toksin
 'COS',                 // tokcos
 'TAN',                 // toktan
 'ARCTAN',              // tokarctan
 'LOG',                 // toklog
 'EXP',                 // tokexp
 'ABS',                 // tokabs
 'SGN',                 // toksgn,
 'STR$',                // tokstr_
 'VAL',                 // tokval
 'CHR$',                // tokchr_
 'ASC',                 // tokasc
 'LEN',                 // toklen
 'MID$',                // tokmid_
 'LEFT$',               // tokleft
 'INT',                 // tokint
 'RND',                 // tokrnd

 'REM',                 // tokrem
 'LET',                 // toklet
 'PRINT',               // tokprint
 'INPUT',               // tokinput
 'GOTO'+ts+'GO TO',     // tokgoto
 'IF',                  // tokif
 'END',                 // tokend
 'STOP',                // tokstop
 'FOR',                 // tokfor
 'NEXT',                // toknext
 'WHILE',               // tokwhile
 'WEND',                // tokwend
 'GOSUB',               // tokgosub
 'RETURN',              // tokreturn
 'READ',                // tokread
 'DATA',                // tokdata
 'RESTORE',             // tokrestore
 'ON',                  // tokon
 'COMMON',              // tokcommon
 'DIM',                 // tokdim
 'DEF',                 // tokdef

 'LIST',                // toklist
 'RUN',                 // tokrun
 'NEW',                 // toknew
 'LOAD',                // tokload
 'MERGE',               // tokmerge
 'SAVE',                // toksave
 'BYE'+ts+'QUIT',       // tokbye
 'DEL',                 // tokdel
 'DECLARE',             // tokdeclare
 'RENUM',               // tokrenum

 'THEN',                // tokthen
 'ELSE',                // tokelse
 'TO',                  // tokto
 'STEP'                 // tokstep
);


procedure snerr;
    begin
       errormsg('Syntax error');
    end;

procedure tmerr;
    begin
       errormsg('Type mismatch error');
    end;

procedure badsubscr;
    begin
       errormsg('Bad subscript');
    end;

function strltrim(const s:string):string;
var i:integer;
begin
 for i:=1 to length(s) do
  if s[i]<>' ' then begin
   strltrim:=Copy(s,i,maxint);
   exit
  end;
 strltrim:=''
end;

// TODO: use numtostr(,false) where appropriate

function numtostr(n : float; trim:boolean) : string;
    var
       s : string;
       i : integer;
    begin
       if (n <> 0) and (abs(n) < 1e-2) or (abs(n) >= 1e12) then
          begin
             Str(n,s);

             if trim or (n<0) then
              numtostr := s
             else
              numtostr := ' '+s
          end
       else
          begin
             Str(n:30:10,s);
             i:=Length(s)+1;
             repeat
                i := i - 1;
             until s[i] <> '0';
             if s[i] = '.' then
                i := i - 1;
             SetLength(s,i);

             if trim or (n<0) then
              numtostr := strltrim(s)
             else
              numtostr := ' '+strltrim(s) 
          end;
    end;

procedure NewPChar(var p:PChar; const s:string);
begin
 GetMem(p,length(s)+1);
 if length(s)>0 then Move(s[1],p^,length(s));
 p[length(s)]:=#0
end;

procedure disposetokens(var tok : tokenptr);
    var
       tok1 : tokenptr;
    begin
       while tok <> nil do
          begin
             tok1 := tok^.next;
             if tok^.kind in [tokstr, tokrem] then
                FreeMem(tok^.sptr2);
             dispose(tok);
             tok := tok1;
          end;
    end;

//--------------------------------------------------------------------
constructor TBasic.Create;
begin
 inherited Create;
 Environment:=TStringList.Create;
 Commons:=TStringList.Create;
 TStringList(Commons).Sorted:=true
end;

destructor TBasic.Destroy;
begin
 cmdnew;       // dispose tokens, variables
 inherited;
 Environment.Free;
 Commons.Free
end;

procedure TBasic.CallShellSub;
begin
 snerr
end;

function TBasic.CallShellFunction;
begin
 snerr
end;

//--------------------------------------------------------------------
procedure TBasic.ExportCommons;
var i:integer;
var key:string;
var v:varptr;
var line:string;
begin
 for i:=Commons.Count-1 downto 0 do begin
  key:=Commons[i];
  v:=varbase;
  while v<>nil do
   if CompareText(v^.name,key)=0 then
    break
   else
    v:=v^.next;

  if key[length(key)]='$' then SetLength(key,length(key)-1);
  if v=nil then
   Env.Values[key]:=''
  else begin
   { TODO: handle arrays }
   case v^.kind of
   vString:
    Env.Values[key]:=_varrec2string(v^);

   vNumber:
    begin
     Str(_varrec2float(v^),line);
     Env.Values[key]:=Trim(line)
    end;

   else assert(false)
   end
  end
 end
end;

procedure TBasic.initvarfromenv(v:varptr);
var value:string;
var num:float;
var code:integer;
var key:string;
begin
 { TODO: handle arrays ? }
 key:=v^.name;
 if key[length(key)]='$' then SetLength(key,length(key)-1);
 value:=Environment.Values[key];

 case v^.kind of
 vString:
  _setvarrec2string(v^,value);

 vNumber:
  begin
   Val(value,num,code);
   if code<>0 then num:=0;
   _setvarrec2float(v^,num)
  end;

 else assert(false)
 end;
end;

procedure TBasic.listtokens(buf : tokenptr);
    var
       ltr : boolean;
       wasSpace:boolean;

       procedure Put(const s:string);
       begin
        if (s[1]=' ') and wasSpace then
//         Write(f,Copy(s,2,maxint))
           FPrint(Self, Copy(s,2,maxint))
        else
//         Write(f,s);
           FPrint(Self, s);
        wasSpace:=s[length(s)]=' '
       end;

       function TN:string;
       var i:integer;
       begin
        Result:=tokenNames[buf^.kind];
        i:=Pos(ts,Result);
        if i<>0 then SetLength(Result,i-1)
       end;

       procedure PT;
       begin
        Put(TN)
       end;

       procedure PS;
       begin
        Put(' '+TN+' ')
       end;

       procedure PU;
       begin
        Put(TN+' ')
       end;

       function s2p(const s:string):string;
       var i:integer;
       begin
        Result:='';
        for i:=1 to length(s) do
         if s[i]='"' then
          Result:=Result+'""'
         else
          Result:=Result+s[i]
       end;

    begin
       ltr := false;
       wasSpace:=false;
       while buf <> nil do
          begin
             if buf^.kind in [tokvar, tokFunc, toknum, toknot..tokrenum] then
                begin
                   if ltr then Put(' ');
                   ltr := (buf^.kind <> toknot);
                end
             else
                ltr := false;
             case buf^.kind of
                tokvar     : Put(buf^.vp^.name);
                toknum     : Put(numtostr(buf^.num,true));
                tokstr     : Put('"'+ s2p(buf^.sptr2) +'"');
                tokFunc    : Put(FFuncs[FFuncs.IndexOfObject(TObject(buf^.fi))]);
                toksnerr   : Put('{'+ buf^.snch +'}');
                tokplus    ,
                tokminus   ,
                toktimes   ,
                tokdiv     ,
                tokup      ,
                toklp      ,
                tokrp      ,
                tokcomma   ,
                toksemi    : PT;
                tokcolon   ,
                tokeq      ,
                toklt      ,
                tokgt      ,
                tokle      ,
                tokge      ,
                tokne      ,
                tokand     ,
                tokor      ,
                tokxor     ,
                tokmod     : PS;
                toknot     : PU;
                toksqr     ,
                toksqrt    ,
                toksin     ,
                tokcos     ,
                toktan     ,
                tokarctan  ,
                toklog     ,
                tokexp     ,
                tokabs     ,
                toksgn     ,
                tokstr_    ,
                tokval     ,
                tokchr_    ,
                tokasc     ,
                toklen     ,
                tokmid_    ,
                tokleft    ,
                tokint     ,
                tokrnd     ,
                toklet     ,
                tokprint   ,
                tokinput   ,
                tokgoto    ,
                tokif      ,
                tokend     ,
                tokstop    ,
                tokfor     ,
                toknext    ,
                tokwhile   ,
                tokwend    ,
                tokgosub   ,
                tokreturn  ,
                tokread    ,
                tokdata    ,
                tokrestore ,
                tokon      ,
                tokcommon  ,
                tokdim     ,
                tokdef     ,
                toklist    ,
                tokrun     ,
                toknew     ,
                tokload    ,
                tokmerge   ,
                toksave    ,
                tokdel     ,
                tokbye     ,
                tokrenum   ,
                tokdeclare : PT;
                tokthen    ,
                tokelse    ,
                tokto      ,
                tokstep    : PS;
                tokrem     : Put(TN+buf^.sptr2);
             end;
             buf := buf^.next;
          end;
    end;

//--------------------------------------------------------------------
procedure TBasic.clearvars;
    var
       v : varptr;
    begin
       v := varbase;
       while v <> nil do
          begin
             clearvar(v^);
             v := v^.next;
          end;
    end;
//--------------------------------------------------------------------
procedure TBasic.clearloops;
    var
       l : loopptr;
    begin
       while loopbase <> nil do
          begin
             l := loopbase^.next;
             dispose(loopbase);
             loopbase := l;
          end;
    end;
//--------------------------------------------------------------------
procedure TBasic.parseinput(var buf : tokenptr);
    var
       l, l0, l1 : lineptr;
    begin
       inbuf := strltrim(inbuf);
       curline := 0;
       while (length(inbuf) <> 0) and (inbuf[1] in ['0'..'9']) do
          begin
             curline := curline * 10 + ord(inbuf[1]) - ord('0');
             Delete(inbuf,1,1)
          end;
       parse(inbuf, buf);
       if curline <> 0 then
          begin
             l := linebase;
             l0 := nil;
             while (l <> nil) and (l^.num < curline) do
                begin
                   l0 := l;
                   l := l^.next;
                end;
             if (l <> nil) and (l^.num = curline) then
                begin
                   l1 := l;
                   l := l^.next;
                   if l0 = nil then
                      linebase := l
                   else
                      l0^.next := l;
                   disposetokens(l1^.txt);
                   dispose(l1);
                end;
             if buf <> nil then
                begin
                   new(l1);
                   FillChar(l1^,sizeof(l1^),0);
                   l1^.next := l;
                   if l0 = nil then
                      linebase := l1
                   else
                      l0^.next := l1;
                   l1^.num := curline;
                   l1^.txt := buf;
                end;
             clearloops;
             restoredata;
          end;
    end;


//--------------------------------------------------------------------
procedure TBasic.restoredata;
    begin
       dataline := nil;
       datatok := nil;
    end;
//--------------------------------------------------------------------
procedure TBasic.parse(const inbuf :string; var buf : tokenptr);

    const
       toklength = 20;

    type
       chset = set of char;

    const
       idchars = ['A'..'Z','a'..'z','0'..'9','_','$',{ TODO: }'%'];

    var
       i, j, k, i2 : integer;
       token : string[toklength];
       t, tptr : tokenptr;
       v : varptr;
       ch : char;
       n, d, d1 : float;

       // TODO: support "GO TO"

       function IsA(const key:string):boolean;
       var i:integer;
       begin
        IsA:=false;
        if length(key)<>length(token) then exit;
        for i:=1 to length(key) do
         if UpCase(token[i])<>UpCase(key[i]) then exit;
        IsA:=true
       end;

       function MatchTokens(toks:array of tokenkinds):boolean;
       var i:integer;
       var keys:string;
       var p:integer;
       label loop;
       begin
        Result:=false;
        for i:=Low(toks) to High(toks) do begin
         keys:=tokenNames[toks[i]];
         loop:
         p:=Pos(ts,keys);
         if p=0 then p:=length(keys)+1;
         if IsA(Copy(keys,1,p-1)) then begin
          t^.kind:=toks[i];
          Result:=true;
          exit
         end;
         Delete(keys,1,p);
         if keys<>'' then goto loop
        end
       end;

    var tmp:string;
    begin
       tptr := nil;
       buf := nil;
       i := 1;
       repeat
          ch := ' ';
          while (i <= length(inbuf)) and (ch = ' ') do
             begin
                ch := inbuf[i];
                i := i + 1;
             end;
          if ch <> ' ' then
             begin
                new(t);
                FillChar(t^,sizeof(t^),0);
                if tptr = nil then
                   buf := t
                else
                   tptr^.next := t;
                tptr := t;
                t^.next := nil;
                case ch of
                   'A'..'Z', 'a'..'z', '_' :
                      begin
                         i := i - 1;
                         j := 0;
                         SetLength(token,toklength);
                         while (i <= Length(inbuf)) and (inbuf[i] in idchars) do
                            begin
                               if j < toklength then
                                  begin
                                     j := j + 1;
                                     token[j] := inbuf[i];
                                  end;
                               i := i + 1;
                            end;
                         SetLength(token,j);


                         i2:=FindFunc(token,inbuf,i);
                         if i2>=0 then begin
                           t^.kind:=tokFunc;
                           t^.fi:=integer(FFuncs.Objects[i2])
                         end else

                         if MatchTokens([
                          tokand,
                          tokor,
                          tokxor,
                          toknot,
                          tokmod,
                          toksqr,
                          toksqrt,
                          toksin,
                          tokcos,
                          toktan,
                          tokarctan,
                          toklog,
                          tokexp,
                          tokabs,
                          toksgn,
                          tokstr_,
                          tokval,
                          tokchr_,
                          tokasc,
                          toklen,
                          tokmid_,
                          tokleft,
                          tokint,
                          tokrnd,
                          toklet,
                          tokprint,
                          tokinput,
                          tokgoto,
                          tokif,
                          tokend,
                          tokstop,
                          tokfor,
                          toknext,
                          tokwhile,
                          tokwend,
                          tokgosub,
                          tokreturn,
                          tokread,
                          tokdata,
                          tokrestore,
                          tokon,
                          tokcommon,
                          tokdim,
                          tokdef,
                          toklist,
                          tokrun,
                          toknew,
                          tokload,
                          tokmerge,
                          toksave,
                          tokbye,
                          tokdel,
                          tokrenum,
                          tokdeclare,
                          tokthen,
                          tokelse,
                          tokto,
                          tokstep
                         ]) then
                    else if IsA(tokenNames[tokrem]) then
                            begin
                               t^.kind := tokrem;
                               NewPChar(t^.sptr2,Copy(inbuf,i,maxint));
                               i := length(inbuf)+1;
                            end
                         else
                            begin
                               t^.kind := tokvar;
                               v := varbase;
                               while (v <> nil) and (not IsA(v^.name)) do
                                  v := v^.next;
                               if v = nil then
                                  begin
                                     new(v);
                                     FillChar(v^,sizeof(v^),0);

                                     v^.next := varbase;
                                     varbase := v;
                                     v^.name := token;
                                     v^.numdims := 0;
                                     if token[length(token)] = '$' then
                                       v^.kind:=vString
                                     else
                                       v^.kind:=vNumber
                                  end;
                               t^.vp := v;
                            end;
                      end;
                   '"' :
                      begin
                         t^.kind := tokstr;
                         tmp:='';
                         while true do begin
                          if i>length(inbuf) then break;
                          if inbuf[i]=ch then begin
                           if (i<length(inbuf)) and (inbuf[i+1]=ch) then begin
                            tmp:=tmp+ch;
                            inc(i,2)
                           end else begin
                            inc(i);
                            break
                           end
                          end else begin
                           tmp:=tmp+inbuf[i];
                           inc(i)
                          end 
                         end;
                         NewPChar(t^.sptr2,tmp);
                      end;
                   '0'..'9', '.' :
                      begin
                         t^.kind := toknum;
                         n := 0;
                         d := 1;
                         d1 := 1;
                         i := i - 1;
                         while (i <= length(inbuf)) and ((inbuf[i] in ['0'..'9'])
                                     or ((inbuf[i] = '.') and (d1 = 1))) do
                            begin
                               if inbuf[i] = '.' then
                                  d1 := 10
                               else
                                  begin
                                     n := n * 10 + ord(inbuf[i]) - ord('0');
                                     d := d * d1;
                                  end;
                               i := i + 1;
                            end;
                         n := n / d;
                         if (i <= length(inbuf)) and (inbuf[i] in ['e','E']) then
                            begin
                               i := i + 1;
                               d1 := 10;
                               if (i <= length(inbuf)) and (inbuf[i] in ['+','-']) then
                                  begin
                                     if inbuf[i] = '-' then
                                        d1 := 0.1;
                                     i := i + 1;
                                  end;
                               j := 0;
                               while (i <= length(inbuf)) and (inbuf[i] in ['0'..'9']) do
                                  begin
                                     j := j * 10 + ord(inbuf[i]) - ord('0');
                                     i := i + 1;
                                  end;
                               for k := 1 to j do
                                  n := n * d1;
                            end;
                         t^.num := n;
                      end;
                   '+' : t^.kind := tokplus;
                   '-' : t^.kind := tokminus;
                   '*' : t^.kind := toktimes;
                   '/' : t^.kind := tokdiv;
                   '^' : t^.kind := tokup;
                   '(', '[' : t^.kind := toklp;
                   ')', ']' : t^.kind := tokrp;
                   ',' : t^.kind := tokcomma;
                   ';' : t^.kind := toksemi;
                   ':' : t^.kind := tokcolon;
                   '?' : t^.kind := tokprint;
                   '=' : t^.kind := tokeq;
                   '<' :
                      begin
                         if (i <= length(inbuf)) and (inbuf[i] = '=') then
                            begin
                               t^.kind := tokle;
                               i := i + 1;
                            end
                         else if (i <= length(inbuf)) and (inbuf[i] = '>') then
                            begin
                               t^.kind := tokne;
                               i := i + 1;
                            end
                         else
                            t^.kind := toklt;
                      end;
                   '>' :
                      begin
                         if (i <= length(inbuf)) and (inbuf[i] = '=') then
                            begin
                               t^.kind := tokge;
                               i := i + 1;
                            end
                         else
                            t^.kind := tokgt;
                      end;
                   else
                      begin
                         t^.kind := toksnerr;
                         t^.snch := ch;
                      end;
                end;
             end;
       until i > length(inbuf);
    end;
//--------------------------------------------------------------------
const
 MaxArgs=6; // TUNE:
type
 TArg=packed record
  sbuf:string;
  val:valrec;
  ref:valref;
  isRef:boolean
 end;
 TArgs=packed record
  count:integer;
  outVal:TArg;
  inVal:array [1..MaxArgs] of TArg;
 end;

procedure TBasic.cmdend;
   begin
      stmtline := nil;
      t := nil;
   end;


procedure TBasic.cmdnew;
   var
      p : pointer;
   begin
      cmdend;
      clearloops;
      restoredata;
      while linebase <> nil do
         begin
            p := linebase^.next;
            disposetokens(linebase^.txt);
            dispose(linebase);
            linebase := p;
         end;
      while varbase <> nil do
         begin
            p := varbase^.next;
            clearvar(varbase^);
            dispose(varbase);
            varbase := p;
         end;
   end;


procedure TBasic.cmdload(merging : boolean; name : string);
   var
      f : file;
      buf : tokenptr;
      ch:char;
      block:array [0..8 { TUNE: }*1024-1] of char;
      blockSize:integer;
      blockHead:integer;
      eof:boolean;

      function Get:boolean;
      begin
       if blockHead=blockSize then begin
        blockHead:=0;
        blockread(f,block,sizeof(block),blockSize);
        if blockSize=0 then begin
         Result:=false;
         eof:=true;
         exit
        end
       end;
       ch:=block[blockHead];
       inc(blockHead);
       Result:=true
      end;

   begin
      if not merging then
         cmdnew;
      assign(f,ExpandFileName(name,false));       // TODO: shared
      reset(f,sizeof(ch));

      blockSize:=0;
      blockHead:=0;

      eof:=false;
      while not eof do
         begin
            inbuf:='';
            while not eof do begin
             if not Get then break;
             case ch of
             #$0A: break;
             #$0D: ;
             else inbuf:=inbuf+ch
             end
            end;
            // readln(f, inbuf);
            if inbuf='' then continue;
            parseinput(buf);
            if curline = 0 then
               begin
//                  writeln(output^,'Bad line in file');
                  if Assigned(FPrint) then
                    FPrint(Self, 'Bad line in file');
                  disposetokens(buf);
               end;
         end;
      close(f);
   end;

procedure TBasic.cmdsave;
   var
      f : text;
      l : lineptr;
   begin
//      rewrite(f, ExpandFileName(name,true));
//      l := linebase;
//      while l <> nil do
//         begin
//            write(f, l^.num:1, ' ');
//            listtokens(f, l^.txt);
//            writeln(f);
//            l := l^.next;
//         end;
//      close(f);
   end;

procedure TBasic.NewFunction;
var lin:lineptr;

 procedure Replace(t:tokenptr);
 begin
  while t<>nil do begin
   if (t^.kind=tokvar) and (UpperCase(t^.vp^.name)=symbolName) then begin
    t^.kind:=tokfunc;
    t^.fi:=index
   end;
   t:=t^.next
  end;
 end;

begin
 { replace tokvar with tokfunc }
 Replace(t);
 lin:=linebase;
 while lin<>nil do begin
  Replace(lin^.txt);
  lin:=lin^.next
 end
end;

procedure TBasic.SetBreak;
begin
  BreakFlag := True
end;

procedure TBasic.CheckBreak;
begin
  if BreakFlag then begin
    BreakFlag := False;
    escape(-20,'Break');
  end
end;

procedure TBasic.exec;

    var
       gotoflag, elseflag : boolean;

    procedure factor(var n:valrec);forward;

    procedure expr(var n:valrec);forward;

    function realfactor:float;
    var n:valrec;
    begin
      factor(n);
      if n.kind<>vNumber then tmerr;
      Result:=n.num.value
    end;

    function strfactor:string;
    var n:valrec;
    begin
      factor(n);
      if n.kind<>vString then tmerr;
      Result:=n.str.value
    end;

    function intfactor:integer;
    begin
      Result:=round(realfactor);
    end;

    function realexpr:float;
    var n:valrec;
    begin
      expr(n);
      if n.kind<>vNumber then tmerr;
      Result:=n.num.value
    end;

    function strexpr:string;
    var n:valrec;
    begin
      expr(n);
      if n.kind<>vString then tmerr;
      Result:=n.str.value
    end;

    function intexpr:integer;
    begin
      Result:=round(realexpr);
    end;

    procedure require(k : tokenkinds);
    begin
     if (t = nil) or (t^.kind <> k) then
      snerr;
     t := t^.next;
    end;

    function keyword(const name:string):boolean;
    begin
     if t=nil then
      Result:=false
     else begin
      Result:=((t^.kind=tokvar) and (UpperCase(t^.vp^.name)=name)) or
              (tokenNames[t^.kind]=name) or
              ((t^.kind=tokfunc) and (UpperCase(FFuncs[FFuncs.IndexOfObject(TObject(t^.fi))])=name));
      if Result then t:=t^.next
     end
    end;

    procedure requireKeyword(const name:string);
    begin
     if not keyword(name) then snerr
    end;

    procedure skipparen;
       label 1;
       begin
          repeat
             if t = nil then snerr;
             if (t^.kind = tokrp) or (t^.kind = tokcomma) then
                goto 1;
             if t^.kind = toklp then
                begin
                   t := t^.next;
                   skipparen;
                end;
             t := t^.next;
          until false;
        1 :
       end;

    function iseos : boolean;forward;

    procedure skipoptionalparenexpr;
       var level:integer;
       begin
         if (t<>nil) and (t^.kind=toklp) then begin
           t:=t^.next;
           level:=1;
           while level<>0 do begin
             if iseos then snerr;
             if t^.kind=toklp then
              inc(level)
             else
             if t^.kind=tokrp then
              dec(level);
             t:=t^.next
           end
         end;
       end;

    function findvar : varptr;
       var
          v : varptr;
          i, j, k : integer;
          tok : tokenptr;
       begin
          if (t = nil) or (t^.kind <> tokvar) then snerr;
          v := t^.vp;
          t := t^.next;
          if (t <> nil) and (t^.kind = toklp) then
             with v^ do
                begin
                   if numdims = 0 then
                      begin
                         tok := t;
                         i := 0;
                         j := 1;
                         repeat
                            if i >= maxdims then badsubscr;
                            t := t^.next;
                            skipparen;
                            j := j * 11;
                            i := i + 1;
                            dims[i] := 11;
                         until t^.kind = tokrp;
                         numdims := i;
                         case kind of
                         vNumber:
                          begin
                           GetMem(num.base,j*sizeof(float));
                           FillChar(num.base^,j*sizeof(float),0)
                          end;

                         vString:
                          begin
                           GetMem(str.base,j*sizeof(basicstring));
                           FillChar(str.base^,j*sizeof(basicstring),0)
                          end;

                         else assert(false)
                         end;
                         t := tok;
                      end;
                   k := 0;
                   t := t^.next;
                   for i := 1 to numdims do
                      begin
                         j := intexpr;
                         if (j < 0) or (j >= dims[i]) then
                            badsubscr;
                         k := k * dims[i] + j;
                         if i < numdims then
                            require(tokcomma);
                      end;
                   require(tokrp);

                   case kind of
                   vNumber:
                    begin
                     num.ref.base:=num.base;
                     num.ref.index:=k
                    end;

                   vString:
                    begin
                     str.ref.base:=str.base;
                     str.ref.index:=k
                    end;

                   else assert(false)
                   end;
                end
          else
             begin
                { TODO:
                if v^.numdims <> 0 then
                   badsubscr;
                }
                case v^.kind of
                vNumber: v^.num.ref.base:=nil;
                vString: v^.str.ref.base:=nil;
                else assert(false)
                end
             end;
          if v^.func<>nil then snerr;
          findvar := v;
       end;

    procedure getvar(var ref:valref);
    begin
      varrec2valref(findvar^,ref)
    end;

    function inot(i : integer) : integer;
       begin
          inot := -1 - i;
       end;

    function ixor(a, b : integer) : integer;
       begin
          ixor := a xor b;
       end;

    procedure CallFunction(var n:valrec; fi:integer; needResult:boolean);
    var arity:integer;
    var descriptors:string;
    var args:TArgs;
    var flag:integer;
    var needBraces:boolean;
    var i:integer;
    var missing:boolean;

    var stack:array [0..30 { TUNE: }] of integer;
    var sp:integer;
    var _eax,_edx,_ecx:integer;
    var regcount:integer;
    var ltr:boolean;

     procedure PushInt(n:integer);
     begin
      case regcount of
      0: begin inc(regcount); _eax:=n end;
      1: begin inc(regcount); _edx:=n end;
      2: begin inc(regcount); _ecx:=n end;
      else
       stack[sp]:=n;
       if ltr then dec(sp) else inc(sp)
      end
     end;

     procedure PushPtr(n:pointer);
     begin
      PushInt(integer(n))
     end;

     function AsInt(var a:TArg):integer;
     begin
      with a do
       if isRef then begin
        if (ref.kind<>vNumber) or (ref.num.base=nil) then tmerr;
        Result:=Trunc(ref.num.base^[ref.num.index])
       end else begin
        if val.kind<>vNumber then tmerr;
        Result:=Trunc(val.num.value)
       end
     end;

     procedure AsStr(var a:TArg);
     begin
      with a do
       if isRef then begin
        if (ref.kind<>vString) or (ref.str.base=nil) then tmerr;
        a.sbuf:=basicstring2string(ref.str.base^[ref.str.index])
       end else begin
        if val.kind<>vString then tmerr;
        a.sbuf:=val.str.value
       end;
     end;

    var stkusage:integer;
    var stkadr:integer;
    var regcall:boolean;
    var adr:pointer;
    var resadr:pointer;
    var resvalue:integer;
    var needsExtraParam:boolean;
    var isMethod:boolean;
    var obj:TObject;
    var fd:TFuncDef;
    var fl:TFuncDefs;

     function ShellCommand(const cmdFormat:string):string;
     var i:integer;
     var ch:char;
     var ai:integer;
     var flag:integer;
     var missing:boolean;
     begin
      Result:='';
      i:=1;
      while i<=length(cmdFormat) do begin
       ch:=cmdFormat[i];
       if ch='%' then begin
        if (i=length(cmdFormat)) or (cmdFormat[i+1]='%') then begin
         Result:=Result+ch;
         inc(i,2)
        end else begin
         ai:=ord(cmdFormat[i+1])-ord('0');

         if (ai<1) or (ai>arity) then snerr;

         flag:=ord(descriptors[ai+1]);
         missing:=args.count<ai;

         case flag and vkMaskType of
         vkByVal or vkInteger,
         vkByVal or vkInteger or vkConst:
          if missing then
           Result:=Result+'0'
          else
           Result:=Result+IntToStr(AsInt(args.inVal[ai]));

         vkByVal or vkString,
         vkByVal or vkString or vkConst,
         vkByVal or vkPChar,
         vkByVal or vkPChar or vkConst:
          begin
           if not missing then begin
            AsStr(args.inVal[ai]);
            Result:=Result+args.inVal[ai].sbuf
           end
          end;

         else snerr
         end;

         inc(i,2)
        end
       end else begin
        Result:=Result+ch;
        inc(i)
       end
      end
     end;

    begin
     fl:=TFuncDefs(fi);
     fd:=fl.Items[0];

     descriptors:=fd.descriptor;
     adr:=fd.offset;
     arity:=length(descriptors)-1;
     FillChar(args,sizeof(args),0);

     flag:=ord(descriptors[1]);
     if needResult and ((flag and vkMaskType)=vkNone) then tmerr;
     obj:=fd.obj;
     isMethod:=obj<>nil;

     if arity>0 then begin
      if t<>nil then begin
       if t^.kind=toklp then begin
        needBraces:=true;
        t:=t^.next
       end else
        needBraces:=false;

       while true do begin
        if iseos then begin
          if needBraces then snerr else break
        end;

        if needBraces and (t^.kind=tokrp) then begin
         t:=t^.next;
         break
        end;

        flag:=ord(descriptors[args.count+1]);
        if (flag and vkByRef)<>0 then begin
         with args.inVal[args.count+1] do begin
          isRef:=true;
          getvar(ref)
         end
        end else begin
         with args.inVal[args.count+1] do begin
          isRef:=false;
          if needBraces then
           expr(val)
          else
           factor(val)
         end  
        end;
        inc(args.count);

        dec(arity);

        if (iseos or (arity=0)) and (not needBraces) then break;

        if t=nil then snerr;

        case t^.kind of
        tokcomma: t:=t^.next;
        tokrp: if needBraces then begin t:=t^.next; break end;
        else
         if needBraces then snerr else break
        end;

        if arity=0 then snerr;

       end
      end
     end else begin
      if (t<>nil) and (t^.kind=toklp) then begin
       t:=t^.next;
       require(tokrp)
      end
     end;

     arity:=length(descriptors)-1;
     for i:=args.count+1 to arity do begin
      flag:=ord(descriptors[i+1]);
      if (flag and vkOptional)=0 then snerr
     end;

     if fd.cmdFormat='' then begin
      case ord(descriptors[1]) and vkMaskCall of
      vkFastCall:
       begin
        ltr:=true;
        regcall:=true;
        regcount:=0
       end;
      else
       // vkStdCall
       ltr:=false;
       regcall:=false;
       regcount:=3  // don't use registers
      end;

      if ltr then begin
       sp:=High(stack);
      end else begin
       sp:=Low(stack);
      end;

      flag:=ord(descriptors[1]) and vkMaskType;
      case flag of
      vkString:
       begin
        needsExtraParam:=true
       end;
      else
       needsExtraParam:=false;
      end;

      resadr:=@resvalue;
      resvalue:=0;

      if needsExtraParam and (not ltr) then
       PushInt(integer(resadr));
      if isMethod { TODO: ? and (not ltr)} then
       PushInt(integer(obj));

      for i:=1 to arity do begin
       flag:=ord(descriptors[i+1]);
       missing:=args.count<i;

       case flag and vkMaskType of
       vkByVal or vkInteger,
       vkByVal or vkInteger or vkConst:
        if missing then
         PushInt(0)
        else
         PushInt(AsInt(args.inVal[i]));

       vkByVal or vkString,
       vkByVal or vkString or vkConst:
        begin
         if missing then
          args.inVal[i].sbuf:=''
         else
          AsStr(args.inVal[i]);

         PushPtr(pointer(args.inVal[i].sbuf))
        end;

       vkByVal or vkPChar,
       vkByVal or vkPChar or vkConst:
        begin
         if missing then
          args.inVal[i].sbuf:=''
         else
          AsStr(args.inVal[i]);

         if args.inVal[i].sbuf='' then
          PushInt(0)
         else with args.inVal[i] do begin
          sbuf:=sbuf+#0;
          PushPtr(@sbuf[1])
         end
        end

       else snerr;

       // TODO:
       {      vkByRef or vkInteger:
        ;

       vkByVal or vkString:
        ;

       vkByVal or vkString or vkConst:
        ;

       vkByRef or vkString:
        ;

        ;}


       end
      end;

      if Adr=nil then errormsg('external function missing');

 { TODO:     if isMethod and ltr then
       PushInt(integer(obj)); }
      if needsExtraParam and ltr then
       PushInt(integer(resadr));

      if ltr then begin
       stkadr:=integer(@stack[sp])+sizeof(stack[0]);
       stkusage:=integer(@stack[High(stack)])+sizeof(stack[0])-integer(stkadr)
      end else begin
       stkadr:=integer(@stack);
       stkusage:=integer(@stack[sp])-integer(stkadr);
      end;

      asm
        push esi               // esi, edi, ebp and ebx must be kept
        push edi               // (we use only esi and edi here).
        sub esp, StkUsage      // make room on stack
        mov edi, esp           // set destination of mem copy, it is the stack
        mov esi, StkAdr        // set source of mem copy, it is Addr(ExtStk)
        mov ecx, StkUsage      // prepare ecx to copy StkUsage bytes
        shr ecx, 2             // divide by 4 to perform DWORD-copy (is faster)

        //add edi, StkUsage;
        //sub edi,4
        //add esi, StkUsage;
        //sub esi,4
        cld                    // choose copy direction
        rep movsd              // do DWORD-copy

        cmp RegCall, true
        jnz @@EXEC
        mov EAX, _EAX
        mov EDX, _EDX
        mov ECX, _ECX

        @@EXEC:
        call Adr               // execute the external function
                               // esp is restored by the external function
                               // (except for cdecl-convention)
        pop edi                // restore edi...
        pop esi                // ...and esi
        mov _EAX,eax
      end;                     // asm


      // TODO: convert references back

      if needsExtraParam then begin
       args.outVal.val.kind:=vString;
       args.outVal.val.str.value:=string(resvalue);
       string(resvalue):=''
      end else begin
       args.outVal.val.kind:=vNumber;
       args.outVal.val.num.value:=_EAX;
      end
     end else begin
      { this is a shell call }
      { TODO: use shell func and convert back the output }
      case ord(descriptors[1]) and vkMaskType of
      vkNone:
       CallShellSub(ShellCommand(fd.cmdFormat));

      vkString,vkPChar:
       begin
        args.outVal.val.kind:=vString;
        args.outVal.val.str.value:=CallShellFunction(ShellCommand(fd.cmdFormat))
       end;

      vkInteger:
       begin
        { TODO: }
        args.outVal.val.kind:=vNumber;
        args.outVal.val.num.value:=StrToIntDef(CallShellFunction(ShellCommand(fd.cmdFormat)),0)
       end;

      else snerr
      end
     end;

     n:=args.outVal.val
    end;

    procedure CallProcedure(fi:integer);
    var n:valrec;
    begin
     CallFunction(n,fi,false)
    end;

    procedure factor(var n:valrec);
       var
          v : valref;
          facttok : tokenptr;
          i, j : integer;
          tok, tok1 : tokenptr;
          s : string;

          procedure CallDefFn(var func:funcrec);
          var args:array [1..maxdims] of valrec;
          var i:integer;
          var tmp:valrec;
          var oldtok:tokenptr;
          begin
           { push local variables }
           for i:=1 to func.numdims do
            valref2valrec(func.dims[i],args[i]);
           try
            require(toklp);

            { bind arguments }
            for i:=1 to func.numdims do begin
             expr(tmp);
             valrec2valref(func.dims[i],tmp);
             if i<func.numdims then require(tokcomma)
            end;

            require(tokrp);

            oldtok:=t;
            try
             t:=func.tok;
             expr(n)
            finally
             t:=oldtok
            end
           finally
            { pop local variables }
            for i:=1 to func.numdims do
             valrec2valref(func.dims[i],args[i])
           end
          end;

       begin
          if t = nil then snerr;
          facttok := t;
          t := t^.next;
          n.kind:=vNumber;
          case facttok^.kind of
             toknum :
                n.num.value:=facttok^.num;

             tokstr :
                begin
                   n.kind:=vString;
                   n.str.value:=facttok^.sptr2;
                end;

             tokfunc:
                begin
                   CallFunction(n,facttok^.fi,true)
                end;

             tokvar :
                begin
                   if facttok^.vp^.func<>nil then begin
                    { DEF FN invocation }
                    CallDefFn(facttok^.vp^.func^)
                   end else begin
                    t := facttok;

                    getvar(v);
                    case v.kind of
                    vNumber:
                     begin
                      n.kind:=vNumber;
                      n.num.value:=_valref2float(v)
                     end;

                    vString:
                     begin
                      n.kind:=vString;
                      n.str.value:=_valref2string(v)
                     end;
                    else assert(false)
                    end
                   end 
                end;

             toklp :
                begin
                   expr(n);
                   require(tokrp);
                end;

             tokminus :
                n.num.value:=-realfactor;

             tokplus :
                n.num.value:=realfactor;

             toknot :
                n.num.value:=inot(intfactor);

             toksqr :
                n.num.value:=sqr(realfactor);

             toksqrt :
                n.num.value:=sqrt(realfactor);

             toksin :
                n.num.value:=sin(realfactor);

             tokcos :
                n.num.value:=cos(realfactor);

             toktan :
                begin
                   n.num.value:=realfactor;
                   n.num.value:=sin(n.num.value)/cos(n.num.value);
                end;

             tokarctan :
                n.num.value:=arctan(realfactor);

             toklog:
                n.num.value:=ln(realfactor);

             tokexp :
                n.num.value:=exp(realfactor);

             tokabs :
                n.num.value:=abs(realfactor);

             toksgn :
                begin
                   n.num.value:=realfactor;
                   n.num.value:=ord(n.num.value>0)-ord(n.num.value<0);
                end;

             tokstr_ :
                begin
                   n.kind:=vString;
                   n.str.value:=numtostr(realfactor,true);
                end;

             tokval :
                begin
                   s := strfactor;
                   tok1 := t;
                   parse(s, t);
                   tok := t;
                   if tok = nil then
                      n.num.value:=0
                   else
                      expr(n);
                   disposetokens(tok);
                   t := tok1;
                end;

             tokchr_ :
                begin
                   n.kind:=vString;
                   n.str.value:=chr(intfactor);
                end;

             tokasc :
                begin
                   s := strfactor;
                   if s='' then
                      n.num.value:=0
                   else
                      n.num.value:=ord(s[1]);
                end;

             tokmid_ :
                begin
                   require(toklp);
                   n.kind:=vString;
                   n.str.value:=strexpr;
                   require(tokcomma);
                   i := intexpr;
                   if i < 1 then i := 1;
                   j := maxint;
                   if (t <> nil) and (t^.kind = tokcomma) then
                      begin
                         t := t^.next;
                         j := intexpr;
                      end;
                   if j > length(n.str.value)-i+1 then
                      j := length(n.str.value)-i+1;
                   if i > length(n.str.value) then
                      n.str.value:=''
                   else
                      n.str.value:=Copy(n.str.value, i, j);
                   require(tokrp);
                end;

             tokleft:
                begin
                   require(toklp);
                   n.kind:=vString;
                   n.str.value:=strexpr;
                   require(tokcomma);
                   i := intexpr;
                   if i < 1 then i := 0;
                   n.str.value:=Copy(n.str.value, 1, i);
                   require(tokrp);
                end;

             toklen :
                begin
                   s := strfactor;
                   n.num.value:=length(s);
                end;

             tokint :
                begin
                   n.num.value:=trunc(realfactor);
                end;

             tokrnd:
                begin
                   skipoptionalparenexpr;
                   n.num.value:=random(1000)/1000 { TUNE: TODO: }
                end
             else
                snerr;
          end;
       end;

    procedure upexpr(var n:valrec);
       var n2 : valrec;
       begin
          factor(n);
          while (t <> nil) and (t^.kind = tokup) do
             begin
                if n.kind<>vNumber then tmerr;
                t := t^.next;
                upexpr(n2);
                if n2.kind<>vNumber then tmerr;
                if n.num.value<0 then
                   begin
                      if n2.num.value<>trunc(n2.num.value) then n.num.value:=ln(n.num.value);
                      n.num.value:=exp(n2.num.value*ln(-n.num.value));
                      if odd(trunc(n2.num.value)) then
                         n.num.value:=-n.num.value;
                   end
                else if n.num.value<>0 then
                   n.num.value:=exp(n2.num.value*ln(n.num.value));
             end;
       end;

    procedure term(var n:valrec);
       var
          n2 : valrec;
          k : tokenkinds;
       begin
          upexpr(n);
          while (t <> nil) and (t^.kind in [toktimes, tokdiv, tokmod]) do
             begin
                k := t^.kind;
                t := t^.next;
                upexpr(n2);
                if (n.kind<>vNumber) or (n2.kind<>vNumber) then tmerr;
                if k = tokmod then
                   n.num.value:=round(n.num.value) mod round(n2.num.value)
                else if k = toktimes then
                   n.num.value:=n.num.value*n2.num.value
                else
                   n.num.value:=n.num.value/n2.num.value;
             end;
       end;

    procedure sexpr(var n:valrec);
       var
          n2 : valrec;
          k : tokenkinds;
       begin
          term(n);
          while (t <> nil) and (t^.kind in [tokplus, tokminus]) do
             begin
                k := t^.kind;
                t := t^.next;
                term(n2);
                if n.kind<>n2.kind then tmerr;
                if k = tokplus then begin
                   case n.kind of
                   vNumber:
                    n.num.value:=n.num.value+n2.num.value;

                   vString:
                    n.str.value:=n.str.value+n2.str.value;

                   else assert(false)
                   end
                end else
                   case n.kind of
                   vNumber:
                    n.num.value:=n.num.value-n2.num.value;

                   vString:
                    tmerr;

                   else assert(false)
                   end
             end;
       end;

    procedure relexpr(var n:valrec);
       var
          n2 : valrec;
          f : boolean;
          k : tokenkinds;
       begin
          sexpr(n);
          while (t <> nil) and (t^.kind in [tokeq..tokne]) do
             begin
                k := t^.kind;
                t := t^.next;
                sexpr(n2);
                if n.kind<>n2.kind then tmerr;

                case n.kind of
                vString:
                   begin
                      f := ((n.str.value=n2.str.value) and (k in [tokeq, tokge, tokle]) or
                            (n.str.value<n2.str.value) and (k in [toklt, tokle, tokne]) or
                            (n.str.value>n2.str.value) and (k in [tokgt, tokge, tokne]));
                   end;

                vNumber:
                   begin
                   f := ((n.num.value=n2.num.value) and (k in [tokeq, tokge, tokle]) or
                         (n.num.value<n2.num.value) and (k in [toklt, tokle, tokne]) or
                         (n.num.value>n2.num.value) and (k in [tokgt, tokge, tokne]));
                   end;

                else assert(false)
                end;

                n.kind:=vNumber;
                n.num.value:=ord(f);
             end;
       end;

    procedure andexpr(var n:valrec);
       var
          n2 : valrec;
       begin
          relexpr(n);
          while (t <> nil) and (t^.kind = tokand) do
             begin
                t := t^.next;
                relexpr(n2);
                if (n.kind<>vNumber) or (n2.kind<>vNumber) then tmerr;
                n.num.value:=trunc(n.num.value) and trunc(n2.num.value);
             end;
       end;

    procedure expr(var n:valrec);
       var
          n2 : valrec;
          k : tokenkinds;
       begin
          andexpr(n);
          while (t <> nil) and (t^.kind in [tokor, tokxor]) do
             begin
                k := t^.kind;
                t := t^.next;
                andexpr(n2);
                if (n.kind<>vNumber) or (n2.kind<>vNumber) then tmerr;
                if k = tokor then
                   n.num.value:=trunc(n.num.value) or trunc(n2.num.value)
                else
                   n.num.value:=trunc(n.num.value) xor trunc(n2.num.value);
             end;
       end;


    procedure checkextra;
       begin
          if t <> nil then
             errormsg('Extra information on line');
       end;


    function iseos : boolean;
       begin
          iseos := (t = nil) or (t^.kind in [tokcolon, tokelse]);
       end;


    procedure skiptoeos;
       begin
          while not iseos do
             t := t^.next;
       end;


    function findline(n : integer) : lineptr;
       var
          l : lineptr;
       begin
          l := linebase;
          while (l <> nil) and (l^.num <> n) do
             l := l^.next;
          findline := l;
       end;


    function mustfindline(n : integer) : lineptr;
       var
          l : lineptr;
       begin
          l := findline(n);
          if l = nil then
             errormsg('Undefined line');
          mustfindline := l;
       end;


    procedure cmdlist;
       var
          l : lineptr;
          n1, n2 : integer;
       begin
          repeat
             n1 := 0;
             n2 := maxint;
             if (t <> nil) and (t^.kind = toknum) then
                begin
                   n1 := trunc(t^.num);
                   t := t^.next;
                   if (t = nil) or (t^.kind <> tokminus) then
                      n2 := n1;
                end;
             if (t <> nil) and (t^.kind = tokminus) then
                begin
                   t := t^.next;
                   if (t <> nil) and (t^.kind = toknum) then
                      begin
                         n2 := trunc(t^.num);
                         t := t^.next;
                      end
                   else
                      n2 := maxint;
                end;
             l := linebase;
             while (l <> nil) and (l^.num <= n2) do
                begin
                   if (l^.num >= n1) then
                      begin
//                         write(output^,l^.num:1, ' ');
//                         listtokens(output^, l^.txt);
//                         writeln(output^);
                         if Assigned(FPrint) then
                         begin
                           FPrint(Self, Format('%d ',[l^.num]));
                           listtokens(l^.txt);
                           FPrint(Self, #13#10);
                         end;
                      end;
                   l := l^.next;
                end;
             if not iseos then
                require(tokcomma);
          until iseos;
       end;


    procedure cmdrun;
       var
          l : lineptr;
          i : integer;
          s : string;
       begin
          l := linebase;
          if not iseos then
             begin
                if t^.kind = toknum then
                   l := mustfindline(intexpr)
                else
                   begin
                      s := strexpr;
                      i := 0;
                      if not iseos then
                         begin
                            require(tokcomma);
                            i := intexpr;
                         end;
                      checkextra;
                      cmdload(false, s);
                      if i = 0 then
                         l := linebase
                      else
                         l := mustfindline(i)
                   end
             end;
          stmtline := l;
          gotoflag := true;
          clearvars;
          clearloops;
          restoredata;
       end;


    procedure cmdbye;
       begin
          exitflag := true;
       end;


    procedure cmddel;
       var
          l, l0, l1 : lineptr;
          n1, n2 : integer;
       begin
          repeat
             if iseos then snerr;
             n1 := 0;
             n2 := maxint;
             if (t <> nil) and (t^.kind = toknum) then
                begin
                   n1 := trunc(t^.num);
                   t := t^.next;
                   if (t = nil) or (t^.kind <> tokminus) then
                      n2 := n1;
                end;
             if (t <> nil) and (t^.kind = tokminus) then
                begin
                   t := t^.next;
                   if (t <> nil) and (t^.kind = toknum) then
                      begin
                         n2 := trunc(t^.num);
                         t := t^.next;
                      end
                   else
                      n2 := maxint;
                end;
             l := linebase;
             l0 := nil;
             while (l <> nil) and (l^.num <= n2) do
                begin
                   l1 := l^.next;
                   if (l^.num >= n1) then
                      begin
                         if l = stmtline then
                            begin
                               cmdend;
                               clearloops;
                               restoredata;
                            end;
                         if l0 = nil then
                            linebase := l^.next
                         else
                            l0^.next := l^.next;
                         disposetokens(l^.txt);
                         dispose(l);
                      end
                   else
                      l0 := l;
                   l := l1;
                end;
             if not iseos then
                require(tokcomma);
          until iseos;
       end;


    procedure cmdrenum;
       var
          l, l1 : lineptr;
          tok : tokenptr;
          lnum, step : integer;
       begin
          lnum := 10;
          step := 10;
          if not iseos then
             begin
                lnum := intexpr;
                if not iseos then
                   begin
                      require(tokcomma);
                      step := intexpr;
                   end;
             end;
          l := linebase;
          if l <> nil then
             begin
                while l <> nil do
                   begin
                      l^.num2 := lnum;
                      lnum := lnum + step;
                      l := l^.next;
                   end;
                l := linebase;
                repeat
                   tok := l^.txt;
                   repeat
                      if tok^.kind in [tokgoto, tokgosub, tokthen, tokelse,
                                       tokrun, toklist, tokrestore, tokdel] then
                         while (tok^.next <> nil) and (tok^.next^.kind = toknum) do
                            begin
                               tok := tok^.next;
                               lnum := round(tok^.num);
                               l1 := linebase;
                               while (l1 <> nil) and (l1^.num <> lnum) do
                                  l1 := l1^.next;
                               if l1 = nil then
//                                  writeln(output^,'Undefined line ', lnum:1, ' in line ', l^.num2:1)
                               begin
                                  if Assigned(FPrint) then
                                    FPrint(Self, Format('Undefined line %d in line %d',[lnum, l^.num2]));
                               end
                               else
                                  tok^.num := l1^.num2;
                               if (tok^.next <> nil) and (tok^.next^.kind = tokcomma) then
                                  tok := tok^.next;
                            end;
                      tok := tok^.next;
                   until tok = nil;
                   l := l^.next;
                until l = nil;
                l := linebase;
                while l <> nil do
                   begin
                      l^.num := l^.num2;
                      l := l^.next;
                   end;
             end;
       end;


    procedure cmdprint;
       var
          semiflag : boolean;
          n : valrec;
       begin
          semiflag := false;
          while not iseos do
             begin
                semiflag := false;
                if t^.kind in [toksemi, tokcomma] then
                   begin
                      semiflag := true;
                      t := t^.next;
                   end
                else if keyword('TAB') then begin
                   n.kind:=vNumber;
                   n.num.value:=intfactor;
                   { TODO: tabulate to position }
//                   write(output^,' ')
                   if Assigned(FPrint) then
                      FPrint(Self, ' ')
                end else
                   begin
                      expr(n);
                      case n.kind of
                      vString:
//                        write(output^,n.str.value);
                        if Assigned(FPrint) then
                          FPrint(self, n.str.value);
                      vNumber:
//                        write(output^,numtostr(n.num.value,true),' ');
                        if Assigned(FPrint) then
                          FPrint(self, numtostr(n.num.value,true) + ' ');

                      else assert(false)
                      end
                   end;
             end;
          if not semiflag then
//             writeln(output^);
               if Assigned(FPrint) then
                 FPrint(self, #13#10);
       end;


    procedure cmdinput;
       var
          v : valref;
          s,si : string;
          tok, tok0, tok1 : tokenptr;
          strflag : vartype;
       begin
          si:='';
          if (t <> nil) and (t^.kind = tokstr) then
             begin
//                write(output^,t^.sptr2);
//                if Assigned(FPrint) then
//                  FPrint(Self, t^.sptr2);
                si:=si+t^.sptr2;
                t := t^.next;
                if (t<>nil) and (t^.kind=tokcomma) then begin
                 t:=t^.next;
//                 write(output^,'? ')
//                if Assigned(FPrint) then
//                  FPrint(Self, '? ');
                end else
                 require(toksemi);
             end
          else
             begin
//                write(output^,'? ');
//                if Assigned(FPrint) then
//                  FPrint(Self, '? ');
                  si:='? ';
             end;
          tok := t;
          if (t = nil) or (t^.kind <> tokvar) then snerr;
          strflag := t^.vp^.kind;
          repeat
             if (t <> nil) and (t^.kind = tokvar) then
                if t^.vp^.kind <> strflag then snerr;
             t := t^.next;
          until iseos;
          t := tok;
          case strflag of
          vString:
             begin
                repeat
//                   readln(input^,s);
                   s:=inputbox('input',si,'');
                   getvar(v);
                   _assignstring2valref(v,s);
                   if not iseos then
                      begin
                         require(tokcomma);
//                         write(output^,'?? ');
                         if Assigned(FPrint) then
                           FPrint(Self, '?? ');

                      end;
                until iseos;
             end;

          vNumber:
             begin
//                readln(input^,s);
                s:=inputbox('input',si,'');
                parse(s, tok);
                tok0 := tok;
                repeat
                   getvar(v);
                   while tok = nil do
                      begin
//                         write(output^,'?? ');
                         if Assigned(FPrint) then
                           FPrint(Self, '?? ');

//                         readln(input^,s);
                         s:=inputbox('input','','');
                         disposetokens(tok0);
                         parse(s, tok);
                         tok0 := tok;
                      end;
                   tok1 := t;
                   t := tok;
                   _assignfloat2valref(v,realexpr);
                   if t <> nil then
                      if t^.kind = tokcomma then
                         t := t^.next
                      else
                         snerr;
                   tok := t;
                   t := tok1;
                   if not iseos then
                      require(tokcomma);
                until iseos;
                disposetokens(tok0);
             end;

          else assert(false)
          end
       end;


    procedure cmdlet(implied : boolean);
       var
          v : valref;
       begin
          if implied then
             t := stmttok;
          getvar(v);
          require(tokeq);

          case v.kind of
          vNumber: _assignfloat2valref(v,realexpr);
          vString: _assignstring2valref(v,strexpr);
          else assert(false)
          end;
       end;


    procedure cmdgoto;
       begin
          stmtline := mustfindline(intexpr);
          t := nil;
          gotoflag := true;
       end;


    procedure cmdif;
       var
          n : float;
          i : integer;
       begin
          n := realexpr;
          require(tokthen);
          if n = 0 then
             begin
                i := 0;
                repeat
                   if t <> nil then
                      begin
                         if t^.kind = tokif then
                            i := i + 1;
                         if t^.kind = tokelse then
                            i := i - 1;
                         t := t^.next;
                      end;
                until (t = nil) or (i < 0);
             end;
          if (t <> nil) and (t^.kind = toknum) then
             cmdgoto
          else
             elseflag := true;
       end;


    procedure cmdelse;
       begin
          t := nil;
       end;


    function skiploop(up, dn : tokenkinds) : boolean;
       label 1;
       var
          i : integer;
          saveline : lineptr;
       begin
          saveline := stmtline;
          i := 0;
          repeat
             while t = nil do
                begin
                   if (stmtline = nil) or (stmtline^.next = nil) then
                      begin
                         skiploop := false;
                         stmtline := saveline;
                         goto 1;
                      end;
                   stmtline := stmtline^.next;
                   t := stmtline^.txt;
                end;
             if t^.kind = up then
                i := i + 1;
             if t^.kind = dn then
                i := i - 1;
             t := t^.next;
          until i < 0;
          skiploop := true;
      1 :
       end;


    procedure cmdfor;
       var
          l : loopptr;
          lr : looprec;
          saveline : lineptr;
          i, j : integer;
       begin
          getvar(lr.ref);
          if lr.ref.kind<>vNumber then snerr;
          require(tokeq);
          _assignfloat2valref(lr.ref,realexpr);
          require(tokto);
          lr.max := realexpr;
          if (t <> nil) and (t^.kind = tokstep) then
             begin
                t := t^.next;
                lr.step := realexpr;
             end
          else
             lr.step := 1;
          lr.homeline := stmtline;
          lr.hometok := t;
          lr.kind := forloop;
          lr.next := loopbase;
          with lr do
             if ((step >= 0) and (_valref2float(ref) > max)) or ((step <= 0) and (_valref2float(ref) < max)) then
                begin
                   saveline := stmtline;
                   i := 0;
                   j := 0;
                   repeat
                      while t = nil do
                         begin
                            if (stmtline = nil) or (stmtline^.next = nil) then
                               begin
                                  stmtline := saveline;
                                  errormsg('FOR without NEXT');
                               end;
                            stmtline := stmtline^.next;
                            t := stmtline^.txt;
                         end;
                      if t^.kind = tokfor then
                         if (t^.next <> nil) and (t^.next^.kind = tokvar) and valrefMaps(ref,t^.next^.vp^) then
                            j := j + 1
                         else
                            i := i + 1;
                      if (t^.kind = toknext) then
                         if (t^.next <> nil) and (t^.next^.kind = tokvar) and valrefMaps(ref,t^.next^.vp^) then
                            j := j - 1
                         else
                            i := i - 1;
                      t := t^.next;
                   until (i < 0) or (j < 0);
                   skiptoeos;
                end
             else
                begin
                   new(l);
                   FillChar(l^,sizeof(l^),0);
                   l^ := lr;
                   loopbase := l;
                end;
       end;


    procedure cmdnext;
       var
          v : varptr;
          found : boolean;
          l : loopptr;
       begin
          if not iseos then
             v := findvar
          else
             v := nil;
          repeat
             if (loopbase = nil) or (loopbase^.kind = gosubloop) then
                errormsg('NEXT without FOR');
             found := (loopbase^.kind = forloop) and
                      ((v = nil) or valrefMaps(loopbase^.ref,v^));
             if not found then
                begin
                   l := loopbase^.next;
                   dispose(loopbase);
                   loopbase := l;
                end;
          until found;
          with loopbase^ do
             begin
                _assignfloat2valref(ref,_valref2float(ref) + step);
                if ((step >= 0) and (_valref2float(ref) > max)) or ((step <= 0) and (_valref2float(ref) < max)) then
                   begin
                      l := loopbase^.next;
                      dispose(loopbase);
                      loopbase := l;
                   end
                else
                   begin
                      stmtline := homeline;
                      t := hometok;
                   end;
             end;
       end;


    procedure cmdwhile;
       var
          l : loopptr;
       begin
          new(l);
          FillChar(l^,sizeof(l^),0);
          l^.next := loopbase;
          loopbase := l;
          l^.kind := whileloop;
          l^.homeline := stmtline;
          l^.hometok := t;
          if not iseos then
             if realexpr = 0 then
                begin
                   if not skiploop(tokwhile, tokwend) then
                      errormsg('WHILE without WEND');
                   l := loopbase^.next;
                   dispose(loopbase);
                   loopbase := l;
                   skiptoeos;
                end;
       end;


    procedure cmdwend;
       var
          tok : tokenptr;
          tokline : lineptr;
          l : loopptr;
          found : boolean;
       begin
          repeat
             if (loopbase = nil) or (loopbase^.kind = gosubloop) then
                errormsg('WEND without WHILE');
             found := (loopbase^.kind = whileloop);
             if not found then
                begin
                   l := loopbase^.next;
                   dispose(loopbase);
                   loopbase := l;
                end;
          until found;
          if not iseos then
             if realexpr <> 0 then
                found := false;
          tok := t;
          tokline := stmtline;
          if found then
             begin
                stmtline := loopbase^.homeline;
                t := loopbase^.hometok;
                if not iseos then
                   if realexpr = 0 then
                      found := false;
             end;
          if not found then
             begin
                t := tok;
                stmtline := tokline;
                l := loopbase^.next;
                dispose(loopbase);
                loopbase := l;
             end;
       end;


    procedure cmdgosub;
       var
          l : loopptr;
       begin
          new(l);
          FillChar(l^,sizeof(l^),0);
          l^.next := loopbase;
          loopbase := l;
          l^.kind := gosubloop;
          l^.homeline := stmtline;
          l^.hometok := t;
          cmdgoto;
       end;


    procedure cmdreturn;
       var
          l : loopptr;
          found : boolean;
       begin
          repeat
             if loopbase = nil then
                errormsg('RETURN without GOSUB');
             found := (loopbase^.kind = gosubloop);
             if not found then
                begin
                   l := loopbase^.next;
                   dispose(loopbase);
                   loopbase := l;
                end;
          until found;
          stmtline := loopbase^.homeline;
          t := loopbase^.hometok;
          l := loopbase^.next;
          dispose(loopbase);
          loopbase := l;
          skiptoeos;
       end;


    procedure cmdread;
       var
          v : valref;
          tok : tokenptr;
          found : boolean;
       begin
          repeat
             getvar(v);
             tok := t;
             t := datatok;
             if dataline = nil then
                begin
                   dataline := linebase;
                   t := dataline^.txt;
                end;
             if (t = nil) or (t^.kind <> tokcomma) then
                repeat
                   while t = nil do
                      begin
                         if (dataline = nil) or (dataline^.next = nil) then
                            errormsg('Out of Data');
                         dataline := dataline^.next;
                         t := dataline^.txt;
                      end;
                   found := (t^.kind = tokdata);
                   t := t^.next;
                until found and not iseos
             else
                t := t^.next;

             case v.kind of
             vString: _assignstring2valref(v,strexpr);
             vNumber: _assignfloat2valref(v,realexpr);
             else assert(false)
             end;
             datatok := t;
             t := tok;
             if not iseos then
                require(tokcomma);
          until iseos;
       end;


    procedure cmddata;
       begin
          skiptoeos;
       end;


    procedure cmdrestore;
       begin
          if iseos then
             restoredata
          else
             begin
                dataline := mustfindline(intexpr);
                datatok := dataline^.txt;
             end;
       end;


    procedure cmdon;
       var
          i : integer;
          l : loopptr;
       begin
          i := intexpr;
          if (t <> nil) and (t^.kind = tokgosub) then
             begin
                new(l);
                FillChar(l^,sizeof(l^),0);
                l^.next := loopbase;
                loopbase := l;
                l^.kind := gosubloop;
                l^.homeline := stmtline;
                l^.hometok := t;
                t := t^.next;
             end
          else
             require(tokgoto);
          if i < 1 then
             skiptoeos
          else
             begin
                while (i > 1) and not iseos do
                   begin
                      require(toknum);
                      if not iseos then
                         require(tokcomma);
                      i := i - 1;
                   end;
                if not iseos then
                   cmdgoto;
             end;
       end;


    procedure cmddim;
       var
          i, j, k : integer;
          v : varptr;
          done : boolean;
       begin
          repeat
             if (t = nil) or (t^.kind <> tokvar) then snerr;
             v := t^.vp;
             t := t^.next;
             with v^ do
                begin
                   if numdims <> 0 then
                      errormsg('Array already dimensioned');
                   j := 1;
                   i := 0;
                   require(toklp);
                   repeat
                      k := intexpr + 1;
                      if k < 1 then badsubscr;
                      if i >= maxdims then badsubscr;
                      i := i + 1;
                      dims[i] := k;
                      j := j * k;
                      done := (t <> nil) and (t^.kind = tokrp);
                      if not done then
                         require(tokcomma);
                   until done;
                   t := t^.next;
                   numdims := i;

                   case kind of
                   vNumber:
                    begin
                     GetMem(num.base,j*sizeof(float));
                     FillChar(num.base^,j*sizeof(float),0)
                    end;

                   vString:
                    begin
                     GetMem(str.base,j*sizeof(basicstring));
                     FillChar(str.base^,j*sizeof(basicstring),0)
                    end;

                   else assert(false)
                   end;
                end;
             if not iseos then
                require(tokcomma);
          until iseos;
       end;

       procedure cmddef;
       var func:funcrecptr;
       var tok:tokenptr;
       begin
        if (t=nil) or (t^.kind<>tokvar) then snerr;

        tok:=t;
        t:=t^.next;

        require(toklp);

        GetMem(func,sizeof(funcrec));
        FillChar(func^,sizeof(funcrec),0);
        try
         if (t<>nil) and (t^.kind=tokrp) then
          t:=t^.next
         else begin
          while true do begin
           inc(func^.numdims);
           getvar(func^.dims[func^.numdims]);
           if (t<>nil) and (t^.kind=tokrp) then begin
            t:=t^.next;
            break
           end;
           require(tokcomma)
          end
         end;

         require(tokeq);

         func^.tok:=t;
         if tok^.vp^.func<>nil then
          FreeMem(tok^.vp^.func);
         tok^.vp^.func:=func
        except
         FreeMem(func);
         raise
        end;

        skiptoeos
       end;

       procedure cmdcommon;
       var v:varptr;
       var i:integer;
       begin
         repeat
           if (t = nil) or (t^.kind <> tokvar) then snerr;
           v := t^.vp;
           t := t^.next;

           i:=Commons.IndexOf(v^.name);
           if i<0 then
             Commons.Add(UpperCase(v^.name));
           initvarfromenv(v);

           if not iseos then
             require(tokcomma);
         until iseos
       end;

       procedure cmddeclare;
       { Declare Sub name <Lib "libname" [Alias "aliasname"]|Shell "command"> [([arglist])]

         Declare Function name <Lib "libname" [Alias "aliasname"]|Shell "command"> [([arglist])] [As type]
       }
       var funcName:string;
       var libName:string;
       var aliasName:string;
       var isFunc:boolean;
       var descriptor:ArrayOfValueKind;

       var ref:integer;
       var kind:integer;

        function Ident:string;
        begin
         if (t<>nil) and (t^.kind=tokvar) then begin
          Result:=t^.vp^.name;
          t:=t^.next
         end else if (t<>nil) and (t^.kind=tokfunc) then begin
          Result:=FFuncs[FFuncs.IndexOfObject(TObject(t^.fi))];
          t:=t^.next
         end else begin
          Result:='';
          snerr
         end
        end;

        procedure FetchAs;
        begin
         requireKeyword('AS');

         if keyword('STRING') then
          kind:=vkString
         else
         if keyword('LONG') or keyword('INTEGER') then
          kind:=vkInteger
         else
          snerr;
        end;

       var isShell:boolean;
       var cmdFormat:string;
       begin
          isFunc:=keyword('FUNCTION');
	  if not isFunc then requireKeyword('SUB');

          funcName:=Ident;

          if keyword('SHELL') then begin
           isShell:=true;
           cmdFormat:=strexpr
          end else begin
           isShell:=false;
           requireKeyword('LIB');

           libName:=strexpr;

           if keyword('ALIAS') then
            aliasName:=strexpr
           else
            aliasName:=funcName;
          end;

          descriptor:='';

          if (t<>nil) and (t^.kind=toklp) then begin
           t:=t^.next;
           while (t<>nil) and (t^.kind<>tokrp) do begin
            if descriptor<>'' then require(tokcomma);

            { [BYREF|BYVAL] Ident AS String|Long }
            if keyword('BYVAL') then
             ref:=vkByVal
            else
            if keyword('BYREF') then
             ref:=vkByRef
            else
             ref:=vkByVal;   // TODO: default parameter passing

            Ident;
            FetchAs;

            if (ref=vkByVal) and (kind=vkString) then
             kind:=vkPChar;

            descriptor:=descriptor+chr(kind or ref)
           end;
           if t<>nil then t:=t^.next
          end;

          if isFunc then
           FetchAs
          else
           kind:=vkNone;

          if not iseos then snerr;

          if isShell then
           MapShell(funcName,kind,descriptor,cmdFormat)
          else
           MapLib(funcName,kind or vkStdCall,descriptor,libName,aliasName)
       end;

    procedure finalerror;
    begin
      if Assigned(FPrint) then
      begin
        if stmtline <> nil then
          FPrint(Self, ' in '+IntTostr(stmtline^.num));
        FPrint(Self, #13#10);
      end;

//     if stmtline <> nil then
//       write(output^,' in ', stmtline^.num:1);
//     writeln(output^);
    end;

    begin {exec}
       try
          repeat
             repeat
                gotoflag := false;
                elseflag := false;
                while (stmttok <> nil) and (stmttok^.kind = tokcolon) do
                   stmttok := stmttok^.next;
                t := stmttok;
                if t <> nil then
                   begin
                      CheckBreak;
                      t := t^.next;
                      case stmttok^.kind of
                         tokrem     : ;
                         tokfunc    : CallProcedure(stmttok^.fi);
                         toklist    : cmdlist;
                         tokrun     : cmdrun;
                         toknew     : cmdnew;
                         tokload    : cmdload(false, strexpr);
                         tokmerge   : cmdload(true, strexpr);
                         toksave    : cmdsave(strexpr);
                         tokbye     : cmdbye;
                         tokdel     : cmddel;
                         tokrenum   : cmdrenum;
                         tokdeclare : cmddeclare;
                         toklet     : cmdlet(false);
                         tokvar     : cmdlet(true);
                         tokprint   : cmdprint;
                         tokinput   : cmdinput;
                         tokgoto    : cmdgoto;
                         tokif      : cmdif;
                         tokelse    : cmdelse;
                         tokend     : cmdend;
                         tokstop    : escape(-20,'Break');
                         tokfor     : cmdfor;
                         toknext    : cmdnext;
                         tokwhile   : cmdwhile;
                         tokwend    : cmdwend;
                         tokgosub   : cmdgosub;
                         tokreturn  : cmdreturn;
                         tokread    : cmdread;
                         tokdata    : cmddata;
                         tokrestore : cmdrestore;
                         tokon      : cmdon;
                         tokcommon  : cmdcommon;
                         tokdim     : cmddim;
                         tokdef     : cmddef;
                      else
                         errormsg('Illegal command');
                      end;
                   end;
                if not elseflag and not iseos then
                   checkextra;
                stmttok := t;
             until t = nil;
             if stmtline <> nil then
                begin
                   if not gotoflag then
                      stmtline := stmtline^.next;
                   if stmtline <> nil then
                      stmttok := stmtline^.txt;
                end;
          until stmtline = nil;
       except
         on EAbort do raise;
         on e:EBasic do begin
//           Write(output^,#7,'(',e.escapecode,') ',e.Message);
           if Assigned(FPrint) then
             FPrint(Self, Format('(%d) %s',[e.escapecode,e.Message]));

           { TODO: -20 - break, 42 = handled error }
           finalerror
          end;

          on e:Exception do begin
//           write(output^,#7,e.Message);
           if Assigned(FPrint) then
             FPrint(Self, e.Message);
           finalerror
          end;

       end
    end; {exec}
//--------------------------------------------------------------------
const CRLF=#13#10;
const prompt='READY'; //'Ok'

procedure TBasic.Run;
var noinput:boolean;
var p:integer;
var cmd:string;

 function Cut:string;
 label loop;
 begin
  loop:
  p:=Pos(CRLF,cmd);
  if p=0 then begin
   Result:=cmd;
   cmd:=''
  end else begin
   Result:=Copy(cmd,1,p-1);
   Delete(cmd,1,p+length(CRLF)-1)
  end;
  if Result='' then if cmd<>'' then goto loop
 end;

begin {main}
    if output <> nil then
      with TTextRec(output^) do
        Flags := Flags or tfCRLF;

    cmd:=ACommand;
    inbuf:=Cut;
    noinput:=inbuf<>'';
    clearloops;
    clearvars;
    exitflag := false;
    repeat
       try
          repeat
             if inbuf='' then begin
              inbuf:=Cut;
              if inbuf='' then begin
               if noinput then begin
                exitflag:=true;
                break
               end;
//               writeln(output^,prompt);
               if Assigned(FPrint) then
                 FPrint(Self, prompt);
               if eof(input^) then begin
                exitflag:=true;
                break;
               end;
               readln(input^,inbuf);
              end
             end;
             parseinput(buf);
             if curline = 0 then
                begin
                   stmtline := nil;
                   stmttok := buf;
                   if stmttok <> nil then
                      exec;
                   disposetokens(buf);
                end;
             inbuf:=''
          until exitflag;
       except
         on EAbort do raise;
         on e:Exception do begin
          { TODO:
          if escapecode <> -20 then
             misc_printerror(escapecode, ioresult)
          else  }
//           writeln(output^,#7,e.Message);
          if Assigned(FPrint) then
            FPrint(Self, e.Message);
         end
       end;
       inbuf:=''
    until exitflag;
end;

procedure TBasic.Chat;
begin {main}
    exitflag := false;
    repeat
       try
          repeat
//             writeln(output^,prompt);
             if Assigned(FPrint) then
               FPrint(Self, prompt);
             if eof(input^) then break;
             readln(input^,inbuf);
             parseinput(buf);
             if curline = 0 then
                begin
                   stmtline := nil;
                   stmttok := buf;
                   if stmttok <> nil then
                      exec;
                   disposetokens(buf);
                end;
          until exitflag;
       except
         on EAbort do raise;
         on e:Exception do begin
          { TODO:
          if escapecode <> -20 then
             misc_printerror(escapecode, ioresult)
          else  }
//           writeln(output^,#7,e.Message);
          if Assigned(FPrint) then
            FPrint(Self, e.Message);
         end
       end;
    until exitflag;
end;

function TBasic.ExpandFileName;
begin
 if Assigned(FOnGetFileName) then
  Result:=FOnGetFileName(Self,fileName,new)
 else
  if ExtractFileExt(fileName)='' then
   Result:=fileName+'.BAS'
  else
   Result:=fileName
end;

procedure TBasic.LoadFromFile;
begin
 cmdload(false,fileName)
end;

procedure TBasic.SaveToFile;
begin
 cmdsave(fileName)
end;

end.
