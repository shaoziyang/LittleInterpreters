object FormBasicManual: TFormBasicManual
  Left = 0
  Top = 0
  BorderStyle = bsSizeToolWin
  Caption = 'Basic Manual'
  ClientHeight = 558
  ClientWidth = 652
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object SynEditBasicManual: TSynEdit
    Left = 0
    Top = 0
    Width = 652
    Height = 558
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    TabOrder = 0
    Gutter.Font.Charset = DEFAULT_CHARSET
    Gutter.Font.Color = clWindowText
    Gutter.Font.Height = -11
    Gutter.Font.Name = 'Courier New'
    Gutter.Font.Style = []
    Gutter.Visible = False
    Highlighter = SynVBSyn
    Lines.Strings = (
      ''
      '                             Chipmunk BASIC 1.0'
      '                               David Gillespie'
      ''
      ''
      
        '       ---------------------------------------------------------' +
        '-----'
      ''
      ''
      ''
      ''
      '   COMMANDS'
      ''
      ''
      '      LIST line(s)'
      ''
      '         List the specified program lines.  For example,'
      ''
      '               LIST 10, 100-200'
      ''
      '         lists line 10, and lines 100 through 200, inclusive.'
      ''
      ''
      '      RUN [line]'
      ''
      
        '         Begin execution of the program at the first line, or at' +
        ' the'
      '         specified line.  All variables are cleared.'
      ''
      ''
      '      RUN file[,line]'
      ''
      '         Load and run a program.  For example,'
      ''
      '               RUN "FOO", 30'
      ''
      
        '         loads a program from the file FOO.TEXT and begins execu' +
        'tion at'
      '         line 30.'
      ''
      ''
      '      NEW'
      ''
      '         Erase the program in memory.'
      ''
      ''
      '      LOAD file'
      ''
      
        '         Load a program into memory.  The program previously in ' +
        'memory is'
      
        '         erased.  The file name should be in quotes; a .TEXT ext' +
        'ension is'
      
        '         automatically added.  Files contain ASCII listings of t' +
        'he programs.'
      
        '         All lines in the file must begin with a line number, bu' +
        't line'
      '         numbers do not need to be in increasing order.'
      ''
      ''
      '      MERGE file'
      ''
      
        '         Load a program into memory.  The previous program remai' +
        'ns in'
      
        '         memory; if a line exists in both programs, the newly lo' +
        'aded'
      '         line is kept.'
      ''
      ''
      '      SAVE file'
      ''
      '         Save the program in memory to a file.'
      ''
      ''
      '      BYE'
      ''
      '         Return to the operating system.'
      ''
      ''
      '      DEL line(s)'
      ''
      
        '         Delete the specified program lines.  Line numbers may b' +
        'e'
      
        '         separated by commas and dashes as in LIST.  If used ins' +
        'ide'
      
        '         a program, DEL will terminate execution only if it dele' +
        'tes'
      '         the line on which it appears.'
      ''
      ''
      '      RENUM [start[,inc]]'
      ''
      
        '         Renumber program lines.  By default, the new sequence i' +
        's 10,20,30,...'
      
        '         The first argument is a new initial line number; the se' +
        'cond argument'
      '         is the increment between line numbers.'
      ''
      ''
      ''
      ''
      '   STATEMENTS'
      ''
      '      REM comment'
      ''
      
        '         A remark; ignored.  Comments may contain any characters' +
        ' except'
      
        '         that REM can not be immediately followed by an alphanum' +
        'eric'
      '         character.'
      ''
      ''
      '      [LET] var = expr'
      ''
      
        '         Assign a value to a variable.  Variable names contain u' +
        'p to 20'
      
        '         significant characters, consisting of upper- and lower-' +
        'case'
      
        '         letters, digits, underscores, and dollar signs.  Variab' +
        'le names'
      
        '         are case-sensitive.  Variables hold real numbers normal' +
        'ly, or'
      
        '         strings of up to 255 characters if their names end with' +
        ' $.'
      ''
      '         Examples:'
      ''
      '               LET X=20'
      '               X$="FOO"'
      '               X$=X$+"BAR"'
      ''
      ''
      '      DIM var(dimensions), ...'
      ''
      
        '         Allocate memory for arrays.  Arrays may have up to 4 di' +
        'mensions,'
      
        '         ranging from 0 to the value specified in the DIM statem' +
        'ent.'
      
        '         The same name must not be used for both a simple variab' +
        'le and'
      '         an array.'
      ''
      
        '         If an array is used before it is dimensioned, each dime' +
        'nsion'
      '         is set to 10.'
      ''
      '         Example:'
      ''
      '               INPUT "How many elements? "; x'
      '               DIM array(x,1)'
      
        '               FOR i=1 TO x : INPUT array(i,0), array(i,1) : NEX' +
        'T'
      ''
      ''
      '      PRINT items'
      ''
      
        '         Print the items on the screen.  Items may be either num' +
        'eric'
      
        '         or string expressions, and may be separated by commas, ' +
        'semicolons,'
      '         or nothing.'
      ''
      
        '         Numbers are normally terminated by spaces.  To avoid th' +
        'is space,'
      '         convert the number to a string with STR$.'
      ''
      
        '         The line is terminated by a CR/LF, unless the item list' +
        ' ends'
      '         with a comma or semicolon.'
      ''
      '         The word PRINT may be abbreviated as a question mark.'
      ''
      '         Examples:'
      ''
      '               PRINT "1+2=", 1+2'
      '               PRINT X$ "=" Z$;'
      '               ? x; y+z'
      ''
      ''
      '      INPUT [prompt;] vars'
      ''
      
        '         If a prompt string is given, it is printed.  Otherwise,' +
        ' a'
      
        '         question mark is printed.  The computer then waits for ' +
        'values'
      
        '         for each variable to be entered.  If several variables ' +
        'are'
      '         listed, their names must be separated by commas.'
      ''
      
        '         If the variables are numeric, their values may be enter' +
        'ed'
      
        '         on separate lines, or combined with commas.  Any numeri' +
        'c expression'
      '         is a valid response.'
      ''
      
        '         If the variables are strings, each string is typed on a' +
        ' separate'
      
        '         line.  The characters typed are copied verbatim into th' +
        'e string.'
      ''
      
        '         String and numeric variables may be not mixed in a sing' +
        'le'
      '         INPUT statement.'
      ''
      '         Examples:'
      ''
      '            INPUT X$'
      '            INPUT "Type 3 numbers: "; X, Y, Z'
      ''
      ''
      '      GOTO line'
      ''
      
        '         Begin executing statements at the specified line.  The ' +
        'line'
      '         number may be any numeric expression.'
      ''
      
        '         The word GO TO may be used instead of GOTO if preferabl' +
        'e.'
      ''
      ''
      '      IF condition THEN line/statements ELSE line/statements'
      ''
      
        '         If the condition is true (i.e., the numeric expression ' +
        'has a'
      
        '         non-zero value), the statements following the word THEN' +
        ' are'
      '         executed.  Otherwise, the statements following ELSE are'
      
        '         executed.  If there is no ELSE clause, execution procee' +
        'ds'
      '         to the next line in the program.'
      ''
      
        '         A line number may be used after either THEN or ELSE, fo' +
        'r an'
      '         implied GOTO statement.'
      ''
      ''
      '      END'
      ''
      
        '         Terminate the program.  An END statement is not require' +
        'd.'
      ''
      ''
      '      STOP'
      ''
      
        '         Terminate the program with an identifying "Break" messa' +
        'ge.'
      ''
      ''
      '      FOR var = first TO last [STEP inc]'
      '      {statements}'
      '      NEXT [var]'
      ''
      
        '         Execute {statements} repeatedly while the variable coun' +
        'ts from'
      
        '         "first" to "last," incrementing by 1, or by the STEP va' +
        'lue if'
      
        '         given.  If the STEP value is negative, the variable cou' +
        'nts'
      '         downward.'
      ''
      
        '         If "first" is greater than "last" (or less than if STEP' +
        ' is'
      
        '         negative), execution proceeds directly to the NEXT stat' +
        'ement,'
      '         without executing the body of the loop at all.'
      ''
      '         The variable name is optional on the NEXT statement.'
      ''
      ''
      '      WHILE [condition]'
      '      {statements}'
      '      WEND [condition]'
      ''
      
        '         Execute {statements} repeatedly until the WHILE conditi' +
        'on (if'
      
        '         given) becomes false, or until the WEND condition becom' +
        'es true.'
      
        '         This structure can emulate Pascal'#39's WHILE-DO and REPEAT' +
        '-UNTIL,'
      
        '         or even both at once.  If no conditions are given, the ' +
        'loop will'
      '         never terminate unless the Evil GOTO is used.'
      ''
      ''
      '      GOSUB line'
      '      RETURN'
      ''
      
        '         Execute the statements beginning at the specified line,' +
        ' then'
      
        '         when RETURN is reached, return to the statement followi' +
        'ng the'
      '         GOSUB.'
      ''
      ''
      '      READ vars'
      '      DATA values'
      '      RESTORE line'
      ''
      
        '         Read numeric or string values from the DATA statements.' +
        '  Reading'
      
        '         begins at the first DATA statement in the program and p' +
        'roceeds'
      
        '         to the last.  Reading past the end the last DATA statem' +
        'ent'
      '         generates an error.'
      ''
      
        '         The DATA values must be either numeric or string expres' +
        'sions,'
      
        '         according to the type of variable being read.  Reading ' +
        'the wrong'
      '         kind of expression produces a Syntax Error.'
      ''
      
        '         The RESTORE statement causes the next READ to re-use th' +
        'e first'
      
        '         DATA statement in the program, or the first DATA statem' +
        'ent on'
      '         or after a particular line.'
      ''
      ''
      '      ON expr GOTO line, line, ...'
      '      ON expr GOSUB line, line, ...'
      ''
      
        '         If the expression'#39's value, rounded to an integer, is N,' +
        ' go to'
      
        '         the Nth line number in the list.  If N is less than one' +
        ' or is'
      
        '         too large, execution continues at the next statement af' +
        'ter'
      '         the ON-GOTO or ON-GOSUB.'
      ''
      ''
      ''
      '   NUMERIC EXPRESSIONS'
      ''
      '      x AND y'
      ''
      '         Logical AND of two integers.'
      ''
      ''
      '      x OR y'
      ''
      '         Logical OR of two integers.'
      ''
      ''
      '      x XOR y'
      ''
      '         Logical XOR of two integers.'
      ''
      ''
      '      NOT x'
      ''
      '         Logical complement of an integer.'
      ''
      ''
      '      INT x'
      ''
      ''
      '      x+y, x-y, x*y, x/y, x^y, -x'
      ''
      '         Typical floating-point arithmetic operations.'
      ''
      ''
      '      x=y, x<y, x>y, x<=y, x>=y, x<>y'
      ''
      '         Comparisons; result is 1 if true, 0 if false.'
      ''
      ''
      '      x MOD y'
      ''
      '         Modulo of two integers.'
      ''
      ''
      '      SQR x'
      ''
      
        '         Square of X.  Note that parentheses are not required if' +
        ' a function'#39's'
      
        '         argument is a single entitity; for example, SQR SIN X n' +
        'eeds no'
      '         parentheses, but SQR(1+X) does.'
      ''
      ''
      '      SQRT x'
      ''
      '         Square root of X.'
      ''
      ''
      '      SIN x, COS x, TAN x, ARCTAN x'
      ''
      '         Typical trig functions, in radians.'
      ''
      ''
      '      LOG x, EXP x'
      ''
      '         Natural logarithm, and e the power X.'
      ''
      ''
      '      ABS x'
      ''
      '         Absolute value of X.'
      ''
      ''
      '      SGN x'
      ''
      
        '         Sign of X:  1 if X is positive, 0 if zero, -1 if negati' +
        've.'
      ''
      ''
      '      VAL x$'
      ''
      
        '         Value of the expression contained in the string X$.  Fo' +
        'r example,'
      
        '         VAL "1+2" yields 3.  X$ may be a single string literal,' +
        ' variable,'
      '         or function, or a string expression in parentheses.'
      ''
      ''
      '      ASC x$'
      ''
      
        '         ASCII code of the first character in X$, or 0 if X$ is ' +
        'null.'
      ''
      ''
      '      LEN x$'
      ''
      '         Number of characters in X$.'
      ''
      ''
      '      Precedence:      Parentheses'
      '                        Functions  (incl. NOT and unary minus)'
      '                            ^'
      '                        *, /, MOD'
      '                          +, -'
      '                   =, <, >, <=, >=, <>'
      '                           AND'
      '                         OR, XOR'
      ''
      ''
      ''
      '   STRING EXPRESSIONS'
      ''
      '      "string" or '#39'string'#39
      ''
      
        '         String literal.  Single quotes are converted to double ' +
        'quotes'
      '         internally.'
      ''
      ''
      '      x$+y$'
      ''
      '         Concatenation.  Result must be 255 characters or less.'
      ''
      ''
      '      x$=y$, x$<y$, x$>y$, x$<=y$, x$>=y$, x$<>y$'
      ''
      '         String comparisons; result is 1 if true, 0 if false.'
      ''
      ''
      '      STR$(x)'
      ''
      
        '         The number X expressed as a string of digits.  No leadi' +
        'ng or'
      
        '         trailing spaces are included; scientific notation is us' +
        'ed'
      
        '         if the absolute values is greater than 1E12 or less tha' +
        'n 1E-2.'
      ''
      ''
      '      CHR$(x)'
      ''
      '         The character whose ASCII code is X.'
      ''
      ''
      '      MID$(x$, y)'
      '      MID$(x$, y, z)'
      ''
      
        '         (Parentheses required.)  The substring consisting of th' +
        'e first'
      
        '         Z characters starting at position Y of string X$.  Posi' +
        'tion 1'
      
        '         is the first character of the string.  If Z is omitted,' +
        ' 255'
      '         is used, i.e., the entire right part of the string.'
      ''
      ''
      '      LEFT$(x$, y)'
      ''
      '         same as MID$(x$, 1, y)'
      ''
      '   CONVENTIONS'
      ''
      
        '      Multiple statements may be written on a line, separated by' +
        ' colons:'
      ''
      '            10 INPUT X : PRINT X : STOP'
      ''
      ''
      
        '      There is actually no difference between commands and state' +
        'ments;'
      
        '      both can be used in or out of programs at will.  Certain c' +
        'ommands,'
      '      such as NEW, will, of course, halt program execution.'
      ''
      ''
      '      Line numbers may be any integer from 1 to MAXINT.'
      ''
      ''
      '      To delete a line use DEL, or type its line number alone:'
      ''
      '            10'
      ''
      ''
      
        '      Press CLR I/O to halt program execution.  [This is not sup' +
        'ported'
      
        '      by p2c'#39's translation!]  To leave BASIC, use the BYE comman' +
        'd.'
      ''
      ''
      
        '      Keywords must be written in all upper- or all lower-case; ' +
        'they are'
      
        '      always converted to upper-case internally.  Spaces are ign' +
        'ored in'
      
        '      the input except between quotes.  Square brackets are conv' +
        'erted to'
      
        '      parentheses.  Missing closing quotes at the end of the lin' +
        'e are'
      '      added, as in the command:'
      ''
      '            SAVE "PROGRAM'
      ''
      ''
      '')
    ReadOnly = True
    ExplicitLeft = 8
    ExplicitTop = -8
    ExplicitWidth = 642
  end
  object SynVBSyn: TSynVBSyn
    Left = 184
    Top = 104
  end
end
