{ *********************************************************************** }
{                                                                         }
{ ParseConsts                                                             }
{                                                                         }
{ Copyright (c) 2006 Pisarev Yuriy (post@pisarev.net)                     }
{                                                                         }
{ *********************************************************************** }

unit ParseConsts;

{$B-}

interface

uses
  SysUtils, ParseTypes, TextConsts;

type
  TTextOperator = (toNegative, toPositive);
  TParameterOperator = (poComma, poSemicolon);
  TBracketType = (btParenthesis, btBracket, btBrace);

const
  NumberCode = Ord(icNumber);
  FunctionCode = Ord(icFunction);
  StringCode = Ord(icString);
  ScriptCode = Ord(icScript);
  ParameterCode = Ord(icParameter);

  TOperatorArray: array[TTextOperator] of string = (Minus, Plus);
  POperatorArray: array[TParameterOperator] of string = (Comma, Semicolon);
  BracketArray: array[TBracketType] of TBracket = (LeftParenthesis + RightParenthesis, LeftBracket + RightBracket, LeftBrace + RightBrace);
  ParameterPrefix = '#';
  DelimiterArray = Blanks + [Plus, Minus, LeftParenthesis, RightParenthesis, LeftBracket, RightBracket, LeftBrace, RightBrace, Quote, DoubleQuote];

  InternalFunctionName = LeftBrace;
  MinusFunctionName = Minus;
  PlusFunctionName = Plus;

  VoidFunctionName = 'Void';
  NewFunctionName = 'New';
  NewMinParameterCount = 2;
  NewMaxParameterCount = 3;
  DeleteFunctionName = 'Delete';
  DeleteParameterCount = 1;
  FindFunctionName = 'Find';
  FindParameterCount = 1;
  GetFunctionName = 'Get';
  GetParameterCount = 1;
  SetFunctionName = 'Set';
  SetParameterCount = 2;
  ScriptFunctionName = 'Script';
  ScriptMinParameterCount = 1;
  ScriptMaxParameterCount = MaxInt;
  ForFunctionName = 'For';
  ForParameterCount = 4;
  RepeatFunctionName = 'Repeat';
  RepeatParameterCount = 2;
  WhileFunctionName = 'While';
  WhileParameterCount = 2;
  MultiplyFunctionName = '*';
  DivideFunctionName = '/';
  SuccFunctionName = 'Succ';
  PredFunctionName = 'Pred';
  BitwiseNegationFunctionName = 'not';
  BitwiseAndFunctionName = 'and';
  BitwiseOrFunctionName = 'or';
  BitwiseXorFunctionName = 'xor';
  BitwiseShiftLeftFunctionName = 'shl';
  BitwiseShiftRightFunctionName = 'shr';
  SameValueFunctionName = 'SameValue';
  SameValueMinParameterCount = 2;
  SameValueMaxParameterCount = 3;
  IsZeroFunctionName = 'IsZero';
  IsZeroMinParameterCount = 1;
  IsZeroMaxParameterCount = 2;
  IfFunctionName = 'If';
  IfMinParameterCount = 2;
  IfMaxParameterCount = 3;
  IfThenFunctionName = 'IfThen';
  IfThenParameterCount = 3;
  EnsureRangeFunctionName = 'EnsureRange';
  EnsureRangeParameterCount = 3;
  StrToIntFunctionName = 'StrToInt';
  StrToIntParameterCount = 1;
  StrToIntDefFunctionName = 'StrToIntDef';
  StrToIntDefParameterCount = 2;
  StrToFloatFunctionName = 'StrToFloat';
  StrToFloatParameterCount = 1;
  StrToFloatDefFunctionName = 'StrToFloatDef';
  StrToFloatDefParameterCount = 2;
  ParseFunctionName = 'Parse';
  ParseMinParameterCount = 1;
  ParseMaxParameterCount = 2;
  FalseFunctionName = 'False';
  TrueFunctionName = 'True';
  EqualFunctionName = '=';
  NotEqualFunctionName = '<>';
  AboveFunctionName = '>';
  BelowFunctionName = '<';
  AboveOrEqualFunctionName = '>=';
  BelowOrEqualFunctionName = '<=';
  GetEpsilonFunctionName = 'GetEpsilon';
  SetEpsilonFunctionName = 'SetEpsilon';
  SetEpsilonParameterCount = 1;
  SetDecimalSeparatorFunctionName = 'SetDecimalSeparator';
  SetDecimalSeparatorParameterCount = 1;
  IntegerDivideFunctionName = 'div';
  ReminderFunctionName = 'mod';
  DegreeFunctionName = '^';
  FactorialFunctionName = '!';
  SqrFunctionName = 'Sqr';
  SqrtFunctionName = 'Sqrt';
  IntFunctionName = 'Int';
  RoundFunctionName = 'Round';
  RoundToFunctionName = 'RoundTo';
  RoundToParameterCount = 2;
  TruncFunctionName = 'Trunc';
  AbsFunctionName = 'Abs';
  FracFunctionName = 'Frac';
  LnFunctionName = 'Ln';
  LgFunctionName = 'Lg';
  LogFunctionName = 'Log';
  ExpFunctionName = 'Exp';
  RandomFunctionName = 'Random';
  SinFunctionName = 'Sin';
  ArcSinFunctionName = 'ArcSin';
  SinHFunctionName = 'Sinh';
  ArcSinHFunctionName = 'ArcSinh';
  CosFunctionName = 'Cos';
  ArcCosFunctionName = 'ArcCos';
  CosHFunctionName = 'Cosh';
  ArcCosHFunctionName = 'ArcCosh';
  TanFunctionName = 'Tan';
  ArcTanFunctionName = 'ArcTan';
  TanHFunctionName = 'Tanh';
  ArcTanHFunctionName = 'ArcTanh';
  CoTanFunctionName = 'Cotan';
  ArcCoTanFunctionName = 'ArcCotan';
  CoTanHFunctionName = 'Cotanh';
  ArcCoTanHFunctionName = 'ArcCotanh';
  SecFunctionName = 'Sec';
  ArcSecFunctionName = 'ArcSec';
  SecHFunctionName = 'Sech';
  ArcSecHFunctionName = 'SrcSech';
  CscFunctionName = 'Csc';
  ArcCscFunctionName = 'ArcCsc';
  CscHFunctionName = 'Csch';
  ArcCscHFunctionName = 'ArcCsch';
  ArcTan2FunctionName = 'ArcTan2';
  ArcTan2ParameterCount = 2;
  HypotFunctionName = 'Hypot';
  HypotParameterCount = 2;
  RadToDegFunctionName = 'RadToDeg';
  RadToGradFunctionName = 'RadToGrad';
  RadToCycleFunctionName = 'RadToCycle';
  DegToRadFunctionName = 'DegToRad';
  DegToGradFunctionName = 'DegToGrad';
  DegToCycleFunctionName = 'DegToCycle';
  GradToRadFunctionName = 'GradToRad';
  GradToDegFunctionName = 'GradToDeg';
  GradToCycleFunctionName = 'GradToCycle';
  CycleToRadFunctionName = 'CycleToRad';
  CycleToDegFunctionName = 'CycleToDeg';
  CycleToGradFunctionName = 'CycleToGrad';
  LnXP1FunctionName = 'LnXP1';
  Log10FunctionName = 'Log10';
  Log2FunctionName = 'Log2';
  IntPowerFunctionName = 'IntPower';
  IntPowerParameterCount = 2;
  PowerFunctionName = 'Power';
  PowerParameterCount = 2;
  LdexpFunctionName = 'Ldexp';
  LdexpParameterCount = 2;
  CeilFunctionName = 'Ceil';
  FloorFunctionName = 'Floor';
  PolyFunctionName = 'Poly';
  PolyParameterCount = 2;
  MeanFunctionName = 'Mean';
  MeanParameterCount = 1;
  SumFunctionName = 'Sum';
  SumParameterCount = 1;
  SumIntFunctionName = 'SumInt';
  SumIntParameterCount = 1;
  SumOfSquaresFunctionName = 'SumOfSquares';
  SumOfSquaresParameterCount = 1;
  MinValueFunctionName = 'MinValue';
  MinValueParameterCount = 1;
  MinIntValueFunctionName = 'MinIntValue';
  MinIntValueParameterCount = 1;
  MinFunctionName = 'Min';
  MinParameterCount = 2;
  MaxValueFunctionName = 'MaxValue';
  MaxValueParameterCount = 1;
  MaxIntValueFunctionName = 'MaxIntValue';
  MaxIntValueParameterCount = 1;
  MaxFunctionName = 'Max';
  MaxParameterCount = 2;
  StdDevFunctionName = 'StdDev';
  StdDevParameterCount = 1;
  PopnStdDevFunctionName = 'PopnStdDev';
  PopnStdDevParameterCount = 1;
  VarianceFunctionName = 'Variance';
  VarianceParameterCount = 1;
  PopnVarianceFunctionName = 'PopnVariance';
  PopnVarianceParameterCount = 1;
  TotalVarianceFunctionName = 'TotalVariance';
  TotalVarianceParameterCount = 1;
  NormFunctionName = 'Norm';
  NormParameterCount = 1;
  RandGFunctionName = 'RandG';
  RandGParameterCount = 2;
  RandomRangeFunctionName = 'RandomRange';
  RandomRangeParameterCount = 2;
  RandomFromFunctionName = 'RandomFrom';
  RandomFromParameterCount = 1;
  YearFunctionName = 'Year';
  MonthFunctionName = 'Month';
  DayFunctionName = 'Day';
  DayOfWeekFunctionName = 'DayOfWeek';
  HourFunctionName = 'Hour';
  MinuteFunctionName = 'Minute';
  SecondFunctionName = 'Second';
  MSecondFunctionName = 'MSecond';
  TimeFunctionName = 'Time';
  DateFunctionName = 'Date';
  GetYearFunctionName = 'GetYear';
  GetYearParameterCount = 1;
  GetMonthFunctionName = 'GetMonth';
  GetMonthParameterCount = 1;
  GetDayFunctionName = 'GetDay';
  GetDayParameterCount = 1;
  GetDayOfWeekFunctionName = 'GetDayOfWeek';
  GetDayOfWeekParameterCount = 1;
  GetHourFunctionName = 'GetHour';
  GetHourParameterCount = 1;
  GetMinuteFunctionName = 'GetMinute';
  GetMinuteParameterCount = 1;
  GetSecondFunctionName = 'GetSecond';
  GetSecondParameterCount = 1;
  GetMSecondFunctionName = 'GetMSecond';
  GetMSecondParameterCount = 1;
  EncodeTimeFunctionName = 'EncodeTime';
  EncodeTimeParameterCount = 4;
  EncodeDateFunctionName = 'EncodeDate';
  EncodeDateParameterCount = 3;
  EncodeDateTimeFunctionName = 'EncodeDateTime';
  EncodeDateTimeParameterCount = 7;

  PiConstantName = 'Pi';
  KilobyteConstantName = 'Kilobyte';
  MegabyteConstantName = 'Megabyte';
  GigabyteConstantName = 'Gigabyte';
  TerabyteConstantName = 'Terabyte';
  PetabyteConstantName = 'Petabyte';
  MinShortintConstantName = 'MinShortint';
  MaxShortintConstantName = 'MaxShortint';
  MinByteConstantName = 'MinByte';
  MaxByteConstantName = 'MaxByte';
  MinSmallintConstantName = 'MinSmallint';
  MaxSmallintConstantName = 'MaxSmallint';
  MinWordConstantName = 'MinWord';
  MaxWordConstantName = 'MaxWord';
  MinIntegerConstantName = 'MinInteger';
  MaxIntegerConstantName = 'MaxInteger';
  MinLongwordConstantName = 'MinLongword';
  MaxLongwordConstantName = 'MaxLongword';
  MinInt64ConstantName = 'MinInt64';
  MaxInt64ConstantName = 'MaxInt64';
  MinSingleConstantName = 'MinSingle';
  MaxSingleConstantName = 'MaxSingle';
  MinDoubleConstantName = 'MinDouble';
  MaxDoubleConstantName = 'MaxDouble';
  TinyConstantName = 'Tiny';
  HugeConstantName = 'Huge';

  ShortintTypeName = 'Shortint';
  ByteTypeName = 'Byte';
  SmallintTypeName = 'Smallint';
  WordTypeName = 'Word';
  IntegerTypeName = 'Integer';
  LongwordTypeName = 'Longword';
  Int64TypeName = 'Int64';
  SingleTypeName = 'Single';
  DoubleTypeName = 'Double';
  ExtendedTypeName = 'Extended';
  StringTypeName = 'String';

implementation

end.
