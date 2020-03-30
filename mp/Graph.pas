{ *********************************************************************** }
{                                                                         }
{ Graph                                                                   }
{                                                                         }
{ Copyright (c) 2006 Pisarev Yuriy (post@pisarev.net)                     }
{                                                                         }
{ *********************************************************************** }

unit Graph;

{$B-}
{$I Directives.inc}

interface

uses
  {$IFDEF DELPHI_XE3}WinApi.Windows, Winapi.Messages, Winapi.GDIPOBJ,
  Winapi.GDIPAPI, {$ELSE}Windows, Messages, GDIPOBJ, GDIPAPI, {$ENDIF}SysUtils,
  Classes, Graphics, Contnrs, Controls, ExactTimer, FastList, GraphicUtils,
  GraphicTypes, TextConsts, NumberUtils, Parser, ParseTypes, Thread, Types,
  ValueTypes;

type
  TExactArray = array of TExactPoint;
  TExactPointArray = array of TExactArray;
  TArray = array of TPoint;
  TPointArray = array of TArray;
  TRectangularTraceEvent = procedure(Sender: TObject; const FormulaIndex: Integer; const Point: TExactPoint) of object;
  TPolarTraceEvent = procedure(Sender: TObject; const FormulaIndex: Integer; const Angle: Extended; const Point: TExactPoint) of object;
  TCoordinateSystem = (csRectangular, csPolar);
  TLayoutType = (ltBottomLeft, ltBottomRight, ltTopLeft, ltTopRight);

const
  DefaultAutoVary = True;
  DefaultAutoVoid = True;
  DefaultAccuracy = 1;
  DefaultAntialias = True;
  DefaultAutoquality = True;
  DefaultHeight = 300;
  DefaultMulticolor = True;
  DefaultWidth = 300;
  DefaultQuality = 1;
  DefaultTracing = True;
  DefaultOverlap = True;
  DefaultExtreme = True;
  DefaultCS = csRectangular;
  DefaultSign = True;
  DefaultSignTransparency = 100;
  DefaultSignLayout = ltBottomRight;
  DefaultSignMargin = 16;

type
  {$IFNDEF DELPHI_2006}
  TBitmap = class(Graphics.TBitmap)
  public
    procedure SetSize(AWidth, AHeight: Integer); virtual;
  end;
  {$ENDIF}

  PRange = ^TRange;
  TRange = record
    Min, Max: Extended;
  end;
  TRangeArray = array of TRange;

  TQuarterKind = (qkA, qkB, qkC, qkD, qkAB, qkBC, qkCD, qkDA, qkABCD);
  TZoomType = (ztNone, ztIn, ztOut);

const
  WholeRange: TRange = (Min: 0; Max: DoublePi);
  ActiveBitIndex = 0;

type
  TDistanceType = (dtMin, dtMax);
  TDisplay = record
    QuarterKind: TQuarterKind;
    Range: TRange;
    FromCenter: array[TDistanceType] of Extended;
  end;

  TConvertMethod = function(const Point: TExactPoint): TExactPoint of object;
  TComputeMethod = function(const Value: Extended; const Script: TScript): TExactPoint of object;
  TExamineMethod = function(const Point: TExactPoint): Boolean of object;

  TParseThread = class;
  TOverlapThread = class;
  TExtremeThread = class;

  TThreadList = class(TObjectList)
  private
    function GetItem(Index: Integer): TParseThread;
    procedure SetItem(Index: Integer; const Value: TParseThread);
  public
    property Items[Index: Integer]: TParseThread read GetItem write SetItem; default;
  end;

  // TPlace - позволяет выделить те данные в FEntireArray (FCursorArray), которые относятся к конкретной формуле
  PPlace = ^TPlace;
  TPlace = record
    ArrayIndex, Index: Integer;
  end;

  POverlap = ^TOverlap;
  TOverlap = record
    AFormula, BFormula: Integer;
    Point: TExactPoint;
    AAngle, BAngle: Extended;
  end;
  TOverlapArray = array of TOverlap;

  PFormulaData = ^TFormulaData;
  TFormulaData = record
    Flag, ScriptIndex: Integer;
    EntireBack, EntireFace, CursorBack, CursorFace, MinBack, MinFace, MaxBack, MaxFace: TPlace;
    Color: TColor;
  end;

  TGraph = class;

  TFormulaList = class(TFastList)
  private
    FBM: TBitManager;
    function GetActive(const Index: Integer): Boolean;
    function GetActiveCount: Integer;
    function GetData(const Index: Integer): PFormulaData;
    procedure SetActive(const Index: Integer; const Value: Boolean);
  protected
    procedure InsertItem(Index: Integer; const S: string; AObject: TObject); override;
    procedure DataNeeded(const Index: Integer); virtual;
    procedure DeleteData(const Index: Integer); virtual;
    property BM: TBitManager read FBM write FBM;
  public
    constructor Create; override;
    destructor Destroy; override;
    function AddObject(const S: string; AObject: TObject): Integer; override;
    procedure Clear; override;
    procedure Delete(Index: Integer); override;
    property Data[const Index: Integer]: PFormulaData read GetData;
    property Active[const Index: Integer]: Boolean read GetActive write SetActive;
    property ActiveCount: Integer read GetActiveCount;
  end;

  TZoomTimer = class(TExactTimer)
  private
    FZoomType: TZoomType;
  public
    property ZoomType: TZoomType read FZoomType write FZoomType;
  end;

  TGraph = class(TCustomControl)
  private
    FAccuracy: Integer;
    FAngleDigitCount: Integer;
    FAngleFormat: string;
    FAntialias: Boolean;
    FAutoquality: Boolean;
    FAutoVary: Boolean;
    FAutoVoid: Boolean;
    FAxisArrow: TSize;
    FAxisFont: TFont;
    FAxisPen: TPen;
    FBuffer: TBitmap;
    FCenter: TExactPoint;
    FColorArray: TColorArray;
    FCompute: array[TCoordinateSystem] of TComputeMethod;
    FCS: TCoordinateSystem;
    FCursorArray: TPointArray;
    FEntireArray: TExactPointArray;
    FEpsilon: Extended;
    FExtreme: Boolean;
    FExtremeThread: TExtremeThread;
    FExtremeVaryRadius: Extended;
    FExtremeVoidRadius: Extended;
    FFormula: TFormulaList;
    FFormulaFont: TFont;
    FGraphPen: TPen;
    FGridPen: TPen;
    FHSpacing: Extended;
    FInternalParser: TParser;
    FLeadTimer: TExactTimer;
    FMarkerPen: TPen;
    FMax: TExactPoint;
    FMaxArray: TExactPointArray;
    FMaxX: Extended;
    FMaxY: Extended;
    FMaxZoom: array[TCoordinateSystem] of Extended;
    FMin: TExactPoint;
    FMinArray: TExactPointArray;
    FMinZoom: array[TCoordinateSystem] of Extended;
    FMoving: Boolean;
    FMulticolor: Boolean;
    FOffset: TExactPoint;
    FOnOffsetChange: TNotifyEvent;
    FOnPolarTrace: TPolarTraceEvent;
    FOnRectangularTrace: TRectangularTraceEvent;
    FOnTraceDone: TNotifyEvent;
    FOverlap: Boolean;
    FOverlapArray: TOverlapArray;
    FOverlapThread: TOverlapThread;
    FParser: TParser;
    FPivotPoint: TExactPoint;
    FPolarAxisPen: TPen;
    FQuality: Integer;
    FScriptArray: TScriptArray;
    FShowAxis: Boolean;
    FShowGrid: Boolean;
    FSign: Boolean;
    FSignFont: TFont;
    FSignLayout: TLayoutType;
    FSignMargin: Integer;
    FSignTransparency: Byte;
    FSize: TSize;
    FThreadList: TThreadList;
    FTraceArray: TPointArray;
    FTracePen: TPen;
    FTracing: Boolean;
    FValue: TValue;
    FVSpacing: Extended;
    FXDigitCount: Integer;
    FXFactor: Extended;
    FXFormat: string;
    FYDigitCount: Integer;
    FYFactor: Extended;
    FYFormat: string;
    FZoomInFactor: Extended;
    FZoomOutFactor: Extended;
    FZoomTimer: TZoomTimer;
    function GetBusy: Boolean;
    function GetCompute(const CS: TCoordinateSystem): TComputeMethod;
    function GetMaxZoom: Extended;
    function GetMinZoom: Extended;
    function GetThreadCount: Integer;
    procedure SetCS(const Value: TCoordinateSystem);
    procedure SetFormula(const Value: TFormulaList);
    procedure SetMaxZoom(const Value: Extended);
    procedure SetMinZoom(const Value: Extended);
    procedure SetOffset(const Value: TExactPoint);
    procedure SetParser(const Value: TParser);
    procedure SetThreadCount(const Value: Integer);
    procedure SetExtreme(const Value: Boolean);
    procedure SetOverlap(const Value: Boolean);
  protected
    procedure WndProc(var Message: TMessage); override;
    procedure DblClick; override;
    function DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    function DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure Notification(Component: TComponent; Operation: TOperation); override;
    procedure Paint; override;
    procedure Resize; override;
    procedure DoOffsetChange; virtual;
    function MarkPoint(const Point: TExactPoint; var PointArray: TPointArray): Boolean; virtual;
    function GetDisplay: TDisplay; virtual;
    function GetPolarRangeArray: TRangeArray; virtual;
    function FloatFormat(const Scale: Extended; const Count: Integer): string; virtual;
    function CalcSize: TSize; virtual;
    function Examine(const Point: TExactPoint): Boolean; virtual;
    procedure Attach; virtual;
    procedure Detach; virtual;
    procedure DoLeadTimer(Sender: TObject); virtual;
    procedure DoZoomTimer(Sender: TObject); virtual;
    procedure DoTraceDone; virtual;
    procedure DoTrace(const FormulaIndex: Integer; const Point: TExactPoint); overload; virtual;
    procedure DoTrace(const FormulaIndex: Integer; const Angle: Extended; const Point: TExactPoint); overload; virtual;
    function PointCount(const Segment: PExtended = nil): Extended; virtual;
    function Compare(const APoint, BPoint: TPoint; const AAccuracy: Integer = 0): Boolean; virtual;
    procedure Capture; virtual;
    procedure DrawFormula(const Target: TCanvas); virtual;
    procedure DrawOverlap(const Target: TCanvas); virtual;
    procedure DrawMaximum(const Target: TCanvas); virtual;
    procedure DrawMinimum(const Target: TCanvas); virtual;
    function DrawPointArray(const Target: TCanvas; const PointArray: TPointArray; const Pen: TPen = nil; const Smooth: Boolean = False;
      const Back: PPlace = nil; const Face: PPlace = nil; const Color: PColor = nil): Boolean; virtual;
    procedure DrawLine(const Angle: Extended); virtual;
    procedure DrawSign; virtual;
    procedure Prepare; virtual;
    function ComputeRectangular(const Value: Extended; const Script: TScript): TExactPoint; virtual;
    function ComputePolar(const Value: Extended; const Script: TScript): TExactPoint; virtual;
    procedure Parse(const Script: TScript; const RangeArray: TRangeArray; const Step: Extended; const MinStep: PExtended = nil); overload; virtual;
    property PolarRangeArray: TRangeArray read GetPolarRangeArray;
    property Size: TSize read FSize write FSize;
    // В координатах курсора
    property Center: TExactPoint read FCenter write FCenter;
    // В декартовых координатах центр всегда в точке X = 0; Y = 0
    // В декартовых координатах
    property Min: TExactPoint read FMin write FMin;
    // В декартовых координатах
    property Max: TExactPoint read FMax write FMax;
    property XFactor: Extended read FXFactor;
    property YFactor: Extended read FYFactor;
    property PivotPoint: TExactPoint read FPivotPoint write FPivotPoint;
    property Moving: Boolean read FMoving write FMoving;
    property LeadTimer: TExactTimer read FLeadTimer write FLeadTimer;
    property ZoomTimer: TZoomTimer read FZoomTimer write FZoomTimer;
    property OverlapThread: TOverlapThread read FOverlapThread write FOverlapThread;
    property ExtremeThread: TExtremeThread read FExtremeThread write FExtremeThread;
    property ThreadList: TThreadList read FThreadList write FThreadList;
    property TraceArray: TPointArray read FTraceArray write FTraceArray;
    property Value: TValue read FValue write FValue;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Invalidate; override;
    procedure Parse; overload; virtual;
    procedure Build; virtual;
    procedure Clear; virtual;
    procedure MakeZoom(const ZoomType: TZoomType); virtual;
    procedure Zoom(const ZoomType: TZoomType; const Factor: Extended = -1); virtual;
    function XToCursor(const X: Extended): Extended; overload; virtual;
    function YToCursor(const Y: Extended): Extended; overload; virtual;
    function PointToCursor(const Point: TExactPoint): TExactPoint; overload; virtual;
    function PointToCursor(const Point: TPoint): TPoint; overload; virtual;
    function XToPoint(const X: Extended): Extended; overload; virtual;
    function YToPoint(const Y: Extended): Extended; overload; virtual;
    function CursorToPoint(const Point: TExactPoint): TExactPoint; overload; virtual;
    function CursorToPoint(const Point: TPoint): TPoint; overload; virtual;
    procedure MakeColor(const Formula: Integer); virtual;
    procedure WaitFor; virtual;
    procedure Stop; virtual;
    procedure ForceStop; virtual;
    property InternalParser: TParser read FInternalParser write FInternalParser;
    property Display: TDisplay read GetDisplay;
    property ScriptArray: TScriptArray read FScriptArray write FScriptArray;
    property Compute[const CS: TCoordinateSystem]: TComputeMethod read GetCompute;
    property ThreadCount: Integer read GetThreadCount write SetThreadCount;
    property Buffer: TBitmap read FBuffer write FBuffer;
    property XDigitCount: Integer read FXDigitCount write FXDigitCount;
    property YDigitCount: Integer read FYDigitCount write FYDigitCount;
    property AngleDigitCount: Integer read FAngleDigitCount write FAngleDigitCount;
    property ExtremeVaryRadius: Extended read FExtremeVaryRadius write FExtremeVaryRadius;
    property AutoVary: Boolean read FAutoVary write FAutoVary;
    property ExtremeVoidRadius: Extended read FExtremeVoidRadius write FExtremeVoidRadius;
    property AutoVoid: Boolean read FAutoVoid write FAutoVoid;
    property XFormat: string read FXFormat;
    property YFormat: string read FYFormat;
    property AngleFormat: string read FAngleFormat;
    property Epsilon: Extended read FEpsilon;
    property EntireArray: TExactPointArray read FEntireArray write FEntireArray;
    property CursorArray: TPointArray read FCursorArray write FCursorArray;
    property OverlapArray: TOverlapArray read FOverlapArray write FOverlapArray;
    property MaxArray: TExactPointArray read FMaxArray write FMaxArray;
    property MinArray: TExactPointArray read FMinArray write FMinArray;
    property ColorArray: TColorArray read FColorArray write FColorArray;
    property Busy: Boolean read GetBusy;
  published
    property Accuracy: Integer read FAccuracy write FAccuracy default DefaultAccuracy;
    property Align;
    property Anchors;
    property Antialias: Boolean read FAntialias write FAntialias default DefaultAntialias;
    property Autoquality: Boolean read FAutoquality write FAutoquality default DefaultAutoquality;
    property AutoSize;
    property AxisArrow: TSize read FAxisArrow write FAxisArrow;
    property AxisFont: TFont read FAxisFont write FAxisFont;
    property AxisPen: TPen read FAxisPen write FAxisPen;
    property BiDiMode;
    property Color;
    property Constraints;
    property CS: TCoordinateSystem read FCS write SetCS default DefaultCS;
    property Ctl3D;
    property Cursor default crCross;
    property UseDockManager;
    property Sign: Boolean read FSign write FSign default DefaultSign;
    property SignTranspancy: Byte read FSignTransparency write FSignTransparency;
    property SignLayout: TLayoutType read FSignLayout write FSignLayout default DefaultSignLayout;
    property SignMargin: Integer read FSignMargin write FSignMargin default DefaultSignMargin;
    property SignFont: TFont read FSignFont write FSignFont;
    property DockSite;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property Formula: TFormulaList read FFormula write SetFormula;
    property FormulaFont: TFont read FFormulaFont write FFormulaFont;
    property GraphPen: TPen read FGraphPen write FGraphPen;
    property GridPen: TPen read FGridPen write FGridPen;
    property PolarAxisPen: TPen read FPolarAxisPen write FPolarAxisPen;
    property Height default DefaultHeight;
    property HSpacing: Extended read FHSpacing write FHSpacing;
    property MinZoom: Extended read GetMinZoom write SetMinZoom;
    property MarkerPen: TPen read FMarkerPen write FMarkerPen;
    property MaxZoom: Extended read GetMaxZoom write SetMaxZoom;
    // В декартовых координатах
    // Длина половины оси X
    property MaxX: Extended read FMaxX write FMaxX;
    // Длина половины оси Y
    property MaxY: Extended read FMaxY write FMaxY;
    property MulityColor: Boolean read FMulticolor write FMulticolor default DefaultMulticolor;
    property Offset: TExactPoint read FOffset write SetOffset;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property Parser: TParser read FParser write SetParser;
    property PopupMenu;
    property Quality: Integer read FQuality write FQuality default DefaultQuality;
    property ShowAxis: Boolean read FShowAxis write FShowAxis default True;
    property ShowGrid: Boolean read FShowGrid write FShowGrid default True;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property TracePen: TPen read FTracePen write FTracePen;
    property Tracing: Boolean read FTracing write FTracing default DefaultTracing;
    property Overlap: Boolean read FOverlap write SetOverlap default DefaultOverlap;
    property Extreme: Boolean read FExtreme write SetExtreme default DefaultExtreme;
    property VSpacing: Extended read FVSpacing write FVSpacing;
    property Visible;
    property ZoomInFactor: Extended read FZoomInFactor write FZoomInFactor;
    property ZoomOutFactor: Extended read FZoomOutFactor write FZoomOutFactor;
    property Width default DefaultWidth;
    property OnCanResize;
    property OnClick;
    property OnConstrainedResize;
    property OnContextPopup;
    property OnDockDrop;
    property OnDockOver;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnOffsetChange: TNotifyEvent read FOnOffsetChange write FOnOffsetChange;
    property OnGetSiteInfo;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnStartDock;
    property OnStartDrag;
    property OnUnDock;
    property OnTraceDone: TNotifyEvent read FOnTraceDone write FOnTraceDone;
    property OnRectangularTrace: TRectangularTraceEvent read FOnRectangularTrace write FOnRectangularTrace;
    property OnPolarTrace: TPolarTraceEvent read FOnPolarTrace write FOnPolarTrace;
  end;

  TVariable = record
    Handle: Integer;
    Value: TValue;
  end;

  TGraphThread = class(TThread)
  private
    FValue: PValue;
    FParser: TParser;
    FLocalValue: TVariable;
    function GetFloat80: PExtended;
    function GetGraph: TGraph;
    procedure SetParser(const Value: TParser);
  protected
    function MakeName(const Text: string): string; virtual;
    function LocalizeMethod(var Index: Integer; const Header: PScriptHeader; const ItemHeader: PItemHeader;
      const Item: PScriptItem; const Data: Pointer): Boolean; virtual;
    function ValueMethod(const AFunction: PFunction; const AType: PType): TValue; virtual;
    property LocalValue: TVariable read FLocalValue write FLocalValue;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Done; override;
    procedure Attach; virtual;
    procedure Detach; virtual;
    property Graph: TGraph read GetGraph;
    property Parser: TParser read FParser write SetParser;
    property Value: PValue read FValue write FValue;
    property Float80: PExtended read GetFloat80;
  end;

  // Разрыв фунцкии до и после массива значений фрагмента графика функции в рамках TParseThread
  TGapType = (gtBack, gtFace);
  TGap = array[TGapType] of Boolean;

  TParseThread = class(TGraphThread)
  private
    FAutoquality: Boolean;
    FStep: Extended;
    FEpsilon: Extended;
    FMaxY: Extended;
    FMaxX: Extended;
    FMinStep: Extended;
    FCompute: TComputeMethod;
    FPointToCursor: TConvertMethod;
    FCursorToPoint: TConvertMethod;
    FCS: TCoordinateSystem;
    FDisplay: TDisplay;
    FPointArray: TExactPointArray;
    FExamine: TExamineMethod;
    FGap: TGap;
    FRangeArray: TRangeArray;
    FScript: TScript;
    procedure SetScript(const AValue: TScript);
  protected
    function Map(const Range: TRange; const Space: Extended): TRangeArray; overload; virtual;
    function Map(var MapArray: TRangeArray; const Range: TRange; const Space: Extended): Boolean; overload; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Work; override;
    procedure Clear; virtual;
    function Push(const Range: TRange): Integer; virtual;
    property PointArray: TExactPointArray read FPointArray write FPointArray;
    property Gap: TGap read FGap write FGap;
    property MinStep: Extended read FMinStep write FMinStep;
    property Script: TScript read FScript write SetScript;
    property RangeArray: TRangeArray read FRangeArray write FRangeArray;
    property Step: Extended read FStep write FStep;
    property Display: TDisplay read FDisplay write FDisplay;
    property Epsilon: Extended read FEpsilon write FEpsilon;
    property Autoquality: Boolean read FAutoquality write FAutoquality;
    property CS: TCoordinateSystem read FCS write FCS;
    property MaxX: Extended read FMaxX write FMaxX;
    property MaxY: Extended read FMaxY write FMaxY;
    property Compute: TComputeMethod read FCompute write FCompute;
    property PointToCursor: TConvertMethod read FPointToCursor write FPointToCursor;
    property CursorToPoint: TConvertMethod read FCursorToPoint write FCursorToPoint;
    property Examine: TExamineMethod read FExamine write FExamine;
  end;

  TOverlapThread = class(TGraphThread)
  private
    FPrepared: Boolean;
    FMaxX: Extended;
    FEpsilon: Extended;
    FStep: Extended;
    FMaxY: Extended;
    FMin: Extended;
    FMax: Extended;
    FCompute: TComputeMethod;
    FCS: TCoordinateSystem;
    FExamine: TExamineMethod;
    FFormula: TFormulaList;
    FOverlapArray: TOverlapArray;
    FRangeArray: TRangeArray;
    FScriptArray: TScriptArray;
    function GetDistance: Extended;
    procedure SetScriptArray(const AValue: TScriptArray);
  protected
    property OverlapArray: TOverlapArray read FOverlapArray write FOverlapArray;
  public
    destructor Destroy; override;
    procedure Work; override;
    procedure Done; override;
    procedure Clear; virtual;
    property Prepared: Boolean read FPrepared write FPrepared;
    property ScriptArray: TScriptArray read FScriptArray write SetScriptArray;
    property Distance: Extended read GetDistance;
    property RangeArray: TRangeArray read FRangeArray write FRangeArray;
    property Min: Extended read FMin write FMin;
    property Max: Extended read FMax write FMax;
    property Step: Extended read FStep write FStep;
    property CS: TCoordinateSystem read FCS write FCS;
    property MaxX: Extended read FMaxX write FMaxX;
    property MaxY: Extended read FMaxY write FMaxY;
    property Formula: TFormulaList read FFormula write FFormula;
    property Epsilon: Extended read FEpsilon write FEpsilon;
    property Compute: TComputeMethod read FCompute write FCompute;
    property Examine: TExamineMethod read FExamine write FExamine;
  end;

  TExtremeThread = class(TGraphThread)
  private
    FPrepared: Boolean;
    FMaxY: Extended;
    FMaxX: Extended;
    FVoidRadius: Extended;
    FVaryRadius: Extended;
    FEpsilon: Extended;
    FCS: TCoordinateSystem;
    FMax: TExactPoint;
    FMin: TExactPoint;
    FMinArray: TExactPointArray;
    FMaxArray: TExactPointArray;
    FEntireArray: TExactPointArray;
    FFormula: TFormulaList;
  protected
    property MaxArray: TExactPointArray read FMaxArray write FMaxArray;
    property MinArray: TExactPointArray read FMinArray write FMinArray;
  public
    destructor Destroy; override;
    procedure Work; override;
    procedure Done; override;
    procedure Clear; virtual;
    property Prepared: Boolean read FPrepared write FPrepared;
    property VaryRadius: Extended read FVaryRadius write FVaryRadius;
    property VoidRadius: Extended read FVoidRadius write FVoidRadius;
    property Min: TExactPoint read FMin write FMin;
    property Max: TExactPoint read FMax write FMax;
    property CS: TCoordinateSystem read FCS write FCS;
    property MaxX: Extended read FMaxX write FMaxX;
    property MaxY: Extended read FMaxY write FMaxY;
    property Epsilon: Extended read FEpsilon write FEpsilon;
    property EntireArray: TExactPointArray read FEntireArray write FEntireArray;
    property Formula: TFormulaList read FFormula write FFormula;
  end;

const
  WM_INVALIDATE = WM_USER;
  OverlapCode = 1;
  ExtremeCode = 2;
  DefaultThreadCount = 2;
  DefaultColorArray: array[0..9] of TColor = (clMaroon, clNavy, clPurple, clRed, clOlive, clTeal, clGreen, clBlue, clFuchsia, clBlack);
  DefaultMaxX = 5;
  DefaultMaxY = 5;
  DefaultOffset: TExactPoint = (X: 0; Y: 0);
  DefaultXDigitCount = 3;
  DefaultYDigitCount = 3;
  DefaultAngleDigitCount = 3;
  DefaultAxisArrow: TSize = (cx: 15; cy: 8);
  DefaultShowAxis = True;
  DefaultShowGrid = True;
  DefaultHSpacing = 1;
  DefaultVSpacing = 1;
  DefaultZoomInFactor = 0.5;
  DefaultZoomOutFactor = 0.5;
  DefaultMinZoom: array[TCoordinateSystem] of Extended = (0.0000000000001, 0.00000001);
  DefaultMaxZoom: array[TCoordinateSystem] of Extended = (1000000000000, 10000000);
  DefaultLeadElapse = 25;
  DefaultZoomElapse = 15;
  AngleVariableName = 'T';
  ValueVariableName = 'X';
  MarkerMargin = 8;
  ExtremeVaryFactor = 5;
  ExtremeVoidFactor = 10;

function Check(const Target: TScriptArray; const Index: Integer): Boolean; overload;

function Check(const Target: TExactArray; const Index: Integer): Boolean; overload;
function Check(const Target: TExactPointArray; const Index: Integer): Boolean; overload;
function Check(const Target: TExactPointArray; const ArrayIndex, Index: Integer): Boolean; overload;

function Add(var Target: TExactArray; const Value: TExactPoint): Integer; overload;
function Add(var Target: TExactPointArray; const Value: TExactPoint; Index: Integer = -1): Integer; overload;
function Add(var Target: TExactPointArray; const Source: TExactArray): Integer; overload;
procedure Add(var Target: TExactPointArray; const Source: TExactPointArray; const SourceIndex: Integer; TargetIndex: Integer = -1); overload;
procedure Add(var Target: TExactPointArray; const Source: TExactPointArray); overload;
procedure Delete(var Target: TExactPointArray); overload;
function New(var Target: TExactPointArray): Integer; overload;

function Check(const Target: TArray; const Index: Integer): Boolean; overload;
function Check(const Target: TPointArray; const Index: Integer): Boolean; overload;
function Check(const Target: TPointArray; const ArrayIndex, Index: Integer): Boolean; overload;

function Add(var Target: TArray; const Value: TPoint): Integer; overload;
function Add(var Target: TPointArray; const Value: TPoint; Index: Integer = -1): Integer; overload;
function Add(var Target: TPointArray; const Source: TArray): Integer; overload;
procedure Delete(var Target: TPointArray); overload;
function New(var Target: TPointArray): Integer; overload;

function MakeRange(const AMin, AMax: Extended): TRange;
function MakeRangeArray(const RangeArray: array of TRange): TRangeArray; overload;
function MakeRangeArray(const Range: TRange): TRangeArray; overload;
function Add(var Target: TRangeArray; const Value: TRange): Integer; overload;
procedure Add(var Target: TRangeArray; const Source: TRangeArray); overload;
function Inside(const Target: Extended; const Range: TRange; const Epsilon: Extended = 0): Boolean;
function RangeCompare(const AIndex, BIndex: Integer; const Target: Pointer; const Data: Pointer = nil): TValueRelationship;
procedure RangeExchange(const AIndex, BIndex: Integer; const Target: Pointer; const Data: Pointer = nil);
procedure Sort(var Target: TRangeArray);

function MakePlace(const AArrayIndex, AIndex: Integer): TPlace;
function Empty(const Back, Face: TPlace): Boolean;

function Check(const Target: TExactPointArray; const Place: TPlace): Boolean; overload;
function Shift(const Target: TExactPointArray; const Back, Face: TPlace; const Distance: Integer; out Place: TPlace): Boolean; overload;
function Shift(const Target: TExactPointArray; const Back, Face: TPlace; const Distance: Integer; out Point: PExactPoint): Boolean; overload;
function MovePlace(const Target: TExactPointArray; const Place: TPlace; const Forward: Boolean; out Value: TPlace): Boolean; overload;
function NextPlace(const Target: TExactPointArray; const Place: TPlace; out Value: TPlace): Boolean; overload;
function NextPlace(const Target: TExactPointArray; const Place: TPlace): TPlace; overload;
function PrevPlace(const Target: TExactPointArray; const Place: TPlace; out Value: TPlace): Boolean; overload;
function PrevPlace(const Target: TExactPointArray; const Place: TPlace): TPlace; overload;
function LastPlace(const Target: TExactPointArray): TPlace; overload;
function NextPoint(const Target: TExactPointArray; const Back, Face: TPlace; const X: Extended; out Value: PExactPoint): Boolean; overload;
function PrevPoint(const Target: TExactPointArray; const Back, Face: TPlace; const X: Extended; out Value: PExactPoint): Boolean; overload;
function GetRange(const Target: TExactPointArray; const Back, Face: TPlace; const ArrayIndex: Integer; out Min, Max: Integer): Boolean; overload;

function Check(const Target: TPointArray; const Place: TPlace): Boolean; overload;
function Shift(const Target: TPointArray; const Back, Face: TPlace; const Distance: Integer; out Place: TPlace): Boolean; overload;
function Shift(const Target: TPointArray; const Back, Face: TPlace; const Distance: Integer; out Point: PPoint): Boolean; overload;
function MovePlace(const Target: TPointArray; const Place: TPlace; const Forward: Boolean; out Value: TPlace): Boolean; overload;
function NextPlace(const Target: TPointArray; const Place: TPlace; out Value: TPlace): Boolean; overload;
function NextPlace(const Target: TPointArray; const Place: TPlace): TPlace; overload;
function PrevPlace(const Target: TPointArray; const Place: TPlace; out Value: TPlace): Boolean; overload;
function PrevPlace(const Target: TPointArray; const Place: TPlace): TPlace; overload;
function LastPlace(const Target: TPointArray): TPlace; overload;
function NextPoint(const Target: TPointArray; const Back, Face: TPlace; const X: Integer; out Value: PPoint): Boolean; overload;
function PrevPoint(const Target: TPointArray; const Back, Face: TPlace; const X: Integer; out Value: PPoint): Boolean; overload;
function GetRange(const Target: TPointArray; const Back, Face: TPlace; const ArrayIndex: Integer; out Min, Max: Integer): Boolean; overload;

function Add(var Target: TOverlapArray; const Value: TOverlap): Integer; overload;
function MakeOverlap(const AAFormula, ABFormula: Integer; const APoint: TExactPoint): TOverlap; overload;
function MakeOverlap(const AAFormula, ABFormula: Integer; const APoint: TExactPoint; const AAAngle, ABAngle: Extended): TOverlap; overload;
function MakeOverlap(const Overlap: TOverlap; const AAAngle, ABAngle: Extended): TOverlap; overload;

var
  ZeroPoint: TExactPoint = (X: 0; Y: 0);

procedure Register;

implementation

uses
  Math, Notifier, MemoryUtils, NumberConsts, ParseConsts, ParseErrors, ParseUtils,
  StrUtils, {$IFDEF DELPHI_XE2}System.UITypes, {$ENDIF}ThreadUtils, ValueUtils;

procedure Register;
begin
  RegisterComponents('Samples', [TGraph]);
end;

function Check(const Target: TScriptArray; const Index: Integer): Boolean;
begin
  Result := (Index >= Low(Target)) and (Index <= High(Target));
end;

function Check(const Target: TExactArray; const Index: Integer): Boolean;
begin
  Result := (Index >= Low(Target)) and (Index <= High(Target));
end;

function Check(const Target: TExactPointArray; const Index: Integer): Boolean;
begin
  Result := (Index >= Low(Target)) and (Index <= High(Target));
end;

function Check(const Target: TExactPointArray; const ArrayIndex, Index: Integer): Boolean;
begin
  Result := Check(Target, ArrayIndex) and Check(Target[ArrayIndex], Index);
end;

function Add(var Target: TExactArray; const Value: TExactPoint): Integer;
begin
  Result := Length(Target);
  SetLength(Target, Result + 1);
  Target[Result] := Value;
end;

function Add(var Target: TExactPointArray; const Value: TExactPoint; Index: Integer): Integer;
begin
  if Index < 0 then
  begin
    Index := High(Target);
    if Index < 0 then Index := 0;
  end;
  if Index > High(Target) then SetLength(Target, Index + 1);
  Result := Add(Target[Index], Value);
end;

function Add(var Target: TExactPointArray; const Source: TExactArray): Integer;
var
  I: Integer;
begin
  I := Length(Source);
  if I > 0 then
  begin
    Result := High(Target);
    if (Result < 0) or (Length(Target[Result]) > 0) then
    begin
      Inc(Result);
      SetLength(Target, Result + 1);
    end;
    SetLength(Target[Result], I);
    CopyMemory(Target[Result], Source, I * SizeOf(TExactPoint));
  end
  else Result := -1;
end;

procedure Add(var Target: TExactPointArray; const Source: TExactPointArray; const SourceIndex: Integer; TargetIndex: Integer = -1);
var
  I, J: Integer;
begin
  if Assigned(Source[SourceIndex]) then
  begin
    if TargetIndex < 0 then
    begin
      TargetIndex := High(Target);
      if TargetIndex < 0 then TargetIndex := 0;
    end;
    if TargetIndex > High(Target) then SetLength(Target, TargetIndex + 1);
    I := Length(Target[TargetIndex]);
    J := Length(Source[SourceIndex]);
    SetLength(Target[TargetIndex], I + J);
    CopyMemory(Pointer(Integer(Target[TargetIndex]) + I * SizeOf(TExactPoint)), Source[SourceIndex], J * SizeOf(TExactPoint));
  end;
end;

procedure Add(var Target: TExactPointArray; const Source: TExactPointArray);
var
  I, J, K, L: Integer;
begin
  for I := Low(Source) to High(Source) do
  begin
    J := Length(Target);
    if (I = Low(Source)) and (J > 0) then
      Dec(J)
    else
      SetLength(Target, J + 1);
    K := Length(Target[J]);
    L := Length(Source[I]);
    SetLength(Target[J], K + L);
    CopyMemory(Pointer(Integer(Target[J]) + K * SizeOf(TExactPoint)), Source[I], L * SizeOf(TExactPoint));
  end;
end;

procedure Delete(var Target: TExactPointArray);
var
  I: Integer;
begin
  for I := Low(Target) to High(Target) do Target[I] := nil;
  Target := nil;
end;

function New(var Target: TExactPointArray): Integer;
begin
  Result := High(Target);
  if (Result < 0) or (Length(Target[Result]) > 0) then
  begin
    Inc(Result);
    SetLength(Target, Result + 1);
  end;
end;

function Check(const Target: TArray; const Index: Integer): Boolean;
begin
  Result := (Index >= Low(Target)) and (Index <= High(Target));
end;

function Check(const Target: TPointArray; const Index: Integer): Boolean;
begin
  Result := (Index >= Low(Target)) and (Index <= High(Target));
end;

function Check(const Target: TPointArray; const ArrayIndex, Index: Integer): Boolean;
begin
  Result := Check(Target, ArrayIndex) and Check(Target[ArrayIndex], Index);
end;

function Add(var Target: TArray; const Value: TPoint): Integer;
begin
  Result := Length(Target);
  SetLength(Target, Result + 1);
  Target[Result] := Value;
end;

function Add(var Target: TPointArray; const Value: TPoint; Index: Integer): Integer;
begin
  if Index < 0 then
  begin
    Index := High(Target);
    if Index < 0 then Index := 0;
  end;
  if Index > High(Target) then SetLength(Target, Index + 1);
  Result := Add(Target[Index], Value);
end;

function Add(var Target: TPointArray; const Source: TArray): Integer;
var
  I: Integer;
begin
  I := Length(Source);
  if I > 0 then
  begin
    Result := High(Target);
    if (Result < 0) or (Length(Target[Result]) > 0) then
    begin
      Inc(Result);
      SetLength(Target, Result + 1);
    end;
    SetLength(Target[Result], I);
    CopyMemory(Target[Result], Source, I * SizeOf(TPoint));
  end
  else Result := -1;
end;

procedure Delete(var Target: TPointArray);
var
  I: Integer;
begin
  for I := Low(Target) to High(Target) do Target[I] := nil;
  Target := nil;
end;

function New(var Target: TPointArray): Integer;
begin
  Result := High(Target);
  if (Result < 0) or (Length(Target[Result]) > 0) then
  begin
    Inc(Result);
    SetLength(Target, Result + 1);
  end;
end;

function MakeRange(const AMin, AMax: Extended): TRange;
begin
  with Result do
  begin
    Min := AMin;
    Max := AMax;
  end;
end;

function MakeRangeArray(const RangeArray: array of TRange): TRangeArray;
var
  I: Integer;
begin
  SetLength(Result, Length(RangeArray));
  for I := Low(Result) to High(Result) do Result[I] := RangeArray[I];
end;

function MakeRangeArray(const Range: TRange): TRangeArray;
begin
  Result := MakeRangeArray([Range]);
end;

function Add(var Target: TRangeArray; const Value: TRange): Integer;
begin
  Result := Length(Target);
  SetLength(Target, Result + 1);
  Target[Result] := Value;
end;

procedure Add(var Target: TRangeArray; const Source: TRangeArray);
var
  I, J: Integer;
begin
  I := Length(Target);
  J := Length(Source);
  SetLength(Target, I + J);
  CopyMemory(Pointer(Integer(Target) + I * SizeOf(TRange)), Source, J * SizeOf(TRange));
end;

function Inside(const Target: Extended; const Range: TRange; const Epsilon: Extended): Boolean;
begin
  Result := AboveOrEqual(Target, Range.Min, Epsilon) and BelowOrEqual(Target, Range.Max, Epsilon);
end;

function RangeCompare(const AIndex, BIndex: Integer; const Target: Pointer; const Data: Pointer = nil): TValueRelationship;
var
  RangeArray: TRangeArray absolute Target;
begin
  Result := CompareValue(RangeArray[AIndex].Min, RangeArray[BIndex].Min);
end;

procedure RangeExchange(const AIndex, BIndex: Integer; const Target: Pointer; const Data: Pointer = nil);
var
  Range: TRange;
  RangeArray: TRangeArray absolute Target;
begin
  Range := RangeArray[AIndex];
  RangeArray[AIndex] := RangeArray[BIndex];
  RangeArray[BIndex] := Range;
end;

procedure Sort(var Target: TRangeArray);
begin
  QuickSort(Target, Low(Target), High(Target), RangeCompare, RangeExchange);
end;

function MakePlace(const AArrayIndex, AIndex: Integer): TPlace;
begin
  with Result do
  begin
    ArrayIndex := AArrayIndex;
    Index := AIndex;
  end;
end;

function Empty(const Back, Face: TPlace): Boolean;
begin
  Result := (Face.ArrayIndex <= Back.ArrayIndex) and (Face.Index <= Back.Index);
end;

function Check(const Target: TExactPointArray; const Place: TPlace): Boolean;
begin
  Result := Check(Target, Place.ArrayIndex, Place.Index);
end;

function Shift(const Target: TExactPointArray; const Back, Face: TPlace; const Distance: Integer; out Place: TPlace): Boolean;
var
  I, J, K: Integer;
begin
  Result := not Empty(Back, Face) and Check(Target, Back) and Check(Target, Face);
  if Result then
  begin
    J := Distance;
    for I := Back.ArrayIndex to Face.ArrayIndex do
    begin
      K := Face.Index - Back.Index + 1;
      Result := J < K;
      if Result then
      begin
        Place := MakePlace(I, J);
        Exit;
      end;
      Dec(J, K);
    end;
    Result := False;
  end;
end;

function Shift(const Target: TExactPointArray; const Back, Face: TPlace; const Distance: Integer; out Point: PExactPoint): Boolean;
var
  Place: TPlace;
begin
  Result := Shift(Target, Back, Face, Distance, Place);
  if Result then Point := @Target[Place.ArrayIndex][Place.Index];
end;

function MovePlace(const Target: TExactPointArray; const Place: TPlace; const Forward: Boolean; out Value: TPlace): Boolean;
var
  Flag: Boolean;
  I, J: Integer;
begin
  Flag := True;
  I := Place.ArrayIndex;
  while Check(Target, I) do
  begin
    if Flag then
    begin
      if Forward then
        J := Place.Index + 1
      else
        J := Place.Index - 1;
      Flag := False;
    end
    else
      if Forward then
        J := 0
      else
        J := High(Target[I]);
    Result := Check(Target[I], J);
    if Result then
    begin
      Value := MakePlace(I, J);
      Exit;
    end;
    if Forward then
      Inc(I)
    else
      Dec(I);
  end;
  Result := False;
end;

function NextPlace(const Target: TExactPointArray; const Place: TPlace; out Value: TPlace): Boolean;
begin
  Result := MovePlace(Target, Place, True, Value);
end;

function NextPlace(const Target: TExactPointArray; const Place: TPlace): TPlace;
begin
  if not NextPlace(Target, Place, Result) then Result := Place;
end;

function PrevPlace(const Target: TExactPointArray; const Place: TPlace; out Value: TPlace): Boolean;
begin
  Result := MovePlace(Target, Place, False, Value);
end;

function PrevPlace(const Target: TExactPointArray; const Place: TPlace): TPlace;
begin
  if not PrevPlace(Target, Place, Result) then Result := Place;
end;

function LastPlace(const Target: TExactPointArray): TPlace;
var
  I, J: Integer;
begin
  I := High(Target);
  if I < 0 then Result := MakePlace(0, 0)
  else begin
    J := High(Target[I]);
    if J < 0 then
      Result := PrevPlace(Target, MakePlace(I, J))
    else
      Result := MakePlace(I, J);
  end;
end;

function NextPoint(const Target: TExactPointArray; const Back, Face: TPlace; const X: Extended; out Value: PExactPoint): Boolean;
var
  I: Integer;
begin
  I := 0;
  Value := nil;
  while Shift(Target, Back, Face, I, Value) and Below(Value.X, X) do Inc(I);
  Result := Assigned(Value);
end;

function PrevPoint(const Target: TExactPointArray; const Back, Face: TPlace; const X: Extended; out Value: PExactPoint): Boolean;
var
  I: Integer;
  Point: PExactPoint;
begin
  I := 0;
  Value := nil;
  while Shift(Target, Back, Face, I, Point) and Below(Point.X, X) do
  begin
    Value := Point;
    Inc(I);
  end;
  Result := Assigned(Value);
end;

function GetRange(const Target: TExactPointArray; const Back, Face: TPlace; const ArrayIndex: Integer; out Min, Max: Integer): Boolean;
var
  AFlag, BFlag: Boolean;
begin
  Result := Check(Target, Back) and Check(Target, Face);
  if Result then
  begin
    AFlag := Back.ArrayIndex = ArrayIndex;
    BFlag := Face.ArrayIndex = ArrayIndex;
    if AFlag and BFlag then
    begin
      Min := Back.Index;
      Max := Face.Index;
    end
    else begin
      if AFlag then
        Min := Back.Index
      else
        Min := 0;
      if BFlag then
        Max := Face.Index
      else
        Max := Length(Target[ArrayIndex]) - 1;
    end;
  end;
end;

function Check(const Target: TPointArray; const Place: TPlace): Boolean;
begin
  Result := Check(Target, Place.ArrayIndex, Place.Index);
end;

function Shift(const Target: TPointArray; const Back, Face: TPlace; const Distance: Integer; out Place: TPlace): Boolean;
var
  I, J, K: Integer;
begin
  Result := not Empty(Back, Face) and Check(Target, Back) and Check(Target, Face);
  if Result then
  begin
    J := Distance;
    for I := Back.ArrayIndex to Face.ArrayIndex do
    begin
      K := Face.Index - Back.Index + 1;
      Result := J < K;
      if Result then
      begin
        Place := MakePlace(I, J);
        Exit;
      end;
      Dec(J, K);
    end;
    Result := False;
  end;
end;

function Shift(const Target: TPointArray; const Back, Face: TPlace; const Distance: Integer; out Point: PPoint): Boolean;
var
  Place: TPlace;
begin
  Result := Shift(Target, Back, Face, Distance, Place);
  if Result then Point := @Target[Place.ArrayIndex][Place.Index];
end;

function MovePlace(const Target: TPointArray; const Place: TPlace; const Forward: Boolean; out Value: TPlace): Boolean;
var
  Flag: Boolean;
  I, J: Integer;
begin
  Flag := True;
  I := Place.ArrayIndex;
  while Check(Target, I) do
  begin
    if Flag then
    begin
      if Forward then
        J := Place.Index + 1
      else
        J := Place.Index - 1;
      Flag := False;
    end
    else
      if Forward then
        J := 0
      else
        J := High(Target[I]);
    Result := Check(Target[I], J);
    if Result then
    begin
      Value := MakePlace(I, J);
      Exit;
    end;
    if Forward then
      Inc(I)
    else
      Dec(I);
  end;
  Result := False;
end;

function NextPlace(const Target: TPointArray; const Place: TPlace; out Value: TPlace): Boolean;
begin
  Result := MovePlace(Target, Place, True, Value);
end;

function NextPlace(const Target: TPointArray; const Place: TPlace): TPlace;
begin
  if not NextPlace(Target, Place, Result) then Result := Place;
end;

function PrevPlace(const Target: TPointArray; const Place: TPlace; out Value: TPlace): Boolean;
begin
  Result := MovePlace(Target, Place, False, Value);
end;

function PrevPlace(const Target: TPointArray; const Place: TPlace): TPlace;
begin
  if not PrevPlace(Target, Place, Result) then Result := Place;
end;

function LastPlace(const Target: TPointArray): TPlace;
var
  I, J: Integer;
begin
  I := High(Target);
  if I < 0 then Result := MakePlace(0, 0)
  else begin
    J := High(Target[I]);
    if J < 0 then
      Result := PrevPlace(Target, MakePlace(I, J))
    else
      Result := MakePlace(I, J);
  end;
end;

function NextPoint(const Target: TPointArray; const Back, Face: TPlace; const X: Integer; out Value: PPoint): Boolean;
var
  I: Integer;
begin
  I := 0;
  Value := nil;
  while Shift(Target, Back, Face, I, Value) and (Value.X < X) do Inc(I);
  Result := Assigned(Value);
end;

function PrevPoint(const Target: TPointArray; const Back, Face: TPlace; const X: Integer; out Value: PPoint): Boolean;
var
  I: Integer;
  Point: PPoint;
begin
  I := 0;
  Value := nil;
  while Shift(Target, Back, Face, I, Point) and (Point.X < X) do
  begin
    Value := Point;
    Inc(I);
  end;
  Result := Assigned(Value);
end;

function GetRange(const Target: TPointArray; const Back, Face: TPlace; const ArrayIndex: Integer; out Min, Max: Integer): Boolean;
var
  AFlag, BFlag: Boolean;
begin
  Result := Check(Target, Back) and Check(Target, Face);
  if Result then
  begin
    AFlag := Back.ArrayIndex = ArrayIndex;
    BFlag := Face.ArrayIndex = ArrayIndex;
    if AFlag and BFlag then
    begin
      Min := Back.Index;
      Max := Face.Index;
    end
    else begin
      if AFlag then
        Min := Back.Index
      else
        Min := 0;
      if BFlag then
        Max := Face.Index
      else
        Max := Length(Target[ArrayIndex]) - 1;
    end;
  end;
end;

function Add(var Target: TOverlapArray; const Value: TOverlap): Integer;
begin
  Result := Length(Target);
  SetLength(Target, Result + 1);
  Target[Result] := Value;
end;

function MakeOverlap(const AAFormula, ABFormula: Integer; const APoint: TExactPoint): TOverlap;
begin
  FillChar(Result, SizeOf(TOverlap), 0);
  with Result do
  begin
    AFormula := AAFormula;
    BFormula := ABFormula;
    Point := APoint;
  end;
end;

function MakeOverlap(const AAFormula, ABFormula: Integer; const APoint: TExactPoint; const AAAngle, ABAngle: Extended): TOverlap;
begin
  Result := MakeOverlap(MakeOverlap(AAFormula, ABFormula, APoint), AAAngle, ABAngle);
end;

function MakeOverlap(const Overlap: TOverlap; const AAAngle, ABAngle: Extended): TOverlap;
begin
  Result := Overlap;
  with Result do
  begin
    AAngle := AAAngle;
    BAngle := ABAngle;
  end;
end;

{$IFNDEF DELPHI_2006}
{ TBitmap }

procedure TBitmap.SetSize(AWidth, AHeight: Integer);
begin
  Width := AWidth;
  Height := AHeight;
end;
{$ENDIF}

{ TThreadList }

function TThreadList.GetItem(Index: Integer): TParseThread;
begin
  Result := TParseThread(inherited Items[Index]);
end;

procedure TThreadList.SetItem(Index: Integer; const Value: TParseThread);
begin
  inherited Items[Index] := TObject(Value);
end;

{ TFormulaList }

function TFormulaList.AddObject(const S: string; AObject: TObject): Integer;
begin
  if IndexOf(S) < 0 then
    Result := inherited AddObject(S, AObject)
  else
    Result := -1;
end;

procedure TFormulaList.Clear;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do DeleteData(I);
  inherited;
end;

constructor TFormulaList.Create;
begin
  inherited;
  FBM := TBitManager.Create;
end;

procedure TFormulaList.DataNeeded(const Index: Integer);
var
  Data: PFormulaData;
begin
  if not Assigned(Objects[Index]) then
  begin
    System.New(Data);
    ZeroMemory(Data, SizeOf(TFormulaData));
    Objects[Index] := TObject(Data);
  end;
end;

procedure TFormulaList.Delete(Index: Integer);
begin
  if CheckIndex(Index) then DeleteData(Index);
  inherited;
end;

procedure TFormulaList.DeleteData(const Index: Integer);
var
  AData: PFormulaData;
begin
  AData := Data[Index];
  if Assigned(AData) then Dispose(AData);
end;

destructor TFormulaList.Destroy;
begin
  FBM.Free;
  Clear;
  inherited;
end;

function TFormulaList.GetActive(const Index: Integer): Boolean;
begin
  FBM.Open(Data[Index].Flag);
  Result := FBM.Bits[ActiveBitIndex];
end;

function TFormulaList.GetActiveCount: Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to Count - 1 do if Active[I] then Inc(Result);
end;

function TFormulaList.GetData(const Index: Integer): PFormulaData;
begin
  DataNeeded(Index);
  Result := PFormulaData(Objects[Index]);
end;

procedure TFormulaList.InsertItem(Index: Integer; const S: string; AObject: TObject);
begin
  inherited;
  Active[Index] := True;
end;

procedure TFormulaList.SetActive(const Index: Integer; const Value: Boolean);
begin
  FBM.Open(Data[Index].Flag);
  FBM.Bits[ActiveBitIndex] := Value;
  FBM.Save(Data[Index].Flag);
end;

{ TGraph }

procedure TGraph.Attach;
begin
  if Assigned(FParser) then
  begin
    FParser.IgnoreType[icFunction] := True;
    FParser.BeginUpdate;
    try
      FParser.AddVariable(AngleVariableName, FValue, False);
      FParser.AddVariable(ValueVariableName, FValue, False);
    finally
      FParser.EndUpdate;
      Parser.Notify(ntCompile, Self);
    end;
  end;
end;

procedure TGraph.Build;
begin
  Prepare;
  Parse;
  Paint;
end;

function TGraph.CalcSize: TSize;
begin
  with Result, ClientRect do
  begin
    cx := Right - Left;
    cy := Bottom - Top;
  end;
end;

procedure TGraph.Capture;
var
  I, J, K, Prior: Integer;
  APoint, BPoint: PExactPoint;
  CPoint: TPoint;
begin
  for I := 0 to FThreadList.Count - 1 do
  begin
    Prior := -1;
    for J := I - 1 downto 0 do
      if Assigned(FThreadList[J].PointArray) then
      begin
        Prior := J;
        Break;
      end;
    for J := Low(FThreadList[I].PointArray) to High(FThreadList[I].PointArray) do
    begin
      if (J > Low(FThreadList[I].PointArray)) or (FThreadList[I].Gap[gtBack]) or ((Prior >= 0) and (((I - Prior) > 1) or FThreadList[Prior].Gap[gtFace])) then
      begin
        New(FEntireArray);
        New(FCursorArray);
      end;
      Add(FEntireArray, FThreadList[I].PointArray, J);
      APoint := nil;
      for K := Low(FThreadList[I].PointArray[J]) to High(FThreadList[I].PointArray[J]) do
      begin
        BPoint := @FThreadList[I].PointArray[J][K];
        CPoint := MakePoint(PointToCursor(BPoint^));
        if Assigned(APoint) and Compare(MakePoint(PointToCursor(APoint^)), CPoint) or not Assigned(APoint) then
        begin
          Add(FCursorArray, CPoint);
          APoint := BPoint;
        end;
      end;
    end;
  end;
  for I := 0 to FThreadList.Count - 1 do FThreadList[I].Clear;
end;

procedure TGraph.Clear;
begin
  ForceStop;
  Delete(FTraceArray);
  ParseUtils.Delete(FScriptArray);
  Delete(FEntireArray);
  Delete(FCursorArray);
  FOverlapArray := nil;
  Delete(FMaxArray);
  Delete(FMinArray);
  FFormula.Clear;
end;

function TGraph.Compare(const APoint, BPoint: TPoint; const AAccuracy: Integer): Boolean;
begin
  if AAccuracy > 0 then
    Result := GetDistance(MakePoint(APoint), MakePoint(BPoint)) >= AAccuracy
  else
    Result := GetDistance(MakePoint(APoint), MakePoint(BPoint)) >= FAccuracy
end;

function TGraph.ComputePolar(const Value: Extended; const Script: TScript): TExactPoint;
begin
  Result := GetPoint(ZeroPoint, Value, Convert(FParser.Execute(Script)^, vtExtended).Float80);
end;

function TGraph.ComputeRectangular(const Value: Extended; const Script: TScript): TExactPoint;
begin
  Result := MakePoint(Value, Convert(FParser.Execute(Script)^, vtExtended).Float80);
end;

constructor TGraph.Create(AOwner: TComponent);
const
  ExtendedResolution = 1E-16;
var
  I: Integer;
  J: TCoordinateSystem;
begin
  inherited;
  FXDigitCount := DefaultXDigitCount;
  FYDigitCount := DefaultYDigitCount;
  FAngleDigitCount := DefaultAngleDigitCount;
  FAutoVary := DefaultAutoVary;
  FAutoVoid := DefaultAutoVoid;
  FLeadTimer := TExactTimer.Create(Self);
  with FLeadTimer do
  begin
    TimerType := ttOneShot;
    Elapse := DefaultLeadElapse;
    OnTimer := DoLeadTimer;
  end;
  FZoomTimer := TZoomTimer.Create(Self);
  with FZoomTimer do
  begin
    TimerType := ttOneShot;
    Elapse := DefaultZoomElapse;
    OnTimer := DoZoomTimer;
  end;
  FOverlapThread := TOverlapThread.Create(Self);
  FExtremeThread := TExtremeThread.Create(Self);
  FThreadList := TThreadList.Create;
  FValue.ValueType := vtExtended;
  FInternalParser := TMathParser.Create(Self);
  FInternalParser.Cached := False;
  SetParser(FInternalParser);
  FCompute[csRectangular] := ComputeRectangular;
  FCompute[csPolar] := ComputePolar;
  SetThreadCount(DefaultThreadCount);
  SetLength(FColorArray, Length(DefaultColorArray));
  for I := Low(FColorArray) to High(FColorArray) do FColorArray[I] := DefaultColorArray[I];
  FBuffer := TBitmap.Create;
  FBuffer.PixelFormat := pf24bit;
  FEpsilon := ExtendedResolution;
  FAccuracy := DefaultAccuracy;
  FAutoquality := DefaultAutoquality;
  FAxisArrow := DefaultAxisArrow;
  FAxisFont := TFont.Create;
  FAxisPen := TPen.Create;
  FCS := DefaultCS;
  Cursor := crCross;
  FSign := DefaultSign;
  FSignTransparency := DefaultSignTransparency;
  FSignLayout := DefaultSignLayout;
  FSignMargin := DefaultSignMargin;
  FSignFont := TFont.Create;
  FSignFont.Color := clWhite;
  FFormula := TFormulaList.Create;
  FFormulaFont := TFont.Create;
  FGraphPen := TPen.Create;
  FGraphPen.Color := clRed;
  FGridPen := TPen.Create;
  with FGridPen do
  begin
    Color := clGray;
    Style := psDot;
  end;
  FPolarAxisPen := TPen.Create;
  FPolarAxisPen.Color := clGray;
  Height := DefaultHeight;
  FMulticolor := DefaultMulticolor;
  Width := DefaultWidth;
  FHSpacing := DefaultHSpacing;
  for J := Low(TCoordinateSystem) to High(TCoordinateSystem) do
  begin
    FMinZoom[J] := DefaultMinZoom[J];
    FMaxZoom[J] := DefaultMaxZoom[J];
  end;
  FMarkerPen := TPen.Create;
  FMarkerPen.Color := clBlue;
  FMaxX := DefaultMaxX;
  FMaxY := DefaultMaxY;
  FOffset := DefaultOffset;
  FQuality := DefaultQuality;
  FAntialias := DefaultAntialias;
  FShowAxis := DefaultShowAxis;
  FShowGrid := DefaultShowGrid;
  FTracePen := TPen.Create;
  with FTracePen do
  begin
    Color := clBlue;
    Style := psDot;
  end;
  FTracing := DefaultTracing;
  FOverlap := DefaultOverlap;
  FExtreme := DefaultExtreme;
  FVSpacing := DefaultVSpacing;
  FZoomInFactor := DefaultZoomInFactor;
  FZoomOutFactor := DefaultZoomOutFactor;
end;

function TGraph.CursorToPoint(const Point: TPoint): TPoint;
begin
  Result := MakePoint(CursorToPoint(MakePoint(Point)));
end;

function TGraph.CursorToPoint(const Point: TExactPoint): TExactPoint;
begin
  Result.X := XToPoint(Point.X);
  Result.Y := YToPoint(Point.Y);
end;

procedure TGraph.DblClick;
var
  Point: TPoint;
begin
  inherited;
  if GetCursorPos(Point) and PtInRect(ClientRect, ScreenToClient(Point)) then Zoom(ztIn);
end;

destructor TGraph.Destroy;
begin
  FOverlapThread.Free;
  FExtremeThread.Free;
  FThreadList.Free;
  Delete(FTraceArray);
  ParseUtils.Delete(FScriptArray);
  Delete(FEntireArray);
  Delete(FCursorArray);
  FOverlapArray := nil;
  Delete(FMaxArray);
  Delete(FMinArray);
  FColorArray := nil;
  FBuffer.Free;
  FAxisFont.Free;
  FAxisPen.Free;
  FFormula.Free;
  FSignFont.Free;
  FFormulaFont.Free;
  FGraphPen.Free;
  FGridPen.Free;
  FPolarAxisPen.Free;
  FTracePen.Free;
  inherited;
end;

procedure TGraph.Detach;
begin
  if Assigned(FParser) then
  begin
    FParser.BeginUpdate;
    try
      FParser.DeleteVariable(FValue);
    finally
      FParser.EndUpdate;
      FParser.Notify(ntCompile, Self);
    end;
  end;
end;

procedure TGraph.DoLeadTimer(Sender: TObject);
var
  Point: TPoint;
begin
  Prepare;
  GetCursorPos(Point);
  Point := ScreenToClient(Point);
  if PtInRect(ClientRect, Point) then
  begin
    FOffset := MakePoint(- XToPoint(Point.X), - YToPoint(Point.Y));
    DoOffsetChange;
  end;
  Build;
end;

function TGraph.DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean;
begin
  Result := inherited DoMouseWheelDown(Shift, MousePos);
  MakeZoom(ztOut);
end;

function TGraph.DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean;
begin
  Result := inherited DoMouseWheelUp(Shift, MousePos);
  MakeZoom(ztIn);
end;

procedure TGraph.DoOffsetChange;
begin
  if Assigned(FOnOffsetChange) then FOnOffsetChange(Self);
end;

procedure TGraph.DoTrace(const FormulaIndex: Integer; const Angle: Extended; const Point: TExactPoint);
begin
  if Assigned(FOnPolarTrace) then FOnPolarTrace(Self, FormulaIndex, Angle, Point);
end;

procedure TGraph.DoTrace(const FormulaIndex: Integer; const Point: TExactPoint);
begin
  if Assigned(FOnRectangularTrace) then FOnRectangularTrace(Self, FormulaIndex, Point);
end;

procedure TGraph.DoTraceDone;
begin
  if Assigned(FOnTraceDone) then FOnTraceDone(Self);
end;

procedure TGraph.DoZoomTimer(Sender: TObject);
var
  Point: TPoint;
  Timer: TZoomTimer absolute Sender;
begin
  if GetCursorPos(Point) and PtInRect(ClientRect, ScreenToClient(Point)) then Zoom(Timer.ZoomType);
  Timer.ZoomType := ztNone;
end;

procedure TGraph.DrawFormula(const Target: TCanvas);
var
  I, J: Integer;
  Data: PFormulaData;
begin
  if not FMulticolor then J := FGraphPen.Color;
  for I := 0 to FFormula.Count - 1 do if FFormula.Active[I] then
  begin
    Data := FFormula.Data[I];
    if Assigned(Data) then DrawPointArray(Target, FCursorArray, FGraphPen, True, @Data.CursorBack, @Data.CursorFace, PColor(IfThen(FMulticolor, Integer(@Data.Color), Integer(@J))));
  end;
end;

procedure TGraph.DrawLine(const Angle: Extended);
var
  APoint, BPoint: TExactPoint;
begin
  if Equal(Angle, 0) then
  begin
    APoint := MakePoint(FMin.X, 0);
    BPoint := MakePoint(FMax.X, 0);
  end
  else begin
    APoint := GetIntersection(FMin, MakePoint(FMax.X, FMin.Y), ZeroPoint, GetPoint(ZeroPoint, Angle, 1));
    BPoint := GetIntersection(MakePoint(FMin.X, FMax.Y), FMax, ZeroPoint, APoint);
  end;
  FBuffer.Canvas.MoveTo(Round(XToCursor(APoint.X)), Round((YToCursor(APoint.Y))));
  FBuffer.Canvas.LineTo(Round(XToCursor(BPoint.X)), Round((YToCursor(BPoint.Y))));
end;

procedure TGraph.DrawMaximum(const Target: TCanvas);
const
  FontName = 'Courier New';
  FontSize = 8;
  HintMargin = 2;
  HintText = 'max';
var
  I, J, K, L, M: Integer;
  Data: PFormulaData;
  Cursor: TPoint;
  C: TColor;
  Extent: TSize;
  PointArray: TPointArray;
begin
  if FExtreme and FExtremeThread.Finished then
    for I := 0 to FFormula.Count - 1 do if FFormula.Active[I] then
    begin
      Data := FFormula.Data[I];
      if Assigned(Data) then for J := Data.MaxBack.ArrayIndex to Data.MaxFace.ArrayIndex do 
        if GetRange(FMaxArray, Data.MaxBack, Data.MaxFace, J, L, M) then
          for K := L to M do
          begin
            Cursor := MakePoint(PointToCursor(FMaxArray[J][K]));
            try
              if FMulticolor then
                C := Data.Color
              else
                C := clBlack;
              Target.Font.Name := FontName;
              Target.Font.Size := FontSize;
              Target.Font.Color := C;
              Extent := Target.TextExtent(HintText);
              Target.TextOut(Cursor.X - Extent.cx div 2, Cursor.Y + MarkerMargin div 2 + HintMargin, HintText);
              Add(PointArray, MakePoint(GraphicUtils.MakePoint(Cursor.X - MarkerMargin, Cursor.Y + MarkerMargin)));
              Add(PointArray, MakePoint(GraphicUtils.MakePoint(Cursor.X, Cursor.Y - MarkerMargin)));
              Add(PointArray, MakePoint(GraphicUtils.MakePoint(Cursor.X + MarkerMargin, Cursor.Y + MarkerMargin)));
              Add(PointArray, MakePoint(GraphicUtils.MakePoint(Cursor.X - MarkerMargin, Cursor.Y + MarkerMargin)));
              DrawPointArray(Target, PointArray, FMarkerPen, False, nil, nil, @C);
            finally
              PointArray := nil;
            end;
          end;
    end;
end;

procedure TGraph.DrawMinimum(const Target: TCanvas);
const
  FontName = 'Courier New';
  FontSize = 8;
  HintMargin = 4;
  HintText = 'min';
var
  I, J, K, L, M: Integer;
  Data: PFormulaData;
  Cursor: TPoint;
  C: TColor;
  Extent: TSize;
  PointArray: TPointArray;
begin
  if FExtreme and FExtremeThread.Finished then
    for I := 0 to FFormula.Count - 1 do if FFormula.Active[I] then
    begin
      Data := FFormula.Data[I];
      if Assigned(Data) then for J := Data.MinBack.ArrayIndex to Data.MinFace.ArrayIndex do 
        if GetRange(FMinArray, Data.MinBack, Data.MinFace, J, L, M) then
          for K := L to M do
          begin
            Cursor := MakePoint(PointToCursor(FMinArray[J][K]));
            try
              if FMulticolor then
                C := Data.Color
              else
                C := clBlack;
              Target.Font.Name := FontName;
              Target.Font.Size := FontSize;
              Target.Font.Color := C;
              Extent := Target.TextExtent(HintText);
              Target.TextOut(Cursor.X - Extent.cx div 2, Cursor.Y - MarkerMargin div 2 - HintMargin - Extent.cy, HintText);
              Add(PointArray, MakePoint(GraphicUtils.MakePoint(Cursor.X, Cursor.Y + MarkerMargin)));
              Add(PointArray, MakePoint(GraphicUtils.MakePoint(Cursor.X - MarkerMargin, Cursor.Y - MarkerMargin)));
              Add(PointArray, MakePoint(GraphicUtils.MakePoint(Cursor.X + MarkerMargin, Cursor.Y - MarkerMargin)));
              Add(PointArray, MakePoint(GraphicUtils.MakePoint(Cursor.X, Cursor.Y + MarkerMargin)));
              DrawPointArray(Target, PointArray, FMarkerPen, False, nil, nil, @C);
            finally
              PointArray := nil;
            end;
          end;
    end;
end;

procedure TGraph.DrawOverlap(const Target: TCanvas);
var
  I, J, K: Integer;
  AData, BData: PFormulaData;
  Cursor: TPoint;
  PointArray: TPointArray;
begin
  if FOverlap and FOverlapThread.Finished and (FFormula.ActiveCount > 1) then
    for I := Low(FOverlapArray) to High(FOverlapArray) do
    begin
      J := FOverlapArray[I].AFormula;
      K := FOverlapArray[I].BFormula;
      AData := FFormula.Data[J];
      BData := FFormula.Data[K];
      if FFormula.Active[J] and FFormula.Active[K] and Assigned(AData) and Assigned(BData) then
      begin
        Cursor := MakePoint(PointToCursor(FOverlapArray[I].Point));
        try
          Add(PointArray, MakePoint(GraphicUtils.MakePoint(Cursor.X - MarkerMargin, Cursor.Y + MarkerMargin)));
          Add(PointArray, MakePoint(GraphicUtils.MakePoint(Cursor.X - MarkerMargin, Cursor.Y - MarkerMargin)));
          Add(PointArray, MakePoint(GraphicUtils.MakePoint(Cursor.X + MarkerMargin, Cursor.Y - MarkerMargin)));
          DrawPointArray(Target, PointArray, FMarkerPen, False, nil, nil, @AData.Color);
          PointArray := nil;
          Add(PointArray, MakePoint(GraphicUtils.MakePoint(Cursor.X + MarkerMargin, Cursor.Y - MarkerMargin)));
          Add(PointArray, MakePoint(GraphicUtils.MakePoint(Cursor.X + MarkerMargin, Cursor.Y + MarkerMargin)));
          Add(PointArray, MakePoint(GraphicUtils.MakePoint(Cursor.X - MarkerMargin, Cursor.Y + MarkerMargin)));
          DrawPointArray(Target, PointArray, FMarkerPen);
          DrawPointArray(Target, PointArray, FMarkerPen, False, nil, nil, @BData.Color);
          PointArray := nil;
          Add(PointArray, MakePoint(GraphicUtils.MakePoint(Cursor.X - MarkerMargin, Cursor.Y + MarkerMargin)));
          Add(PointArray, MakePoint(GraphicUtils.MakePoint(Cursor.X + MarkerMargin, Cursor.Y - MarkerMargin)));
          DrawPointArray(Target, PointArray, FMarkerPen, False, nil, nil, @AData.Color);
          PointArray := nil;
          Add(PointArray, MakePoint(GraphicUtils.MakePoint(Cursor.X + MarkerMargin, Cursor.Y + MarkerMargin)));
          Add(PointArray, MakePoint(GraphicUtils.MakePoint(Cursor.X - MarkerMargin, Cursor.Y - MarkerMargin)));
          DrawPointArray(Target, PointArray, FMarkerPen, False, nil, nil, @BData.Color);
        finally
          PointArray := nil;
        end;
      end;
    end;
end;

function TGraph.DrawPointArray(const Target: TCanvas; const PointArray: TPointArray; const Pen: TPen; const Smooth: Boolean;
  const Back, Face: PPlace; const Color: PColor): Boolean;
var
  Entire: Boolean;
  C: TColor;
  G: TGPGraphics;
  P: TGPPen;
  I: Integer;
begin
  Entire := not Assigned(Back) or not Assigned(Face);
  Result := Assigned(PointArray) and (Entire or not Entire and not Empty(Back^, Face^) and Check(PointArray, Back^) and Check(PointArray, Face^));
  if Result then
  begin
    if Assigned(Pen) then Target.Pen := Pen;
    if FAntialias and Smooth then
    begin
      G := TGPGraphics.Create(Target.Handle);
      try
        G.SetCompositingQuality(CompositingQualityAssumeLinear);
        G.SetInterpolationMode(InterpolationModeHighQuality);
        G.SetSmoothingMode(SmoothingModeHighQuality);
        if Assigned(Color) then
          C := Color^
        else
          C := Target.Pen.Color;
        P := TGPPen.Create(ColorRefToARGB(C));
        try
          P.SetWidth(Target.Pen.Width);
          if Entire then
            for I := Low(PointArray) to High(PointArray) do G.DrawCurve(P, PGPPoint(PointArray[I]), Length(PointArray[I]))
          else
            for I := Back.ArrayIndex to Face.ArrayIndex do G.DrawCurve(P, PGPPoint(PointArray[I]), Length(PointArray[I]));
        finally
          P.Free;
        end;
      finally
        G.Free;
      end;
    end
    else begin
      C := Target.Pen.Color;
      try
        if Assigned(Color) then Target.Pen.Color := Color^;
        if Entire then
          for I := Low(PointArray) to High(PointArray) do Target.Polyline(PointArray[I])
        else
          for I := Back.ArrayIndex to Face.ArrayIndex do Target.Polyline(PointArray[I]);
      finally
        Target.Pen.Color := C;
      end;
    end;
  end;
end;

procedure TGraph.DrawSign;
type
  TBitmapType = (btSource, btTarget);
const
  XMargin = 3;
  YMargin = 3;
var
  Bitmap: TBitmap;
  I, J: Integer;
  K: TChannelType;
  ASize, BSize: TSize;
  APoint: TPoint;
  Data: PFormulaData;
  ARect: TRect;
  Line: array[TBitmapType] of Pointer;
  Pixel: array[TBitmapType] of PPixel;
begin
  if FSign and (FFormula.ActiveCount > 0) then
  begin
    Bitmap := TBitmap.Create;
    try
      Bitmap.PixelFormat := pf24bit;
      Bitmap.Canvas.Font.Assign(FSignFont);
      FillChar(ASize, SizeOf(TSize), 0);
      for I := 0 to FFormula.Count - 1 do if FFormula.Active[I] then
      begin
        Data := FFormula.Data[I];
        if Assigned(Data) then
        begin
          BSize := Bitmap.Canvas.TextExtent(Parser.ScriptToString(ScriptArray[Data.ScriptIndex], rmUser));
          if ASize.cx < BSize.cx + XMargin then ASize.cx := BSize.cx + XMargin;
          if ASize.cy < BSize.cy + YMargin then ASize.cy := BSize.cy + YMargin;
        end;
      end;
      I := FFormula.ActiveCount * ASize.cy;
      case FSignLayout of
        ltBottomLeft: APoint := Point(FSignMargin, ClientRect.Bottom - FSignMargin - I);
        ltBottomRight: APoint := Point(ClientRect.Right - FSignMargin - ASize.cx, ClientRect.Bottom - FSignMargin - I);
        ltTopLeft: APoint := Point(FSignMargin, FSignMargin);
      else
        APoint := Point(ClientRect.Right - FSignMargin - ASize.cx, FSignMargin);
      end;
      if APoint.X < 0 then APoint.X := 0;
      if APoint.Y < 0 then APoint.Y := 0;
      Bitmap.SetSize(IfThen(APoint.X + ASize.cx > FBuffer.Width, FBuffer.Width - APoint.X, ASize.cx), IfThen(APoint.Y + I > FBuffer.Height, FBuffer.Height - APoint.Y, I));
      J := 0;
      for I := 0 to FFormula.Count - 1 do if FFormula.Active[I] then
      begin
        Data := FFormula.Data[I];
        if Assigned(Data) then
        begin
          ARect := Rect(0, J, ASize.cx, J + ASize.cy);
          Bitmap.Canvas.Brush.Color := Data.Color;
          Bitmap.Canvas.FillRect(ARect);
          BSize := Bitmap.Canvas.TextExtent(FFormula[I]);
          Bitmap.Canvas.TextRect(ARect, XMargin div 2, ARect.Top + ((ARect.Bottom - ARect.Top) - BSize.cy) div 2, Parser.ScriptToString(ScriptArray[Data.ScriptIndex], rmUser));
          Inc(J, ASize.cy);
        end;
      end;
      I := 0;
      while (I < Bitmap.Height) and (APoint.Y + I < FBuffer.Height) do
      begin
        Line[btSource] := Bitmap.ScanLine[I];
        Line[btTarget] := Pointer(Integer(FBuffer.ScanLine[APoint.Y + I]) + APoint.X * SizeOf(TPixel));
        J := 0;
        while (J < Bitmap.Width) and (APoint.X + J < FBuffer.Width) do
        begin
          Pixel[btSource] := Pointer(Integer(Line[btSource]) + J * SizeOf(TPixel));
          Pixel[btTarget] := Pointer(Integer(Line[btTarget]) + J * SizeOf(TPixel));
          for K := Low(TChannelType) to High(TChannelType) do Pixel[btTarget, K] := CalcTransparency(Pixel[btTarget, K], Pixel[btSource, K], FSignTransparency);
          Inc(J);
        end;
        Inc(I);
      end;
    finally
      Bitmap.Free;
    end;
  end;
end;

function TGraph.Examine(const Point: TExactPoint): Boolean;
begin
  Result := not IsNan(Point.X) and not IsInfinite(Point.X) and not IsNan(Point.Y) and not IsInfinite(Point.Y) and
    AboveOrEqual(Point.X, FMin.X, FEpsilon) and BelowOrEqual(Point.X, FMax.X, FEpsilon) and
    AboveOrEqual(Point.Y, FMin.Y, FEpsilon) and BelowOrEqual(Point.Y, FMax.Y, FEpsilon);
end;

function TGraph.FloatFormat(const Scale: Extended; const Count: Integer): string;
const
  Template = '0.';
begin
  Result := Template + DupeString('0', FracSize(Scale) + Count);
end;

procedure TGraph.ForceStop;
var
  I: Integer;
begin
  for I := 0 to FThreadList.Count - 1 do FThreadList[I].ForceStop;
  FOverlapThread.ForceStop;
  FExtremeThread.ForceStop;
end;

function TGraph.GetBusy: Boolean;

  function Busy: Boolean;
  var
    I: Integer;
  begin
    for I := 0 to FThreadList.Count - 1 do
      if FThreadList[I].Started then
      begin
        Result := True;
        Exit;
      end;
    Result := False;
  end;

begin
  Result := Busy or (not Assigned(FOverlapThread) or FOverlapThread.Started) or
    (not Assigned(FExtremeThread) or FExtremeThread.Started);
end;

function TGraph.GetCompute(const CS: TCoordinateSystem): TComputeMethod;
begin
  Result := FCompute[FCS];
end;

function TGraph.GetDisplay: TDisplay;
var
  XA, YA, XB, YB: Boolean;
begin
  XA := AboveOrEqual(FMin.X, 0, FEpsilon);
  YA := AboveOrEqual(FMin.Y, 0, FEpsilon);
  XB := BelowOrEqual(FMax.X, 0, FEpsilon);
  YB := BelowOrEqual(FMax.Y, 0, FEpsilon);
  if XA and YA then
  begin
    Result.QuarterKind := qkA;
    if Equal(FMin.Y, 0) then
      Result.Range.Min := 0
    else
      Result.Range.Min := GetAngle(MakePoint(FMaxX, 0), ZeroPoint, MakePoint(FMax.X, FMin.Y));
    if Equal(FMin.X, 0) then
      Result.Range.Max := HalfPi
    else
      Result.Range.Max := GetAngle(MakePoint(FMaxX, 0), ZeroPoint, MakePoint(FMin.X, FMax.Y));
    Result.FromCenter[dtMin] := GetDistance(ZeroPoint, FMin);
    Result.FromCenter[dtMax] := GetDistance(ZeroPoint, FMax);
  end
  else if XB and YA then
  begin
    Result.QuarterKind := qkB;
    if Equal(FMax.X, 0) then
      Result.Range.Min := HalfPi
    else
      Result.Range.Min := GetAngle(MakePoint(FMaxX, 0), ZeroPoint, MakePoint(FMax.X, FMax.Y));
    if Equal(FMin.Y, 0) then
      Result.Range.Max := Pi
    else
      Result.Range.Max := GetAngle(MakePoint(FMaxX, 0), ZeroPoint, MakePoint(FMin.X, FMin.Y));
    Result.FromCenter[dtMin] := GetDistance(ZeroPoint, MakePoint(FMax.X, FMin.Y));
    Result.FromCenter[dtMax] := GetDistance(ZeroPoint, MakePoint(FMin.X, FMax.Y));
  end
  else if YB and XB then
  begin
    Result.QuarterKind := qkC;
    if Equal(FMax.Y, 0) then
      Result.Range.Min := Pi
    else
      Result.Range.Min := DoublePi - GetAngle(MakePoint(FMaxX, 0), ZeroPoint, MakePoint(FMin.X, FMax.Y));
    if Equal(FMax.X, 0) then
      Result.Range.Max := Pi + HalfPi
    else
      Result.Range.Max := DoublePi - GetAngle(MakePoint(FMaxX, 0), ZeroPoint, MakePoint(FMax.X, FMin.Y));
    Result.FromCenter[dtMin] := GetDistance(ZeroPoint, FMax);
    Result.FromCenter[dtMax] := GetDistance(ZeroPoint, FMin);
  end
  else if XA and YB then
  begin
    Result.QuarterKind := qkD;
    if Equal(FMin.X, 0) then
      Result.Range.Min := Pi + HalfPi
    else
      Result.Range.Min := DoublePi - GetAngle(MakePoint(FMaxX, 0), ZeroPoint, MakePoint(FMin.X, FMin.Y));
    if Equal(FMax.Y, 0) then
      Result.Range.Max := DoublePi
    else
      Result.Range.Max := DoublePi - GetAngle(MakePoint(FMaxX, 0), ZeroPoint, MakePoint(FMax.X, FMax.Y));
    Result.FromCenter[dtMin] := GetDistance(ZeroPoint, MakePoint(FMin.X, FMax.Y));
    Result.FromCenter[dtMax] := GetDistance(ZeroPoint, MakePoint(FMax.X, FMin.Y));
  end
  else if YA then
  begin
    Result.QuarterKind := qkAB;
    if Equal(FMin.Y, 0) then
    begin
      Result.Range.Min := 0;
      Result.Range.Max := Pi;
    end
    else begin
      Result.Range.Min := GetAngle(MakePoint(FMaxX, 0), ZeroPoint, MakePoint(FMax.X, FMin.Y));
      Result.Range.Max := GetAngle(MakePoint(FMaxX, 0), ZeroPoint, MakePoint(FMin.X, FMin.Y));
    end;
    Result.FromCenter[dtMin] := GetDistance(ZeroPoint, MakePoint(0, FMin.Y));
    if Above(Abs(FMax.X), Abs(FMin.X), FEpsilon) then
      // Область просмотра большей частью в 1 чевтерти
      Result.FromCenter[dtMax] := GetDistance(ZeroPoint, FMax)
    else
      // Область просмотра большей частью в 2 чевтерти
      Result.FromCenter[dtMax] := GetDistance(ZeroPoint, MakePoint(FMin.X, FMax.Y));
  end
  else if XB then
  begin
    Result.QuarterKind := qkBC;
    if Equal(FMax.X, 0) then
    begin
      Result.Range.Min := HalfPi;
      Result.Range.Max := Pi + HalfPi;
    end
    else begin
      Result.Range.Min := GetAngle(MakePoint(FMaxX, 0), ZeroPoint, MakePoint(FMax.X, FMax.Y));
      Result.Range.Max := DoublePi - GetAngle(MakePoint(FMaxX, 0), ZeroPoint, MakePoint(FMax.X, FMin.Y));
    end;
    Result.FromCenter[dtMin] := GetDistance(ZeroPoint, MakePoint(FMax.X, 0));
    if Above(Abs(FMax.Y), Abs(FMin.Y), FEpsilon) then
      // Область просмотра большей частью в 2 четверти
      Result.FromCenter[dtMax] := GetDistance(ZeroPoint, MakePoint(FMin.X, FMax.Y))
    else
      // Область просмотра большей частью в 3 четверти
      Result.FromCenter[dtMax] := GetDistance(ZeroPoint, FMin);
  end
  else if YB then
  begin
    Result.QuarterKind := qkCD;
    if Equal(FMax.Y, 0) then
    begin
      Result.Range.Min := Pi;
      Result.Range.Max := DoublePi;
    end
    else begin
      Result.Range.Min := DoublePi - GetAngle(MakePoint(FMaxX, 0), ZeroPoint, MakePoint(FMin.X, FMax.Y));
      Result.Range.Max := DoublePi - GetAngle(MakePoint(FMaxX, 0), ZeroPoint, MakePoint(FMax.X, FMax.Y));
    end;
    Result.FromCenter[dtMin] := GetDistance(ZeroPoint, MakePoint(0, FMax.Y));
    if Above(Abs(FMax.X), Abs(FMin.X), FEpsilon) then
      // Область просмотра большей частью в 4 чевтерти
      Result.FromCenter[dtMax] := GetDistance(ZeroPoint, MakePoint(FMax.X, FMin.Y))
    else
      // Область просмотра большей частью в 3 чевтерти
      Result.FromCenter[dtMax] := GetDistance(ZeroPoint, FMin);
  end
  else if XA then
  begin
    Result.QuarterKind := qkDA;
    if Equal(FMin.X, 0) then
    begin
      Result.Range.Min := Pi + HalfPi;
      Result.Range.Max := DoublePi + HalfPi;
    end
    else begin
      Result.Range.Min := DoublePi - GetAngle(MakePoint(FMaxX, 0), ZeroPoint, MakePoint(FMin.X, FMin.Y));
      Result.Range.Max := GetAngle(MakePoint(FMaxX, 0), ZeroPoint, MakePoint(FMin.X, FMax.Y));
    end;
    Result.FromCenter[dtMin] := GetDistance(ZeroPoint, MakePoint(FMin.X, 0));
    if Above(Abs(FMax.Y), Abs(FMin.Y), FEpsilon) then
      // Область просмотра большей частью в 1 четверти
      Result.FromCenter[dtMax] := GetDistance(ZeroPoint, FMax)
    else
      // Область просмотра большей частью в 4 четверти
      Result.FromCenter[dtMax] := GetDistance(ZeroPoint, MakePoint(FMax.X, FMin.Y));
  end
  else begin
    Result.QuarterKind := qkABCD;
    Result.Range := WholeRange;
    Result.FromCenter[dtMin] := 0;
    XA := Above(Abs(FMax.X), Abs(FMin.X), FEpsilon);
    YA := Above(Abs(FMax.Y), Abs(FMin.Y), FEpsilon);
    if XA then
      if YA then
        // Область просмотра большей частью в 1 четверти
        Result.FromCenter[dtMax] := GetDistance(ZeroPoint, FMax)
      else
        // Область просмотра большей частью в 4 четверти
        Result.FromCenter[dtMax] := GetDistance(ZeroPoint, MakePoint(FMax.X, FMin.Y))
    else
      if YA then
        // Область просмотра большей частью в 2 четверти
        Result.FromCenter[dtMax] := GetDistance(ZeroPoint, MakePoint(FMin.X, FMax.Y))
      else
        // Область просмотра большей частью в 3 четверти
        Result.FromCenter[dtMax] := GetDistance(ZeroPoint, FMin);
  end;
end;

function TGraph.GetMaxZoom: Extended;
begin
  Result := FMaxZoom[FCS];
end;

function TGraph.GetMinZoom: Extended;
begin
  Result := FMinZoom[FCS];
end;

function TGraph.GetPolarRangeArray: TRangeArray;
var
  ADisplay: TDisplay;
begin
  Result := nil;
  ADisplay := Display;
  case ADisplay.QuarterKind of
    qkA, qkB:
      begin
        Add(Result, ADisplay.Range);
        Add(Result, MakeRange(ADisplay.Range.Min + Pi, ADisplay.Range.Max + Pi));
      end;
    qkC, qkD:
      begin
        Add(Result, ADisplay.Range);
        Add(Result, MakeRange(ADisplay.Range.Min - Pi, ADisplay.Range.Max - Pi));
      end;
  else
    Add(Result, WholeRange);
  end;
end;

function TGraph.GetThreadCount: Integer;
begin
  Result := FThreadList.Count;
end;

procedure TGraph.Invalidate;
begin
  inherited;
  Prepare;
end;

function TGraph.MarkPoint(const Point: TExactPoint; var PointArray: TPointArray): Boolean;
var
  Cursor: TExactPoint;
begin
  Result := Examine(Point);
  if Result then
  begin
    Cursor := PointToCursor(Point);
    Add(PointArray, MakePoint(GraphicUtils.MakePoint(Cursor.X - MarkerMargin, Cursor.Y + MarkerMargin)));
    Add(PointArray, MakePoint(GraphicUtils.MakePoint(Cursor.X - MarkerMargin, Cursor.Y - MarkerMargin)));
    Add(PointArray, MakePoint(GraphicUtils.MakePoint(Cursor.X + MarkerMargin, Cursor.Y - MarkerMargin)));
    Add(PointArray, MakePoint(GraphicUtils.MakePoint(Cursor.X + MarkerMargin, Cursor.Y + MarkerMargin)));
    Add(PointArray, MakePoint(GraphicUtils.MakePoint(Cursor.X - MarkerMargin, Cursor.Y + MarkerMargin)));
    New(PointArray);
    Add(PointArray, MakePoint(GraphicUtils.MakePoint(Cursor.X - MarkerMargin, Cursor.Y + MarkerMargin)));
    Add(PointArray, MakePoint(GraphicUtils.MakePoint(Cursor.X + MarkerMargin, Cursor.Y - MarkerMargin)));
    New(PointArray);
    Add(PointArray, MakePoint(GraphicUtils.MakePoint(Cursor.X + MarkerMargin, Cursor.Y + MarkerMargin)));
    Add(PointArray, MakePoint(GraphicUtils.MakePoint(Cursor.X - MarkerMargin, Cursor.Y - MarkerMargin)));
    New(PointArray);
  end;
end;

procedure TGraph.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if not FMoving then
  begin
    FMoving := True;
    FPivotPoint := MakePoint(XToPoint(X), YToPoint(Y));
  end;
end;

procedure TGraph.MouseMove(Shift: TShiftState; X, Y: Integer);
type
  TRemote = record
    Shift: Extended;
    Point: TExactPoint;
    Alive: Boolean;
  end;

  TRemoteType = (rtFace, rtBack);

  function ToRemoteType(const Value: Boolean): TRemoteType;
  begin
    if Value then
      Result := rtFace
    else
      Result := rtBack;
  end;

  function MakeRemote(const AShift: Extended; const APoint: TExactPoint; const AAlive: Boolean): TRemote;
  begin
    with Result do
    begin
      Shift := AShift;
      Point := APoint;
      Alive := AAlive;
    end;
  end;

var
  Remote: array[TRemoteType] of TRemote;
  I: Integer;
  Data: PFormulaData;
  AShift: Extended;
  APoint, BPoint: TExactPoint;
  J: TRemoteType;
  ADisplay: TDisplay;
begin
  inherited;
  if FMoving then
  begin
    if ssRight in Shift then
      FOffset := MakePoint(FOffset.X + XToPoint(X), FOffset.Y + YToPoint(Y))
    else
      FOffset := MakePoint(FOffset.X - FPivotPoint.X + XToPoint(X), FOffset.Y - FPivotPoint.Y + YToPoint(Y));
    DoOffsetChange;
    Build;
  end
  else begin
    if not FLeadTimer.Active and FTracing and Assigned(FScriptArray) then
    begin
      Delete(FTraceArray);
      FillChar(Remote, SizeOf(Remote), 0);
      case FCS of
        csRectangular:
          if FFormula.ActiveCount > 0 then
          begin
            for I := 0 to FFormula.Count - 1 do if FFormula.Active[I] then
            begin
              Data := FFormula.Data[I];
              if Assigned(Data) and Check(FScriptArray, Data.ScriptIndex) then
              begin
                FValue.Float80 := XToPoint(X);
                APoint := ComputeRectangular(FValue.Float80, FScriptArray[Data.ScriptIndex]);
                if Examine(APoint) then
                begin
                  Remote[rtFace].Alive := True;
                  Add(FTraceArray, GraphicUtils.MakePoint(PointToCursor(MakePoint(FMin.X, APoint.Y))));
                  Add(FTraceArray, GraphicUtils.MakePoint(PointToCursor(MakePoint(FMax.X, APoint.Y))));
                  New(FTraceArray);
                  DoTrace(I, APoint);
                end;
              end;
            end;
            if Remote[rtFace].Alive then
            begin
              Add(FTraceArray, Point(X, Round(YToCursor(FMax.Y))));
              Add(FTraceArray, Point(X, Round(YToCursor(FMin.Y))));
              New(FTraceArray);
            end;
          end;
      else
        if FFormula.ActiveCount > 0 then
        begin
          for I := 0 to FFormula.Count - 1 do if FFormula.Active[I] then
          begin
            Data := FFormula.Data[I];
            if Assigned(Data) and Check(FScriptArray, Data.ScriptIndex) then
            begin
              FValue.Float80 := GetAngle(MakePoint(FMaxX, 0), ZeroPoint, CursorToPoint(GraphicUtils.MakePoint(X, Y)));
              if Above(Y, YToCursor(0), FEpsilon) then FValue.Float80 := DoublePi - FValue.Float80;
              APoint := ComputePolar(FValue.Float80, FScriptArray[Data.ScriptIndex]);
              if Examine(APoint) then
              begin
                ADisplay := Display;
                case ADisplay.QuarterKind of
                  qkA: BPoint := GetPoint(APoint, CounterClockwise(qtA, GetAngle(APoint, ZeroPoint)), - GetDistance(APoint, FMin));
                  qkB: BPoint := GetPoint(APoint, CounterClockwise(qtB, GetAngle(APoint, ZeroPoint)), - GetDistance(APoint, MakePoint(FMax.X, FMin.Y)));
                  qkC: BPoint := GetPoint(APoint, CounterClockwise(qtC, GetAngle(APoint, ZeroPoint)), - GetDistance(APoint, FMax));
                  qkD: BPoint := GetPoint(APoint, CounterClockwise(qtD, GetAngle(APoint, ZeroPoint)), - GetDistance(APoint, MakePoint(FMin.X, FMax.Y)));
                  qkAB: BPoint := GetIntersection(APoint, ZeroPoint, FMin, MakePoint(FMax.X, FMin.Y));
                  qkBC: BPoint := GetIntersection(APoint, ZeroPoint, FMax, MakePoint(FMax.X, FMin.Y));
                  qkCD: BPoint := GetIntersection(APoint, ZeroPoint, MakePoint(FMin.X, FMax.Y), FMax);
                  qkDA: BPoint := GetIntersection(APoint, ZeroPoint, FMin, MakePoint(FMin.X, FMax.Y));
                  qkABCD: BPoint := ZeroPoint;
                end;
                if Equal(APoint.Y, 0, FEpsilon) then
                  J := ToRemoteType(Above(APoint.X, 0, FEpsilon))
                else
                  J := ToRemoteType(Above(APoint.Y, 0, FEpsilon));
                AShift := GetDistance(APoint, BPoint);
                if Above(AShift, Remote[J].Shift, FEpsilon) then Remote[J] := MakeRemote(AShift, APoint, True);
                Add(FTraceArray, MakePoint(PointToCursor(MakePoint(FMin.X, APoint.Y))));
                Add(FTraceArray, MakePoint(PointToCursor(MakePoint(FMax.X, APoint.Y))));
                New(FTraceArray);
                DoTrace(I, FValue.Float80, APoint);
              end;
            end;
            if Remote[rtFace].Alive and Remote[rtBack].Alive then
            begin
              Add(FTraceArray, MakePoint(PointToCursor(Remote[rtFace].Point)));
              Add(FTraceArray, MakePoint(PointToCursor(Remote[rtBack].Point)));
              New(FTraceArray);
            end
            else if Remote[rtFace].Alive then
            begin
              Add(FTraceArray, MakePoint(PointToCursor(BPoint)));
              Add(FTraceArray, MakePoint(PointToCursor(Remote[rtFace].Point)));
              New(FTraceArray);
            end
            else if Remote[rtBack].Alive then
            begin
              Add(FTraceArray, MakePoint(PointToCursor(BPoint)));
              Add(FTraceArray, MakePoint(PointToCursor(Remote[rtBack].Point)));
              New(FTraceArray);
            end;
          end;
        end;
      end;
      DoTraceDone;
      Canvas.Draw(0, 0, FBuffer);
      if Assigned(FTraceArray) then DrawPointArray(Canvas, FTraceArray, FTracePen);
    end;
  end;
end;

procedure TGraph.MakeColor(const Formula: Integer);
begin
  FFormula.Data[Formula].Color := TColor(RGB(Random(MaxByte + 1), Random(MaxByte + 1), Random(MaxByte + 1)));
end;

procedure TGraph.MakeZoom(const ZoomType: TZoomType);
begin
  FZoomTimer.Active := True;
  FZoomTimer.ZoomType := ZoomType;
  FZoomTimer.SetTimer;
end;

procedure TGraph.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if FMoving then FMoving := False;
end;

procedure TGraph.Notification(Component: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (Component = FParser) then SetParser(nil);
end;

procedure TGraph.Paint;
const
  // Максимальное число линий
  MaxLC = 500;
  XText = 'X';
  YText = 'Y';
  TextMargin = 20;
var
  I: Integer;
  APoint, BPoint, CPoint: TExactPoint;
  ADisplay: TDisplay;
  S: string;
begin
  inherited;
  FBuffer.SetSize(FSize.cx, FSize.cy);
  FBuffer.Canvas.Brush.Color := Color;
  FBuffer.Canvas.FillRect(Rect(0, 0, FBuffer.Width, FBuffer.Height));
  if FShowGrid then
  begin
    I := Round(FMaxX / FHSpacing + FMaxY / FVSpacing);
    if I < MaxLC then
      case FCS of
        csRectangular:
          begin
            FBuffer.Canvas.Pen.Assign(FGridPen);
            I := FBuffer.Canvas.Pen.Width;
            if FShowAxis then
              APoint := MakePoint(- FHSpacing, - FVSpacing)
            else
              APoint := ZeroPoint;
            while AboveOrEqual(APoint.X, FMin.X, FEpsilon) do
            begin
              FBuffer.Canvas.MoveTo(Round(XToCursor(APoint.X)), Round(YToCursor(FMin.Y)));
              FBuffer.Canvas.LineTo(Round(XToCursor(APoint.X)), Round(YToCursor(FMax.Y)));
              APoint.X := APoint.X - FHSpacing;
            end;
            while AboveOrEqual(APoint.Y, FMin.Y, FEpsilon) do
            begin
              FBuffer.Canvas.MoveTo(Round(XToCursor(FMin.X)), Round(YToCursor(APoint.Y)) - I);
              FBuffer.Canvas.LineTo(Round(XToCursor(FMax.X)), Round(YToCursor(APoint.Y)) - I);
              APoint.Y := APoint.Y - FVSpacing;
            end;
            APoint := MakePoint(FHSpacing, FVSpacing);
            while BelowOrEqual(APoint.X, FMax.X, FEpsilon) do
            begin
              FBuffer.Canvas.MoveTo(Round(XToCursor(APoint.X) - I), Round(YToCursor(FMin.Y)));
              FBuffer.Canvas.LineTo(Round(XToCursor(APoint.X) - I), Round(YToCursor(FMax.Y)));
              APoint.X := APoint.X + FHSpacing;
            end;
            while BelowOrEqual(APoint.Y, FMax.Y, FEpsilon) do
            begin
              FBuffer.Canvas.MoveTo(Round(XToCursor(FMin.X)), Round(YToCursor(APoint.Y)));
              FBuffer.Canvas.LineTo(Round(XToCursor(FMax.X)), Round(YToCursor(APoint.Y)));
              APoint.Y := APoint.Y + FVSpacing;
            end;
          end;
      else
        FBuffer.Canvas.Pen.Assign(FPolarAxisPen);
        FBuffer.Canvas.Pen.Assign(FPolarAxisPen);
        DrawLine(Pi / 4);
        DrawLine(Pi * 3 / 4);
        FBuffer.Canvas.Pen.Assign(FGridPen);
        DrawLine(Pi / 8);
        DrawLine(TriplePi / 8);
        DrawLine(Pi * 5 / 8);
        DrawLine(Pi * 7 / 8);
        ADisplay := Display;
        if Above(ADisplay.FromCenter[dtMin], 0, FEpsilon) then
          APoint := MakePoint(NextStep(ADisplay.FromCenter[dtMin], FHSpacing, 1), NextStep(ADisplay.FromCenter[dtMin], FVSpacing, 1))
        else
          APoint := MakePoint(FHSpacing, FVSpacing);
        FBuffer.Canvas.Brush.Style := bsClear;
        while BelowOrEqual(APoint.X, ADisplay.FromCenter[dtMax], FEpsilon) and BelowOrEqual(APoint.Y, ADisplay.FromCenter[dtMax], FEpsilon) do
        begin
          FBuffer.Canvas.Ellipse(Round(XToCursor(- APoint.X)), Round(YToCursor(- APoint.Y)), Round(XToCursor(APoint.X)), Round(YToCursor(APoint.Y)));
          APoint.X := APoint.X + FHSpacing;
          APoint.Y := APoint.Y + FVSpacing;
        end;
      end;
  end;
  if FShowAxis then
  begin
    FBuffer.Canvas.Pen.Assign(FAxisPen);
    FBuffer.Canvas.MoveTo(Round(XToCursor(0)), Round(YToCursor(FMin.Y)));
    FBuffer.Canvas.LineTo(Round(XToCursor(0)), Round(YToCursor(FMax.Y)));
    FBuffer.Canvas.MoveTo(Round(XToCursor(FMin.X)), Round(YToCursor(0)));
    FBuffer.Canvas.LineTo(Round(XToCursor(FMax.X)), Round(YToCursor(0)));
    FBuffer.Canvas.Brush.Color := FBuffer.Canvas.Pen.Color;
    APoint := MakePoint(XToCursor(FMax.X) - FAxisArrow.cx, YToCursor(0) - FAxisArrow.cy);
    BPoint := MakePoint(XToCursor(FMax.X), YToCursor(0));
    CPoint := MakePoint(XToCursor(FMax.X) - FAxisArrow.cx, YToCursor(0) + FAxisArrow.cy);
    FBuffer.Canvas.Polygon([MakePoint(APoint), MakePoint(BPoint), MakePoint(CPoint)]);
    APoint := MakePoint(XToCursor(0) - FAxisArrow.cy, YToCursor(FMax.Y) + FAxisArrow.cx);
    BPoint := MakePoint(XToCursor(0), YToCursor(FMax.Y));
    CPoint := MakePoint(XToCursor(0) + FAxisArrow.cy, YToCursor(FMax.Y) + FAxisArrow.cx);
    FBuffer.Canvas.Polygon([MakePoint(APoint), MakePoint(BPoint), MakePoint(CPoint)]);
    FBuffer.Canvas.Brush.Style := bsClear;
    FBuffer.Canvas.Font.Assign(FAxisFont);
    FBuffer.Canvas.TextOut(Round(XToCursor(FMax.X)) - FBuffer.Canvas.TextWidth(XText), Round(YToCursor(0)) - TextMargin - FBuffer.Canvas.TextHeight(XText), XText);
    S := FormatFloat(FXFormat, FMax.X);
    FBuffer.Canvas.TextOut(Size.cx - FBuffer.Canvas.TextWidth(S), Round(FCenter.Y) + TextMargin, S);
    S := FormatFloat(FXFormat, FMin.X);
    FBuffer.Canvas.TextOut(0, Round(FCenter.Y) + TextMargin, S);
    FBuffer.Canvas.TextOut(Round(XToCursor(0)) - TextMargin - FBuffer.Canvas.TextWidth(YText), Round(YToCursor(FMax.Y)), YText);
    S := FormatFloat(FYFormat, FMax.Y);
    FBuffer.Canvas.TextOut(Round(FCenter.X) + TextMargin, 0, S);
    S := FormatFloat(FYFormat, FMin.Y);
    FBuffer.Canvas.TextOut(Round(FCenter.X) + TextMargin, Size.cy - FBuffer.Canvas.TextHeight(S), S);
  end;
  DrawFormula(FBuffer.Canvas);
  DrawOverlap(FBuffer.Canvas);
  DrawMaximum(FBuffer.Canvas);
  DrawMinimum(FBuffer.Canvas);
  DrawSign;
  Canvas.Draw(0, 0, FBuffer);
end;

procedure TGraph.Parse(const Script: TScript; const RangeArray: TRangeArray; const Step: Extended; const MinStep: PExtended);
var
  I, J: Integer;
  Count, Start: Extended;
  Thread: TParseThread;
begin
  for I := Low(RangeArray) to High(RangeArray) do
  begin
    Count := (RangeArray[I].Max - RangeArray[I].Min) / FThreadList.Count;
    for J := 0 to FThreadList.Count - 1 do
    begin
      FThreadList[J].Clear;
      FThreadList[J].Parser := FParser;
    end;
    for J := 0 to FThreadList.Count - 1 do
    begin
      Thread := FThreadList[J];
      Thread.Value := @FValue;
      Start := RangeArray[I].Min + J * Count;
      Thread.Push(MakeRange(Start, Start + Count));
      Thread.Step := Step;
      Thread.Display := Display;
      Thread.Script := Copy(Script);
      Thread.Epsilon := FEpsilon;
      Thread.Autoquality := FAutoquality;
      Thread.CS := FCS;
      Thread.MaxX := FMaxX;
      Thread.MaxY := FMaxY;
      Thread.Compute := FCompute[FCS];
      Thread.PointToCursor := PointToCursor;
      Thread.CursorToPoint := CursorToPoint;
      Thread.Examine := Examine;
      Thread.Start;
    end;
    if Assigned(MinStep) then MinStep^ := 0;
    for J := 0 to FThreadList.Count - 1 do
    begin
      FThreadList[J].WaitFor(MaxInt);
      if Assigned(MinStep) and Below(MinStep^, FThreadList[J].MinStep, FEpsilon) then MinStep^ := FThreadList[J].MinStep;
    end;
    Capture;
  end;
end;

procedure TGraph.Parse;
var
  I, J: Integer;
  Script: TScript;
  Step: Extended;
  Data: PFormulaData;
begin
  ForceStop;
  FOverlapThread.Clear;
  FExtremeThread.Clear;
  Delete(FTraceArray);
  ParseUtils.Delete(FScriptArray);
  Delete(FEntireArray);
  Delete(FCursorArray);
  FOverlapArray := nil;
  Delete(FMaxArray);
  Delete(FMinArray);
  for I := 0 to FFormula.Count - 1 do
  begin
    FParser.StringToScript(FFormula[I], Script);
    try
      FFormula.Data[I].ScriptIndex := Add(FScriptArray, Script);
    finally
      Script := nil;
    end;
    J := I;
    while J >= Length(FColorArray) do Dec(J, Length(FColorArray));
    FFormula.Data[I].Color := FColorArray[J];
    for J := 0 to FThreadList.Count - 1 do FThreadList[J].RangeArray := nil;
    case FCS of
      csRectangular:
        begin
          FOverlapThread.RangeArray := MakeRangeArray(MakeRange(FMin.X, FMax.X));
          Step := (FMaxX + FMaxY) / PointCount / FQuality;
          Parse(FScriptArray[FFormula.Data[I].ScriptIndex], FOverlapThread.RangeArray, Step, @Step);
          if I = 0 then
            FOverlapThread.Step := Step
          else
            if Above(FOverlapThread.Step, Step) then FOverlapThread.Step := Step;
        end
    else
      FOverlapThread.RangeArray := PolarRangeArray;
      if Assigned(FOverlapThread.RangeArray) then
      begin
        Step := FOverlapThread.Distance / Length(FOverlapThread.RangeArray);
        Step := (FMaxX + FMaxY) * Step / PointCount(@Step) / FQuality;
        Parse(FScriptArray[FFormula.Data[I].ScriptIndex], FOverlapThread.RangeArray, Step, @Step);
        if I = 0 then
          FOverlapThread.Step := Step
        else
          if Above(FOverlapThread.Step, Step) then FOverlapThread.Step := Step;
      end;
    end;
    if I < FFormula.Count - 1 then
    begin
      New(FEntireArray);
      New(FCursorArray);
    end;
    Data := FFormula.Data[I];
    if I > 0 then
    begin
      Data.EntireBack := NextPlace(FEntireArray, FFormula.Data[I - 1].EntireFace);
      Data.CursorBack := NextPlace(FCursorArray, FFormula.Data[I - 1].CursorFace);
    end
    else begin
      Data.EntireBack := MakePlace(0, 0);
      Data.CursorBack := MakePlace(0, 0);
    end;
    Data.EntireFace := LastPlace(FEntireArray);
    Data.CursorFace := LastPlace(FCursorArray);
  end;
  FOverlapThread.Parser := FParser;
  FExtremeThread.Parser := FParser;
  if Assigned(FScriptArray) and Assigned(FOverlapThread.RangeArray) then
  begin
    FOverlapThread.Value := @FValue;
    FOverlapThread.OverlapArray := nil;
    FOverlapThread.ScriptArray := FScriptArray;
    FOverlapThread.Min := FMin.Y;
    FOverlapThread.Max := FMax.Y;
    FOverlapThread.CS := FCS;
    FOverlapThread.MaxX := FMaxX;
    FOverlapThread.MaxY := FMaxY;
    FOverlapThread.Formula := FFormula;
    FOverlapThread.Epsilon := FEpsilon;
    FOverlapThread.Compute := FCompute[FCS];
    FOverlapThread.Examine := Examine;
    FOverlapThread.Prepared := True;
    if FOverlap then FOverlapThread.Start;
  end;
  if Assigned(FEntireArray) then
  begin
    FExtremeThread.VaryRadius := FExtremeVaryRadius;
    FExtremeThread.VoidRadius := FExtremeVoidRadius;
    FExtremeThread.Min := FMin;
    FExtremeThread.Max := FMax;
    FExtremeThread.CS := FCS;
    FExtremeThread.MaxX := FMaxX;
    FExtremeThread.MaxY := FMaxY;
    FExtremeThread.Epsilon := FEpsilon;
    FExtremeThread.EntireArray := FEntireArray;
    FExtremeThread.Formula := FFormula;
    FExtremeThread.Prepared := True;
    if FExtreme then FExtremeThread.Start;
  end;
end;

function TGraph.PointCount(const Segment: PExtended): Extended;
begin
  case FCS of
    csRectangular: Result := FSize.cx;
  else
    if Assigned(Segment) then
      Result := Segment^ * (FSize.cx + FSize.cy) / 2
    else
      Result := DoublePi * (FSize.cx + FSize.cy) / 2;
  end;
end;

function TGraph.PointToCursor(const Point: TPoint): TPoint;
begin
  Result := MakePoint(PointToCursor(MakePoint(Point)));
end;

procedure TGraph.Prepare;
var
  Resolution: Extended;
  ADisplay: TDisplay;
begin
  FSize := CalcSize;
  FCenter := MakePoint(FSize.cx / 2, FSize.cy / 2);
  FMin := MakePoint(- FMaxX - FOffset.X, - FMaxY - FOffset.Y);
  FMax := MakePoint(FMaxX - FOffset.X, FMaxY - FOffset.Y);
  FXFactor := FCenter.X / FMaxX;
  FYFactor := FCenter.Y / FMaxY;
  if FAutoVary or FAutoVoid then
  begin
    Resolution := GetDistance(CursorToPoint(GraphicUtils.MakePoint(0, 0)), CursorToPoint(GraphicUtils.MakePoint(1, 1)));
    if FAutoVary then FExtremeVaryRadius := ExtremeVaryFactor * Resolution;
    if FAutoVoid then FExtremeVoidRadius := ExtremeVoidFactor * Resolution;
  end;
  FXFormat := FloatFormat(FMaxX, FXDigitCount);
  FYFormat := FloatFormat(FMaxY, FYDigitCount);
  ADisplay := Display;
  FAngleFormat := FloatFormat(ADisplay.Range.Max - ADisplay.Range.Min, FAngleDigitCount);
end;

function TGraph.PointToCursor(const Point: TExactPoint): TExactPoint;
begin
  Result.X := XToCursor(Point.X);
  Result.Y := YToCursor(Point.Y);
end;

procedure TGraph.Resize;
begin
  inherited;
  Build;
end;

procedure TGraph.SetExtreme(const Value: Boolean);
begin
  FExtreme := Value;
  if FExtreme and FExtremeThread.Prepared then FExtremeThread.Start;
end;

procedure TGraph.SetCS(const Value: TCoordinateSystem);
begin
  if FCS <> Value then
  begin
    Clear;
    FCS := Value;
    Zoom(ztNone);
  end;
end;

procedure TGraph.SetFormula(const Value: TFormulaList);
begin
  FFormula.Assign(Value);
end;

procedure TGraph.SetMaxZoom(const Value: Extended);
begin
  FMaxZoom[FCS] := Value;
end;

procedure TGraph.SetMinZoom(const Value: Extended);
begin
  FMinZoom[FCS] := Value;
  if Below(FMinZoom[FCS], FEpsilon) then FEpsilon := FMinZoom[FCS];
end;

procedure TGraph.SetOffset(const Value: TExactPoint);
begin
  FOffset := Value;
  DoOffsetChange;
  Prepare;
end;

procedure TGraph.SetOverlap(const Value: Boolean);
begin
  FOverlap := Value;
  if FOverlap and FOverlapThread.Prepared then FOverlapThread.Start;
end;

procedure TGraph.SetParser(const Value: TParser);
var
  I: Integer;
begin
  if FParser <> Value then
  begin
    Detach;
    FParser := Value;
    Attach;
  end;
  for I := 0 to FThreadList.Count - 1 do FThreadList[I].Parser := Value;
  FOverlapThread.Parser := Value;
  FExtremeThread.Parser := Value;
end;

procedure TGraph.SetThreadCount(const Value: Integer);
var
  I, J: Integer;
begin
  if FThreadList.Count <> Value then
    if Value > FThreadList.Count then
    begin
      J := FThreadList.Count;
      FThreadList.Count := Value;
      for I := J to FThreadList.Count - 1 do
      begin
        ThreadList[I] := TParseThread.Create(Self);
        ThreadList[I].Priority := tpHigher;
      end;
    end
    else FThreadList.Count := Value;
end;

procedure TGraph.Stop;
var
  I: Integer;
begin
  for I := 0 to FThreadList.Count - 1 do FThreadList[I].Stop;
  FOverlapThread.Stop;
  FExtremeThread.Stop;
end;

procedure TGraph.WaitFor;
var
  I: Integer;
begin
  for I := 0 to FThreadList.Count - 1 do FThreadList[I].WaitFor(MaxInt);
  FOverlapThread.WaitFor(MaxInt);
  FExtremeThread.WaitFor(MaxInt);
end;

procedure TGraph.WndProc(var Message: TMessage);
begin
  case Message.Msg of
    WM_INVALIDATE:
      case Message.WParam of
        OverlapCode:
          begin
            DrawOverlap(FBuffer.Canvas);
            Canvas.Draw(0, 0, FBuffer);
          end;
        ExtremeCode:
          begin
            DrawMaximum(FBuffer.Canvas);
            DrawMinimum(FBuffer.Canvas);
            Canvas.Draw(0, 0, FBuffer);
          end;
      end;
    CM_INVALIDATE: Paint;
  else inherited;
  end;
end;

function TGraph.XToCursor(const X: Extended): Extended;
begin
  Result := FCenter.X + (FOffset.X + X) * FCenter.X / FMaxX;
end;

function TGraph.XToPoint(const X: Extended): Extended;
begin
  Result := X * FMaxX / FCenter.X - (FMaxX + FOffset.X);
end;

function TGraph.YToCursor(const Y: Extended): Extended;
begin
  Result := FCenter.Y - (FOffset.Y + Y) * FCenter.Y / FMaxY;
end;

function TGraph.YToPoint(const Y: Extended): Extended;
begin
  Result := (FMaxY - FOffset.Y) - Y * FMaxY / FCenter.Y;
end;

procedure TGraph.Zoom(const ZoomType: TZoomType; const Factor: Extended);
var
  AFactor: Extended;
begin
  case ZoomType of
    ztIn:
      begin
        if Below(Factor, 0) then
          AFactor := ZoomInFactor
        else
          AFactor := Factor;
        if Above(FMaxX, 1 / FMaxZoom[FCS], FEpsilon) then
          FMaxX := EnsureRange(FMaxX - FMaxX * AFactor, 1 / FMaxZoom[FCS], 1 / FMinZoom[FCS]);
        if Above(FMaxY, 1 / FMaxZoom[FCS], FEpsilon) then
          FMaxY := EnsureRange(FMaxY - FMaxY * AFactor, 1 / FMaxZoom[FCS], 1 / FMinZoom[FCS]);
        FLeadTimer.Active := True;
        FLeadTimer.SetTimer;
      end;
    ztOut:
      begin
        if Below(Factor, 0) then
          AFactor := ZoomOutFactor
        else
          AFactor := Factor;
        if Below(FMaxX, 1 / FMinZoom[FCS], FEpsilon) then
          FMaxX := EnsureRange(FMaxX + FMaxX * AFactor, 1 / FMaxZoom[FCS], 1 / FMinZoom[FCS]);
        if Below(FMaxY, 1 / FMinZoom[FCS], FEpsilon) then
          FMaxY := EnsureRange(FMaxY + FMaxY * AFactor, 1 / FMaxZoom[FCS], 1 / FMinZoom[FCS]);
        FLeadTimer.Active := True;
        FLeadTimer.SetTimer;
      end;
  else
    if Below(FMaxX, 1 / FMaxZoom[FCS], FEpsilon) then FMaxX := 1 / FMaxZoom[FCS];
    if Below(FMaxY, 1 / FMaxZoom[FCS], FEpsilon) then FMaxY := 1 / FMaxZoom[FCS];
    if Above(FMaxX, 1 / FMinZoom[FCS], FEpsilon) then FMaxX := 1 / FMinZoom[FCS];
    if Above(FMaxY, 1 / FMinZoom[FCS], FEpsilon) then FMaxX := 1 / FMinZoom[FCS];
    Prepare;
    Build;
  end;
end;

{ TGraphThread }

procedure TGraphThread.Attach;
begin
  if Assigned(FParser) then FParser.AddFunction(MakeName(ValueVariableName), FLocalValue.Handle, fkMethod, MakeFunctionMethod(ValueMethod), False, vtExtended);
end;

constructor TGraphThread.Create(AOwner: TComponent);
begin
  inherited;
  FLocalValue.Value.ValueType := vtExtended;
end;

destructor TGraphThread.Destroy;
begin
  Detach;
  inherited;
end;

procedure TGraphThread.Detach;
begin
  ForceStop;
  if Assigned(FParser) then
  begin
    FParser.BeginUpdate;
    try
      FParser.DeleteFunction(FLocalValue.Handle);
    finally
      FParser.EndUpdate;
      FParser.Notify(ntCompile, Self);
    end;
  end;
end;

procedure TGraphThread.Done;
begin
//
end;

function TGraphThread.GetFloat80: PExtended;
begin
  Result := @FLocalValue.Value.Float80;
end;

function TGraphThread.GetGraph: TGraph;
begin
  Result := TGraph(Owner);
end;

function TGraphThread.LocalizeMethod(var Index: Integer; const Header: PScriptHeader; const ItemHeader: PItemHeader;
  const Item: PScriptItem; const Data: Pointer): Boolean;
var
  AFunction: PFunction;
  AValue: PValue;
begin
  case Item.Code of
    NumberCode: Inc(Index, SizeOf(TCode) + SizeOf(TScriptNumber));
    FunctionCode:
      begin
        Inc(Index, SizeOf(TCode) + SizeOf(TScriptFunction));
        AFunction := FParser.GetFunction(Item.ScriptFunction.Handle);
        if Assigned(AFunction) then
        begin
          AValue := AFunction.Method.Variable.Variable;
          if (AFunction.Method.MethodType = mtVariable) and (AValue = FValue) then Item.ScriptFunction.Handle := FLocalValue.Handle
        end;
      end;
    StringCode:
      Inc(Index, SizeOf(TCode) + SizeOf(TScriptString) + Item.ScriptString.Size);
    ScriptCode, ParameterCode:
      begin
        ParseScript(Index + SizeOf(TCode), LocalizeMethod, Data);
        Inc(Index, SizeOf(TCode) + Item.Script.Header.ScriptSize);
      end;
  else raise Error(ScriptError);
  end;
  Result := True;
end;

function TGraphThread.MakeName(const Text: string): string;
begin
  Result := Text + IntToHex(Integer(Self), 0);
end;

procedure TGraphThread.SetParser(const Value: TParser);
begin
  if FParser <> Value then
  begin
    Detach;
    FParser := Value;
    Attach;
  end;
end;

function TGraphThread.ValueMethod(const AFunction: PFunction; const AType: PType): TValue;
begin
  Result := FLocalValue.Value;
end;

{ TParseThread }

procedure TParseThread.Clear;
begin
  Delete(FPointArray);
  FScript := nil;
  FRangeArray := nil;
end;

constructor TParseThread.Create(AOwner: TComponent);
begin
  inherited;
  FLocalValue.Value.ValueType := vtExtended;
end;

destructor TParseThread.Destroy;
begin
  inherited;
  Delete(FPointArray);
  FScript := nil;
  FRangeArray := nil;
end;

function TParseThread.Map(const Range: TRange; const Space: Extended): TRangeArray;
var
  I, J, Count: Integer;
  RangeArray: TRangeArray;
begin
  Result := nil;
  if Above(Space, FStep, FEpsilon) then
  begin
    if Map(RangeArray, Range, Space) then Add(RangeArray, MakeRange(Range.Min - Space, Range.Max + Space));
    try
      if Assigned(RangeArray) then
      begin
        Sort(RangeArray);
        Count := Length(RangeArray);
        I := Count - 1;
        J := Low(RangeArray);
        if Below(RangeArray[J].Min, Range.Min) then RangeArray[J].Min := Range.Min;
        if Above(RangeArray[I].Max, Range.Max) then RangeArray[I].Max := Range.Max;
        for I := J + 1 to Count do
          if I > Count - 1 then
            Add(Result, MakeRange(RangeArray[J].Min, RangeArray[I - 1].Max))
          else if Above(RangeArray[I].Min, RangeArray[I - 1].Max) then
          begin
            Add(Result, MakeRange(RangeArray[J].Min, RangeArray[I - 1].Max));
            J := I;
          end;
      end;
    finally
      RangeArray := nil;
    end;
  end
  else Add(Result, MakeRange(Range.Min, Range.Max));
end;

function TParseThread.Map(var MapArray: TRangeArray; const Range: TRange; const Space: Extended): Boolean;
var
  Value, Focus: Extended;
  L, R: Boolean;
begin
  Result := not Stopped;
  if Result then
  begin
    Value := Range.Max - Range.Min;
    Focus := Range.Min + Value / 2;
    if Above(Value, Space) then
    begin
      L := Map(MapArray, MakeRange(Range.Min, Focus), Space);
      R := Map(MapArray, MakeRange(Focus, Range.Max), Space);
      Result := L and R;
      if not Result then
      begin
        if L then Add(MapArray, MakeRange(Range.Min - Space, Focus + Space));
        if R then Add(MapArray, MakeRange(Focus - Space, Range.Max + Space));
      end;
    end
    else begin
      Float80^ := Focus;
      Result := FExamine(FCompute(Float80^, FScript));
    end;
  end;
end;

function TParseThread.Push(const Range: TRange): Integer;
begin
  Result := Add(FRangeArray, Range);
end;

procedure TParseThread.SetScript(const AValue: TScript);
begin
  if FScript <> AValue then
  begin
    FScript := Copy(AValue);
    if not ParseScript(Integer(FScript), LocalizeMethod, nil) then FScript := nil;
  end;
end;

procedure TParseThread.Work;
type
  TPair = record
    Prev: PExactPoint;
    Next: TExactPoint;
    Flag: Boolean;
  end;

const
  MinRatio = 5;
  MaxRatio = 100000;
  MinShift: array[TCoordinateSystem] of Integer = (-10, -2);
  MaxShift: array[TCoordinateSystem] of Integer = (10, 2);
  MaxDistance = 2;

var
  I, J, Index, Shift: Integer;
  Move, Prev: Extended;
  MapArray: TRangeArray;
  K: TGapType;
  Pair: TPair;

  procedure MakeMove;
  var
    Distance: Extended;
  begin
    if FAutoquality then
      if Shift < 0 then
        Distance := - Move * (Shift - 1)
      else
        if Shift > 0 then
          Distance := Move / (Shift + 1)
        else
          Distance := Move
    else
      Distance := Move;
    Float80^ := Prev + Distance;
    if Below(FMinStep, Distance, FEpsilon) then FMinStep := Distance;
  end;

  function IncreaseQuality: Boolean;

    function Scatter: Boolean;
    begin
      Result := Assigned(Pair.Prev) and Above(GetDistance(FPointToCursor(Pair.Prev^), FPointToCursor(Pair.Next)), MaxDistance, FEpsilon);
    end;

  begin
    Result := (Shift >= 0) and (Shift < MaxShift[FCS]) and (Pair.Flag or Scatter);
    if Result then
    begin
      Inc(Shift);
      MakeMove;
    end;
  end;

  function DecreaseQuality: Boolean;

    function Overlap: Boolean;
    var
      ACursor, BCursor: TPoint;
    begin
      Result := Assigned(Pair.Prev);
      if Result then
      begin
        ACursor := MakePoint(FPointToCursor(Pair.Prev^));
        BCursor := MakePoint(FPointToCursor(Pair.Next));
        Result := (ACursor.X = BCursor.X) and (ACursor.Y = BCursor.Y);
      end;
    end;

  begin
    Result := (Shift <= 0) and (Shift > MinShift[FCS]) and not Pair.Flag and Overlap;
    if Result then
    begin
      Dec(Shift);
      MakeMove;
    end;
  end;

begin
  FillChar(FGap, SizeOf(TGap), 0);
  FMinStep := FStep;
  if Assigned(FScript) and Assigned(FRangeArray) then
  begin
    K := gtBack;
    I := Low(FRangeArray);
    while not Stopped and (I < Length(FRangeArray)) do
    begin
      try
        case FCS of
          csRectangular:
            begin
              Move := FStep;
              MapArray := MakeRangeArray(FRangeArray[I]);
            end;
        else
          Move := FracSize(FMaxX);
          if Above(Move, 0) then
          begin
            Move := FStep / Move;
            MapArray := Map(FRangeArray[I], Move * EnsureRange(1 + 1 / FMaxX, MinRatio, MaxRatio));
          end
          else begin
            Move := FStep;
            MapArray := MakeRangeArray(FRangeArray[I]);
          end;
        end;
        J := 0;
        while not Stopped and (J < Length(MapArray)) do
        begin
          Index := New(FPointArray);
          Shift := 0;
          FillChar(Pair, SizeOf(TPair), 0);
          Float80^ := MapArray[J].Min;
          Prev := Float80^;
          while not Stopped and Below(Float80^, MapArray[J].Max, FEpsilon) do
          begin
            Pair.Next := FCompute(Float80^, FScript);
            if FAutoquality and (IncreaseQuality or DecreaseQuality) then Continue;
            FGap[K] := not FExamine(Pair.Next);
            if FGap[K] then
            begin
              Index := New(FPointArray);
              Pair.Prev:= nil;
            end
            else Pair.Prev := @FPointArray[Index, Add(FPointArray, Pair.Next, Index)];
            Pair.Flag := FGap[K] or ((Length(FPointArray) = 0) or ((Index < Length(FPointArray)) and (Length(FPointArray[Index]) = 0)));
            if K = Low(K) then K := Succ(K);
            Prev := Float80^;
            MakeMove;
            if FAutoquality then
            begin
              if Shift < 0 then Inc(Shift);
              if Shift > 0 then Dec(Shift);
            end;
          end;
          Inc(J);
        end;
        Index := Length(FPointArray);
        if (Index > 0) and not Assigned(FPointArray[Index - 1]) then SetLength(FPointArray, Index - 1);
      finally
        MapArray := nil;
      end;
      Inc(I);
    end;
  end;
end;

{ TOverlapThread }

procedure TOverlapThread.Clear;
begin
  FPrepared := False;
  ParseUtils.Delete(FScriptArray);
  FOverlapArray := nil;
  FRangeArray := nil;
end;

destructor TOverlapThread.Destroy;
begin
  inherited;
  ParseUtils.Delete(FScriptArray);
  FOverlapArray := nil;
  FRangeArray := nil;
end;

procedure TOverlapThread.Done;
begin
  inherited;
  if not ForceStopped and not (csDestroying in Graph.ComponentState) then
  begin
    Integer(Graph.FOverlapArray) := InterlockedExchange(Integer(FOverlapArray), 0);
    PostMessage(Graph.Handle, WM_INVALIDATE, OverlapCode, 0);
  end;
  Clear;
end;

function TOverlapThread.GetDistance: Extended;
var
  I: Integer;
begin
  Result := 0;
  for I := Low(FRangeArray) to High(FRangeArray) do Result := Result + FRangeArray[I].Max - FRangeArray[I].Min;
end;

procedure TOverlapThread.SetScriptArray(const AValue: TScriptArray);
var
  I: Integer;
  Script: TScript;
begin
  if FScriptArray <> AValue then
  begin
    ParseUtils.Delete(FScriptArray);
    for I := Low(AValue) to High(AValue) do
    begin
      Script := Copy(AValue[I]);
      try
        if ParseScript(Integer(Script), LocalizeMethod, nil) then ParseUtils.Add(FScriptArray, Script);
      finally
        Script := nil;
      end;
    end;
  end;
end;

procedure TOverlapThread.Work;
type
  TGraphType = (gtPrev, gtNext);
  TPointType = (ptPrev, ptNext);
var
  I, J, K: Integer;
  Current: Extended;
  Shift: array[TGraphType] of Extended;
  Point: array[TGraphType, TPointType] of TExactPoint;

  function Prev: Extended;
  begin
    Result := Current;
  end;

  function Next: Extended;
  begin
    Result := Current + FStep;
  end;

  function Calc(const AValue: Extended; const Formula: Integer; out APoint: TExactPoint): Boolean;
  begin
    Float80^ := AValue;
    APoint := FCompute(Float80^, FScriptArray[FFormula.Data[Formula].ScriptIndex]);
    Result := FExamine(APoint);
  end;

  function Capture(const Overlap: TOverlap): Boolean;
  var
    Angle: Extended;
    I: TGraphType;
    J: TPointType;
    Area: array[TGraphType] of TExactArea;
  begin
    Result := FExamine(Overlap.Point);
    if Result then
      case FCS of
        csRectangular:
        begin
          Result := AboveOrEqual(Overlap.Point.X, Prev, FEpsilon) and BelowOrEqual(Overlap.Point.X, Next, FEpsilon);
          if Result then Add(FOverlapArray, Overlap);
        end;
      else
        Angle := CounterClockwise(Overlap.Point, GetAngle(Overlap.Point, ZeroPoint));
        Result := AboveOrEqual(Angle, Prev, FEpsilon) and BelowOrEqual(Angle, Next, FEpsilon);
        if Result then
        begin
          for I := Low(TGraphType) to High(TGraphType) do
          begin
            FillChar(Area[I], SizeOf(TExactArea), 0);
            for J := Low(TPointType) to High(TPointType) do
            begin
              if J = Low(TPointType) then
              begin
                Area[I].Min := Point[I, J];
                Area[I].Max := Point[I, J];
              end
              else begin
                if Below(Area[I].Max.Y, Point[I, J].Y) then Area[I].Max.Y := Point[I, J].Y;
                if Above(Area[I].Min.Y, Point[I, J].Y) then Area[I].Min.Y := Point[I, J].Y;
                if Above(Area[I].Min.X, Point[I, J].X) then Area[I].Min.X := Point[I, J].X;
                if Below(Area[I].Max.X, Point[I, J].X) then Area[I].Max.X := Point[I, J].X;
              end;
            end;
            Area[I].Min.X := Area[I].Min.X - FStep;
            Area[I].Min.Y := Area[I].Min.Y - FStep;
            Area[I].Max.X := Area[I].Max.X + FStep;
            Area[I].Max.Y := Area[I].Max.Y + FStep;
          end;
          for I := Low(TGraphType) to High(TGraphType) do
            if not GraphicUtils.Inside(Overlap.Point, Area[I]) then
            begin
              Result := False;
              Exit;
            end;
          Add(FOverlapArray, MakeOverlap(Overlap, Improve(Angle + Shift[gtPrev]), Improve(Angle + Shift[gtNext])));
        end;
      end;
  end;

begin
  inherited;
  if Assigned(FScriptArray) and Assigned(FRangeArray) then
  begin
    I := Low(RangeArray);
    while not Stopped and (I < Length(RangeArray)) do
    begin
      Float80^ := FRangeArray[I].Min;
      while not Stopped and Below(Float80^, FRangeArray[I].Max) do
      begin
        Current := Float80^;
        for J := 0 to FFormula.Count - 1 do
          case FCS of
            csRectangular:
              if Calc(Prev, J, Point[gtPrev, ptPrev]) and Calc(Next, J, Point[gtPrev, ptNext]) then
                for K := 0 to FFormula.Count - 1 do
                begin
                  if Stopped or (J = K) then Break;
                  if Calc(Prev, K, Point[gtNext, ptPrev]) and Calc(Next, K, Point[gtNext, ptNext]) then
                    Capture(MakeOverlap(J, K, GetIntersection(Point[gtPrev, ptPrev], Point[gtPrev, ptNext], Point[gtNext, ptPrev], Point[gtNext, ptNext])));
                end;
          else
            Shift[gtPrev] := 0;
            while BelowOrEqual(Shift[gtPrev], Pi) do
            begin
              if Calc(Improve(Prev + Shift[gtPrev]), J, Point[gtPrev, ptPrev]) and Calc(Improve(Next + Shift[gtPrev]), J, Point[gtPrev, ptNext]) then
                for K := 0 to FFormula.Count - 1 do
                begin
                  if Stopped or (J = K) then Break;
                  Shift[gtNext] := 0;
                  while BelowOrEqual(Shift[gtNext], Pi) do
                  begin
                    if Calc(Improve(Prev + Shift[gtNext]), K, Point[gtNext, ptPrev]) and Calc(Improve(Next + Shift[gtNext]), K, Point[gtNext, ptNext]) then
                      Capture(MakeOverlap(J, K, GetIntersection(Point[gtPrev, ptPrev], Point[gtPrev, ptNext], Point[gtNext, ptPrev], Point[gtNext, ptNext])));
                    Shift[gtNext] := Shift[gtNext] + Pi;
                  end;
                end;
              Shift[gtPrev] := Shift[gtPrev] + Pi;
            end;
          end;
        Float80^ := Current + FStep;
      end;
      Inc(I);
    end;
  end;
end;

{ TExtremeThread }

procedure TExtremeThread.Clear;
begin
  FPrepared := False;
  Delete(FMaxArray);
  Delete(FMinArray);
end;

destructor TExtremeThread.Destroy;
begin
  Delete(FMaxArray);
  Delete(FMinArray);
  inherited;
end;

procedure TExtremeThread.Done;
begin
  inherited;
  if not ForceStopped and not (csDestroying in Graph.ComponentState) then
  begin
    Integer(Graph.FMaxArray) := InterlockedExchange(Integer(FMaxArray), 0);
    Integer(Graph.FMinArray) := InterlockedExchange(Integer(FMinArray), 0);
    PostMessage(Graph.Handle, WM_INVALIDATE, ExtremeCode, 0);
  end;
  Clear;
end;

procedure TExtremeThread.Work;
var
  AMin, AMax, Distance: Extended;
  AMinArray, AMaxArray, PointArray: TExactArray;
  I, J, K, L, M: Integer;
  Data: PFormulaData;
  Point: TExactPoint;
begin
  for I := 0 to FFormula.Count - 1 do
  begin
    Data := FFormula.Data[I];
    if Assigned(Data) then
    begin
      case FCS of
        csRectangular:
          begin
            AMax := FMin.Y;
            AMin := FMax.Y;
          end
      else
        if Above(FMin.X, FMin.Y, FEpsilon) then
        begin
          AMax := FMin.X;
          AMin := FMax.X;
        end
        else begin
          AMax := FMin.Y;
          AMin := FMax.Y;
        end;
      end;
      AMinArray := nil;
      AMaxArray := nil;
      if Check(FEntireArray, Data.EntireBack) and Check(FEntireArray, Data.EntireFace) then
      try
        for J := Data.EntireBack.ArrayIndex to Data.EntireFace.ArrayIndex do
          if GetRange(FEntireArray, Data.EntireBack, Data.EntireFace, J, L, M) then
            for K := L to M do
            begin
              Point := FEntireArray[J][K];
              case FCS of
                csRectangular:
                  begin
                    if Equal(Point.Y, AMax, FVaryRadius) then Add(AMaxArray, Point)
                    else
                      if Above(Point.Y, AMax, FVaryRadius) then
                      begin
                        AMaxArray := nil;
                        AMax := Point.Y;
                        Add(AMaxArray, Point);
                      end;
                    if Equal(Point.Y, AMin, FVaryRadius) then Add(AMinArray, Point)
                    else
                      if Below(Point.Y, AMin, FVaryRadius) then
                      begin
                        AMinArray := nil;
                        AMin := Point.Y;
                        Add(AMinArray, Point);
                      end;
                  end;
              else
                Distance := GetDistance(ZeroPoint, Point);
                if Equal(Distance, AMax, FVaryRadius) then Add(AMaxArray, Point)
                else
                  if Above(Distance, AMax, FVaryRadius) then
                  begin
                    AMaxArray := nil;
                    AMax := Distance;
                    Add(AMaxArray, Point);
                  end;
                if Equal(Distance, AMin, FVaryRadius) then Add(AMinArray, Point)
                else
                  if Below(Distance, AMin, FVaryRadius) then
                  begin
                    AMinArray := nil;
                    AMin := Distance;
                    Add(AMinArray, Point);
                  end;
              end;
            end;
        PointArray := nil;
        try
          M := 0;
          for L := Low(AMaxArray) to High(AMaxArray) do
          begin
            if Stopped then Break;
            if (L > 0) and Above(GraphicUtils.GetDistance(AMaxArray[L - 1], AMaxArray[L]), FVoidRadius) or (L = High(AMaxArray)) then
              Add(PointArray, AMaxArray[M])
            else
              case FCS of
                csRectangular: if Above(AMaxArray[M].Y, AMaxArray[L].Y, FEpsilon) then Continue;
              else
                if Above(GetDistance(ZeroPoint, AMaxArray[M]), GetDistance(ZeroPoint, AMaxArray[L]), FEpsilon) then Continue;
              end;
            M := L;
          end;
          Add(FMaxArray, PointArray);
          PointArray := nil;
          M := 0;
          for L := Low(AMinArray) to High(AMinArray) do
          begin
            if Stopped then Break;
            if (L > 0) and Above(GraphicUtils.GetDistance(AMinArray[L - 1], AMinArray[L]), FVoidRadius) or (L = High(AMinArray)) then
              Add(PointArray, AMinArray[M])
            else
              case FCS of
                csRectangular: if Below(AMinArray[M].Y, AMinArray[L].Y, FEpsilon) then Continue;
              else
                if Below(GetDistance(ZeroPoint, AMinArray[M]), GetDistance(ZeroPoint, AMinArray[L]), FEpsilon) then Continue;
              end;
            M := L;
          end;
          Add(FMinArray, PointArray);
        finally
          PointArray := nil;
        end;
      finally
        AMaxArray := nil;
        AMinArray := nil;
      end;
      if I < FFormula.Count - 1 then
      begin
        New(FMaxArray);
        New(FMinArray);
      end;
      if I > 0 then
      begin
        Data.MaxBack := NextPlace(FMaxArray, FFormula.Data[I - 1].MaxFace);
        Data.MinBack := NextPlace(FMinArray, FFormula.Data[I - 1].MinFace);
      end
      else begin
        Data.MaxBack := MakePlace(0, 0);
        Data.MinBack := MakePlace(0, 0);
      end;
      Data.MaxFace := LastPlace(FMaxArray);
      Data.MinFace := LastPlace(FMinArray);
    end;
  end;
end;

end.
