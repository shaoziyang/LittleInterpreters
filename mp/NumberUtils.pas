{ *********************************************************************** }
{                                                                         }
{ NumberUtils                                                             }
{                                                                         }
{ Copyright (c) 2007 Pisarev Yuriy (post@pisarev.net)                     }
{                                                                         }
{ *********************************************************************** }

unit NumberUtils;

{$B-}
{$I Directives.inc}

interface

uses
  SysUtils, SysConst, Classes;

const
  BitCount = 8;

type
  TBitManager = class(TBits)
  public
    procedure Open(const Value: Int64); overload; virtual;
    procedure Open(const Value: Integer); overload; virtual;
    procedure Open(const Value: Byte); overload; virtual;
    procedure Save(out Value: Int64); overload; virtual;
    procedure Save(out Value: Integer); overload; virtual;
    procedure Save(out Value: Byte); overload; virtual;
  end;

function GetHashCode(const Value: string): Integer;

function Equal(const AValue, BValue: Extended; AEpsilon: Extended = 0): Boolean;
function Above(const AValue, BValue: Extended; AEpsilon: Extended = 0): Boolean;
function AboveOrEqual(const AValue, BValue: Extended; AEpsilon: Extended = 0): Boolean;
function Below(const AValue, BValue: Extended; AEpsilon: Extended = 0): Boolean;
function BelowOrEqual(const AValue, BValue: Extended; AEpsilon: Extended = 0): Boolean;

function NextStep(const Value, Distance: Extended; const Index: Integer; const Epsilon: Extended = 0): Extended;

function Positive(const Value: Integer): Integer;

function FracSize(const Value: Extended): Integer;

var
  BM: TBitManager;
  Epsilon: Extended = 0;

implementation

uses
  Math, {$IFNDEF UNICODE}TextUtils, {$ENDIF}Types;

{ TBitManager }

procedure TBitManager.Open(const Value: Int64);
var
  I: Integer;
begin
  Size := SizeOf(Value) * BitCount;
  for I := 0 to Size - 1 do Bits[I] := (Value and Round(IntPower(2, I))) > 0;
end;

procedure TBitManager.Open(const Value: Integer);
var
  I: Integer;
begin
  Size := SizeOf(Value) * BitCount;
  for I := 0 to Size - 1 do Bits[I] := (Value and Round(IntPower(2, I))) > 0;
end;

procedure TBitManager.Open(const Value: Byte);
var
  I: Integer;
begin
  Size := SizeOf(Value) * BitCount;
  for I := 0 to Size - 1 do Bits[I] := (Value and Round(IntPower(2, I))) > 0;
end;

procedure TBitManager.Save(out Value: Int64);
var
  I: Integer;
begin
  Value := 0;
  for I := 0 to Size - 1 do if Bits[I] then Value := Value or Round(IntPower(2, I));
end;

procedure TBitManager.Save(out Value: Integer);
var
  I: Integer;
begin
  Value := 0;
  for I := 0 to Size - 1 do if Bits[I] then Value := Value or Round(IntPower(2, I));
end;

procedure TBitManager.Save(out Value: Byte);
var
  I: Integer;
begin
  Value := 0;
  for I := 0 to Size - 1 do if Bits[I] then Value := Value or Round(IntPower(2, I));
end;

function Bit(const Value: Int64; const Index: Integer): Boolean;
begin
  BM.Open(Value);
  Result := BM.Bits[Index];
end;

function GetHashCode(const Value: string): Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 1 to Length(Value) do
    Result := ((Result shl 2) or (Result shr (SizeOf(Result) * 8 - 2))) xor Ord(Value[I]);
end;

function Equal(const AValue, BValue: Extended; AEpsilon: Extended): Boolean;
begin
  if AEpsilon = 0 then AEpsilon := Epsilon;  
  Result := SameValue(AValue, BValue, AEpsilon);
end;

function Above(const AValue, BValue: Extended; AEpsilon: Extended): Boolean;
begin
  if AEpsilon = 0 then AEpsilon := Epsilon;
  Result := CompareValue(AValue, BValue, AEpsilon) = GreaterThanValue;
end;

function AboveOrEqual(const AValue, BValue: Extended; AEpsilon: Extended): Boolean;
begin
  if AEpsilon = 0 then AEpsilon := Epsilon;  
  Result := CompareValue(AValue, BValue, AEpsilon) <> LessThanValue;
end;

function Below(const AValue, BValue: Extended; AEpsilon: Extended): Boolean;
begin
  if AEpsilon = 0 then AEpsilon := Epsilon;
  Result := CompareValue(AValue, BValue, AEpsilon) = LessThanValue;
end;

function BelowOrEqual(const AValue, BValue: Extended; AEpsilon: Extended): Boolean;
begin
  if AEpsilon = 0 then AEpsilon := Epsilon;
  Result := CompareValue(AValue, BValue, AEpsilon) <> GreaterThanValue;
end;

function NextStep(const Value, Distance: Extended; const Index: Integer; const Epsilon: Extended): Extended;
var
  A: Extended;
begin
  A := Value / Distance;
  if (Index = 0) and Equal(Frac(A), 0, Epsilon) then
    Result := Value
  else
    Result := (Int(A) + Index) * Distance;
end;

function Positive(const Value: Integer): Integer;
begin
  if Value < 0 then
    Result := - Value
  else
    Result := Value;
end;

function FracSize(const Value: Extended): Integer;
begin
  if Value > 0 then
  begin
    Result := Round(Log10(1 / Value));
    if Result < 0 then Result := 0;
  end
  else Result := 0;
end;

initialization
  BM := TBitManager.Create;

finalization
  BM.Free;

end.
