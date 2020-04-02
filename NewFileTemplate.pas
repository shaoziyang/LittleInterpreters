const

  NewCFileTemplate: string = (
  'for(int i = 0; i < 10; i++) {' + #13#10 +
  '    print(i, '' '');' + #13#10 +
  '    sleep(100);' + #13#10 +
  '}'
    );

  NewPasFileTemplate: string = (
  'program newfile;' + #13#10 +
  'var' + #13#10 +
  '  i: integer;' + #13#10#13#10 +
  '  procedure f1;' + #13#10 +
  '  begin' + #13#10#13#10 +
  '  end;' + #13#10#13#10 +
  'begin' + #13#10 +
  '  print([1, 1+2 * 3.4 / 5, ''Hello''])' + #13#10 +
  'end.' 
    );

  NewBasFileTemplate: string = (
  '10 FOR i = 1 TO 10' + #13#10 +
  '20 PRINT i;' + #13#10 +
  '30 NEXT i' + #13#10 +
  '40 PRINT'
    );
