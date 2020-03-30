UNIT BeRoStream;
{$IFDEF FPC}
 {$MODE DELPHI}
 {$WARNINGS OFF}
 {$HINTS OFF}
 {$OVERFLOWCHECKS OFF}
 {$RANGECHECKS OFF}
 {$IFDEF CPUI386}
  {$DEFINE CPU386}
  {$ASMMODE INTEL}
 {$ENDIF}
 {$IFDEF FPC_LITTLE_ENDIAN}
  {$DEFINE LITTLE_ENDIAN}
 {$ELSE}
  {$IFDEF FPC_BIG_ENDIAN}
   {$DEFINE BIG_ENDIAN}
  {$ENDIF}
 {$ENDIF}
{$ELSE}
 {$DEFINE LITTLE_ENDIAN}
 {$IFNDEF CPU64}
  {$DEFINE CPU32}
 {$ENDIF}
 {$OPTIMIZATION ON}
{$ENDIF}

INTERFACE

CONST bsoFromBeginning=0;
      bsoFromCurrent=1;
      bsoFromEnd=2;

TYPE PBeRoStreamData=^TBeRoStreamData;
     TBeRoStreamData=PACKED ARRAY[0..$7FFFFFFE] OF BYTE;

     PBeRoStreamBuffer=^TBeRoStreamBuffer;
     TBeRoStreamBuffer=PACKED ARRAY[1..4096] OF BYTE;

     PBeRoStream=^TBeRoStream;
     TBeRoStream=CLASS
      PRIVATE
       fPosition,fSize,fInMemorySize:INTEGER;
       fData:PBeRoStreamData;
       fBitBuffer:LONGWORD;
       fBitBufferSize:BYTE;
       PROCEDURE Realloc(NewInMemorySize:INTEGER);
       PROCEDURE Resize(NewSize:INTEGER);
       FUNCTION GetString:STRING;
       PROCEDURE SetString(Value:STRING);
       FUNCTION GetByte(BytePosition:INTEGER):BYTE;
       PROCEDURE SetByte(BytePosition:INTEGER;Value:BYTE);
      PUBLIC
       CONSTRUCTOR Create;
       DESTRUCTOR Destroy; OVERRIDE;
       FUNCTION Assign(Src:TBeRoStream):INTEGER;
       FUNCTION Append(Src:TBeRoStream):INTEGER;
       FUNCTION AppendFrom(Src:TBeRoStream;Counter:INTEGER):INTEGER;
       PROCEDURE Clear; VIRTUAL;
       FUNCTION Read(VAR Buf;Count:INTEGER):INTEGER; VIRTUAL;
       FUNCTION ReadAt(Position:INTEGER;VAR Buf;Count:INTEGER):INTEGER; VIRTUAL;
       FUNCTION Write(CONST Buf;Count:INTEGER):INTEGER; VIRTUAL;
       FUNCTION SeekEx(APosition:INTEGER):INTEGER; VIRTUAL;
       FUNCTION Seek(APosition:INTEGER):INTEGER; OVERLOAD;
       FUNCTION Seek(APosition,Origin:INTEGER):INTEGER; OVERLOAD;
       FUNCTION Position:INTEGER; VIRTUAL;
       FUNCTION Size:INTEGER; VIRTUAL;
       PROCEDURE SetSize(NewSize:INTEGER);
       FUNCTION ReadByte:BYTE;
       FUNCTION ReadWord:WORD;
       FUNCTION ReadDWord:LONGWORD;
       FUNCTION ReadLine:STRING;
       FUNCTION ReadString:STRING;
       PROCEDURE WriteByte(Value:BYTE);
       FUNCTION WriteByteCount(Value:BYTE;Count:INTEGER):INTEGER;
       PROCEDURE WriteWord(Value:WORD);
       PROCEDURE WriteDWord(Value:LONGWORD);
       PROCEDURE WriteShortInt(Value:SHORTINT);
       PROCEDURE WriteSmallInt(Value:SMALLINT);
       PROCEDURE WriteLongInt(Value:LONGINT);
       PROCEDURE WriteInt64(Value:INT64);
       PROCEDURE WriteBoolean(Value:BOOLEAN);
       PROCEDURE WriteLine(Line:STRING);
       PROCEDURE WriteString(S:STRING);
       PROCEDURE WriteDataString(S:STRING);
       PROCEDURE ResetBits;
       FUNCTION ReadBit:BOOLEAN;
       FUNCTION ReadBits(BitsCount:BYTE):LONGWORD;
       FUNCTION ReadBitsSigned(BitsCount:BYTE):LONGINT;
       PROCEDURE WriteBit(Value:BOOLEAN);
       PROCEDURE WriteBits(Value:LONGWORD;BitsCount:BYTE);
       PROCEDURE WriteBitsSigned(Value:LONGINT;BitsCount:BYTE);
       PROCEDURE FlushBits;
       PROPERTY Text:STRING READ GetString WRITE SetString;
       PROPERTY Bytes[BytePosition:INTEGER]:BYTE READ GetByte WRITE SetByte; DEFAULT;
       PROPERTY BitsInBuffer:BYTE READ fBitBufferSize;
     END;

     PBeRoDatenStream=^TBeRoDatenStream;
     TBeRoDatenStream=TBeRoStream;

     PBeRoMemoryStream=^TBeRoMemoryStream;
     TBeRoMemoryStream=TBeRoStream;

     PBeRoFileStream=^TBeRoFileStream;
     TBeRoFileStream=CLASS(TBeRoStream)
      PRIVATE
       fFile:FILE;
      PUBLIC
       CONSTRUCTOR Create(FileName:STRING);
       CONSTRUCTOR CreateNew(FileName:STRING);
       DESTRUCTOR Destroy; OVERRIDE;
       FUNCTION Read(VAR Buf;Count:INTEGER):INTEGER; OVERRIDE;
       FUNCTION Write(CONST Buf;Count:INTEGER):INTEGER; OVERRIDE;
       FUNCTION SeekEx(APosition:INTEGER):INTEGER; OVERRIDE;
       FUNCTION Position:INTEGER; OVERRIDE;
       FUNCTION Size:INTEGER; OVERRIDE;
     END;

IMPLEMENTATION

TYPE PBYTE=^BYTE;

CONST MemoryDelta=1 SHL 16;
      MemoryDeltaMask=MemoryDelta-1;

CONSTRUCTOR TBeRoStream.Create;
BEGIN
 INHERITED Create;
 fData:=NIL;
 REALLOCMEM(fData,0);
 fPosition:=0;
 fSize:=0;
 fInMemorySize:=0;
 ResetBits;
END;

DESTRUCTOR TBeRoStream.Destroy;
BEGIN
 REALLOCMEM(fData,0);
 fPosition:=0;
 fSize:=0;
 fInMemorySize:=0;
 INHERITED Destroy;
END;

FUNCTION TBeRoStream.Assign(Src:TBeRoStream):INTEGER;
VAR Remain,Count:INTEGER;
    Buf:TBeRoStreamBuffer;
BEGIN
 Clear;
 RESULT:=0;
 Remain:=Src.Size;
 IF (Seek(0)<>0) OR (Src.Seek(0)<>0) THEN EXIT;
 WHILE Remain>=SIZEOF(TBeRoStreamBuffer) DO BEGIN
  Count:=Src.Read(Buf,SIZEOF(TBeRoStreamBuffer));
  Write(Buf,Count);
  INC(RESULT,Count);
  DEC(Remain,SIZEOF(TBeRoStreamBuffer));
 END;
 Count:=Src.Read(Buf,Remain);
 Write(Buf,Count);
 INC(RESULT,Count);
END;

FUNCTION TBeRoStream.Append(Src:TBeRoStream):INTEGER;
VAR Remain,Count:INTEGER;
    Buf:TBeRoStreamBuffer;
BEGIN
 RESULT:=0;
 Remain:=Src.Size;
 IF Src.Seek(0)<>0 THEN EXIT;
 WHILE Remain>=SIZEOF(TBeRoStreamBuffer) DO BEGIN
  Count:=Src.Read(Buf,SIZEOF(TBeRoStreamBuffer));
  Write(Buf,Count);
  INC(RESULT,Count);
  DEC(Remain,SIZEOF(TBeRoStreamBuffer));
 END;
 Count:=Src.Read(Buf,Remain);
 Write(Buf,Count);
 INC(RESULT,Count);
END;

FUNCTION TBeRoStream.AppendFrom(Src:TBeRoStream;Counter:INTEGER):INTEGER;
VAR Remain,Count:INTEGER;
    Buf:TBeRoStreamBuffer;
BEGIN
 RESULT:=0;
 Remain:=Counter;
 WHILE Remain>=SIZEOF(TBeRoStreamBuffer) DO BEGIN
  Count:=Src.Read(Buf,SIZEOF(TBeRoStreamBuffer));
  Write(Buf,Count);
  INC(RESULT,Count);
  DEC(Remain,SIZEOF(TBeRoStreamBuffer));
 END;
 Count:=Src.Read(Buf,Remain);
 Write(Buf,Count);
 INC(RESULT,Count);
END;

PROCEDURE TBeRoStream.Clear;
BEGIN
 REALLOCMEM(fData,0);
 fPosition:=0;
 fSize:=0;
 fInMemorySize:=0;
END;

PROCEDURE TBeRoStream.Realloc(NewInMemorySize:INTEGER);
VAR OldInMemorySize,Count:INTEGER;
BEGIN
 IF NewInMemorySize>0 THEN BEGIN
  NewInMemorySize:=(NewInMemorySize+MemoryDeltaMask) AND NOT MemoryDeltaMask;
 END;
 IF fInMemorySize<>NewInMemorySize THEN BEGIN
  OldInMemorySize:=fInMemorySize;
  fInMemorySize:=NewInMemorySize;
  REALLOCMEM(fData,fInMemorySize);
  Count:=NewInMemorySize-OldInMemorySize;
  IF Count>0 THEN BEGIN
   FILLCHAR(fData^[OldInMemorySize],Count,#0);
  END;
 END;
END;

PROCEDURE TBeRoStream.Resize(NewSize:INTEGER);
BEGIN
 fSize:=NewSize;
 IF fPosition>fSize THEN fPosition:=fSize;
 Realloc(fSize);
END;

FUNCTION TBeRoStream.Read(VAR Buf;Count:INTEGER):INTEGER;
BEGIN
 IF (fPosition>=0) AND (Count>0) THEN BEGIN
  RESULT:=fSize-fPosition;
  IF RESULT>0 THEN BEGIN
   IF RESULT>Count THEN RESULT:=Count;
   MOVE(fData^[fPosition],Buf,RESULT);
   INC(fPosition,RESULT);
   EXIT;
  END;
 END;
 RESULT:=0;
END;

FUNCTION TBeRoStream.ReadAt(Position:INTEGER;VAR Buf;Count:INTEGER):INTEGER;
BEGIN
 IF Seek(Position)=Position THEN BEGIN
  RESULT:=Read(Buf,Count);
 END ELSE BEGIN
  RESULT:=0;
 END;
END;

FUNCTION TBeRoStream.Write(CONST Buf;Count:INTEGER):INTEGER;
VAR EndPosition:INTEGER;
BEGIN
IF (fPosition>=0) AND (Count>0) THEN BEGIN
  EndPosition:=fPosition+Count;
  IF EndPosition>fSize THEN Resize(EndPosition);
  MOVE(Buf,fData^[fPosition],Count);
  fPosition:=EndPosition;
  RESULT:=Count;
  EXIT;
 END;
 RESULT:=0;
END;

FUNCTION TBeRoStream.SeekEx(APosition:INTEGER):INTEGER;
VAR AltePos,RemainSize:INTEGER;
BEGIN
 fPosition:=APosition;
 IF fPosition<0 THEN fPosition:=0;
 IF fPosition>fSize THEN BEGIN
  AltePos:=fSize;
  RemainSize:=fPosition-fSize;
  IF RemainSize>0 THEN BEGIN
   Resize(fSize+RemainSize);
   FILLCHAR(fData^[AltePos],RemainSize,#0);
  END;
  RESULT:=fPosition;
 END ELSE BEGIN
  RESULT:=fPosition;
 END;
END;

FUNCTION TBeRoStream.Seek(APosition:INTEGER):INTEGER;
BEGIN
 RESULT:=SeekEx(APosition);
END;

FUNCTION TBeRoStream.Seek(APosition,Origin:INTEGER):INTEGER;
BEGIN
 CASE Origin OF
  bsoFromBeginning:RESULT:=SeekEx(APosition);
  bsoFromCurrent:RESULT:=SeekEx(Position+APosition);
  bsoFromEnd:RESULT:=SeekEx(Size-APosition);
  ELSE RESULT:=SeekEx(APosition);
 END;
END;

FUNCTION TBeRoStream.Position:INTEGER;
BEGIN
 RESULT:=fPosition;
END;

FUNCTION TBeRoStream.Size:INTEGER;
BEGIN
 RESULT:=fSize;
END;

PROCEDURE TBeRoStream.SetSize(NewSize:INTEGER);
BEGIN
 fSize:=NewSize;
 IF fPosition>fSize THEN fPosition:=fSize;
 REALLOCMEM(fData,fSize);
END;

FUNCTION TBeRoStream.ReadByte:BYTE;
VAR B:BYTE;
BEGIN
 IF Read(B,1)<>1 THEN BEGIN
  RESULT:=0;
 END ELSE BEGIN
  RESULT:=B;
 END;
END;

FUNCTION TBeRoStream.ReadWord:WORD;
BEGIN
 RESULT:=ReadByte OR (ReadByte SHL 8);
END;

FUNCTION TBeRoStream.ReadDWord:LONGWORD;
BEGIN
 RESULT:=ReadWord OR (ReadWord SHL 16);
END;

FUNCTION TBeRoStream.ReadLine:STRING;
VAR C:CHAR;
BEGIN
 RESULT:='';
 WHILE Position<Size DO BEGIN
  Read(C,1);
  CASE C OF
   #10,#13:BEGIN
    WHILE (Position<Size) AND (Bytes[Position] IN [10,13]) DO BEGIN
     Read(C,1);
    END;
    BREAK;
   END;
   ELSE RESULT:=RESULT+C;
  END;
 END;
END;

FUNCTION TBeRoStream.ReadString:STRING;
VAR L:LONGWORD;
BEGIN
 L:=ReadDWord;
 SETLENGTH(RESULT,L);
 IF L>0 THEN Read(RESULT[1],L);
END;

PROCEDURE TBeRoStream.WriteByte(Value:BYTE);
BEGIN
 Write(Value,SIZEOF(BYTE));
END;

FUNCTION TBeRoStream.WriteByteCount(Value:BYTE;Count:INTEGER):INTEGER;
VAR Counter:INTEGER;
BEGIN
 RESULT:=0;
 FOR Counter:=1 TO Count DO INC(RESULT,Write(Value,SIZEOF(BYTE)));
END;

PROCEDURE TBeRoStream.WriteWord(Value:WORD);
BEGIN
 Write(Value,SIZEOF(WORD));
END;

PROCEDURE TBeRoStream.WriteDWord(Value:LONGWORD);
BEGIN
 Write(Value,SIZEOF(LONGWORD));
END;

PROCEDURE TBeRoStream.WriteShortInt(Value:SHORTINT);
BEGIN
 Write(Value,SIZEOF(SHORTINT));
END;

PROCEDURE TBeRoStream.WriteSmallInt(Value:SMALLINT);
BEGIN
 Write(Value,SIZEOF(SMALLINT));
END;

PROCEDURE TBeRoStream.WriteLongInt(Value:LONGINT);
BEGIN
 Write(Value,SIZEOF(LONGINT));
END;

PROCEDURE TBeRoStream.WriteInt64(Value:INT64);
BEGIN
 Write(Value,SIZEOF(INT64));
END;

PROCEDURE TBeRoStream.WriteBoolean(Value:BOOLEAN);
BEGIN
 IF Value THEN BEGIN
  WriteByte(1);
 END ELSE BEGIN
  WriteByte(0);
 END;
END;

PROCEDURE TBeRoStream.WriteLine(Line:STRING);
CONST CRLF:ARRAY[1..2] OF CHAR=#13#10;
BEGIN
 IF LENGTH(Line)>0 THEN Write(Line[1],LENGTH(Line));
 Write(CRLF,2);
END;

PROCEDURE TBeRoStream.WriteString(S:STRING);
VAR L:LONGWORD;
BEGIN
 L:=LENGTH(S);
 IF L>0 THEN Write(S[1],L);
END;

PROCEDURE TBeRoStream.WriteDataString(S:STRING);
VAR L:LONGWORD;
BEGIN
 L:=LENGTH(S);
 WriteDWord(L);
 IF L>0 THEN Write(S[1],L);
END;

PROCEDURE TBeRoStream.ResetBits;
BEGIN
 fBitBuffer:=0;
 fBitBufferSize:=0;
END;

FUNCTION TBeRoStream.ReadBit:BOOLEAN;
BEGIN
 RESULT:=(ReadBits(1)<>0);
END;

FUNCTION TBeRoStream.ReadBits(BitsCount:BYTE):LONGWORD;
BEGIN
 WHILE fBitBufferSize<BitsCount DO BEGIN
  fBitBuffer:=(fBitBuffer SHL 8) OR ReadByte;
  INC(fBitBufferSize,8);
 END;
 RESULT:=(fBitBuffer SHR (fBitBufferSize-BitsCount)) AND ((1 SHL BitsCount)-1);
 DEC(fBitBufferSize,BitsCount);
END;

FUNCTION TBeRoStream.ReadBitsSigned(BitsCount:BYTE):LONGINT;
BEGIN
 RESULT:=0;
 IF BitsCount>1 THEN BEGIN
  IF ReadBits(1)<>0 THEN BEGIN
   RESULT:=-ReadBits(BitsCount-1);
  END ELSE BEGIN
   RESULT:=ReadBits(BitsCount-1);
  END;
 END;
END;

PROCEDURE TBeRoStream.WriteBit(Value:BOOLEAN);
BEGIN
 IF Value THEN BEGIN
  WriteBits(1,1);
 END ELSE BEGIN
  WriteBits(0,1);
 END;
END;

PROCEDURE TBeRoStream.WriteBits(Value:LONGWORD;BitsCount:BYTE);
BEGIN
 fBitBuffer:=(fBitBuffer SHL BitsCount) OR Value;
 INC(fBitBufferSize,BitsCount);
 WHILE fBitBufferSize>=8 DO BEGIN
  WriteByte((fBitBuffer SHR (fBitBufferSize-8)) AND $FF);
  DEC(fBitBufferSize,8);
 END;
END;

PROCEDURE TBeRoStream.WriteBitsSigned(Value:LONGINT;BitsCount:BYTE);
BEGIN
 IF BitsCount>1 THEN BEGIN
  IF Value<0 THEN BEGIN
   WriteBits(1,1);
   WriteBits(LONGWORD(0-Value),BitsCount-1);
  END ELSE BEGIN
   WriteBits(0,1);
   WriteBits(LONGWORD(Value),BitsCount-1);
  END;
 END;
END;

PROCEDURE TBeRoStream.FlushBits;
BEGIN
 IF fBitBufferSize>0 THEN BEGIN
  WriteByte(fBitBuffer SHL (8-fBitBufferSize));
 END;
 fBitBuffer:=0;
 fBitBufferSize:=0;
END;

FUNCTION TBeRoStream.GetString:STRING;
BEGIN
 Seek(0);
 IF Size>0 THEN BEGIN
  SETLENGTH(RESULT,Size);
  Read(RESULT[1],Size);
 END ELSE BEGIN
  RESULT:='';
 END;
END;

PROCEDURE TBeRoStream.SetString(Value:STRING);
BEGIN
 Clear;
 IF LENGTH(Value)>0 THEN BEGIN
  Write(Value[1],LENGTH(Value));
 END;
END;

FUNCTION TBeRoStream.GetByte(BytePosition:INTEGER):BYTE;
VAR AltePosition:INTEGER;
BEGIN
 AltePosition:=Position;
 Seek(BytePosition);
 Read(RESULT,SIZEOF(BYTE));
 Seek(AltePosition);
END;

PROCEDURE TBeRoStream.SetByte(BytePosition:INTEGER;Value:BYTE);
VAR AltePosition:INTEGER;
BEGIN
 AltePosition:=Position;
 Seek(BytePosition);
 Write(Value,SIZEOF(BYTE));
 Seek(AltePosition);
END;

CONSTRUCTOR TBeRoFileStream.Create(FileName:STRING);
VAR Alt:BYTE;
BEGIN
 INHERITED Create;
 Alt:=FileMode;
 FileMode:=0;
 ASSIGNFILE(fFile,FileName);
 {$I-}RESET(fFile,1);{$I+}
 FileMode:=Alt;
 IF IOResult<>0 THEN {$I-}REWRITE(fFile,1);{$I+}
 IF IOResult<>0 THEN BEGIN
 END;
END;

CONSTRUCTOR TBeRoFileStream.CreateNew(FileName:STRING);
VAR Alt:BYTE;
BEGIN
 INHERITED Create;
 Alt:=FileMode;
 FileMode:=2;
 ASSIGNFILE(fFile,FileName);
 {$I-}REWRITE(fFile,1);{$I+}
 FileMode:=Alt;
 IF IOResult<>0 THEN BEGIN
 END;
END;

DESTRUCTOR TBeRoFileStream.Destroy;
BEGIN
 {$I-}CLOSEFILE(fFile);{$I+}
 IF IOResult<>0 THEN BEGIN
 END;
 INHERITED Destroy;
END;

FUNCTION TBeRoFileStream.Read(VAR Buf;Count:INTEGER):INTEGER;
VAR I:INTEGER;
BEGIN
 {$I-}BLOCKREAD(fFile,Buf,Count,I);{$I+}
 IF IOResult<>0 THEN BEGIN
  RESULT:=0;
  EXIT;
 END;
 {$I-}fPosition:=FILEPOS(fFile);{$I+}
 IF IOResult<>0 THEN BEGIN
  RESULT:=0;
  EXIT;
 END;
 RESULT:=I;
END;

FUNCTION TBeRoFileStream.Write(CONST Buf;Count:INTEGER):INTEGER;
VAR I:INTEGER;
BEGIN
 {$I-}BLOCKWRITE(fFile,Buf,Count,I);{$I+}
 IF IOResult<>0 THEN BEGIN
  RESULT:=0;
  EXIT;
 END;
 {$I-}fPosition:=FILEPOS(fFile);{$I+}
 IF IOResult<>0 THEN BEGIN
  RESULT:=0;
  EXIT
 END;
 RESULT:=I;
END;

FUNCTION TBeRoFileStream.SeekEx(APosition:INTEGER):INTEGER;
BEGIN
 IF APosition<=Size THEN BEGIN
  {$I-}System.SEEK(fFile,APosition);{$I+}
  IF IOResult<>0 THEN BEGIN
   RESULT:=0;
   EXIT;
  END;
 END;
 {$I-}RESULT:=FILEPOS(fFile);{$I+}
 IF IOResult<>0 THEN BEGIN
  RESULT:=0;
 END;
END;

FUNCTION TBeRoFileStream.Position:INTEGER;
BEGIN
 {$I-}RESULT:=FILEPOS(fFile);{$I+}
 IF IOResult<>0 THEN BEGIN
  RESULT:=0;
 END;
END;

FUNCTION TBeRoFileStream.Size:INTEGER;
BEGIN
 {$I-}RESULT:=FILESIZE(fFile);{$I+}
 IF IOResult<>0 THEN BEGIN
  RESULT:=0;
 END;
END;

END.
