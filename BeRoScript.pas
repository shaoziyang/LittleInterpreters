// BeRoScript - Copyright (C) 2002-2006, Benjamin Rosseaux
// bero.0ok.de - bero@0ok.de
//
// This source is freeware (free for use in private & commerical products), but
// not PUBLIC DOMAIN!
//
// And please give Credits ;)
//
{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}
UNIT BeRoScript;
{$HINTS OFF}

INTERFACE

USES Windows,Dialogs,BeRoStream;

CONST BeRoScriptArchive='BeRoScriptArchive';
      BeRoScriptBuild=1;

      fmOpenRead=$0000;
      fmOpenWrite=$0001;
      fmOpenReadWrite=$0002;
      fmShareCompat=$0000;
      fmShareExclusive=$0010;
      fmShareDenyWrite=$0020;
      fmShareDenyRead=$0030;
      fmShareDenyNone=$0040;

      faReadOnly=$00000001;
      faHidden=$00000002;
      faSysFile=$00000004;
      faVolumeID=$00000008;
      faDirectory=$00000010;
      faArchive=$00000020;
      faAnyFile=$0000003F;

      IMPORTED_NAME_OFFSET=$00000002;
      IMAGE_ORDINAL_FLAG32=$80000000;
      IMAGE_ORDINAL_MASK32=$0000FFFF;

      RTL_CRITSECT_TYPE=0;
      RTL_RESOURCE_TYPE=1;

      DLL_PROCESS_ATTACH=1;
      DLL_THREAD_ATTACH=2;
      DLL_THREAD_DETACH=3;
      DLL_PROCESS_DETACH=0;

      IMAGE_SizeHeader=20;

      IMAGE_FILE_RELOCS_STRIPPED=$0001;
      IMAGE_FILE_EXECUTABLE_IMAGE=$0002;
      IMAGE_FILE_LINE_NUMS_STRIPPED=$0004;
      IMAGE_FILE_LOCAL_SYMS_STRIPPED=$0008;
      IMAGE_FILE_AGGRESIVE_WS_TRIM=$0010;
      IMAGE_FILE_BYTES_REVERSED_LO=$0080;
      IMAGE_FILE_32BIT_MACHINE=$0100;
      IMAGE_FILE_DEBUG_STRIPPED=$0200;
      IMAGE_FILE_REMOVABLE_RUN_FROM_SWAP=$0400;
      IMAGE_FILE_NET_RUN_FROM_SWAP=$0800;
      IMAGE_FILE_SYSTEM=$1000;
      IMAGE_FILE_DLL=$2000;
      IMAGE_FILE_UP_SYSTEM_ONLY=$4000;
      IMAGE_FILE_BYTES_REVERSED_HI=$8000;

      IMAGE_FILE_MACHINE_UNKNOWN=0;
      IMAGE_FILE_MACHINE_I386=$14C;
      IMAGE_FILE_MACHINE_R3000=$162;
      IMAGE_FILE_MACHINE_R4000=$166;
      IMAGE_FILE_MACHINE_R10000=$168;
      IMAGE_FILE_MACHINE_ALPHA=$184;
      IMAGE_FILE_MACHINE_POWERPC=$1F0;

      IMAGE_NUMBEROF_DIRECTORY_ENTRIES=16;

      IMAGE_SUBSYSTEM_UNKNOWN=0;
      IMAGE_SUBSYSTEM_NATIVE=1;
      IMAGE_SUBSYSTEM_WINDOWS_GUI=2;
      IMAGE_SUBSYSTEM_WINDOWS_CUI=3;
      IMAGE_SUBSYSTEM_OS2_CUI=5;
      IMAGE_SUBSYSTEM_POSIX_CUI=7;
      IMAGE_SUBSYSTEM_RESERVED=8;

      IMAGE_DIRECTORY_ENTRY_EXPORT=0;
      IMAGE_DIRECTORY_ENTRY_IMPORT=1;
      IMAGE_DIRECTORY_ENTRY_RESOURCE=2;
      IMAGE_DIRECTORY_ENTRY_EXCEPTION=3;
      IMAGE_DIRECTORY_ENTRY_SECURITY=4;
      IMAGE_DIRECTORY_ENTRY_BASERELOC=5;
      IMAGE_DIRECTORY_ENTRY_DEBUG=6;
      IMAGE_DIRECTORY_ENTRY_COPYRIGHT=7;
      IMAGE_DIRECTORY_ENTRY_GLOBALPTR=8;
      IMAGE_DIRECTORY_ENTRY_TLS=9;
      IMAGE_DIRECTORY_ENTRY_LOAD_CONFIG=10;
      IMAGE_DIRECTORY_ENTRY_BOUND_IMPORT=11;
      IMAGE_DIRECTORY_ENTRY_IAT=12;

      IMAGE_SIZEOF_SHORT_NAME=8;

      IMAGE_SCN_TYIMAGE_REG=$00000000;
      IMAGE_SCN_TYIMAGE_DSECT=$00000001;
      IMAGE_SCN_TYIMAGE_NOLOAD=$00000002;
      IMAGE_SCN_TYIMAGE_GROUP=$00000004;
      IMAGE_SCN_TYIMAGE_NO_PAD=$00000008;
      IMAGE_SCN_TYIMAGE_COPY=$00000010;
      IMAGE_SCN_CNT_CODE=$00000020;
      IMAGE_SCN_CNT_INITIALIZED_DATA=$00000040;
      IMAGE_SCN_CNT_UNINITIALIZED_DATA=$00000080;
      IMAGE_SCN_LNK_OTHER=$00000100;
      IMAGE_SCN_LNK_INFO=$00000200;
      IMAGE_SCN_TYIMAGE_OVER=$0000400;
      IMAGE_SCN_LNK_REMOVE=$00000800;
      IMAGE_SCN_LNK_COMDAT=$00001000;
      IMAGE_SCN_MEM_PROTECTED=$00004000;
      IMAGE_SCN_MEM_FARDATA=$00008000;
      IMAGE_SCN_MEM_SYSHEAP=$00010000;
      IMAGE_SCN_MEM_PURGEABLE=$00020000;
      IMAGE_SCN_MEM_16BIT=$00020000;
      IMAGE_SCN_MEM_LOCKED=$00040000;
      IMAGE_SCN_MEM_PRELOAD=$00080000;
      IMAGE_SCN_ALIGN_1BYTES=$00100000;
      IMAGE_SCN_ALIGN_2BYTES=$00200000;
      IMAGE_SCN_ALIGN_4BYTES=$00300000;
      IMAGE_SCN_ALIGN_8BYTES=$00400000;
      IMAGE_SCN_ALIGN_16BYTES=$00500000;
      IMAGE_SCN_ALIGN_32BYTES=$00600000;
      IMAGE_SCN_ALIGN_64BYTES=$00700000;
      IMAGE_SCN_LNK_NRELOC_OVFL=$01000000;
      IMAGE_SCN_MEM_DISCARDABLE=$02000000;
      IMAGE_SCN_MEM_NOT_CACHED=$04000000;
      IMAGE_SCN_MEM_NOT_PAGED=$08000000;
      IMAGE_SCN_MEM_SHARED=$10000000;
      IMAGE_SCN_MEM_EXECUTE=$20000000;
      IMAGE_SCN_MEM_READ=$40000000;
      IMAGE_SCN_MEM_WRITE=LONGWORD($80000000);

      IMAGE_REL_BASED_ABSOLUTE=0;
      IMAGE_REL_BASED_HIGH=1;
      IMAGE_REL_BASED_LOW=2;
      IMAGE_REL_BASED_HIGHLOW=3;
      IMAGE_REL_BASED_HIGHADJ=4;
      IMAGE_REL_BASED_MIPS_JMPADDR=5;
      IMAGE_REL_BASED_SECTION=6;
      IMAGE_REL_BASED_REL32=7;

      IMAGE_REL_BASED_MIPS_JMPADDR16=9;
      IMAGE_REL_BASED_IA64_IMM64=9;
      IMAGE_REL_BASED_DIR64=10;
      IMAGE_REL_BASED_HIGH3ADJ=11;

      PAGE_NOACCESS=1;
      PAGE_READONLY=2;
      PAGE_READWRITE=4;
      PAGE_WRITECOPY=8;
      PAGE_EXECUTE=$10;
      PAGE_EXECUTE_READ=$20;
      PAGE_EXECUTE_READWRITE=$40;
      PAGE_EXECUTE_WRITECOPY=$80;
      PAGE_GUARD=$100;
      PAGE_NOCACHE=$200;
      MEM_COMMIT=$1000;
      MEM_RESERVE=$2000;
      MEM_DECOMMIT=$4000;
      MEM_RELEASE=$8000;
      MEM_FREE=$10000;
      MEM_PRIVATE=$20000;
      MEM_MAPPED=$40000;
      MEM_RESET=$80000;
      MEM_TOP_DOWN=$100000;
      SEC_FILE=$800000;
      SEC_IMAGE=$1000000;
      SEC_RESERVE=$4000000;
      SEC_COMMIT=$8000000;
      SEC_NOCACHE=$10000000;
      MEM_IMAGE=SEC_IMAGE;

      ftNul=0;
      ftFile=1;

      ceUndefErr=4;
      ceLParenExp=5;
      ceRParenExp=6;
      ceThenExp=7;
      ceErrInExpr=8;
      ceExpectEql=9;
      ceExpectSet=10;
      ceUnexpectedEOF=11;
      ceVarNotDef=12;
      ceVarDoppelDefiniert=13;
      ceZahlenWertErwartet=14;
      ceKRParentErwartet=15;
      ceKeinArray=16;
      ceBezeichnerErwartet=17;
      ceFuncParamDefFehler=18;
      ceFuncParamNumFehler=19;
      ceFuncParamSetError=20;
      ceWhileErwartet=21;
      ceSemiColonErwartet=22;
      ceBeginErwartet=23;
      ceEndErwartet=24;
      ceNativeProcNichtGefunden=25;
      ceNativeProcIsNull=26;
      ceCaseErwartet=27;
      ceDoppelPunktErwartet=28;
      ceFixUpFehler=29;
      ceStructNotDefined=30;
      ceTypeExpected=31;
      ceNotStruct=32;
      ceWrongType=33;
      ceFloatTypeExpected=34;
      ceFloatOperationError=35;
      ceFloatInHexError=36;
      cePreprocessorError=37;
      ceLabelDoppelDefiniert=38;
      ceLabelNotFound=39;
      ceLabelNameVariableDefiniert=40;
      ceENumAlreadyDefined=41;
      ceENumStructAlreadyUsed=42;
      ceStringTypeExpected=43;
      ceStringExpected=44;
      CeIllegalStringOperation=45;
      ceStructExpected=46;
      ceIllegalStructOperation=47;
      ceStructOrUnionOrObjectStatementExpected=48;
      ceStructOrUnionOrObjectDoppelDefiniert=49;
      ceOnlyInMethodAllowed=50;
      ceNoInheritedCallPossible=51;
      ceCommaExp=52;
      ceImportProcNichtGefunden=53;
      ceImportProcIsNull=54;

      _keyword=0;
      _ident=1;
      _type=100;
      _enumstruct=150;
      _enumvalue=151;
      _label=200;
      _labelident=201;

      _lparent=2;
      _rparent=3;
      _integer=4;
      _unknow=9;
      _or=10;
      _plus=11;
      _minus=12;
      _mul=13;
      _div=14;
      _mod=15;
      _comma=16;
      _semicolon=17;
      _plusplus=18;
      _minusminus=19;
      _and=20;
      _eql=21;
      _neg=22;
      _lss=23;
      _lea=24;
      _gre=25;
      _gra=26;
      _doublepoint=27;
      _doubledoublepoint=28;
      _shortif=29;
      _do=30;
      _begin=31;
      _if=32;
      _switch=33;
      _case=34;
      _default=35;
      _else=36;
      _while=37;
      _end=38;
      _printf=39;
      _print=40;
      _set=41;
      _isnot=42;
      _shortint=43;
      _void=44;
      _char=45;
      _float=46;
      _for=47;
      _call=48;
      _int=49;
      _byte=50;
      _unsigned=51;
      _signed=52;
      _stringtype=53;
      _not=54;
      _klparent=55;
      _krparent=56;
      _static=57;
      _shl=58;
      _shr=59;
      _xor=60;
      _struct=61;
      _union=62;
      _object=63;
      _import=65;
      _break=70;
      _continue=71;
      _return=72;
      _native=75;
      _stdcall=76;
      _goto=77;
      _enum=78;
      _string=80;
      _packed=81;
      _inherited=82;
      _notbitwise=85;
      _dot=90;
      _usepointer=91;
      _floatnum=92;
      _asm=93;
      _outputblock=94;
      _sizeof=95;
      _breakpoint=96;

      tufutDifferenz=0;
      tufutAbsolut=1;
      tufutJump=2;
      tufutNative=3;
      tufutNativeRelative=4;
      tufutImport=4;
      tufutImportRelative=5;
      tufutClassPointer=6;

      tnttNative=0;
      tnttImport=1;

      tnFunctionResult='?FR!';
      tnFunctionObjectPointer='this';

TYPE PBYTE=^BYTE;
     PLONGWORD=^LONGWORD;
     PLONGINT=^LONGINT;
     PPOINTER=^POINTER;
     PPLONGWORD=^PLONGWORD;

     PWORD=^WORD;
     PPWORD=^PWORD;

     HINST=LONGWORD;
     HMODULE=HINST;

     PWordArray=^TWordArray;
     TWordArray=ARRAY[0..(2147483647 DIV SIZEOF(WORD))-1] OF WORD;

     PLongWordArray=^TLongWordArray;
     TLongWordArray=ARRAY [0..(2147483647 DIV SIZEOF(LONGWORD))-1] OF LONGWORD;

     PImageDOSHeader=^TImageDOSHeader;
     TImageDOSHeader=PACKED RECORD
      Signature:WORD;
      PartPag:WORD;
      PageCnt:WORD;
      ReloCnt:WORD;
      HdrSize:WORD;
      MinMem:WORD;
      MaxMem:WORD;
      ReloSS:WORD;
      ExeSP:WORD;
      ChkSum:WORD;
      ExeIP:WORD;
      ReloCS:WORD;
      TablOff:WORD;
      Overlay:WORD;
      Reserved:PACKED ARRAY[0..3] OF WORD;
      OEMID:WORD;
      OEMInfo:WORD;
      Reserved2:PACKED ARRAY[0..9] OF WORD;
      LFAOffset:LONGWORD;
     END;

     TISHMisc=PACKED RECORD
      CASE INTEGER OF
       0:(PhysicalAddress:LONGWORD);
       1:(VirtualSize:LONGWORD);
     END;

     PImageExportDirectory=^TImageExportDirectory;
     TImageExportDirectory=PACKED RECORD
      Characteristics:LONGWORD;
      TimeDateStamp:LONGWORD;
      MajorVersion:WORD;
      MinorVersion:WORD;
      Name:LONGWORD;
      Base:LONGWORD;
      NumberOfFunctions:LONGWORD;
      NumberOfNames:LONGWORD;
      AddressOfFunctions:PPLONGWORD;
      AddressOfNames:PPLONGWORD;
      AddressOfNameOrdinals:PPWORD;
     END;

     PImageSectionHeader=^TImageSectionHeader;
     TImageSectionHeader=PACKED RECORD
      Name:PACKED ARRAY[0..IMAGE_SIZEOF_SHORT_NAME-1] OF BYTE;
      Misc:TISHMisc;
      VirtualAddress:LONGWORD;
      SizeOfRawData:LONGWORD;
      PointerToRawData:LONGWORD;
      PointerToRelocations:LONGWORD;
      PointerToLinenumbers:LONGWORD;
      NumberOfRelocations:WORD;
      NumberOfLinenumbers:WORD;
      Characteristics:LONGWORD;
     END;

     PImageSectionHeaders=^TImageSectionHeaders;
     TImageSectionHeaders=ARRAY[0..(2147483647 DIV SIZEOF(TImageSectionHeader))-1] OF TImageSectionHeader;

     PImageDataDirectory=^TImageDataDirectory;
     TImageDataDirectory=PACKED RECORD
      VirtualAddress:LONGWORD;
      Size:LONGWORD;
     END;

     PImageFileHeader=^TImageFileHeader;
     TImageFileHeader=PACKED RECORD
      Machine:WORD;
      NumberOfSections:WORD;
      TimeDateStamp:LONGWORD;
      PointerToSymbolTable:LONGWORD;
      NumberOfSymbols:LONGWORD;
      SizeOfOptionalHeader:WORD;
      Characteristics:WORD;
     END;

     PImageOptionalHeader=^TImageOptionalHeader;
     TImageOptionalHeader=PACKED RECORD
      Magic:WORD;
      MajorLinkerVersion:BYTE;
      MinorLinkerVersion:BYTE;
      SizeOfCode:LONGWORD;
      SizeOfInitializedData:LONGWORD;
      SizeOfUninitializedData:LONGWORD;
      AddressOfEntryPoint:LONGWORD;
      BaseOfCode:LONGWORD;
      BaseOfData:LONGWORD;
      ImageBase:LONGWORD;
      SectionAlignment:LONGWORD;
      FileAlignment:LONGWORD;
      MajorOperatingSystemVersion:WORD;
      MinorOperatingSystemVersion:WORD;
      MajorImageVersion:WORD;
      MinorImageVersion:WORD;
      MajorSubsystemVersion:WORD;
      MinorSubsystemVersion:WORD;
      Win32VersionValue:LONGWORD;
      SizeOfImage:LONGWORD;
      SizeOfHeaders:LONGWORD;
      CheckSum:LONGWORD;
      Subsystem:WORD;
      DllCharacteristics:WORD;
      SizeOfStackReserve:LONGWORD;
      SizeOfStackCommit:LONGWORD;
      SizeOfHeapReserve:LONGWORD;
      SizeOfHeapCommit:LONGWORD;
      LoaderFlags:LONGWORD;
      NumberOfRvaAndSizes:LONGWORD;
      DataDirectory:PACKED ARRAY[0..IMAGE_NUMBEROF_DIRECTORY_ENTRIES-1] OF TImageDataDirectory;
     END;

     PImageNTHeaders=^TImageNTHeaders;
     TImageNTHeaders=PACKED RECORD
      Signature:LONGWORD;
      FileHeader:TImageFileHeader;
      OptionalHeader:TImageOptionalHeader;
     END;

     PImageImportDescriptor=^TImageImportDescriptor;
     TImageImportDescriptor=PACKED RECORD
      OriginalFirstThunk:LONGWORD;
      TimeDateStamp:LONGWORD;
      ForwarderChain:LONGWORD;
      Name:LONGWORD;
      FirstThunk:LONGWORD;
     END;

     PImageBaseRelocation=^TImageBaseRelocation;
     TImageBaseRelocation=PACKED RECORD
      VirtualAddress:LONGWORD;
      SizeOfBlock:LONGWORD;
     END;

     PImageThunkData=^TImageThunkData;
     TImageThunkData=PACKED RECORD
      ForwarderString:LONGWORD;
      Funktion:LONGWORD;
      Ordinal:LONGWORD;
      AddressOfData:LONGWORD;
     END;

     PSection=^TSection;
     TSection=PACKED RECORD
      Base:POINTER;
      RVA:LONGWORD;
      Size:LONGWORD;
      Characteristics:LONGWORD;
     END;

     TSections=ARRAY OF TSection;

     TDLLEntryProc=FUNCTION(hinstDLL:HMODULE;dwReason:LONGWORD;lpvReserved:POINTER):BOOLEAN; STDCALL;

     TNameOrID=(niName,niID);

     TExternalLibrary=RECORD
      LibraryName:STRING;
      LibraryHandle:HINST;
     END;

     TExternalLibrarys=ARRAY OF TExternalLibrary;

     PDLLFunctionImport=^TDLLFunctionImport;
     TDLLFunctionImport=RECORD
      NameOrID:TNameOrID;
      Name:STRING;
      ID:INTEGER;
     END;

     PDLLImport=^TDLLImport;
     TDLLImport=RECORD
      LibraryName:STRING;
      LibraryHandle:HINST;
      Entries:ARRAY OF TDLLFunctionImport;
     END;

     TImports=ARRAY OF TDLLImport;

     PDLLFunctionExport=^TDLLFunctionExport;
     TDLLFunctionExport=RECORD
      Name:STRING;
      Index:LONGWORD;
      FunctionPointer:POINTER;
     END;

     TExports=ARRAY OF TDLLFunctionExport;

     TExportTreeLink=POINTER;

     PExportTreeNode=^TExportTreeNode;
     TExportTreeNode=RECORD
      TheChar:CHAR;
      Link:TExportTreeLink;
      LinkExist:BOOLEAN;
      Prevoius,Next,Up,Down:PExportTreeNode;
     END;

     TExportTree=CLASS
      PRIVATE
       Root:PExportTreeNode;
      PUBLIC
       CONSTRUCTOR Create;
       DESTRUCTOR Destroy; OVERRIDE;
       PROCEDURE Dump;
       FUNCTION Add(FunctionName:STRING;Link:TExportTreeLink):BOOLEAN;
       FUNCTION Delete(FunctionName:STRING):BOOLEAN;
       FUNCTION Find(FunctionName:STRING;VAR Link:TExportTreeLink):BOOLEAN;
     END;

     TDynamicLinkLibrary=CLASS
      PRIVATE
       ImageBase:POINTER;
       ImageBaseDelta:INTEGER;
       DLLName:STRING;
       DLLProc:TDLLEntryProc;
       DLLHandle:HINST;
       ExternalLibraryArray:TExternalLibrarys;
       ImportArray:TImports;
       ExportArray:TExports;
       Sections:TSections;
       ExportTree:TExportTree;
       FUNCTION FindExternalLibrary(LibraryName:STRING):INTEGER;
       FUNCTION LoadExternalLibrary(LibraryName:STRING):INTEGER;
       FUNCTION GetExternalLibraryHandle(LibraryName:STRING):HINST;
      PUBLIC
       CONSTRUCTOR Create(DynamicLinkLibraryName:STRING='');
       DESTRUCTOR Destroy; OVERRIDE;
       FUNCTION Load(Stream:TBeRoStream):BOOLEAN;
       FUNCTION LoadFile(FileName:STRING):BOOLEAN;
       FUNCTION Unload:BOOLEAN;
       FUNCTION FindExport(FunctionName:STRING):POINTER;
       PROPERTY Name:STRING READ DLLName;
     END;

     TDynamicLinkLibrarys=ARRAY OF TDynamicLinkLibrary;

     Int64Rec=PACKED RECORD
      Lo,Hi:LONGWORD;
     END;

     LongRec=PACKED RECORD
      Lo,Hi:WORD;
     END;

     TFileName=STRING;

     TSearchRec=RECORD
      Time,Size,Attr:INTEGER;
      Name:TFileName;
      ExcludeAttr:INTEGER;
      FindHandle:THandle;
      FindData:TWin32FindData;
     END;

     PBeRoCompressCompressionDataArray=^TBeRoCompressCompressionDataArray;
     TBeRoCompressCompressionDataArray=ARRAY[0..2147483647-1] OF BYTE;

     TBeRoScriptSign=PACKED ARRAY[1..4] OF CHAR;

     TBeRoArchiveSign=PACKED ARRAY[0..LENGTH(BeRoScriptArchive)-1] OF CHAR;
     TBeRoArchiveBuf=PACKED ARRAY[1..8192] OF CHAR;

     TBeRoArchiveHeader=PACKED RECORD
      Sign:TBeRoArchiveSign;
      KeyHash:LONGWORD;
     END;

     TBeRoArchiveFile=PACKED RECORD
      FileNameLength:WORD;
      FileType:BYTE;
      Size:LONGWORD;
      KeyHash:LONGWORD;
     END;

     TBeRoArchiveFileParam=PACKED RECORD
      FileName:STRING;
      Data:TBeRoArchiveFile;
     END;

     TBeRoArchive=CLASS
      PRIVATE
       fOpen:BOOLEAN;
       fInitSearch:BOOLEAN;
       fStream:TBeRoStream;
       fKey:TBeRoStream;
       fSubKey:TBeRoStream;
       fHeader:TBeRoArchiveHeader;
       PROCEDURE EncodeBuffer(VAR B:TBeRoArchiveBuf);
       PROCEDURE DecodeBuffer(VAR B:TBeRoArchiveBuf);
       FUNCTION FindNextEx:TBeRoArchiveFileParam;
      PROTECTED
      PUBLIC
       FastCompression:BOOLEAN;
       CONSTRUCTOR Create;
       DESTRUCTOR Destroy; OVERRIDE;
       PROCEDURE SetKey(AStream:TBeRoStream); OVERLOAD;
       PROCEDURE SetKey(AKey:STRING); OVERLOAD;
       PROCEDURE SetSubKey(AStream:TBeRoStream); OVERLOAD;
       PROCEDURE SetSubKey(AKey:STRING); OVERLOAD;
       FUNCTION IsArchive(AStream:TBeRoStream):BOOLEAN;
       FUNCTION IsCrypted(AStream:TBeRoStream):BOOLEAN;
       FUNCTION CreateArchive(AStream:TBeRoStream):BOOLEAN;
       FUNCTION OpenArchive(AStream:TBeRoStream):BOOLEAN;
       PROCEDURE CloseArchive;
       FUNCTION Add(FileNameInArchive:STRING;AStream:TBeRoStream):BOOLEAN;
       FUNCTION AddString(FileNameInArchive:STRING;AString:STRING):BOOLEAN;
       PROCEDURE InitSearch;
       FUNCTION FindNext:TBeRoArchiveFileParam;
       FUNCTION EndOfArchive:BOOLEAN;
       FUNCTION IsFileCrypted(FileNameInArchive:STRING):BOOLEAN;
       FUNCTION Extract(FileNameInArchive:STRING;AStream:TBeRoStream):BOOLEAN;
       FUNCTION GetString(FileNameInArchive:STRING):STRING;
       PROCEDURE Delete(FileNameInArchive:STRING);
      PUBLISHED
     END;

     TWert=INTEGER;
     TTyp=(tNichts,tuByte,tByte,tuChar,tChar,tuShortInt,tShortInt,tuInt,tInt,tFloat,tVoid,tString,tType);
     TArt=(aGlobal,aLokal,aStatic,aParam,aShadowParam,aStructVar);

     PNameTabelleEintrag=^TNameTabelleEintrag;
     TNameTabelleEintrag=RECORD
      Name,StructName,Proc,AsmVarName:STRING[255];
      Obj:BYTE;
      Typ:TTyp;
      TypLink:INTEGER;
      InTypLink:INTEGER;
      Zeiger,IstArray:BOOLEAN;
      Art:TArt;
      storage,StackPtr,symptr,StackAlloc,Bytes2Pass,SubNum,ProcNr,
      ParamNum,ShadowParamNum,TotalParamNum,ArrayDim,Size,BTyp,
      Feld_Offset:INTEGER;
      EinTyp,InTyp:BOOLEAN;
      Wert:INTEGER;
      native:BOOLEAN;
      import:BOOLEAN;
      isstdcall:BOOLEAN;
      Param:ARRAY OF INTEGER;
      Adr:TWert;
      Tok:BYTE;
     END;

     TNameTabelle=ARRAY OF TNameTabelleEintrag;

     TTypTabelleEintrag=RECORD
      Name:STRING[255];
      IsPacked:BOOLEAN;
      StackAlloc,Bytes2Pass,Size,Felder:INTEGER;
      VariableNum:INTEGER;
      Variable:ARRAY OF INTEGER;
      Extends:ARRAY OF INTEGER;
      ExtendsOffsets:ARRAY OF INTEGER;
     END;

     TTypTabelle=ARRAY OF TTypTabelleEintrag;

     TNativeTabelleEintrag=PACKED RECORD
      Name:STRING[255];
      AsmVarName:STRING[255];
      Proc:POINTER;
     END;
     TNativeTabelle=ARRAY OF TNativeTabelleEintrag;

     TImportTabelleEintrag=PACKED RECORD
      Name:STRING[255];
      AsmVarName:STRING[255];
      LibraryName:STRING[255];
      LibraryFunction:STRING[255];
     END;
     TImportTabelle=ARRAY OF TImportTabelleEintrag;

     TBlock=PACKED ARRAY[1..8192] OF CHAR;

     TStringHandling=RECORD
      IstZeiger:BOOLEAN;
     END;

     TMethod=PROCEDURE OF OBJECT;

     TLabelFixUpEintrag=PACKED RECORD
      Name:STRING[255];
      Offset:LONGINT;
     END;

     TUseFixUpEintrag=PACKED RECORD
      Typ:BYTE;
      Name:STRING[255];
      Offset:LONGINT;
      AddOffset:LONGINT;
     END;

     TProcEintrag=PACKED RECORD
      Name:STRING[255];
      Offset:LONGWORD;
     END;

     TVariableEintrag=PACKED RECORD
      Name:STRING[255];
      Offset:LONGWORD;
     END;

     TDefine=RECORD
      Name:STRING[255];
      Lines:STRING;
      Parameter:ARRAY OF STRING[255];
     END;

     PBeRoScriptString=^TBeRoScriptString;
     TBeRoScriptString=PACKED RECORD
{$IFDEF FPC}
      MaxLength:LONGWORD;
      Length:LONGWORD;
      Reference:LONGINT;
{$ELSE}
      Reference:LONGINT;
      Length:LONGWORD;
{$ENDIF}
      FirstChar:CHAR;
     END;

     PPBeRoScriptString=^PBeRoScriptString;

     BeRoString=POINTER;

     TBeRoScript=CLASS;

     TBeRoScriptStringEvent=FUNCTION(ABeRoScript:TBeRoScript):STRING;
     TBeRoScriptEvent=PROCEDURE(ABeRoScript:TBeRoScript);

     TBeRoLine=RECORD
      LineNumber:INTEGER;
      FileIndex:INTEGER;
     END;

     TBeRoLineInfo=RECORD
      PreparsedLines:ARRAY OF TBeRoLine;
      Lines:ARRAY OF TBeRoLine;
      Files:ARRAY OF STRING;
     END;

     TBeRoScriptPrintEvent = procedure(Sender: TObject; msg: string) of object;

     TBeRoScript=CLASS
      PRIVATE
       FPrint: TBeRoScriptPrintEvent;
       fOnOwnPreCode:TBeRoScriptStringEvent;
       fOnOwnNativesPointers:TBeRoScriptEvent;
       fOnOwnNativesDefinitions:TBeRoScriptEvent;
       CacheDir:STRING;
       AktProc,AktSymPtr,AktTypPtr:INTEGER;
       AktProcName:STRING;
       AktTyp:TTyp;
       ferror,frunning,feof,inmain:BOOLEAN;
       Level,VarSize:INTEGER;
       UseOutputBlock,UseWrtSTR,UseWrtAXSigned,UseWrtAXUnsigned,
       UseWrtChar,UseWrtPCharString,UseWrtFloat,UseStrNew,UseStrAssign,
       UseStrLength,UseStrSetLength,UseStrUnique,UseStrCharConvert,UseStrGet,
       UseStrConcat,UseStrSelfConcat,UseStrCompare:BOOLEAN;
       ContinueLabel,BreakLabel:ARRAY OF STRING[255];
       LabelArray:ARRAY OF STRING;
       LinesInfo:TBeRoLineInfo;
       SBuf:STRING;
       QuelltextPos,QuelltextZeile,QuelltextSpalte:INTEGER;
       ch:CHAR;
       DP,p,StrWert:LONGWORD;
       fTok:SINGLE;
       iTok:INT64;
       tTok:BYTE;
       tnZaehler,ttZaehler,tnpZaehler,tnSubZaehler:INTEGER;
       GeneratiereLabelNr,AsmVarNr:INTEGER;
       NameTabelle:ARRAY OF TNameTabelleEintrag;
       TypTabelle:ARRAY OF TTypTabelleEintrag;
       NativeTabelle:ARRAY OF TNativeTabelleEintrag;
       ImportTabelle:ARRAY OF TImportTabelleEintrag;
       LabelFixUpTabelle:ARRAY OF TLabelFixUpEintrag;
       UseFixUpTabelle:ARRAY OF TUseFixUpEintrag;
       ProcTabelle:ARRAY OF TProcEintrag;
       VariableTabelle:ARRAY OF TVariableEintrag;
       Defines:ARRAY OF TDefine;
       sTok,AktStr:STRING;
       QuellStream:TBeRoMemoryStream;
       StringHandling:TStringHandling;
       Fehler:BOOLEAN;
       IsCompiled:BOOLEAN;
       CodeStream:TBeRoMemoryStream;
       CodeProc:PROCEDURE;
       IsStringTerm:BOOLEAN;
       MustBeStringTerm:BOOLEAN;
       StringLevel:INTEGER;
       IsFloatExpression:BOOLEAN;
       CodeFileName:STRING;
       CodeName:STRING;
       SourceChecksumme:LONGWORD;
       IsTermSigned:BOOLEAN;
       BSSGroesse:LONGWORD;
       DynamicLinkLibrarys:TDynamicLinkLibrarys;
       FUNCTION MTRIM(S:STRING):STRING;
       FUNCTION MUPPERCASE(S:STRING):STRING;
       FUNCTION MeinePosition(Wo,Was:STRING;AbWo:INTEGER):INTEGER;
       FUNCTION StringErsetzen(Wo,Von,Mit:STRING):STRING;
       PROCEDURE CompilerCreate;
       PROCEDURE IncLevel;
       PROCEDURE DecLevel;
       PROCEDURE SetError(err:INTEGER);
       PROCEDURE ByteHinzufuegen(B:BYTE);
       PROCEDURE WordHinzufuegen(W:WORD);
       PROCEDURE DWordHinzufuegen(DW:LONGWORD);
       PROCEDURE ProcHinzufuegen(S,SO:STRING);
       PROCEDURE VariableHinzufuegen(S,SO:STRING);
       PROCEDURE DifferenzLabelFixUpHinzufuegen(S:STRING);
       PROCEDURE JumpLabelFixUpHinzufuegen(S:STRING);
       PROCEDURE LabelFixUpHinzufuegen(S:STRING;Offset:LONGINT);
       PROCEDURE LabelAdresseHinzufuegen(S:STRING);
       PROCEDURE LabelAdresseOffsetHinzufuegen(S:STRING;Offset:LONGINT);
       PROCEDURE LabelHinzufuegen(S:STRING);
       PROCEDURE NativeFixUpHinzufuegen(NativeName:STRING);
       PROCEDURE NativeRelativeFixUpHinzufuegen(NativeName:STRING);
       PROCEDURE ImportFixUpHinzufuegen(ImportName:STRING);
       PROCEDURE ImportRelativeFixUpHinzufuegen(ImportName:STRING);
       PROCEDURE ClassPointerFixUpHinzufuegen;
       PROCEDURE CodeFixen(CodeOffset:LONGWORD);
       PROCEDURE CallLabel(S:STRING);
       PROCEDURE JZLabel(S:STRING);
       PROCEDURE JNZLabel(S:STRING);
       PROCEDURE JumpLabel(S:STRING);
       FUNCTION GeneratiereLabel:STRING;
       FUNCTION AsmVar:STRING;
       FUNCTION GetLabelName(S:STRING):STRING;
       FUNCTION GetStructTempVariableName(TypLink:INTEGER):STRING;
       FUNCTION GetObjectTempVariableName(TypLink:INTEGER):STRING;
       FUNCTION GetStringTempVariableName(Nummer:INTEGER):STRING;
       FUNCTION GetStringLevelVariableName:STRING;
       FUNCTION GetStringVariableName:STRING;
       FUNCTION AddObjekt(Name,StructName:STRING;Obj:BYTE;Typ:TTyp;Adr:TWert;ArrayDim:INTEGER;Art:TArt;Zeiger,InTyp:BOOLEAN;TypLink,Wert:INTEGER):WORD;
       FUNCTION Find(Name,StructName:STRING;Ident:BOOLEAN;VAR ENT:TNameTabelleEintrag;VAR SymNr:INTEGER;TypLink:INTEGER):BOOLEAN;
       FUNCTION LockKey(Name:STRING):BYTE;
       FUNCTION LockVar(Name,StructName:STRING;VAR AsmVarName:STRING;VAR Adr:TWert;define:BOOLEAN;TypLink:INTEGER):BOOLEAN;
       PROCEDURE OutJmp(S:STRING);
       PROCEDURE OutLabel(S:STRING);
       PROCEDURE OutRet;
       PROCEDURE OutRetEx;
       PROCEDURE OutRetValue(I:LONGWORD);
       PROCEDURE OutOutputBlock;
       PROCEDURE OutWrtAXSigned;
       PROCEDURE OutWrtAXUnsigned;
       PROCEDURE OutWrtFloatAX;
       PROCEDURE OutWrtStr;
       PROCEDURE OutWrtPCharString;
       PROCEDURE OutWrtChar;
       PROCEDURE OutStrNew;
       PROCEDURE OutStrIncrease;
       PROCEDURE OutStrDecrease;
       PROCEDURE OutStrAssign;
       PROCEDURE OutStrLength;
       PROCEDURE OutStrSetLength;
       PROCEDURE OutStrUnique;
       PROCEDURE OutStrCharConvert;
       PROCEDURE OutStrGet;
       PROCEDURE OutStrConcat;
       PROCEDURE OutStrSelfConcat;
       PROCEDURE OutStrCompare;
       PROCEDURE OutClrESPStr;
       PROCEDURE OutLeaESPStr;
       PROCEDURE OutMovESPStr;
       PROCEDURE OutLeaESPStruct;
       PROCEDURE OutMovESPStruct;
       PROCEDURE OutMovEAXStruct(Size:LONGWORD);
       PROCEDURE OutMovEBXEAXStruct(Size:LONGWORD);
       PROCEDURE OutJzIf(S:STRING);
       PROCEDURE OutJzIfBx(S:STRING);
       PROCEDURE OutEql;
       PROCEDURE OutNe;
       PROCEDURE OutLss;
       PROCEDURE OutLea;
       PROCEDURE OutGre;
       PROCEDURE OutGra;
       PROCEDURE OutStrBXTest;
       PROCEDURE OutStrEql;
       PROCEDURE OutStrNe;
       PROCEDURE OutStrLss;
       PROCEDURE OutStrLea;
       PROCEDURE OutStrGre;
       PROCEDURE OutStrGra;
       PROCEDURE OutNotAxBoolean;
       PROCEDURE OutNotAxBitwise;
       PROCEDURE OutNegAx;
       PROCEDURE OutPushSi;
       PROCEDURE OutPopSi;
       PROCEDURE OutPushDi;
       PROCEDURE OutPopDi;
       PROCEDURE OutMovCxSp;
       PROCEDURE OutMovSpCx;
       PROCEDURE OutMovBpSp;
       PROCEDURE OutMovSpBp;
       PROCEDURE OutMovSiAx;
       PROCEDURE OutMovBxSi;
       PROCEDURE OutMoveFromEBXToStack(Size:LONGWORD;Position:LONGINT);
       PROCEDURE OutMoveFromEBXToEAX(Size:LONGWORD);
       PROCEDURE OutPush32(I:LONGWORD);
       PROCEDURE OutPushClassPointer;
       PROCEDURE OutPushAx32;
       PROCEDURE OutPushAx16;
       PROCEDURE OutPushAx8;
       PROCEDURE OutPushAx;
       PROCEDURE OutPushBx;
       PROCEDURE OutPopAx;
       PROCEDURE OutPopBx;
       PROCEDURE OutPushCx;
       PROCEDURE OutPushDx;
       PROCEDURE OutPopCx;
       PROCEDURE OutPopDx;
       PROCEDURE OutPushBp;
       PROCEDURE OutPopBp;
       PROCEDURE OutMulDx;
       PROCEDURE OutMulBx;
       PROCEDURE OutDivBx;
       PROCEDURE OutModBx;
       PROCEDURE OutIMulBx;
       PROCEDURE OutIDivBx;
       PROCEDURE OutIModBx;
       PROCEDURE OutAndBx;
       PROCEDURE OutOrBx;
       PROCEDURE OutShlCx(I:BYTE);
       PROCEDURE OutShlBx;
       PROCEDURE OutShrBx;
       PROCEDURE OutSalBx;
       PROCEDURE OutSarBx;
       PROCEDURE OutXorBx;
       PROCEDURE OutXorAxAx;
       PROCEDURE OutXorBxBx;
       PROCEDURE OutXorCxCx;
       PROCEDURE OutAddAxBx;
       PROCEDURE OutAddAxCx;
       PROCEDURE OutAddBxAx;
       PROCEDURE OutAddBxCx;
       PROCEDURE OutSubAxBx;
       PROCEDURE OutMovBxAx;
       PROCEDURE OutLeaBxAxPlusOne;
       PROCEDURE OutMovAxBx;
       PROCEDURE OutMovCxAx;
       PROCEDURE OutMovCxBx;
       PROCEDURE OutMovBxFromBx;
       PROCEDURE OutMovCxFromBx;
       PROCEDURE OutMovBxCx;
       PROCEDURE OutMovDxImmSigned(S:LONGINT);
       PROCEDURE OutMovDxImmUnsigned(S:LONGWORD);
       PROCEDURE OutMovAxImmSigned(S:LONGINT);
       PROCEDURE OutMulAxImmSigned(S:LONGINT);
       PROCEDURE OutMovAxImmUnsigned(S:LONGWORD);
       PROCEDURE OutMovAxImmLabel(S:STRING);
       PROCEDURE OutMovAxVar32(S:STRING);
       PROCEDURE OutMovAxVarLabel(S:STRING;Size:BYTE);
       PROCEDURE OutMovsxAxVarLabel(S:STRING;Size:BYTE);
       PROCEDURE OutMovAxVarEBXLabel(S:STRING;Size:BYTE);
       PROCEDURE OutMovsxAxVarEBXLabel(S:STRING;Size:BYTE);
       PROCEDURE OutMovESPAx(Offset:INTEGER;Size:BYTE);
       PROCEDURE OutMovAxVarEBP(Offset:INTEGER;Size:BYTE);
       PROCEDURE OutMovsxAxVarEBP(Offset:INTEGER;Size:BYTE);
       PROCEDURE OutMovAxVarEBX(Offset:INTEGER;Size:BYTE);
       PROCEDURE OutMovsxAxVarEBX(Offset:INTEGER;Size:BYTE);
       PROCEDURE OutMovBxVarLabel(S:STRING;Size:BYTE);
       PROCEDURE OutMovBxVarEBP(Offset:INTEGER;Size:BYTE);
       PROCEDURE OutMovCxVarEBP(Offset:INTEGER;Size:BYTE);
       PROCEDURE OutMovVarLabelAx(S:STRING;Size:BYTE);
       PROCEDURE OutMovVarEBPAx(Offset:INTEGER;Size:BYTE);
       PROCEDURE OutMovVarEBXAx(Offset:INTEGER;Size:BYTE);
       PROCEDURE OutMovVarEBXLabelAx(S:STRING;Size:BYTE);
       PROCEDURE OutIncVarEBX(Offset:INTEGER;Size:BYTE);
       PROCEDURE OutDecVarEBX(Offset:INTEGER;Size:BYTE);
       PROCEDURE OutIncVarEBP(Offset:INTEGER;Size:BYTE);
       PROCEDURE OutDecVarEBP(Offset:INTEGER;Size:BYTE);
       PROCEDURE OutIncVarLabel(S:STRING;Size:BYTE);
       PROCEDURE OutDecVarLabel(S:STRING;Size:BYTE);
       PROCEDURE OutIncVarLabelEBX(S:STRING;Size:BYTE);
       PROCEDURE OutDecVarLabelEBX(S:STRING;Size:BYTE);
       PROCEDURE OutAddVarLabel(S:STRING;Size:BYTE;Value:LONGWORD);
       PROCEDURE OutSubVarLabel(S:STRING;Size:BYTE;Value:LONGWORD);
       PROCEDURE OutAddVarEBP(Offset:INTEGER;Size:BYTE;Value:LONGWORD);
       PROCEDURE OutSubVarEBP(Offset:INTEGER;Size:BYTE;Value:LONGWORD);
       PROCEDURE OutMovEAXEBP;
       PROCEDURE OutLeaEAXEBP(Offset:INTEGER);
       PROCEDURE OutLeaEAXEBPECX(Offset:INTEGER;Size:BYTE);
       PROCEDURE OutLeaEAXImmLabelECX(S:STRING;Size:BYTE);
       PROCEDURE OutLeaEAXEBPEBX(Offset:INTEGER;Size:BYTE);
       PROCEDURE OutLeaEAXImmLabelEBX(S:STRING;Size:BYTE);
       PROCEDURE OutLeaEBXEBP(Offset:INTEGER);
       PROCEDURE OutSubESP(I:LONGWORD);
       PROCEDURE OutAddESP(I:LONGWORD);
       PROCEDURE OutSubEAX(I:LONGWORD);
       PROCEDURE OutAddEAX(I:LONGWORD);
       PROCEDURE OutMovBxImmSigned(S:LONGINT);
       PROCEDURE OutMovBxImmUnsigned(S:LONGWORD);
       PROCEDURE OutMovBxImmLabel(S:STRING);
       PROCEDURE OutMovBxImmLabelOffset(S:STRING;Offset:INTEGER);
       PROCEDURE OutMovEBXEBP;
       PROCEDURE OutMovzxEAXAL;
       PROCEDURE OutSubEBX(I:LONGWORD);
       PROCEDURE OutAddEBX(I:LONGWORD);
       PROCEDURE OutAddECX(I:LONGWORD);
       PROCEDURE OutMovAxVarAdr(S:STRING;Index:Integer;Zeiger,UseArray:BOOLEAN);
       PROCEDURE OutMovAxVar(S:STRING;Index:Integer;Zeiger,UseArray:BOOLEAN);
       PROCEDURE OutMovVarAx(S:STRING;Index:Integer;Zeiger,UseArray:BOOLEAN);
       PROCEDURE OutIncVar(S:STRING;Zeiger,UseArray:BOOLEAN);
       PROCEDURE OutDecVar(S:STRING;Zeiger,UseArray:BOOLEAN);
       PROCEDURE OutIncStructVar;
       PROCEDURE OutDecStructVar;
       PROCEDURE OutIncFPU;
       PROCEDURE OutDecFPU;
       PROCEDURE OutMovToStructVar(Variable:INTEGER);
       PROCEDURE OutMovFromStructVar(Variable:INTEGER);
       PROCEDURE OutCall(S,SO:STRING);
       PROCEDURE OutCallAx;
       PROCEDURE OutCallBx;
       PROCEDURE OutCallNative(Name:STRING);
       PROCEDURE OutCallImport(Name:STRING);
       FUNCTION HexB(B:BYTE):STRING;
       FUNCTION HexW(W:WORD):STRING;
       FUNCTION FlagIsSet(Flags:BYTE;FlagMask:BYTE):BOOLEAN;
       FUNCTION LeseNaechstesZeichen:CHAR;
       PROCEDURE Get;
       PROCEDURE OutXChgAxBx;
       PROCEDURE OutFPULD1;
       PROCEDURE OutIntAXtoFPU;
       PROCEDURE OutFPUToIntAX;
       PROCEDURE OutAXtoFPU;
       PROCEDURE OutFPUtoAX;
       PROCEDURE OutAXtoStack;
       PROCEDURE OutStacktoAX;
       PROCEDURE OutFPUAddEx;
       PROCEDURE OutFPUSubEx;
       PROCEDURE OutFPUAdd;
       PROCEDURE OutFPUSub;
       PROCEDURE OutFPUMul;
       PROCEDURE OutFPUDiv;
       PROCEDURE OutFPUWait;
       PROCEDURE OutFPULss;
       PROCEDURE OutFPULea;
       PROCEDURE OutFPUGre;
       PROCEDURE OutFPUGra;
       PROCEDURE FloatFactor;
       PROCEDURE FloatTerm;
       PROCEDURE FloatExpression;
       PROCEDURE FloatBoolExpression;
       PROCEDURE FloatBoolExpressionEx;
       FUNCTION Factor:BOOLEAN;
       FUNCTION Term:BOOLEAN;
       FUNCTION Expression:BOOLEAN;
       FUNCTION BoolExpression:BOOLEAN;
       PROCEDURE StringFactor;
       PROCEDURE StringTerm;
       PROCEDURE StringExpression(Standalone:BOOLEAN);
       PROCEDURE StringBoolExpression(Standalone:BOOLEAN);
       PROCEDURE StructFactor;
       PROCEDURE DoExpression;
       PROCEDURE DoExpressionEx;
       PROCEDURE PrntStatement;
       PROCEDURE ASMStatement;
       PROCEDURE ReturnStatement;
       PROCEDURE Assignment;
       FUNCTION LookDLL(Name:STRING):INTEGER;
       FUNCTION LookNative(Name:STRING):INTEGER;
       FUNCTION LookImport(Name:STRING):INTEGER;
       FUNCTION LookNativeAsmVar(Name:STRING):INTEGER;
       FUNCTION LookImportAsmVar(Name:STRING):INTEGER;
       FUNCTION IsStruct(Name:STRING):BOOLEAN;
       FUNCTION LookStruct(Name:STRING):INTEGER;
       FUNCTION LookStructVar(Name:STRING):INTEGER;
       FUNCTION LookVarStruct(SymPtr:INTEGER):INTEGER;
       FUNCTION VarStruct(StartLevel:BOOLEAN):BOOLEAN;
       PROCEDURE AddImportProc(Name,LibraryName,FunctionName:STRING);
       PROCEDURE AssignmentOrVarStruct;
       PROCEDURE WhileState;
       PROCEDURE DoWhileState;
       PROCEDURE ForState;
       PROCEDURE IfState;
       PROCEDURE SwitchState;
       FUNCTION CallState(Selbststaendig,UseEBX,Klammern:BOOLEAN):INTEGER;
       PROCEDURE BeginState;
       FUNCTION StructAssignment(IstZeiger,StringWrite,IsObjectVar,NoCode:BOOLEAN):BOOLEAN;
       PROCEDURE StructStatement(StartLevel,IsUnion,IsObject:BOOLEAN);
       FUNCTION AreInThatStrings(SymPtr:INTEGER):BOOLEAN;
       FUNCTION FunctionStringFree(SymPtr:INTEGER;Art:TArt;Offset,SubOffset:INTEGER):INTEGER;
       PROCEDURE VarDefStatement(StartLevel,FuncParam,Struct:BOOLEAN;Typ:INTEGER;IsStructStatement:BOOLEAN);
       PROCEDURE LabelStatement;
       PROCEDURE GotoStatement;
       PROCEDURE enumStatement(Art:TArt);
       PROCEDURE BreakPointStatement;
       PROCEDURE OutputBlockStatement;
       PROCEDURE SizeOfStatement;
       PROCEDURE InheritedStatement;
       PROCEDURE IdentStatement;
       PROCEDURE Statement(Semicolon:BOOLEAN);
       PROCEDURE FirstStatement;
       PROCEDURE Init;
       PROCEDURE OutRTL;
       PROCEDURE DoCompile;
       PROCEDURE Preprocessor;
       FUNCTION LoadCode:BOOLEAN;
       PROCEDURE SaveCode;
       PROCEDURE CopyCode;
       PROCEDURE RunProc(S:STRING);
      PUBLIC
       CacheCompression:BOOLEAN;
       FastCacheCompression:BOOLEAN;
       Alignment:BOOLEAN;
       OutDirect:BOOLEAN;
       Debug:BOOLEAN;
       CodePointer:POINTER;
       CodeLength:INTEGER;
       LineDifference:INTEGER;
       Errors:STRING;
       Output:STRING;
       BeginBlock:INTEGER;
       EndBlock:INTEGER;
       Blocks:ARRAY OF STRING;
       Archive:TBeRoArchive;
       CONSTRUCTOR Create(TheCacheDir:STRING;SubCacheDir:STRING='BeRoScriptCache');
       DESTRUCTOR Destroy; OVERRIDE;
       PROCEDURE ClearBlocks;
       PROCEDURE Clear;
       PROCEDURE AddNativeProc(Name:STRING;Proc:POINTER);
       PROCEDURE AddDefine(Name:STRING);
       PROCEDURE AddString(CONST S:STRING);
       PROCEDURE AddNativePointers;
       PROCEDURE AddNativeDefinitions;
       FUNCTION Compile(Source:STRING;Name:STRING=''):BOOLEAN;
       FUNCTION CompileFile(SourceFile:STRING):BOOLEAN;
       PROCEDURE RunStart;
       PROCEDURE RunMain;
       PROCEDURE RunEnd;
       PROCEDURE Run;
       FUNCTION GetProcPointer(Name:STRING):POINTER;
       FUNCTION GetVariablePointer(Name:STRING):POINTER;
       PROCEDURE OutputBlock(BlockNummer:INTEGER);
       FUNCTION ParseWebScript(FileName:STRING):STRING;
       FUNCTION RunWebScript(FileName:STRING):BOOLEAN;
       FUNCTION RunArchive(Stream:TBeRoStream;Name:STRING=''):BOOLEAN;
       FUNCTION RunArchiveFile(FileName:STRING):BOOLEAN;
       PROPERTY Compiled:BOOLEAN READ IsCompiled;
       PROPERTY OnOwnPreCode:TBeRoScriptStringEvent READ fOnOwnPreCode WRITE fOnOwnPreCode;
       PROPERTY OnOwnNativesPointers:TBeRoScriptEvent READ fOnOwnNativesPointers WRITE fOnOwnNativesPointers;
       PROPERTY OnOwnNativesDefinitions:TBeRoScriptEvent READ fOnOwnNativesDefinitions WRITE fOnOwnNativesDefinitions;
       procedure Print(s:string);
       property OnPrint: TBeRoScriptPrintEvent write FPrint;
     END;

VAR RandomSeed:LONGWORD;
    RandomFactor:LONGWORD;
    RandomIncrement:LONGWORD;

PROCEDURE RegisterExtensions;
FUNCTION RandomValue:LONGWORD;
FUNCTION RandomFloatValue:SINGLE;
FUNCTION CountActiveBits(Wert:LONGWORD):LONGWORD;
FUNCTION CountBits(Wert:LONGWORD):BYTE; OVERLOAD;
FUNCTION SlowCountBits(Wert:LONGWORD):BYTE; OVERLOAD;
FUNCTION CountBitsSigned(Wert:LONGINT):BYTE; OVERLOAD;
FUNCTION SlowCountBitsSigned(Wert:LONGINT):BYTE; OVERLOAD;
FUNCTION CountBits(Wert:LONGWORD;MinBits:BYTE):BYTE; OVERLOAD;
FUNCTION SlowCountBits(Wert:LONGWORD;MinBits:BYTE):BYTE; OVERLOAD;
FUNCTION CountBitsSigned(Wert:LONGINT;MinBits:BYTE):BYTE; OVERLOAD;
FUNCTION SlowCountBitsSigned(Wert:LONGINT;MinBits:BYTE):BYTE; OVERLOAD;
FUNCTION MinInt(A,B:LONGINT):LONGINT;
FUNCTION Min(A,B:LONGWORD):LONGWORD; OVERLOAD;
FUNCTION Min(A,B:SINGLE):SINGLE; OVERLOAD;
FUNCTION MaxInt(A,B:LONGINT):LONGINT;
FUNCTION Max(A,B:LONGWORD):LONGWORD; OVERLOAD;
FUNCTION Max(A,B:SINGLE):SINGLE; OVERLOAD;
FUNCTION FixedCast(A:SINGLE):LONGINT;
FUNCTION ExtractFileExt(S:STRING):STRING;
FUNCTION ExtractFileName(S:STRING):STRING;
FUNCTION ExtractFilePath(S:STRING):STRING;
FUNCTION ChangeFileExt(S,E:STRING):STRING;
FUNCTION GetApplicationDir:STRING;
FUNCTION GetCurrentDir:STRING;
FUNCTION GetTempDir:STRING;
FUNCTION GetWinDir:STRING;
FUNCTION GetSystemDir:STRING;
FUNCTION GetTemp:STRING;
FUNCTION FILEEXISTS(S:STRING):BOOLEAN;
FUNCTION FILESETATTR(CONST Dateiname:STRING;Attr:INTEGER):INTEGER;
FUNCTION PFindMatchingFile(VAR F:TSearchRec):INTEGER;
FUNCTION PFindNext(VAR F:TSearchRec):INTEGER;
PROCEDURE PFindClose(VAR F:TSearchRec);
FUNCTION PFindFirst(CONST Path:STRING;Attr:INTEGER;VAR F:TSearchRec):INTEGER;
PROCEDURE LoescheDatei(CONST Datei:STRING);
PROCEDURE LoescheDateien(CONST Path,Mask:STRING;SubDirectories:BOOLEAN);
FUNCTION ConvertFromBeRoString(Src:BeRoString):STRING;
FUNCTION ConvertToBeRoString(Src:STRING):BeRoString;
FUNCTION LOG2(I:INTEGER):INTEGER;
FUNCTION ReadFileAsString(SourceFile:STRING):STRING;
FUNCTION INTTOSTR(I:INTEGER):STRING;
FUNCTION TRIM(CONST S:STRING):STRING;
FUNCTION UPPERCASE(CONST S:STRING):STRING;
FUNCTION LOWERCASE(CONST S:STRING):STRING;
FUNCTION CRC32(Data:TBeRoStream):LONGWORD; OVERLOAD;
FUNCTION CRC32(Data:STRING):LONGWORD; OVERLOAD;
FUNCTION ProcessCompress(VAR SourcePointer,DestinationPointer:POINTER;Size:LONGWORD):LONGWORD;
FUNCTION ProcessDecompress(VAR SourcePointer,DestinationPointer:POINTER;Size:LONGWORD):LONGWORD;
PROCEDURE Compression(Source,Destination:TBeRoStream;Fast:BOOLEAN); OVERLOAD;
PROCEDURE Decompression(Source,Destination:TBeRoStream); OVERLOAD;
PROCEDURE Encode(Data,Key:TBeRoStream); OVERLOAD;
PROCEDURE Decode(Data,Key:TBeRoStream); OVERLOAD;
FUNCTION Encode(Data:STRING;Key:TBeRoStream):STRING; OVERLOAD;
FUNCTION Decode(Data:STRING;Key:TBeRoStream):STRING; OVERLOAD;
FUNCTION Encode(Data,Key:STRING):STRING; OVERLOAD;
FUNCTION Decode(Data,Key:STRING):STRING; OVERLOAD;
PROCEDURE Encode(VAR Data;DataLength:LONGWORD;Key:TBeRoStream); OVERLOAD;
PROCEDURE Decode(VAR Data;DataLength:LONGWORD;Key:TBeRoStream); OVERLOAD;
PROCEDURE Encode(VAR Data;DataLength:LONGWORD;Key:STRING); OVERLOAD;
PROCEDURE Decode(VAR Data;DataLength:LONGWORD;Key:STRING); OVERLOAD;
FUNCTION Starten(CONST Dateiname,Parameter:STRING;FensterStatus:WORD):BOOLEAN;
FUNCTION Ausfuehren(Dateiname,Parameter:STRING):BOOLEAN;
FUNCTION Int64ToBase(Value,Base:INT64):STRING; REGISTER;
FUNCTION Int64ToHex(Value:INT64):STRING; REGISTER;
FUNCTION IntToBase(Value,Base:INTEGER):STRING; REGISTER;
FUNCTION IntToHex(Value:INTEGER):STRING; REGISTER;
FUNCTION LongWordToBase(Value,Base:LONGWORD):STRING; REGISTER;
FUNCTION LongWordToHex(Value:LONGWORD):STRING; REGISTER;

IMPLEMENTATION

CONST strRecordLength=SIZEOF(TBeRoScriptString);
      strStartOffset=strRecordLength-1;
      MySign:TBeRoArchiveSign=BeRoScriptArchive;
      MyCacheSign:TBeRoScriptSign='BSCF';

VAR CRCTabelle:ARRAY[0..255] OF LONGWORD;

PROCEDURE RegisterExtension(Extension:STRING);
VAR Key:HKEY;
    S:STRING;
BEGIN
 IF RegCreateKeyEx(HKEY_CLASSES_ROOT,PCHAR(Extension),0,'',REG_OPTION_NON_VOLATILE,KEY_WRITE,NIL,Key,NIL)=ERROR_SUCCESS THEN BEGIN
  S:='BeRoScript';
  IF RegSetValueEx(Key,'',0,REG_SZ,PCHAR(S),LENGTH(S))=ERROR_SUCCESS THEN BEGIN
   IF RegSetValueEx(Key,'Content Type',0,REG_SZ,PCHAR(S),LENGTH(S))=ERROR_SUCCESS THEN BEGIN
   END;
  END;
  RegCloseKey(Key);
 END;
END;

PROCEDURE RegisterEnginePart;
VAR Key,Key2:HKEY;
    S:STRING;
BEGIN
 IF RegCreateKeyEx(HKEY_CLASSES_ROOT,'BeRoScript',0,'',REG_OPTION_NON_VOLATILE,KEY_WRITE,NIL,Key,NIL)=ERROR_SUCCESS THEN BEGIN
  S:='BeRoScript File';
  IF RegSetValueEx(Key,'',0,REG_SZ,PCHAR(S),LENGTH(S))=ERROR_SUCCESS THEN BEGIN
   IF RegCreateKeyEx(HKEY_CLASSES_ROOT,'BeRoScript\DefaultIcon',0,'',REG_OPTION_NON_VOLATILE,KEY_WRITE,NIL,Key2,NIL)=ERROR_SUCCESS THEN BEGIN
    S:=PARAMSTR(0)+',0';
    IF RegSetValueEx(Key2,'',0,REG_SZ,PCHAR(S),LENGTH(S))=ERROR_SUCCESS THEN BEGIN
    END;
    RegCloseKey(Key2);
   END;
   IF RegCreateKeyEx(HKEY_CLASSES_ROOT,'BeRoScript\shell',0,'',REG_OPTION_NON_VOLATILE,KEY_WRITE,NIL,Key2,NIL)=ERROR_SUCCESS THEN BEGIN
    RegCloseKey(Key2);
   END;
   IF RegCreateKeyEx(HKEY_CLASSES_ROOT,'BeRoScript\shell\open',0,'',REG_OPTION_NON_VOLATILE,KEY_WRITE,NIL,Key2,NIL)=ERROR_SUCCESS THEN BEGIN
    RegCloseKey(Key2);
   END;
   IF RegCreateKeyEx(HKEY_CLASSES_ROOT,'BeRoScript\shell\open\command',0,'',REG_OPTION_NON_VOLATILE,KEY_WRITE,NIL,Key2,NIL)=ERROR_SUCCESS THEN BEGIN
    S:='"'+PARAMSTR(0)+'" "%1"';
    IF RegSetValueEx(Key2,'',0,REG_SZ,PCHAR(S),LENGTH(S))=ERROR_SUCCESS THEN BEGIN
    END;
    RegCloseKey(Key2);
   END;
  END;
  RegCloseKey(Key);
 END;
END;

PROCEDURE RegisterExtensions;
BEGIN
 RegisterExtension('.bs');
 RegisterExtension('.bsa');
 RegisterExtension('.bws');
 RegisterEnginePart;
END;

FUNCTION RandomValue:LONGWORD;
BEGIN
 RandomSeed:=(RandomSeed*RandomFactor)+RandomIncrement;
 RESULT:=RandomSeed*RandomSeed;
END;

FUNCTION RandomFloatValue:SINGLE;
VAR Value:LONGWORD;
BEGIN
 Value:=(RandomValue AND $7FFFFF) OR $40000000;
 RESULT:=ABS(SINGLE(POINTER(@Value)^)-3);
END;                                    

FUNCTION Starten(CONST Dateiname,Parameter:STRING;FensterStatus:WORD):BOOLEAN;
VAR SUInfo:TStartupInfo;
    ProcInfo:TProcessInformation;
    Befehlszeile:STRING;
BEGIN
 IF LENGTH(Dateiname)>0 THEN BEGIN
  Befehlszeile:='"'+Dateiname+'" '+Parameter;
 END ELSE BEGIN
  Befehlszeile:='"cmd" /C '+Parameter;
 END;
 FILLCHAR(SUInfo,SIZEOF(SUInfo),#0);
 FILLCHAR(ProcInfo,SIZEOF(ProcInfo),#0);
 WITH SUInfo DO BEGIN
  CB:=SIZEOF(SUInfo);
  dwFlags:=STARTF_USESHOWWINDOW;
  wShowWindow:=FensterStatus;
 END;
 RESULT:=CreateProcess(NIL,PCHAR(Befehlszeile),NIL,NIL,FALSE,NORMAL_PRIORITY_CLASS,NIL,PCHAR(GetCurrentDir),SUInfo,ProcInfo);
 IF RESULT THEN BEGIN
  WaitForSingleObject(ProcInfo.hProcess,INFINITE);
 END;
END;

FUNCTION Ausfuehren(Dateiname,Parameter:STRING):BOOLEAN;
BEGIN
 RESULT:=Starten(Dateiname,Parameter,SW_SHOWNORMAL);
END;

FUNCTION Int64ToBase(Value,Base:INT64):STRING; REGISTER;
CONST Digits:ARRAY[0..35] OF CHAR='0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';
VAR Negative:BOOLEAN;
BEGIN
 RESULT:='';
 IF (Base>1) AND (Base<37) THEN BEGIN
  Negative:=Value<0;
  Value:=ABS(Value);
  WHILE Value<>0 DO BEGIN
   RESULT:=Digits[Value MOD Base]+RESULT;
   Value:=Value DIV Base;
  END;
  IF Negative THEN RESULT:='-'+RESULT;
 END;
END;

FUNCTION Int64ToHex(Value:INT64):STRING; REGISTER;
CONST Digits:ARRAY[0..$F] OF CHAR='0123456789ABCDEF';
VAR Negative:BOOLEAN;
BEGIN
 RESULT:='';
 Negative:=Value<0;
 Value:=ABS(Value);
 WHILE Value<>0 DO BEGIN
  RESULT:=Digits[Value AND $F]+RESULT;
  Value:=Value SHR 4;
 END;
 IF Negative THEN RESULT:='-'+RESULT;
END;

FUNCTION IntToBase(Value,Base:INTEGER):STRING; REGISTER;
CONST Digits:ARRAY[0..35] OF CHAR='0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';
VAR Negative:BOOLEAN;
BEGIN
 RESULT:='';
 IF (Base>1) AND (Base<37) THEN BEGIN
  Negative:=Value<0;
  Value:=ABS(Value);
  WHILE Value<>0 DO BEGIN
   RESULT:=Digits[Value MOD Base]+RESULT;
   Value:=Value DIV Base;
  END;
  IF Negative THEN RESULT:='-'+RESULT;
 END;
END;

FUNCTION IntToHex(Value:INTEGER):STRING; REGISTER;
CONST Digits:ARRAY[0..$F] OF CHAR='0123456789ABCDEF';
VAR Negative:BOOLEAN;
BEGIN
 RESULT:='';
 Negative:=Value<0;
 Value:=ABS(Value);
 WHILE Value<>0 DO BEGIN
  RESULT:=Digits[Value AND $F]+RESULT;
  Value:=Value SHR 4;
 END;
 IF Negative THEN RESULT:='-'+RESULT;
END;

FUNCTION LongWordToBase(Value,Base:LONGWORD):STRING; REGISTER;
CONST Digits:ARRAY[0..35] OF CHAR='0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';
BEGIN
 RESULT:='';
 IF (Base>1) AND (Base<37) THEN BEGIN
  WHILE Value<>0 DO BEGIN
   RESULT:=Digits[Value MOD Base]+RESULT;
   Value:=Value DIV Base;
  END;
 END;
END;

FUNCTION LongWordToHex(Value:LONGWORD):STRING; REGISTER;
CONST Digits:ARRAY[0..$F] OF CHAR='0123456789ABCDEF';
BEGIN
 RESULT:='';
 WHILE Value<>0 DO BEGIN
  RESULT:=Digits[Value AND $F]+RESULT;
  Value:=Value SHR 4;
 END;
END;

FUNCTION CountActiveBits(Wert:LONGWORD):LONGWORD;
BEGIN
 RESULT:=((Wert AND $AAAAAAAA) SHR 1)+(Wert AND $55555555);
 RESULT:=((RESULT AND $CCCCCCCC) SHR 2)+(RESULT AND $33333333);
 RESULT:=((RESULT AND $F0F0F0F0) SHR 4)+(RESULT AND $0F0F0F0F);
 RESULT:=((RESULT AND $FF00FF00) SHR 8)+(RESULT AND $00FF00FF);
 RESULT:=((RESULT AND $FFFF0000) SHR 16)+(RESULT AND $0000FFFF);
END;

FUNCTION CountBits(Wert:LONGWORD):BYTE;
VAR DerWert:LONGWORD;
BEGIN
 RESULT:=0;
 DerWert:=Wert;
 WHILE DerWert<>0 DO BEGIN
  DerWert:=DerWert SHR 1;
  INC(RESULT);
 END;
END;

FUNCTION SlowCountBits(Wert:LONGWORD):BYTE;
VAR DerWert:LONGWORD;
BEGIN
 RESULT:=0;
 DerWert:=Wert;
 IF DerWert>0 THEN BEGIN
  RESULT:=32;
  WHILE ((DerWert AND (1 SHL 31))=0) DO BEGIN
   DerWert:=DerWert SHL 1;
   DEC(RESULT);
  END;
 END;
END;

FUNCTION CountBitsSigned(Wert:LONGINT):BYTE;
BEGIN
 RESULT:=CountBits(ABS(Wert))+1;
 IF RESULT>32 THEN RESULT:=32;
END;

FUNCTION SlowCountBitsSigned(Wert:LONGINT):BYTE;
BEGIN
 RESULT:=SlowCountBits(ABS(Wert))+1;
 IF RESULT>32 THEN RESULT:=32;
END;

FUNCTION CountBits(Wert:LONGWORD;MinBits:BYTE):BYTE;
BEGIN
 RESULT:=CountBits(Wert);
 IF RESULT<MinBits THEN RESULT:=MinBits;
END;

FUNCTION SlowCountBits(Wert:LONGWORD;MinBits:BYTE):BYTE;
BEGIN
 RESULT:=SlowCountBits(Wert);
 IF RESULT<MinBits THEN RESULT:=MinBits;
END;

FUNCTION CountBitsSigned(Wert:LONGINT;MinBits:BYTE):BYTE;
BEGIN
 RESULT:=CountBitsSigned(Wert);
 IF RESULT<MinBits THEN RESULT:=MinBits;
END;

FUNCTION SlowCountBitsSigned(Wert:LONGINT;MinBits:BYTE):BYTE;
BEGIN
 RESULT:=SlowCountBitsSigned(Wert);
 IF RESULT<MinBits THEN RESULT:=MinBits;
END;

FUNCTION MinInt(A,B:LONGINT):LONGINT;
BEGIN
 RESULT:=B;
 IF A<B THEN RESULT:=A;
END;

FUNCTION Min(A,B:LONGWORD):LONGWORD;
BEGIN
 RESULT:=B;
 IF A<B THEN RESULT:=A;
END;

FUNCTION Min(A,B:SINGLE):SINGLE;
BEGIN
 RESULT:=B;
 IF A<B THEN RESULT:=A;
END;

FUNCTION MaxInt(A,B:LONGINT):LONGINT;
BEGIN
 RESULT:=A;
 IF A<B THEN RESULT:=B;
END;

FUNCTION Max(A,B:LONGWORD):LONGWORD;
BEGIN
 RESULT:=A;
 IF A<B THEN RESULT:=B;
END;

FUNCTION Max(A,B:SINGLE):SINGLE;
BEGIN
 RESULT:=A;
 IF A<B THEN RESULT:=B;
END;

FUNCTION FixedCast(A:SINGLE):LONGINT;
VAR B:SINGLE;
BEGIN
 B:=A*(1 SHL 16);
 RESULT:=TRUNC(B);
 IF FRAC(B)<0 THEN DEC(RESULT);
END;

FUNCTION ExtractFileExt(S:STRING):STRING;
VAR I,J,K:INTEGER;
BEGIN
 RESULT:='';
 K:=0;
 J:=LENGTH(S);
 FOR I:=J DOWNTO 1 DO IF (S[I]='.') OR (S[I]='\') OR (S[I]='/') OR (S[I]=':') THEN BEGIN
  K:=I;
  BREAK;
 END;
 IF (K>0) AND (S[K]='.') THEN RESULT:=COPY(S,K,J-K+1);
END;

FUNCTION ExtractFileName(S:STRING):STRING;
VAR I,J,K:INTEGER;
BEGIN
 RESULT:=S;
 K:=0;
 J:=LENGTH(S);
 FOR I:=J DOWNTO 1 DO IF (S[I]='\') OR (S[I]='/') OR (S[I]=':') THEN BEGIN
  K:=I;
  BREAK;
 END;
 IF K>0 THEN RESULT:=COPY(S,K+1,J-K+1);
END;

FUNCTION ExtractFilePath(S:STRING):STRING;
VAR I,J,K:INTEGER;
BEGIN
 RESULT:=S;
 K:=0;
 J:=LENGTH(S);
 FOR I:=J DOWNTO 1 DO IF (S[I]='\') OR (S[I]='/') OR (S[I]=':') THEN BEGIN
  K:=I;
  BREAK;
 END;
 IF K>0 THEN RESULT:=COPY(S,1,K);
END;

FUNCTION ChangeFileExt(S,E:STRING):STRING;
VAR I,J,K:INTEGER;
BEGIN
 K:=0;
 J:=LENGTH(S);
 FOR I:=J DOWNTO 1 DO IF (S[I]='.') OR (S[I]='\') OR (S[I]='/') OR (S[I]=':') THEN BEGIN
  K:=I;
  BREAK;
 END;
 IF (K>0) AND (S[K]='.') THEN BEGIN
  RESULT:=COPY(S,1,K-1)+E;
 END ELSE BEGIN
  RESULT:=S+E;
 END;
END;

FUNCTION GetApplicationDir:STRING;
BEGIN
 RESULT:=ExtractFilePath(PARAMSTR(0));
 IF LENGTH(RESULT)>0 THEN IF RESULT[LENGTH(RESULT)]<>'\' THEN RESULT:=RESULT+'\';
END;

FUNCTION GetCurrentDir:STRING;
VAR Buffer:ARRAY[0..MAX_PATH-1] OF CHAR;
BEGIN
 SetString(RESULT,Buffer,GetCurrentDirectory(SIZEOF(Buffer),Buffer));
 IF LENGTH(RESULT)>0 THEN IF RESULT[LENGTH(RESULT)]<>'\' THEN RESULT:=RESULT+'\';
END;

FUNCTION GetTempDir:STRING;
VAR Buffer:ARRAY[0..MAX_PATH-1] OF CHAR;
BEGIN
 SetString(RESULT,Buffer,GetTempPath(SIZEOF(Buffer),Buffer));
 IF LENGTH(RESULT)>0 THEN IF RESULT[LENGTH(RESULT)]<>'\' THEN RESULT:=RESULT+'\';
END;

FUNCTION GetWinDir:STRING;
VAR Buffer:ARRAY[0..MAX_PATH-1] OF CHAR;
BEGIN
 SetString(RESULT,Buffer,GetWindowsDirectory(Buffer,SIZEOF(Buffer)));
 IF LENGTH(RESULT)>0 THEN IF RESULT[LENGTH(RESULT)]<>'\' THEN RESULT:=RESULT+'\';
END;

FUNCTION GetSystemDir:STRING;
VAR Buffer:ARRAY[0..MAX_PATH-1] OF CHAR;
BEGIN
 SetString(RESULT,Buffer,GetSystemDirectory(Buffer,SIZEOF(Buffer)));
 IF LENGTH(RESULT)>0 THEN IF RESULT[LENGTH(RESULT)]<>'\' THEN RESULT:=RESULT+'\';
END;

FUNCTION GetTemp:STRING;
VAR Path,PathDatei:ARRAY[0..MAX_PATH-1] OF CHAR;
BEGIN
 GetTempPath(SIZEOF(Path),@Path);
 GetTempFileName(@Path,'BSA',0,@PathDatei);
 RESULT:=PCHAR(@PathDatei);
END;

FUNCTION FILEEXISTS(S:STRING):BOOLEAN;
VAR F:FILE;
BEGIN
 RESULT:=FALSE;
 FILESETATTR(S,0); {Alle Dateiattribute löschen}
 ASSIGNFILE(F,S);
 {$I-}RESET(F,1);{$I+}
 IF IOResult=0 THEN BEGIN
  CLOSEFILE(F);
  RESULT:=TRUE;
 END;
END;

FUNCTION PFindMatchingFile(VAR F:TSearchRec):INTEGER;
VAR LocalFileTime:TFileTime;
BEGIN
 WITH F DO BEGIN
  WHILE (FindData.dwFileAttributes AND ExcludeAttr)<>0 DO BEGIN
   IF NOT FindNextFile(FindHandle,FindData) THEN BEGIN
    RESULT:=GetLastError;
    EXIT;
   END;
  END;
  FileTimeToLocalFileTime(FindData.ftLastWriteTime,LocalFileTime);
  FileTimeToDosDateTime(LocalFileTime,LongRec(Time).Hi,LongRec(Time).Lo);
  Size:=FindData.nFileSizeLow;
  Attr:=FindData.dwFileAttributes;
  Name:=FindData.cFileName;
 END;
 RESULT:=0;
END;

FUNCTION PFindNext(VAR F:TSearchRec):INTEGER;
BEGIN
 IF FindNextFile(F.FindHandle,F.FindData) THEN BEGIN
  RESULT:=PFindMatchingFile(F);
 END ELSE BEGIN
  RESULT:=GetLastError;
 END;
END;

PROCEDURE PFindClose(VAR F:TSearchRec);
BEGIN
 IF F.FindHandle<>INVALID_HANDLE_VALUE THEN BEGIN
  FindClose(F.FindHandle);
  F.FindHandle:=INVALID_HANDLE_VALUE;
 END;
END;

FUNCTION PFindFirst(CONST Path:STRING;Attr:INTEGER;VAR F:TSearchRec):INTEGER;
CONST faSpecial=faHidden OR faSysFile OR faVolumeID OR faDirectory;
BEGIN
 F.ExcludeAttr:=NOT Attr AND faSpecial;
 F.FindHandle:=FindFirstFile(PCHAR(Path),F.FindData);
 IF F.FindHandle<>INVALID_HANDLE_VALUE THEN BEGIN
  RESULT:=PFindMatchingFile(F);
  IF RESULT<>0 THEN PFindClose(F);
 END ELSE BEGIN
  RESULT:=GetLastError;
 END;
END;

FUNCTION FILESETATTR(CONST Dateiname:STRING;Attr:INTEGER):INTEGER;
BEGIN
 RESULT:=0;
 IF NOT SetFileAttributes(PCHAR(Dateiname),Attr) THEN RESULT:=GetLastError;
END;

PROCEDURE LoescheDatei(CONST Datei:STRING);
BEGIN
 IF NOT DELETEFILE(PCHAR(Datei)) THEN BEGIN
  FILESETATTR(Datei,0); {Alle Dateiattribute löschen}
  DELETEFILE(PCHAR(Datei));
 END;
END;

PROCEDURE LoescheDateien(CONST Path,Mask:STRING;SubDirectories:BOOLEAN);
VAR SR:TSearchRec;
BEGIN
 IF PFindFirst(Path+Mask,faAnyFile-faDirectory,SR)=0 THEN BEGIN
  REPEAT
   LoescheDatei(Path+SR.Name);
  UNTIL PFindNext(SR)<>0;
  PFindClose(SR);
 END;
 IF SubDirectories THEN BEGIN
  IF PFindFirst(Path+'*.*',faDirectory,SR)=0 THEN BEGIN
   REPEAT
    IF (SR.Name<>'.') AND (SR.Name<>'..') THEN BEGIN
     FILESETATTR(Path+SR.Name,faDirectory);
     LoescheDateien(Path+SR.Name+'\',Mask,TRUE);
     FILESETATTR(Path+SR.Name,faDirectory); {Alle Dateiattribute löschen}
     {$I-}
     RMDIR(Path+SR.Name); {Leeres Verzsichnis löschen}
     {$I+}
     IF IOResult<>0 THEN BEGIN
     END;
    END;
   UNTIL PFindNext(SR)<>0;
   PFindClose(SR);
  END;
 END;
END;

FUNCTION LOG2(I:INTEGER):INTEGER;
BEGIN
 IF I<=0 THEN BEGIN
  RESULT:=-1;
 END ELSE BEGIN
  RESULT:=LOG2(I DIV 2)+1;
 END;
END;

FUNCTION ReadFileAsString(SourceFile:STRING):STRING;
VAR F:TBeRoFileStream;
BEGIN
 F:=TBeRoFileStream.Create(SourceFile);
 IF F.Size>0 THEN BEGIN
  SETLENGTH(RESULT,F.Size);
  F.Read(RESULT[1],F.Size);
 END ELSE BEGIN
  RESULT:='';
 END;
 F.Free;
END;

FUNCTION INTTOSTR(I:INTEGER):STRING;
BEGIN
 STR(I,RESULT);
END;

FUNCTION TRIM(CONST S:STRING):STRING;
VAR StartPos,Laenge:INTEGER;
BEGIN
 Laenge:=LENGTH(S);
 IF Laenge>0 THEN BEGIN
  WHILE (Laenge>0) AND (S[Laenge] IN [#0..#32]) DO DEC(Laenge);
  StartPos:=1;
  WHILE (StartPos<=Laenge) AND (S[StartPos] IN [#0..#32]) DO INC(StartPos);
  RESULT:=COPY(S,StartPos,Laenge-StartPos+1);
 END ELSE BEGIN
  RESULT:='';
 END;
END;

FUNCTION UPPERCASE(CONST S:STRING):STRING;
VAR I,L:INTEGER;
BEGIN
 RESULT:='';
 L:=LENGTH(S);
 I:=1;
 WHILE I<=L DO BEGIN
  IF S[I] IN ['a'..'z'] THEN BEGIN
   RESULT:=RESULT+CHAR(BYTE(S[I])-32);
  END ELSE BEGIN
   RESULT:=RESULT+S[I];
  END;
  INC(I);
 END;
END;

FUNCTION LOWERCASE(CONST S:STRING):STRING;
VAR I,L:INTEGER;
BEGIN
 RESULT:='';
 L:=LENGTH(S);
 I:=1;
 WHILE I<=L DO BEGIN
  IF S[I] IN ['A'..'Z'] THEN BEGIN
   RESULT:=RESULT+CHAR(BYTE(S[I])+32);
  END ELSE BEGIN
   RESULT:=RESULT+S[I];
  END;
  INC(I);
 END;
END;

FUNCTION StrToInt(S:STRING):INTEGER;
VAR C:INTEGER;
BEGIN
 VAL(S,RESULT,C);
END;

PROCEDURE ErzeugeTabelle;
CONST GenerationWert=$EDB88320;
VAR I,J:LONGWORD;
    Wert:LONGWORD;
BEGIN
 I:=0;
 WHILE I<256 DO BEGIN
  Wert:=I;
  J:=8;
  WHILE J>0 DO BEGIN
   IF (Wert AND 1)<>0 THEN BEGIN
    Wert:=(Wert SHR 1) XOR GenerationWert;
   END ELSE BEGIN
    Wert:=Wert SHR 1;
   END;
   DEC(J);
  END;
  CRCTabelle[I]:=Wert;
  INC(I);
 END;
END;

FUNCTION CRC32(Data:TBeRoStream):LONGWORD;
VAR I,J:LONGWORD;
    Wert:LONGWORD;
    B:BYTE;
BEGIN
 Wert:=$FFFFFFFF;
 Data.Seek(0);
 J:=Data.Size;
 I:=0;
 WHILE I<J DO BEGIN
  B:=Data.ReadByte;
  Wert:=((Wert SHR 8) AND $00FFFFFF) XOR CRCTabelle[(Wert XOR B) AND $FF];
  INC(I);
 END;
 Data.Seek(0);
 RESULT:=Wert XOR $FFFFFFFF;
END;

FUNCTION CRC32(Data:STRING):LONGWORD;
VAR Stream:TBeRoMemoryStream;
BEGIN
 Stream:=TBeRoMemoryStream.Create;
 Stream.Text:=Data;
 RESULT:=CRC32(Stream);
 Stream.Free;
END;

FUNCTION ProcessCompress(VAR SourcePointer,DestinationPointer:POINTER;Size:LONGWORD):LONGWORD;
CONST MethodLiteral=0;
      MethodShortLiteralMatch=1;
      MethodLastIndexPhrase=2;
      MethodShortMatch=3;
      MethodMatch=4;
      MethodNullByte=5;
      CheckMethodsStart=MethodShortLiteralMatch;
      CheckMethodsEnd=MethodMatch;
TYPE PBYTE=^BYTE;
     PWORD=^WORD;
     PLONGWORD=^LONGWORD;
     PByteArray=^TByteArray;
     TByteArray=ARRAY[0..$7FFFFFFE] OF BYTE;
     PNode=^TNode;
     TNode=RECORD
      DataPointer:POINTER;
      Previous,Next:PNode;
     END;
     PNodes=^TNodes;
     TNodes=ARRAY[0..($7FFFFFFF DIV SIZEOF(TNode))-1] OF TNode;
     PRecentNodes=^TRecentNodes;
     TRecentNodes=ARRAY[0..$FFFF] OF PNode;
VAR Source,Destination,EndPointer,LastHashedPointer,TagPointer:PBYTE;
    Tag,BitCount,BestFoundPhraseIndex,BestFoundPhraseLength,
    LastIndexUsed:LONGWORD;
    BestMethod:BYTE;
    LastWasMatch:BOOLEAN;
    NodesSize:LONGWORD;
    NodePosition:LONGWORD;
    Nodes:PNodes;
    RecentNodes:PRecentNodes;
 FUNCTION AddNode(Data:POINTER):BOOLEAN;
 VAR Prefix:WORD;
     LastNode:PNode;
     NewNode:PNode;
 BEGIN
  RESULT:=NodePosition<(Size-1);
  IF RESULT THEN BEGIN
   Prefix:=PWORD(Data)^;
   LastNode:=RecentNodes^[Prefix];
   NewNode:=@Nodes^[NodePosition];
   WITH NewNode^ DO BEGIN
    DataPointer:=Data;
    Previous:=LastNode;
    Next:=NIL;
   END;
   IF ASSIGNED(LastNode) THEN LastNode^.Next:=NewNode;
   RecentNodes^[Prefix]:=NewNode;
   INC(NodePosition);
  END;
 END;
 PROCEDURE PutBits(Value,Bits:LONGWORD);
 VAR RemainValue,RemainBits:LONGWORD;
 BEGIN
  IF Bits>1 THEN BEGIN
   RemainValue:=Value;
   RemainBits:=Bits;
   WHILE RemainBits>0 DO BEGIN
    PutBits((RemainValue SHR (RemainBits-1)) AND 1,1);
    DEC(RemainBits);
   END;
  END ELSE BEGIN
   IF BitCount=0 THEN BEGIN
    TagPointer^:=Tag;
    TagPointer:=Destination;
    INC(Destination);
    BitCount:=8;
   END;
   DEC(BitCount);
   Tag:=(Tag SHL Bits) OR Value;
  END;
 END;
 PROCEDURE PutBit(Bit:BOOLEAN);
 BEGIN
  IF Bit THEN BEGIN
   PutBits(1,1);
  END ELSE BEGIN
   PutBits(0,1);
  END;
 END;
 PROCEDURE PutGamma(Value:LONGWORD);
 VAR Mask:LONGWORD;
 BEGIN
  Mask:=Value SHR 1;
  WHILE (Mask AND (Mask-1))<>0 DO Mask:=Mask AND (Mask-1);
  PutBit((Value AND Mask)<>0);
  Mask:=Mask SHR 1;
  WHILE Mask<>0 DO BEGIN
   PutBit(TRUE);
   PutBit((Value AND Mask)<>0);
   Mask:=Mask SHR 1;
  END;
  PutBit(FALSE);
 END;
 FUNCTION GetGammaSize(Value:LONGWORD):LONGWORD;
 VAR Mask:LONGWORD;
 BEGIN
  Mask:=Value SHR 1;
  WHILE (Mask AND (Mask-1))<>0 DO Mask:=Mask AND (Mask-1);
  RESULT:=2;
  Mask:=Mask SHR 1;
  WHILE Mask<>0 DO BEGIN
   INC(RESULT,2);
   Mask:=Mask SHR 1;
  END;
 END;
 PROCEDURE PutByte(Value:BYTE);
 BEGIN
  Destination^:=Value;
  INC(Destination);
 END;
 PROCEDURE PutLongWord(Value:LONGWORD);
 BEGIN
  PLONGWORD(Destination)^:=Value;
  INC(Destination,SIZEOF(LONGWORD));
 END;
 FUNCTION CheckBitLength(PhraseIndex,PhraseLength:LONGWORD;Method:BYTE):LONGWORD; REGISTER;
 VAR Value:LONGWORD;
 BEGIN
  RESULT:=0;
  CASE Method OF
   MethodShortLiteralMatch:BEGIN
    IF (PhraseLength=1) AND (PhraseIndex<=$F) THEN BEGIN
     RESULT:=3+4;
    END;
   END;
   MethodLastIndexPhrase:BEGIN
    IF (PhraseIndex=LastIndexUsed) AND (PhraseLength>=2) AND NOT LastWasMatch THEN BEGIN
     RESULT:=2+GetGammaSize(2)+GetGammaSize(PhraseLength);
    END;
   END;
   MethodShortMatch:BEGIN
    IF (PhraseLength IN [2,3]) AND (PhraseIndex<128) THEN BEGIN
     RESULT:=3+8;
    END;
   END;
   MethodMatch:BEGIN
    IF ((PhraseLength>=4) OR
        ((PhraseIndex>=128) AND (PhraseIndex<1280) AND (PhraseLength>=2)) OR
        ((PhraseIndex>=1280) AND (PhraseIndex<32000) AND (PhraseLength>=3))) THEN BEGIN
     RESULT:=2;
     Value:=PhraseIndex;
     IF LastWasMatch THEN BEGIN
      INC(RESULT,GetGammaSize((Value SHR 8)+2));
     END ELSE BEGIN
      INC(RESULT,GetGammaSize((Value SHR 8)+3));
     END;
     INC(RESULT,8);
     Value:=PhraseLength;
     IF PhraseIndex<128 THEN BEGIN
      DEC(Value,2);
     END ELSE BEGIN
      IF PhraseIndex>=1280 THEN DEC(Value);
      IF PhraseIndex>=32000 THEN DEC(Value);
     END;
     INC(RESULT,GetGammaSize(Value));
    END;
   END;
  END;
 END;
 FUNCTION CompareBytes(FirstComparePointer,SecondComparePointer:PBYTE):LONGWORD; REGISTER;
 BEGIN
  RESULT:=0;
  WHILE (LONGWORD(SecondComparePointer)<LONGWORD(EndPointer)) AND
        (FirstComparePointer^=SecondComparePointer^) DO BEGIN
   INC(RESULT);
   INC(FirstComparePointer);
   INC(SecondComparePointer);
  END;
 END;
 FUNCTION SearchForPhrase(Source:PBYTE;VAR BestPhraseIndex,BestPhraseLength:LONGWORD;VAR Node:PNode;VAR Mode:BYTE):BOOLEAN; REGISTER;
 VAR SearchPointer:PBYTE;
     FoundLength:LONGWORD;
 BEGIN
  RESULT:=FALSE;
  BestPhraseLength:=0;
  BestPhraseIndex:=0;
  CASE Mode OF
   0:BEGIN
    IF NOT ASSIGNED(Node) THEN Node:=RecentNodes^[PWORD(Source)^];
    IF ASSIGNED(Node) THEN BEGIN
     IF LONGWORD(Source)<(LONGWORD(EndPointer)-1) THEN BEGIN
      SearchPointer:=Node^.DataPointer;
      FoundLength:=CompareBytes(SearchPointer,Source);
      IF FoundLength>0 THEN BEGIN
       BestPhraseLength:=FoundLength;
       BestPhraseIndex:=LONGWORD(Source)-LONGWORD(SearchPointer);
       RESULT:=TRUE;
      END;
     END;
     Node:=Node^.Previous;
    END;
    IF NOT ASSIGNED(Node) THEN BEGIN
     IF (LONGWORD(Source)-LONGWORD(SourcePointer))>0 THEN BEGIN
      INC(Mode);
     END ELSE BEGIN
      INC(Mode,2);
     END;
    END;
   END;
   1:BEGIN
    IF (LONGWORD(Source)-LONGWORD(SourcePointer))>0 THEN BEGIN
     SearchPointer:=Source;
     DEC(SearchPointer);
     FoundLength:=CompareBytes(SearchPointer,Source);
     IF FoundLength>0 THEN BEGIN
      BestPhraseLength:=FoundLength;
      BestPhraseIndex:=LONGWORD(Source)-LONGWORD(SearchPointer);
      RESULT:=TRUE;
     END;
    END;
    INC(Mode);
   END;
   2..16:BEGIN
    IF (LONGWORD(Source)-LONGWORD(SourcePointer))>=LONGWORD(Mode-1) THEN BEGIN
     SearchPointer:=Source;
     DEC(SearchPointer,(Mode-1));
    END ELSE BEGIN
     SearchPointer:=SourcePointer;
     Mode:=18;
    END;
    IF SearchPointer^=Source^ THEN BEGIN
     BestPhraseLength:=1;
     BestPhraseIndex:=LONGWORD(Source)-LONGWORD(SearchPointer);
     RESULT:=TRUE;
    END;
    INC(Mode);
   END;
  END;
 END;
 PROCEDURE SearchForLongestPhrase(Source:PBYTE;VAR BestPhraseIndex,BestPhraseLength:LONGWORD;VAR BestPhraseMethod:BYTE); REGISTER;
 VAR PhraseIndex,PhraseLength,PhraseSaves:LONGwORD;
     BestPhraseSaves,Bits:LONGWORD;
     PhraseMethod,Mode:BYTE;
     Node:PNode;
 BEGIN
  BestPhraseIndex:=0;
  BestPhraseLength:=1;
  IF Source^=0 THEN BEGIN
   BestPhraseMethod:=MethodNullByte;
   BestPhraseSaves:=1;
  END ELSE BEGIN
   BestPhraseMethod:=MethodLiteral;
   BestPhraseSaves:=0;
  END;
  Node:=NIL;
  IF Source^=0 THEN BEGIN
   Node:=NIL;
  END;
  Mode:=0;
  WHILE Mode<17 DO BEGIN
   IF SearchForPhrase(Source,PhraseIndex,PhraseLength,Node,Mode) THEN BEGIN
    IF (PhraseIndex>0) AND (PhraseLength>0) THEN BEGIN
     FOR PhraseMethod:=CheckMethodsStart TO CheckMethodsEnd DO BEGIN
      Bits:=CheckBitLength(PhraseIndex,PhraseLength,PhraseMethod);
      IF Bits<>0 THEN BEGIN
       PhraseSaves:=(PhraseLength SHL 3)-Bits;
       IF PhraseSaves>BestPhraseSaves THEN BEGIN
        BestPhraseIndex:=PhraseIndex;
        BestPhraseLength:=PhraseLength;
        BestPhraseSaves:=PhraseSaves;
        BestPhraseMethod:=PhraseMethod;
       END;
      END;
     END;
    END;
   END;
  END;
 END;
 PROCEDURE PutResult(VAR Source:PBYTE); REGISTER;
 VAR Value:LONGWORD;
 BEGIN
  CASE BestMethod OF
   MethodLiteral:BEGIN
    PutBit(FALSE);
    PutByte(Source^);
    INC(Source);
    LastWasMatch:=FAlSE;
   END;
   MethodShortLiteralMatch:BEGIN
    PutBit(TRUE);
    PutBit(TRUE);
    PutBit(TRUE);
    PutBits(BestFoundPhraseIndex,4);
    INC(Source);
    LastWasMatch:=FALSE;
   END;
   MethodLastIndexPhrase:BEGIN
    PutBit(TRUE);
    PutBit(FALSE);
    PutGamma(2);
    PutGamma(BestFoundPhraseLength);
    INC(Source,BestFoundPhraseLength);
    LastIndexUsed:=BestFoundPhraseIndex;
    LastWasMatch:=TRUE;
   END;
   MethodShortMatch:BEGIN
    PutBit(TRUE);
    PutBit(TRUE);
    PutBit(FALSE);
    PutByte((BestFoundPhraseIndex SHL 1)+(BestFoundPhraseLength-2));
    INC(Source,BestFoundPhraseLength);
    LastIndexUsed:=BestFoundPhraseIndex;
    LastWasMatch:=TRUE;
   END;
   MethodMatch:BEGIN
    PutBit(TRUE);
    PutBit(FALSE);
    Value:=BestFoundPhraseIndex;
    IF LastWasMatch THEN BEGIN
     PutGamma((Value SHR 8)+2);
    END ELSE BEGIN
     PutGamma((Value SHR 8)+3);
    END;
    PutByte(Value AND $FF);
    Value:=BestFoundPhraseLength;
    IF BestFoundPhraseIndex<128 THEN BEGIN
     DEC(Value,2);
    END ELSE BEGIN
     IF BestFoundPhraseIndex>=1280 THEN DEC(Value);
     IF BestFoundPhraseIndex>=32000 THEN DEC(Value);
    END;
    PutGamma(Value);
    INC(Source,BestFoundPhraseLength);
    LastIndexUsed:=BestFoundPhraseIndex;
    LastWasMatch:=TRUE;
   END;
   MethodNullByte:BEGIN
    PutBit(TRUE);
    PutBit(TRUE);
    PutBit(TRUE);
    PutBits(0,4);
    INC(Source);
    LastWasMatch:=FALSE;
   END;
  END;
 END;
 PROCEDURE DoHash(VAR Source:PBYTE); REGISTER;
 BEGIN
  WHILE LONGWORD(LastHashedPointer)<(LONGWORD(Source)-1) DO BEGIN
   AddNode(LastHashedPointer);
   INC(LastHashedPointer);
  END;
 END;
 PROCEDURE PutEndCode;
 BEGIN
  PutBit(TRUE);
  PutBit(TRUE);
  PutBit(FALSE);
  Destination^:=0;
 END;
 PROCEDURE DoMainLoop(VAR Source:PBYTE); REGISTER;
 BEGIN
  PutLongWord(Size);
  Destination^:=Source^;
  INC(Source);
  INC(Destination);
  DoHash(Source);
  TagPointer:=Destination;
  INC(Destination);
  Tag:=0;
  BitCount:=8;
  LastIndexUsed:=0;
  LastWasMatch:=FALSE;
  WHILE LONGWORD(Source)<LONGWORD(EndPointer) DO BEGIN
   SearchForLongestPhrase(Source,BestFoundPhraseIndex,BestFoundPhraseLength,BestMethod);
   PutResult(Source);
   DoHash(Source);
  END;
  PutEndCode;
  IF BitCount<7 THEN TagPointer^:=Tag SHL BitCount;
 END;
BEGIN
 RESULT:=0;
 IF Size>0 THEN BEGIN
  NodesSize:=SIZEOF(TNode)*Size;
  GETMEM(Nodes,NodesSize);
  FILLCHAR(Nodes^,NodesSize,#0);
  GETMEM(RecentNodes,SIZEOF(TRecentNodes));
  GETMEM(RecentNodes,SIZEOF(TRecentNodes));
  FILLCHAR(RecentNodes^,SIZEOF(TRecentNodes),#0);
  NodePosition:=0;
  GETMEM(DestinationPointer,Size*16);
  Source:=SourcePointer;
  Destination:=DestinationPointer;
  EndPointer:=Source;
  INC(EndPointer,Size);
  LastHashedPointer:=SourcePointer;
  DoMainLoop(Source);
  FREEMEM(Nodes);
  FREEMEM(RecentNodes);
  RESULT:=LONGWORD(Destination)-LONGWORD(DestinationPointer);
 END;
END;

FUNCTION ProcessDecompress(VAR SourcePointer,DestinationPointer:POINTER;Size:LONGWORD):LONGWORD;
TYPE PBYTE=^BYTE;
     PLONGWORD=^LONGWORD;
     TSignature=ARRAY[1..4] OF CHAR;
     THeader=PACKED RECORD
      Signature:TSignature;
      HeaderSize:LONGWORD;
     END;
     THeaderExt=PACKED RECORD
      PackedSize:LONGWORD;
      PackedCRC:LONGWORD;
      UncompressedSize:LONGWORD;
      UncompressedCRC:LONGWORD;
     END;
VAR Source,Destination,EndPointer,CopySource:PBYTE;
    Tag,BitCount,LengthCount,SourceOffset,DestSize:LONGWORD;
    LastMatchOffset:LONGWORD;
    LastWasMatch:BOOLEAN;
    Header:THeader;
    HeaderExt:THeaderExt;
 FUNCTION GetBits(Bits:LONGWORD):LONGWORD;
 BEGIN
  IF Bits=1 THEN BEGIN
   IF BitCount=0 THEN BEGIN
    Tag:=Source^;
    INC(Source);
    BitCount:=8;
   END;
   DEC(BitCount);
   RESULT:=(Tag SHR 7) AND 1;
   Tag:=Tag SHL 1;
  END ELSE BEGIN
   RESULT:=0;
   WHILE Bits>0 DO BEGIN
    RESULT:=(RESULT SHL 1)+GetBits(1);
    DEC(Bits);
   END;
  END;
 END;
 FUNCTION GetBit:BOOLEAN;
 BEGIN
  RESULT:=GetBits(1)<>0;
 END;
 FUNCTION GetByte:LONGWORD;
 BEGIN
  RESULT:=Source^;
  INC(Source);
 END;
 FUNCTION GetData(VAR Data;Size:LONGWORD):LONGWORD;
 BEGIN
  MOVE(Source^,Data,Size);
  INC(Source,Size);
  RESULT:=Size;
 END;
 FUNCTION GetLongWord:LONGWORD;
 BEGIN
  RESULT:=PLONGWORD(Source)^;
  INC(Source,SIZEOF(LONGWORD));
 END;
 FUNCTION GetGamma:LONGWORD;
 BEGIN
  RESULT:=1;
  REPEAT
   RESULT:=(RESULT SHL 1)+GetBits(1);
  UNTIL NOT GetBit;
 END;
 PROCEDURE DoMove(Src,Dst:PBYTE;Counter:LONGWORD);
 BEGIN
  WHILE Counter>0 DO BEGIN
   Dst^:=Src^;
   INC(Src);
   INC(Dst);
   DEC(Counter);
  END;
 END;
 PROCEDURE MainLoop;
 VAR Value:LONGWORD;
 BEGIN
  LastMatchOffset:=0;
  LastWasMatch:=FALSE;
  Destination^:=GetByte;
  INC(Destination);
  WHILE LONGWORD(Destination)<LONGWORD(EndPointer) DO BEGIN
   IF GetBit THEN BEGIN
    IF GetBit THEN BEGIN
     IF GetBit THEN BEGIN
      SourceOffset:=GetBits(4);
      IF SourceOffset<>0 THEN BEGIN
       CopySource:=Destination;
       DEC(CopySource,SourceOffset);
       Destination^:=CopySource^;
      END ELSE BEGIN
       Destination^:=0;
      END;
      INC(Destination);
      LastWasMatch:=FALSE;
     END ELSE BEGIN
      Value:=GetByte;
      SourceOffset:=Value SHR 1;
      LengthCount:=(Value AND 1)+2;
      IF SourceOffset<>0 THEN BEGIN
       CopySource:=Destination;
       DEC(CopySource,SourceOffset);
       DoMove(CopySource,Destination,LengthCount);
       INC(Destination,LengthCount);
       LastMatchOffset:=SourceOffset;
       LastWasMatch:=TRUE;
      END ELSE BEGIN
       BREAK;
      END;
     END;
    END ELSE BEGIN
     SourceOffset:=GetGamma;
     IF (SourceOffset=2) AND NOT LastWasMatch THEN BEGIN
      SourceOffset:=LastMatchOffset;
      LengthCount:=GetGamma;
      CopySource:=Destination;
      DEC(CopySource,SourceOffset);
      DoMove(CopySource,Destination,LengthCount);
      INC(Destination,LengthCount);
     END ELSE BEGIN
      IF LastWasMatch THEN BEGIN
       DEC(SourceOffset,2);
      END ELSE BEGIN
       DEC(SourceOffset,3);
      END;
      SourceOffset:=(SourceOffset SHL 8) OR GetByte;
      LengthCount:=GetGamma;
      IF SourceOffset<128 THEN BEGIN
       INC(LengthCount,2);
      END ELSE BEGIN
       IF SourceOffset>=32000 THEN INC(LengthCount);
       IF SourceOffset>=1280 THEN INC(LengthCount);
      END;
      CopySource:=Destination;
      DEC(CopySource,SourceOffset);
      DoMove(CopySource,Destination,LengthCount);
      INC(Destination,LengthCount);
      LastMatchOffset:=SourceOffset;
     END;
     LastWasMatch:=TRUE;
    END;
   END ELSE BEGIN
    Destination^:=GetByte;
    INC(Destination);
    LastWasMatch:=FALSE;
   END;
  END;
 END;
BEGIN
 RESULT:=0;
 IF Size>0 THEN BEGIN
  Source:=SourcePointer;
  GetData(Header,SIZEOF(THeader));
  IF Header.Signature='AP32' THEN BEGIN
   DEC(Header.HeaderSize,SIZEOF(THeader));
   IF Header.HeaderSize<=SIZEOF(THeaderExt) THEN BEGIN
    GetData(HeaderExt,Header.HeaderSize);
   END ELSE BEGIN
    GetData(HeaderExt,SIZEOF(THeaderExt));
    INC(Source,Header.HeaderSize-SIZEOF(THeaderExt));
   END;
   DestSize:=HeaderExt.UncompressedSize;
  END ELSE BEGIN
   Source:=SourcePointer;
   DestSize:=GetLongWord;
  END;
  IF DestSize>0 THEN BEGIN
   GETMEM(DestinationPointer,DestSize);
   Destination:=DestinationPointer;
   EndPointer:=Destination;
   INC(EndPointer,DestSize);
   Tag:=0;
   BitCount:=0;
   MainLoop;
   RESULT:=LONGWORD(Destination)-LONGWORD(DestinationPointer);
  END;
 END;
END;

PROCEDURE Compression(Source,Destination:TBeRoStream;Fast:BOOLEAN); OVERLOAD;
VAR SourcePointer,DestinationPointer:POINTER;
    SourceSize,DestinationSize:LONGWORD;
BEGIN
 IF ASSIGNED(Source) AND ASSIGNED(Destination) THEN BEGIN
  DestinationSize:=0;
  DestinationPointer:=NIL;
  SourceSize:=Source.Size;
  GETMEM(SourcePointer,SourceSize);
  Source.Seek(0);
  Source.Read(SourcePointer^,SourceSize);
  DestinationSize:=ProcessCompress(SourcePointer,DestinationPointer,SourceSize);
  Destination.Clear;
  Destination.Write(DestinationPointer^,DestinationSize);
  FREEMEM(DestinationPointer);
  FREEMEM(SourcePointer);
 END;
END;

PROCEDURE Decompression(Source,Destination:TBeRoStream); OVERLOAD;
VAR SourcePointer,DestinationPointer:POINTER;
    SourceSize,DestinationSize:LONGWORD;
BEGIN
 IF ASSIGNED(Source) AND ASSIGNED(Destination) THEN BEGIN
  DestinationSize:=0;
  DestinationPointer:=NIL;
  SourceSize:=Source.Size;
  GETMEM(SourcePointer,SourceSize);
  Source.Seek(0);
  Source.Read(SourcePointer^,SourceSize);
  DestinationSize:=ProcessDecompress(SourcePointer,DestinationPointer,SourceSize);
  Destination.Clear;
  Destination.Write(DestinationPointer^,DestinationSize);
  FREEMEM(DestinationPointer);
  FREEMEM(SourcePointer);
 END;
END;

FUNCTION CreateExportTreeNode(AChar:CHAR):PExportTreeNode;
BEGIN
 GETMEM(RESULT,SIZEOF(TExportTreeNode));
 RESULT^.TheChar:=AChar;
 RESULT^.Link:=NIL;
 RESULT^.LinkExist:=FALSE;
 RESULT^.Prevoius:=NIL;
 RESULT^.Next:=NIL;
 RESULT^.Up:=NIL;
 RESULT^.Down:=NIL;
END;

PROCEDURE DestroyExportTreeNode(Node:PExportTreeNode);
BEGIN
 IF ASSIGNED(Node) THEN BEGIN
  DestroyExportTreeNode(Node^.Next);
  DestroyExportTreeNode(Node^.Down);
  FREEMEM(Node);
 END;
END;

CONSTRUCTOR TExportTree.Create;
BEGIN
 INHERITED Create;
 Root:=NIL;
END;

DESTRUCTOR TExportTree.Destroy;
BEGIN
 DestroyExportTreeNode(Root);
 INHERITED Destroy;
END;

PROCEDURE TExportTree.Dump;
VAR Ident:INTEGER;
 PROCEDURE DumpNode(Node:PExportTreeNode);
 VAR SubNode:PExportTreeNode;
     IdentCounter,IdentOld:INTEGER;
 BEGIN
  FOR IdentCounter:=1 TO Ident DO WRITE(' ');
  WRITE(Node^.TheChar);
  IdentOld:=Ident;
  SubNode:=Node^.Next;
  WHILE ASSIGNED(SubNode) DO BEGIN
   WRITE(SubNode.TheChar);
   IF NOT ASSIGNED(SubNode^.Next) THEN BREAK;
   INC(Ident);
   SubNode:=SubNode^.Next;
  END;
  WRITELN;
  INC(Ident);
  WHILE ASSIGNED(SubNode) AND (SubNode<>Node) DO BEGIN
   IF ASSIGNED(SubNode^.Down) THEN DumpNode(SubNode^.Down);
   SubNode:=SubNode^.Prevoius;
   DEC(Ident);
  END;
  Ident:=IdentOld;
  IF ASSIGNED(Node^.Down) THEN DumpNode(Node^.Down);
 END;
BEGIN
 Ident:=0;
 DumpNode(Root);
END;

FUNCTION TExportTree.Add(FunctionName:STRING;Link:TExportTreeLink):BOOLEAN;
VAR StringLength,Position,PositionCounter:INTEGER;
    NewNode,LastNode,Node:PExportTreeNode;
    StringChar,NodeChar:CHAR;
BEGIN
 RESULT:=FALSE;
 StringLength:=LENGTH(FunctionName);
 IF StringLength>0 THEN BEGIN
  LastNode:=NIL;
  Node:=Root;
  FOR Position:=1 TO StringLength DO BEGIN
   StringChar:=FunctionName[Position];
   IF ASSIGNED(Node) THEN BEGIN
    NodeChar:=Node^.TheChar;
    IF NodeChar=StringChar THEN BEGIN
     LastNode:=Node;
     Node:=Node^.Next;
   END ELSE BEGIN
     WHILE (NodeChar<StringChar) AND ASSIGNED(Node^.Down) DO BEGIN
      Node:=Node^.Down;
      NodeChar:=Node^.TheChar;
     END;
     IF NodeChar=StringChar THEN BEGIN
      LastNode:=Node;
      Node:=Node^.Next;
     END ELSE BEGIN
      NewNode:=CreateExportTreeNode(StringChar);
      IF NodeChar<StringChar THEN BEGIN
       NewNode^.Down:=Node^.Down;
       NewNode^.Up:=Node;
       IF ASSIGNED(NewNode^.Down) THEN BEGIN
        NewNode^.Down^.Up:=NewNode;
       END;
       NewNode^.Prevoius:=Node^.Prevoius;
       Node^.Down:=NewNode;
      END ELSE IF NodeChar>StringChar THEN BEGIN
       NewNode^.Down:=Node;
       NewNode^.Up:=Node^.Up;
       IF ASSIGNED(NewNode^.Up) THEN BEGIN
        NewNode^.Up^.Down:=NewNode;
       END;
       NewNode^.Prevoius:=Node^.Prevoius;
       IF NOT ASSIGNED(NewNode^.Up) THEN BEGIN
        IF ASSIGNED(NewNode^.Prevoius) THEN BEGIN
         NewNode^.Prevoius^.Next:=NewNode;
        END ELSE BEGIN
         Root:=NewNode;
        END;
       END;
       Node^.Up:=NewNode;
      END;
      LastNode:=NewNode;
      Node:=LastNode^.Next;
     END;
    END;
   END ELSE BEGIN
    FOR PositionCounter:=Position TO StringLength DO BEGIN
     NewNode:=CreateExportTreeNode(FunctionName[PositionCounter]);
     IF ASSIGNED(LastNode) THEN BEGIN
      NewNode^.Prevoius:=LastNode;
      LastNode^.Next:=NewNode;
      LastNode:=LastNode^.Next;
     END ELSE BEGIN
      IF NOT ASSIGNED(Root) THEN BEGIN
       Root:=NewNode;
       LastNode:=Root;
      END;
     END;
    END;
    BREAK;
   END;
  END;
  IF ASSIGNED(LastNode) THEN BEGIN
   IF NOT LastNode^.LinkExist THEN BEGIN
    LastNode^.Link:=Link;
    LastNode^.LinkExist:=TRUE;
    RESULT:=TRUE;
   END;
  END;
 END;
END;

FUNCTION TExportTree.Delete(FunctionName:STRING):BOOLEAN;
VAR StringLength,Position:INTEGER;
    Node:PExportTreeNode;
    StringChar,NodeChar:CHAR;
BEGIN
 RESULT:=FALSE;
 StringLength:=LENGTH(FunctionName);
 IF StringLength>0 THEN BEGIN
  Node:=Root;
  FOR Position:=1 TO StringLength DO BEGIN
   StringChar:=FunctionName[Position];
   IF ASSIGNED(Node) THEN BEGIN
    NodeChar:=Node^.TheChar;
    WHILE (NodeChar<>StringChar) AND ASSIGNED(Node^.Down) DO BEGIN
     Node:=Node^.Down;
     NodeChar:=Node^.TheChar;
    END;
    IF NodeChar=StringChar THEN BEGIN
     IF (Position=StringLength) AND Node^.LinkExist THEN BEGIN
      Node^.LinkExist:=FALSE;
      RESULT:=TRUE;
      BREAK;
     END;
     Node:=Node^.Next;
    END;
   END ELSE BEGIN
    BREAK;
   END;
  END;
 END;
END;

FUNCTION TExportTree.Find(FunctionName:STRING;VAR Link:TExportTreeLink):BOOLEAN;
VAR StringLength,Position:INTEGER;
    Node:PExportTreeNode;
    StringChar,NodeChar:CHAR;
BEGIN
 RESULT:=FALSE;
 StringLength:=LENGTH(FunctionName);
 IF StringLength>0 THEN BEGIN
  Node:=Root;
  FOR Position:=1 TO StringLength DO BEGIN
   StringChar:=FunctionName[Position];
   IF ASSIGNED(Node) THEN BEGIN
    NodeChar:=Node^.TheChar;
    WHILE (NodeChar<>StringChar) AND ASSIGNED(Node^.Down) DO BEGIN
     Node:=Node^.Down;
     NodeChar:=Node^.TheChar;
    END;
    IF NodeChar=StringChar THEN BEGIN
     IF (Position=StringLength) AND Node^.LinkExist THEN BEGIN
      Link:=Node^.Link;
      RESULT:=TRUE;
      BREAK;
     END;
     Node:=Node^.Next;
    END;
   END ELSE BEGIN
    BREAK;
   END;
  END;
 END;
END;

CONSTRUCTOR TDynamicLinkLibrary.Create(DynamicLinkLibraryName:STRING='');
BEGIN
 INHERITED Create;
 ImageBase:=NIL;
 DLLName:=DynamicLinkLibraryName;
 DLLProc:=NIL;
 DLLHandle:=0;
 ExternalLibraryArray:=NIL;
 ImportArray:=NIL;
 ExportArray:=NIL;
 Sections:=NIL;
 ExportTree:=NIL;
END;

DESTRUCTOR TDynamicLinkLibrary.Destroy;
BEGIN
 IF @DLLProc<>NIL THEN Unload;
 IF ASSIGNED(ExportTree) THEN ExportTree.Destroy;
 INHERITED Destroy;
END;

FUNCTION TDynamicLinkLibrary.FindExternalLibrary(LibraryName:STRING):INTEGER;
VAR I:INTEGER;
BEGIN
 RESULT:=-1;
 FOR I:=0 TO LENGTH(ExternalLibraryArray)-1 DO BEGIN
  IF ExternalLibraryArray[I].LibraryName=LibraryName THEN BEGIN
   RESULT:=I;
   EXIT;
  END;
 END;
END;

FUNCTION TDynamicLinkLibrary.LoadExternalLibrary(LibraryName:STRING):INTEGER;
BEGIN
 RESULT:=FindExternalLibrary(LibraryName);
 IF RESULT<0 THEN BEGIN
  RESULT:=LENGTH(ExternalLibraryArray);
  SETLENGTH(ExternalLibraryArray,LENGTH(ExternalLibraryArray)+1);
  ExternalLibraryArray[RESULT].LibraryName:=LibraryName;
  ExternalLibraryArray[RESULT].LibraryHandle:=LoadLibrary(PCHAR(LibraryName));
 END;
END;

FUNCTION TDynamicLinkLibrary.GetExternalLibraryHandle(LibraryName:STRING):LONGWORD;
VAR I:INTEGER;
BEGIN
 RESULT:=0;
 FOR I:=0 TO LENGTH(ExternalLibraryArray)-1 DO BEGIN
  IF ExternalLibraryArray[I].LibraryName=LibraryName THEN BEGIN
   RESULT:=ExternalLibraryArray[I].LibraryHandle;
   EXIT;
  END;
 END;
END;

FUNCTION TDynamicLinkLibrary.Load(Stream:TBeRoStream):BOOLEAN;
VAR ImageDOSHeader:TImageDOSHeader;
    ImageNTHeaders:TImageNTHeaders;
    OldProtect:LONGWORD;
 FUNCTION ConvertPointer(RVA:LONGWORD):POINTER;
 VAR I:INTEGER;
 BEGIN
  RESULT:=NIL;
  FOR I:=0 TO LENGTH(Sections)-1 DO BEGIN
   IF (RVA<(Sections[I].RVA+Sections[I].Size)) AND (RVA>=Sections[I].RVA) THEN BEGIN
    RESULT:=POINTER(LONGWORD((RVA-LONGWORD(Sections[I].RVA))+LONGWORD(Sections[I].Base)));
    EXIT;
   END;
  END;
 END;
 FUNCTION ReadImageHeaders:BOOLEAN;
 BEGIN
  RESULT:=FALSE;
  IF Stream.Size>0 THEN BEGIN
   FILLCHAR(ImageNTHeaders,SIZEOF(TImageNTHeaders),#0);
   IF Stream.Read(ImageDOSHeader,SIZEOF(TImageDOSHeader))<>SIZEOF(TImageDOSHeader) THEN EXIT;
   IF ImageDOSHeader.Signature<>$5A4D THEN EXIT;
   IF Stream.Seek(ImageDOSHeader.LFAOffset)<>LONGINT(ImageDOSHeader.LFAOffset) THEN EXIT;
   IF Stream.Read(ImageNTHeaders.Signature,SIZEOF(LONGWORD))<>SIZEOF(LONGWORD) THEN EXIT;
   IF ImageNTHeaders.Signature<>$00004550 THEN EXIT;
   IF Stream.Read(ImageNTHeaders.FileHeader,SIZEOF(TImageFileHeader))<>SIZEOF(TImageFileHeader) THEN EXIT;
   IF ImageNTHeaders.FileHeader.Machine<>$14C THEN EXIT;
   IF Stream.Read(ImageNTHeaders.OptionalHeader,ImageNTHeaders.FileHeader.SizeOfOptionalHeader)<>ImageNTHeaders.FileHeader.SizeOfOptionalHeader THEN EXIT;
   RESULT:=TRUE;
  END;
 END;
 FUNCTION InitializeImage:BOOLEAN;
 VAR SectionBase:POINTER;
     OldPosition:INTEGER;
 BEGIN
  RESULT:=FALSE;
  IF ImageNTHeaders.FileHeader.NumberOfSections>0 THEN BEGIN
   ImageBase:=VirtualAlloc(NIL,ImageNTHeaders.OptionalHeader.SizeOfImage,MEM_RESERVE,PAGE_NOACCESS);
   ImageBaseDelta:=LONGWORD(ImageBase)-ImageNTHeaders.OptionalHeader.ImageBase;
   SectionBase:=VirtualAlloc(ImageBase,ImageNTHeaders.OptionalHeader.SizeOfHeaders,MEM_COMMIT,PAGE_READWRITE);
   OldPosition:=Stream.Position;
   Stream.Seek(0);
   Stream.Read(SectionBase^,ImageNTHeaders.OptionalHeader.SizeOfHeaders);
   VirtualProtect(SectionBase,ImageNTHeaders.OptionalHeader.SizeOfHeaders,PAGE_READONLY,OldProtect);
   Stream.Seek(OldPosition);
   RESULT:=TRUE;
  END;
 END;
 FUNCTION ReadSections:BOOLEAN;
 VAR I:INTEGER;
     Section:TImageSectionHeader;
     SectionHeaders:PImageSectionHeaders;
 BEGIN
  RESULT:=FALSE;
  IF ImageNTHeaders.FileHeader.NumberOfSections>0 THEN BEGIN
   GETMEM(SectionHeaders,ImageNTHeaders.FileHeader.NumberOfSections*SIZEOF(TImageSectionHeader));
   IF Stream.Read(SectionHeaders^,(ImageNTHeaders.FileHeader.NumberOfSections*SIZEOF(TImageSectionHeader)))<>(ImageNTHeaders.FileHeader.NumberOfSections*SIZEOF(TImageSectionHeader)) THEN EXIT;
   SETLENGTH(Sections,ImageNTHeaders.FileHeader.NumberOfSections);
   FOR I:=0 TO ImageNTHeaders.FileHeader.NumberOfSections-1 DO BEGIN
    Section:=SectionHeaders^[I];
    Sections[I].RVA:=Section.VirtualAddress;
    Sections[I].Size:=Section.SizeOfRawData;
    IF Sections[I].Size<Section.Misc.VirtualSize THEN BEGIN
     Sections[I].Size:=Section.Misc.VirtualSize;
    END;
    Sections[I].Characteristics:=Section.Characteristics;
    Sections[I].Base:=VirtualAlloc(POINTER(LONGWORD(Sections[I].RVA+LONGWORD(ImageBase))),Sections[I].Size,MEM_COMMIT,PAGE_READWRITE);
    FILLCHAR(Sections[I].Base^,Sections[I].Size,#0);
    IF Section.PointerToRawData<>0 THEN BEGIN
     Stream.Seek(Section.PointerToRawData);
     IF Stream.Read(Sections[I].Base^,Section.SizeOfRawData)<>LONGINT(Section.SizeOfRawData) THEN EXIT;
    END;
   END;
   FREEMEM(SectionHeaders);
   RESULT:=TRUE;
  END;
 END;
 FUNCTION ProcessRelocations:BOOLEAN;
 VAR Relocations:PCHAR;
     Position:LONGWORD;
     BaseRelocation:PImageBaseRelocation;
     Base:POINTER;
     NumberOfRelocations:LONGWORD;
     Relocation:PWordArray;
     RelocationCounter:LONGINT;
     RelocationPointer:POINTER;
     RelocationType:LONGWORD;
 BEGIN
  IF ImageNTHeaders.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_BASERELOC].VirtualAddress<>0 THEN BEGIN
   RESULT:=FALSE;
   Relocations:=ConvertPointer(ImageNTHeaders.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_BASERELOC].VirtualAddress);
   Position:=0;
   WHILE ASSIGNED(Relocations) AND (Position<ImageNTHeaders.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_BASERELOC].Size) DO BEGIN
    BaseRelocation:=PImageBaseRelocation(Relocations);
    Base:=ConvertPointer(BaseRelocation^.VirtualAddress);
    IF NOT ASSIGNED(Base) THEN EXIT;
    NumberOfRelocations:=(BaseRelocation^.SizeOfBlock-SIZEOF(TImageBaseRelocation)) DIV SIZEOF(WORD);
    Relocation:=POINTER(LONGWORD(LONGWORD(BaseRelocation)+SIZEOF(TImageBaseRelocation)));
    FOR RelocationCounter:=0 TO NumberOfRelocations-1 DO BEGIN
     RelocationPointer:=POINTER(LONGWORD(LONGWORD(Base)+(Relocation^[RelocationCounter] AND $FFF)));
     RelocationType:=Relocation^[RelocationCounter] SHR 12;
     CASE RelocationType OF
      IMAGE_REL_BASED_ABSOLUTE:BEGIN
      END;
      IMAGE_REL_BASED_HIGH:BEGIN
       PWORD(RelocationPointer)^:=(LONGWORD(((LONGWORD(PWORD(RelocationPointer)^+LONGWORD(ImageBase)-ImageNTHeaders.OptionalHeader.ImageBase)))) SHR 16) AND $FFFF;
      END;
      IMAGE_REL_BASED_LOW:BEGIN
       PWORD(RelocationPointer)^:=LONGWORD(((LONGWORD(PWORD(RelocationPointer)^+LONGWORD(ImageBase)-ImageNTHeaders.OptionalHeader.ImageBase)))) AND $FFFF;
      END;
      IMAGE_REL_BASED_HIGHLOW:BEGIN
       PPOINTER(RelocationPointer)^:=POINTER((LONGWORD(LONGWORD(PPOINTER(RelocationPointer)^)+LONGWORD(ImageBase)-ImageNTHeaders.OptionalHeader.ImageBase)));
      END;
      IMAGE_REL_BASED_HIGHADJ:BEGIN
       // ???
      END;
      IMAGE_REL_BASED_MIPS_JMPADDR:BEGIN
       // Only for MIPS CPUs ;)
      END;
     END;
    END;
    Relocations:=POINTER(LONGWORD(LONGWORD(Relocations)+BaseRelocation^.SizeOfBlock));
    INC(Position,BaseRelocation^.SizeOfBlock);
   END;
  END;
  RESULT:=TRUE;
 END;
 FUNCTION ProcessImports:BOOLEAN;
 VAR ImportDescriptor:PImageImportDescriptor;
     ThunkData:PLONGWORD;
     Name:PCHAR;
     DLLImport:PDLLImport;
     DLLFunctionImport:PDLLFunctionImport;
     FunctionPointer:POINTER;
 BEGIN
  IF ImageNTHeaders.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_IMPORT].VirtualAddress<>0 THEN BEGIN
   ImportDescriptor:=ConvertPointer(ImageNTHeaders.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_IMPORT].VirtualAddress);
   IF ASSIGNED(ImportDescriptor) THEN BEGIN
    SETLENGTH(ImportArray,0);
    WHILE ImportDescriptor^.Name<>0 DO BEGIN
     Name:=ConvertPointer(ImportDescriptor^.Name);
     SETLENGTH(ImportArray,LENGTH(ImportArray)+1);
     LoadExternalLibrary(Name);
     DLLImport:=@ImportArray[LENGTH(ImportArray)-1];
     DLLImport^.LibraryName:=Name;
     DLLImport^.LibraryHandle:=GetExternalLibraryHandle(Name);
     DLLImport^.Entries:=NIL;
     IF ImportDescriptor^.TimeDateStamp=0 THEN BEGIN
      ThunkData:=ConvertPointer(ImportDescriptor^.FirstThunk);
     END ELSE BEGIN
      ThunkData:=ConvertPointer(ImportDescriptor^.OriginalFirstThunk);
     END;
     WHILE ThunkData^<>0 DO BEGIN
      SETLENGTH(DLLImport^.Entries,LENGTH(DLLImport^.Entries)+1);
      DLLFunctionImport:=@DLLImport^.Entries[LENGTH(DLLImport^.Entries)-1];
      IF (ThunkData^ AND IMAGE_ORDINAL_FLAG32)<>0 THEN BEGIN
       DLLFunctionImport^.NameOrID:=niID;
       DLLFunctionImport^.ID:=ThunkData^ AND IMAGE_ORDINAL_MASK32;
       DLLFunctionImport^.Name:='';
       FunctionPointer:=GetProcAddress(DLLImport^.LibraryHandle,PCHAR(ThunkData^ AND IMAGE_ORDINAL_MASK32));
      END ELSE BEGIN
       Name:=ConvertPointer(LONGWORD(ThunkData^)+IMPORTED_NAME_OFFSET);
       DLLFunctionImport^.NameOrID:=niName;
       DLLFunctionImport^.ID:=0;
       DLLFunctionImport^.Name:=Name;
       FunctionPointer:=GetProcAddress(DLLImport^.LibraryHandle,Name);
      END;
      PPOINTER(Thunkdata)^:=FunctionPointer;
      INC(ThunkData);
     END;
     INC(ImportDescriptor);
    END;
   END;
  END;
  RESULT:=TRUE;
 END;
 FUNCTION ProtectSections:BOOLEAN;
 VAR I:INTEGER;
     Characteristics:LONGWORD;
     Flags:LONGWORD;
 BEGIN
  RESULT:=FALSE;
  IF ImageNTHeaders.FileHeader.NumberOfSections>0 THEN BEGIN
   FOR I:=0 TO ImageNTHeaders.FileHeader.NumberOfSections-1 DO BEGIN
    Characteristics:=Sections[I].Characteristics;
    Flags:=0;
    IF (Characteristics AND IMAGE_SCN_MEM_EXECUTE)<>0 THEN BEGIN
     IF (Characteristics AND IMAGE_SCN_MEM_READ)<>0 THEN BEGIN
      IF (Characteristics AND IMAGE_SCN_MEM_WRITE)<>0 THEN BEGIN
       Flags:=Flags OR PAGE_EXECUTE_READWRITE;
      END ELSE BEGIN
       Flags:=Flags OR PAGE_EXECUTE_READ;
      END;
     END ELSE IF (Characteristics AND IMAGE_SCN_MEM_WRITE)<>0 THEN BEGIN
      Flags:=Flags OR PAGE_EXECUTE_WRITECOPY;
     END ELSE BEGIN
      Flags:=Flags OR PAGE_EXECUTE;
     END;
    END ELSE IF (Characteristics AND IMAGE_SCN_MEM_READ)<>0 THEN BEGIN
     IF (Characteristics AND IMAGE_SCN_MEM_WRITE)<>0 THEN BEGIN
      Flags:=Flags OR PAGE_READWRITE;
     END ELSE BEGIN
      Flags:=Flags OR PAGE_READONLY;
     END;
    END ELSE IF (Characteristics AND IMAGE_SCN_MEM_WRITE)<>0 THEN BEGIN
     Flags:=Flags OR PAGE_WRITECOPY;
    END ELSE BEGIN
     Flags:=Flags OR PAGE_NOACCESS;
    END;
    IF (Characteristics AND IMAGE_SCN_MEM_NOT_CACHED)<>0 THEN BEGIN
     Flags:=Flags OR PAGE_NOCACHE;
    END;
    VirtualProtect(Sections[I].Base,Sections[I].Size,Flags,OldProtect);
   END;
   RESULT:=TRUE;
  END;
 END;
 FUNCTION InitializeLibrary:BOOLEAN;
 BEGIN
  RESULT:=FALSE;
  @DLLProc:=ConvertPointer(ImageNTHeaders.OptionalHeader.AddressOfEntryPoint);
  IF DLLProc(CARDINAL(ImageBase),DLL_PROCESS_ATTACH,NIL) THEN BEGIN
   RESULT:=TRUE;
  END;
 END;
 FUNCTION ProcessExports:BOOLEAN;
 VAR I:INTEGER;
     ExportDirectory:PImageExportDirectory;
     ExportDirectorySize:LONGWORD;
     FunctionNamePointer:POINTER;
     FunctionName:PCHAR;
     FunctionIndexPointer:POINTER;
     FunctionIndex:LONGWORD;
     FunctionPointer:POINTER;
     ForwarderCharPointer:PCHAR;
     ForwarderString:STRING;
     ForwarderLibrary:STRING;
     ForwarderLibraryHandle:HINST;
  FUNCTION ParseStringToNumber(AString:STRING):LONGWORD;
  VAR CharCounter:INTEGER;
  BEGIN
   RESULT:=0;
   FOR CharCounter:=0 TO LENGTH(AString)-1 DO BEGIN
    IF AString[CharCounter] IN ['0'..'9'] THEN BEGIN
     RESULT:=(RESULT*10)+BYTE(BYTE(AString[CharCounter])-BYTE('0'));
    END ELSE BEGIN
     EXIT;
    END;
   END;
  END;
 BEGIN
  IF ImageNTHeaders.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_EXPORT].VirtualAddress<>0 THEN BEGIN
   ExportTree:=TExportTree.Create;
   ExportDirectory:=ConvertPointer(ImageNTHeaders.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_EXPORT].VirtualAddress);
   IF ASSIGNED(ExportDirectory) THEN BEGIN
    ExportDirectorySize:=ImageNTHeaders.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_EXPORT].Size;
    SETLENGTH(ExportArray,ExportDirectory^.NumberOfNames);
    FOR I:=0 TO ExportDirectory^.NumberOfNames-1 DO BEGIN
     FunctionNamePointer:=ConvertPointer(LONGWORD(ExportDirectory^.AddressOfNames));
     FunctionNamePointer:=ConvertPointer(PLongWordArray(FunctionNamePointer)^[I]);
     FunctionName:=FunctionNamePointer;
     FunctionIndexPointer:=ConvertPointer(LONGWORD(ExportDirectory^.AddressOfNameOrdinals));
     FunctionIndex:=PWordArray(FunctionIndexPointer)^[I];
     FunctionPointer:=ConvertPointer(LONGWORD(ExportDirectory^.AddressOfFunctions));
     FunctionPointer:=ConvertPointer(PLongWordArray(FunctionPointer)^[FunctionIndex]);
     ExportArray[I].Name:=FunctionName;
     ExportArray[I].Index:=FunctionIndex;
     IF (LONGWORD(ExportDirectory)<LONGWORD(FunctionPointer)) AND (LONGWORD(FunctionPointer)<(LONGWORD(ExportDirectory)+ExportDirectorySize)) THEN BEGIN
      ForwarderCharPointer:=FunctionPointer;
      ForwarderString:=ForwarderCharPointer;
      WHILE ForwarderCharPointer^<>'.' DO INC(ForwarderCharPointer);
      ForwarderLibrary:=COPY(ForwarderString,1,POS('.',ForwarderString)-1);
      LoadExternalLibrary(ForwarderLibrary);
      ForwarderLibraryHandle:=GetExternalLibraryHandle(ForwarderLibrary);
      IF ForwarderCharPointer^='#' THEN BEGIN
       INC(ForwarderCharPointer);
       ForwarderString:=ForwarderCharPointer;
       ForwarderCharPointer:=ConvertPointer(ParseStringToNumber(ForwarderString));
       ForwarderString:=ForwarderCharPointer;
      END ELSE BEGIN
       ForwarderString:=ForwarderCharPointer;
       ExportArray[I].FunctionPointer:=GetProcAddress(ForwarderLibraryHandle,PCHAR(ForwarderString));
      END;
     END ELSE BEGIN
      ExportArray[I].FunctionPointer:=FunctionPointer;
     END;
     ExportTree.Add(ExportArray[I].Name,ExportArray[I].FunctionPointer);
    END;
   END;
  END;
  RESULT:=TRUE;
 END;
BEGIN
 RESULT:=FALSE;
 IF ASSIGNED(Stream) THEN BEGIN
  Stream.Seek(0);
  IF Stream.Size>0 THEN BEGIN
   IF ReadImageHeaders THEN BEGIN
    IF InitializeImage THEN BEGIN
     IF ReadSections THEN BEGIN
      IF ProcessRelocations THEN BEGIN
       IF ProcessImports THEN BEGIN
        IF ProtectSections THEN BEGIN
         IF InitializeLibrary THEN BEGIN
          IF ProcessExports THEN BEGIN
           RESULT:=TRUE;
          END;
         END;
        END;
       END;
      END;
     END;
    END;
   END;
  END;
 END;
END;

FUNCTION TDynamicLinkLibrary.LoadFile(FileName:STRING):BOOLEAN;
BEGIN
 IF DLLHandle<>0 THEN BEGIN
  DLLHandle:=0;
  FreeLibrary(DLLHandle);
 END;
 DLLHandle:=LoadLibrary(PCHAR(FileName));
 RESULT:=DLLHandle<>0;
END;

FUNCTION TDynamicLinkLibrary.Unload:BOOLEAN;
VAR I,J:INTEGER;
BEGIN
 RESULT:=FALSE;
 IF DLLHandle<>0 THEN BEGIN
  DLLHandle:=0;
  FreeLibrary(DLLHandle);
 END ELSE BEGIN
  IF @DLLProc<>NIL THEN BEGIN
   DLLProc(LONGWORD(ImageBase),DLL_PROCESS_DETACH,NIL);
  END;
  FOR I:=0 TO LENGTH(Sections)-1 DO BEGIN
   IF ASSIGNED(Sections[I].Base) THEN BEGIN
    VirtualFree(Sections[I].Base,0,MEM_RELEASE);
   END;
  END;
  SETLENGTH(Sections,0);
  FOR I:=0 TO LENGTH(ExternalLibraryArray)-1 DO BEGIN
   ExternalLibraryArray[I].LibraryName:='';
   FreeLibrary(ExternalLibraryArray[I].LibraryHandle);
  END;
  SETLENGTH(ExternalLibraryArray,0);
  FOR I:=0 TO LENGTH(ImportArray)-1 DO BEGIN
   FOR J:=0 TO LENGTH(ImportArray[I].Entries)-1 DO BEGIN
    ImportArray[I].Entries[J].Name:='';
   END;
   SETLENGTH(ImportArray[I].Entries,0);
  END;
  SETLENGTH(ImportArray,0);
  FOR I:=0 TO LENGTH(ExportArray)-1 DO ExportArray[I].Name:='';
  SETLENGTH(ExportArray,0);
  VirtualFree(ImageBase,0,MEM_RELEASE);
 END;
 IF ASSIGNED(ExportTree) THEN BEGIN
  ExportTree.Destroy;
  ExportTree:=NIL;
 END;
END;

FUNCTION TDynamicLinkLibrary.FindExport(FunctionName:STRING):POINTER;
VAR I:INTEGER;
BEGIN
 RESULT:=NIL;
 IF DLLHandle<>0 THEN BEGIN
  RESULT:=GetProcAddress(DLLHandle,PCHAR(FunctionName));
 END ELSE BEGIN
  IF ASSIGNED(ExportTree) THEN BEGIN
   ExportTree.Find(FunctionName,RESULT);
  END ELSE BEGIN
   FOR I:=0 TO LENGTH(ExportArray)-1 DO BEGIN
    IF ExportArray[I].Name=FunctionName THEN BEGIN
     RESULT:=ExportArray[I].FunctionPointer;
     EXIT;
    END;
   END;
  END;
 END;
END;

CONST PrimZahlen:ARRAY[0..255] OF LONGWORD=(2,3,5,7,11,13,17,19,23,29,31,37,41,
                                            43,47,53,59,61,67,71,73,79,83,89,97,
                                            101,103,107,109,113,127,131,137,139,
                                            149,151,157,163,167,173,179,181,191,
                                            193,197,199,211,223,227,229,233,239,
                                            241,251,257,263,269,271,277,281,283,
                                            293,307,311,313,317,331,337,347,349,
                                            353,359,367,373,379,383,389,397,401,
                                            409,419,421,431,433,439,443,449,457,
                                            461,463,467,479,487,491,499,503,509,
                                            521,523,541,547,557,563,569,571,577,
                                            587,593,599,601,607,613,617,619,631,
                                            641,643,647,653,659,661,673,677,683,
                                            691,701,709,719,727,733,739,743,751,
                                            757,761,769,773,787,797,809,811,821,
                                            823,827,829,839,853,857,859,863,877,
                                            881,883,887,907,911,919,929,937,941,
                                            947,953,967,971,977,983,991,997,1009,
                                            1013,1019,1021,1031,1033,1039,1049,
                                            1051,1061,1063,1069,1087,1091,1093,
                                            1097,1103,1109,1117,1123,1129,1151,
                                            1153,1163,1171,1181,1187,1193,1201,
                                            1213,1217,1223,1229,1231,1237,1249,
                                            1259,1277,1279,1283,1289,1291,1297,
                                            1301,1303,1307,1319,1321,1327,1361,
                                            1367,1373,1381,1399,1409,1423,1427,
                                            1429,1433,1439,1447,1451,1453,1459,
                                            1471,1481,1483,1487,1489,1493,1499,
                                            1511,1523,1531,1543,1549,1553,1559,
                                            1567,1571,1579,1583,1597,1601,1607,
                                            1609,1613,1619);

      GenerationWert=$EDB88320;

PROCEDURE Encode(Data,Key:TBeRoStream);
VAR DasLetztesByte:BYTE;
    LetztesByte:BYTE;
    NeuesByte:BYTE;
    HashWert:LONGWORD;
    KeyLaenge:LONGWORD;
    CRCWert:LONGWORD;
    Hash:LONGWORD;
    PrimHash:LONGWORD;
    Zaehler:LONGWORD;
    ByteHash:LONGWORD;
BEGIN
 IF (Data.Size>0) AND (Key.Size>0) THEN BEGIN
  LetztesByte:=Key.Size AND $FF;
  KeyLaenge:=Key.Size;
  CRCWert:=CRC32(Key);
  Hash:=$FFFFFFFF-CRCWert;
  PrimHash:=((Data.Size AND $FFFF) SHL 16) OR (Data.Size SHR 16);
  PrimHash:=PrimHash XOR CRCWert;
  FOR Zaehler:=1 TO Key.Size DO BEGIN
   Hash:=Hash XOR (BYTE(Key[Zaehler-1]) SHL ((Zaehler*8) AND $1F));
   PrimHash:=(PrimHash XOR (PrimZahlen[(((Hash SHR ((Zaehler*8) AND $1F)) AND $FF)) AND $FF]) SHL ((Zaehler*8) AND $1F)) AND $00FFFFFF;
  END;
  ByteHash:=((CRCWert AND $FFFF) SHL 16) OR (CRCWert SHR 16);
  HashWert:=0;
  FOR Zaehler:=1 TO Data.Size DO BEGIN
   HashWert:=HashWert XOR (Hash SHR ((Zaehler*8) AND $1F));
   PrimHash:=(PrimHash*PrimZahlen[((HashWert AND $FF) XOR LetztesByte) AND $FF]) AND $00FFFFFF;
   PrimHash:=PrimHash XOR PrimZahlen[(LetztesByte XOR ((CRCWert SHR ((Zaehler*4) AND $1F)))) AND $FF];
   DasLetztesByte:=BYTE(Data[Zaehler-1]);
   NeuesByte:=BYTE(Data[Zaehler-1]);
   NeuesByte:=NeuesByte XOR (((PrimHash SHR ((Zaehler*8) AND $1F))) AND $FF);
   NeuesByte:=NeuesByte XOR (((CRCWert SHR ((Zaehler*8) AND $1F))) AND $FF);
   NeuesByte:=NeuesByte XOR (((ByteHash SHR ((Zaehler*8) AND $1F))) AND $FF);
   NeuesByte:=NeuesByte XOR BYTE(Key[Zaehler MOD KeyLaenge]);
   NeuesByte:=NeuesByte XOR (((((GenerationWert SHR (LetztesByte AND $1F))) AND $FF)) AND $FF);
   Data[Zaehler-1]:=NeuesByte;
   LetztesByte:=DasLetztesByte;
   ByteHash:=(ByteHash SHL 1) XOR LetztesByte;
  END;
 END;
END;

PROCEDURE Decode(Data,Key:TBeRoStream);
VAR LetztesByte:BYTE;
    NeuesByte:BYTE;
    HashWert:LONGWORD;
    KeyLaenge:LONGWORD;
    CRCWert:LONGWORD;
    Hash:LONGWORD;
    PrimHash:LONGWORD;
    Zaehler:LONGWORD;
    ByteHash:LONGWORD;
BEGIN
 IF (Data.Size>0) AND (Key.Size>0) THEN BEGIN
  LetztesByte:=Key.Size AND $FF;
  KeyLaenge:=Key.Size;
  CRCWert:=CRC32(Key);
  Hash:=$FFFFFFFF-CRCWert;
  PrimHash:=((Data.Size AND $FFFF) SHL 16) OR (Data.Size SHR 16);
  PrimHash:=PrimHash XOR CRCWert;
  FOR Zaehler:=1 TO Key.Size DO BEGIN
   Hash:=Hash XOR (BYTE(Key[Zaehler-1]) SHL ((Zaehler*8) AND $1F));
   PrimHash:=(PrimHash XOR (PrimZahlen[(((Hash SHR ((Zaehler*8) AND $1F)) AND $FF)) AND $FF]) SHL ((Zaehler*8) AND $1F)) AND $00FFFFFF;
  END;
  ByteHash:=((CRCWert AND $FFFF) SHL 16) OR (CRCWert SHR 16);
  HashWert:=0;
  FOR Zaehler:=1 TO Data.Size DO BEGIN
   HashWert:=HashWert XOR (Hash SHR ((Zaehler*8) AND $1F));
   PrimHash:=(PrimHash*PrimZahlen[((HashWert AND $FF) XOR LetztesByte) AND $FF]) AND $00FFFFFF;
   PrimHash:=PrimHash XOR PrimZahlen[(LetztesByte XOR ((CRCWert SHR ((Zaehler*4) AND $1F)))) AND $FF];
   NeuesByte:=BYTE(Data[Zaehler-1]);
   NeuesByte:=NeuesByte XOR (((PrimHash SHR ((Zaehler*8) AND $1F))) AND $FF);
   NeuesByte:=NeuesByte XOR (((CRCWert SHR ((Zaehler*8) AND $1F))) AND $FF);
   NeuesByte:=NeuesByte XOR (((ByteHash SHR ((Zaehler*8) AND $1F))) AND $FF);
   NeuesByte:=NeuesByte XOR BYTE(Key[Zaehler MOD KeyLaenge]);
   NeuesByte:=NeuesByte XOR (((((GenerationWert SHR (LetztesByte AND $1F))) AND $FF)) AND $FF);
   Data[Zaehler-1]:=NeuesByte;
   LetztesByte:=NeuesByte;
   ByteHash:=(ByteHash SHL 1) XOR LetztesByte;
  END;
 END;
END;

FUNCTION Encode(Data:STRING;Key:TBeRoStream):STRING;
VAR DataStream:TBeRoMemoryStream;
BEGIN
 DataStream:=TBeRoMemoryStream.Create;
 DataStream.Text:=Data;
 Encode(DataStream,Key);
 RESULT:=DataStream.Text;
 DataStream.Free;
END;

FUNCTION Decode(Data:STRING;Key:TBeRoStream):STRING;
VAR DataStream:TBeRoMemoryStream;
BEGIN
 DataStream:=TBeRoMemoryStream.Create;
 DataStream.Text:=Data;
 Decode(DataStream,Key);
 RESULT:=DataStream.Text;
 DataStream.Free;
END;

FUNCTION Encode(Data,Key:STRING):STRING; OVERLOAD;
VAR DataStream,KeyStream:TBeRoMemoryStream;
BEGIN
 DataStream:=TBeRoMemoryStream.Create;
 KeyStream:=TBeRoMemoryStream.Create;
 DataStream.Text:=Data;
 KeyStream.Text:=Key;
 Encode(DataStream,KeyStream);
 RESULT:=DataStream.Text;
 DataStream.Free;
 KeyStream.Free;
END;

FUNCTION Decode(Data,Key:STRING):STRING; OVERLOAD;
VAR DataStream,KeyStream:TBeRoMemoryStream;
BEGIN
 DataStream:=TBeRoMemoryStream.Create;
 KeyStream:=TBeRoMemoryStream.Create;
 DataStream.Text:=Data;
 KeyStream.Text:=Key;
 Decode(DataStream,KeyStream);
 RESULT:=DataStream.Text;
 DataStream.Free;
 KeyStream.Free;
END;

PROCEDURE Encode(VAR Data;DataLength:LONGWORD;Key:TBeRoStream);
VAR DataStream:TBeRoMemoryStream;
BEGIN
 DataStream:=TBeRoMemoryStream.Create;
 DataStream.Clear;
 DataStream.Write(Data,DataLength);
 Encode(DataStream,Key);
 DataStream.Seek(0);
 DataStream.Read(Data,DataLength);
 DataStream.Free;
END;

PROCEDURE Decode(VAR Data;DataLength:LONGWORD;Key:TBeRoStream);
VAR DataStream:TBeRoMemoryStream;
BEGIN
 DataStream:=TBeRoMemoryStream.Create;
 DataStream.Clear;
 DataStream.Write(Data,DataLength);
 Decode(DataStream,Key);
 DataStream.Seek(0);
 DataStream.Read(Data,DataLength);
 DataStream.Free;
END;

PROCEDURE Encode(VAR Data;DataLength:LONGWORD;Key:STRING);
VAR DataStream,KeyStream:TBeRoMemoryStream;
BEGIN
 DataStream:=TBeRoMemoryStream.Create;
 KeyStream:=TBeRoMemoryStream.Create;
 DataStream.Clear;
 DataStream.Write(Data,DataLength);
 KeyStream.Text:=Key;
 Encode(DataStream,KeyStream);
 DataStream.Seek(0);
 DataStream.Read(Data,DataLength);
 DataStream.Free;
 KeyStream.Free;
END;

PROCEDURE Decode(VAR Data;DataLength:LONGWORD;Key:STRING);
VAR DataStream,KeyStream:TBeRoMemoryStream;
BEGIN
 DataStream:=TBeRoMemoryStream.Create;
 KeyStream:=TBeRoMemoryStream.Create;
 DataStream.Clear;
 DataStream.Write(Data,DataLength);
 KeyStream.Text:=Key;
 Decode(DataStream,KeyStream);
 DataStream.Seek(0);
 DataStream.Read(Data,DataLength);
 DataStream.Free;
 KeyStream.Free;
END;

CONSTRUCTOR TBeRoArchive.Create;
BEGIN
 INHERITED Create;
 fKey:=TBeRoMemoryStream.Create;
 fSubKey:=TBeRoMemoryStream.Create;
 fOpen:=FALSE;
 fInitSearch:=FALSE;
 FastCompression:=TRUE;
 SetKey('');
 SetSubKey('');
END;

DESTRUCTOR TBeRoArchive.Destroy;
BEGIN
 IF fOpen THEN BEGIN
  fStream:=NIL;
  fOpen:=FALSE;
 END;
 fSubKey.Free;
 fKey.Free;
 INHERITED Destroy;
END;

PROCEDURE TBeRoArchive.EncodeBuffer(VAR B:TBeRoArchiveBuf);
BEGIN
END;

PROCEDURE TBeRoArchive.DecodeBuffer(VAR B:TBeRoArchiveBuf);
BEGIN
END;

PROCEDURE TBeRoArchive.SetKey(AStream:TBeRoStream);
BEGIN
 fKey.Clear;
 fKey.Assign(AStream);
END;

PROCEDURE TBeRoArchive.SetKey(AKey:STRING);
BEGIN
 fKey.Clear;
 fKey.Text:=AKey;
END;

PROCEDURE TBeRoArchive.SetSubKey(AStream:TBeRoStream);
BEGIN
 fSubKey.Clear;
 fSubKey.Assign(AStream);
END;

PROCEDURE TBeRoArchive.SetSubKey(AKey:STRING);
BEGIN
 fSubKey.Clear;
 fSubKey.Text:=AKey;
END;

FUNCTION TBeRoArchive.IsArchive(AStream:TBeRoStream):BOOLEAN;
VAR Header:TBeRoArchiveHeader;
BEGIN
 RESULT:=FALSE;
 AStream.Seek(0);
 AStream.Read(Header,SIZEOF(TBeRoArchiveHeader));
 IF Header.Sign=MySign THEN RESULT:=TRUE;
END;

FUNCTION TBeRoArchive.IsCrypted(AStream:TBeRoStream):BOOLEAN;
VAR Header:TBeRoArchiveHeader;
BEGIN
 RESULT:=FALSE;
 AStream.Seek(0);
 AStream.Read(Header,SIZEOF(TBeRoArchiveHeader));
 IF (Header.Sign=MySign) AND (Header.KeyHash<>CRC32('')) THEN RESULT:=TRUE;
END;

FUNCTION TBeRoArchive.CreateArchive(AStream:TBeRoStream):BOOLEAN;
BEGIN
 IF fOpen THEN BEGIN
  fStream:=NIL;
  fOpen:=FALSE;
 END;
 fInitSearch:=FALSE;
 fStream:=AStream;
 fStream.Clear;
 fHeader.Sign:=MySign;
 fHeader.KeyHash:=CRC32(fKey);
 fStream.Seek(0);
 fStream.Write(fHeader,SIZEOF(TBeRoArchiveHeader));
 IF fHeader.Sign<>MySign THEN BEGIN
  fStream:=NIL;
  fOpen:=FALSE;
 END ELSE BEGIN
  fOpen:=TRUE;
 END;
 RESULT:=fOpen;
END;

FUNCTION TBeRoArchive.OpenArchive(AStream:TBeRoStream):BOOLEAN;
BEGIN
 IF fOpen THEN BEGIN
  fStream:=NIL;
  fOpen:=FALSE;
 END;
 fInitSearch:=FALSE;
 fStream:=AStream;
 fStream.Seek(0);
 fStream.Read(fHeader,SIZEOF(TBeRoArchiveHeader));
 IF fHeader.Sign<>MySign THEN BEGIN
  fStream:=NIL;
  fOpen:=FALSE;
 END ELSE IF fHeader.KeyHash<>CRC32(fKey) THEN BEGIN
  fStream:=NIL;
  fOpen:=FALSE;
 END ELSE BEGIN
  fOpen:=TRUE;
 END;
 RESULT:=fOpen;
END;

PROCEDURE TBeRoArchive.CloseArchive;
BEGIN
 IF fOpen THEN BEGIN
  fStream:=NIL;
  fOpen:=FALSE;
 END;
END;

FUNCTION TBeRoArchive.Add(FileNameInArchive:STRING;AStream:TBeRoStream):BOOLEAN;
VAR fAStream:TBeRoMemoryStream;
    Gelesen:LONGWORD;
    fFile:TBeRoArchiveFile;
    fBuf:TBeRoArchiveBuf;
BEGIN
 RESULT:=FALSE;
 IF fOpen THEN BEGIN
  fAStream:=TBeRoMemoryStream.Create;
  Compression(AStream,fAStream,FastCompression);
  Encode(fAStream,fSubKey);
  Encode(fAStream,fKey);

  fStream.Seek(fStream.Size);

  fFile.FileNameLength:=length(FileNameInArchive);
  fFile.FileType:=ftFile;
  fFile.Size:=fAStream.Size;
  fFile.KeyHash:=CRC32(fSubKey);

  Encode(fFile,SIZEOF(TBeRoArchiveFile),fKey);
  fStream.Write(fFile,SIZEOF(TBeRoArchiveFile));
  Decode(fFile,SIZEOF(TBeRoArchiveFile),fKey);
  fStream.WriteString(Encode(FileNameInArchive,fKey));

  fAStream.Seek(0);
  Gelesen:=fFile.Size;
  WHILE Gelesen>0 DO BEGIN
   Gelesen:=fAStream.Read(fBuf,SIZEOF(TBeRoArchiveBuf));
   EncodeBuffer(fBuf);
   fStream.Write(fBuf,Gelesen);
  END;
  fAStream.Free;
  RESULT:=TRUE;
 END;
END;

FUNCTION TBeRoArchive.AddString(FileNameInArchive:STRING;AString:STRING):BOOLEAN;
VAR StringStream:TBeRoMemoryStream;
BEGIN
 StringStream:=TBeRoMemoryStream.Create;
 StringStream.Text:=AString;
 RESULT:=Add(FileNameInArchive,StringStream);
 StringStream.Free;
END;

PROCEDURE TBeRoArchive.InitSearch;
BEGIN
 IF fOpen THEN BEGIN
  fStream.Seek(0);
  fStream.Read(fHeader,SIZEOF(TBeRoArchiveHeader));
  IF fHeader.Sign<>MySign THEN BEGIN
   fStream:=NIL;
   fOpen:=FALSE;
  END ELSE BEGIN
   fOpen:=TRUE;
  END;
  fInitSearch:=fOpen;
 END;
END;

FUNCTION TBeRoArchive.FindNextEx:TBeRoArchiveFileParam;
VAR fFile:TBeRoArchiveFile;
    fFileParam:TBeRoArchiveFileParam;
BEGIN
 IF fOpen AND fInitSearch AND NOT EndOfArchive THEN BEGIN
  fStream.Read(fFile,SIZEOF(TBeRoArchiveFile));
  Decode(fFile,SIZEOF(TBeRoArchiveFile),fKey);
  fFileParam.FileName:=Decode(fStream.ReadString,fKey);
  fFileParam.Data:=fFile;
  RESULT:=fFileParam;
 END;
END;

FUNCTION TBeRoArchive.FindNext:TBeRoArchiveFileParam;
VAR Next:LONGWORD;
    fFileParam:TBeRoArchiveFileParam;
BEGIN
 IF fOpen AND fInitSearch AND NOT EndOfArchive THEN BEGIN
  fFileParam:=FindNextEx;
  Next:=LONGWORD(fStream.Position)+fFileParam.Data.Size;
  fStream.Seek(Next);
  RESULT:=fFileParam;
 END;
END;

FUNCTION TBeRoArchive.EndOfArchive:BOOLEAN;
BEGIN
 IF fOpen THEN BEGIN
  RESULT:=fStream.Position>=fStream.Size;
 END ELSE BEGIN
  RESULT:=TRUE;
 END;
END;

FUNCTION TBeRoArchive.IsFileCrypted(FileNameInArchive:STRING):BOOLEAN;
VAR Next:LONGWORD;
    fFile:TBeRoArchiveFile;
    fFileParam:TBeRoArchiveFileParam;
BEGIN
 RESULT:=FALSE;
 IF fOpen THEN BEGIN
  InitSearch;
  WHILE fStream.Position<fStream.Size DO BEGIN
   fFileParam:=FindNextEx;
   fFile:=fFileParam.Data;

   Next:=LONGWORD(fStream.Position)+fFile.Size;
   IF (fFileParam.FileName=FileNameInArchive) AND (fFile.FileType=ftFile) THEN BEGIN
    IF fFile.KeyHash<>CRC32('') THEN BEGIN
     RESULT:=TRUE;
    END;
    BREAK;
   END ELSE BEGIN
    fStream.Seek(Next);
   END;
  END;
 END;
END;

FUNCTION TBeRoArchive.Extract(FileNameInArchive:STRING;AStream:TBeRoStream):BOOLEAN;
VAR fAStream:TBeRoMemoryStream;
    Nc,Nr,Next,Gelesen:LONGWORD;
    fFile:TBeRoArchiveFile;
    fFileParam:TBeRoArchiveFileParam;
    fBuf:TBeRoArchiveBuf;
BEGIN
 RESULT:=FALSE;
 IF fOpen THEN BEGIN
  InitSearch;
  WHILE fStream.Position<fStream.Size DO BEGIN
   fFileParam:=FindNextEx;
   fFile:=fFileParam.Data;

   Next:=LONGWORD(fStream.Position)+fFile.Size;
   IF (fFileParam.FileName=FileNameInArchive) AND (fFile.FileType=ftFile) THEN BEGIN
    IF fFile.KeyHash=CRC32(fSubKey) THEN BEGIN
     fAStream:=TBeRoMemoryStream.Create;
     fAStream.Clear;
     Nc:=fFile.Size DIV SIZEOF(fBuf);
     Nr:=fFile.Size-(Nc*SIZEOF(fBuf));
     WHILE Nc>0 DO BEGIN
      Gelesen:=fStream.Read(fBuf,SIZEOF(fBuf));
      DecodeBuffer(fBuf);
      fAStream.Write(fBuf,Gelesen);
      DEC(Nc);
     END;
     Gelesen:=fStream.Read(fBuf,Nr);
     DecodeBuffer(fBuf);
     fAStream.Write(fBuf,Gelesen);
     Decode(fAStream,fKey);
     Decode(fAStream,fSubKey);
     Decompression(fAStream,AStream);
     fAStream.Free;
     RESULT:=TRUE;
    END;
    BREAK;
   END ELSE BEGIN
    fStream.Seek(Next);
   END;
  END;
 END;
END;

FUNCTION TBeRoArchive.GetString(FileNameInArchive:STRING):STRING;
VAR StringStream:TBeRoMemoryStream;
BEGIN
 StringStream:=TBeRoMemoryStream.Create;
 Extract(FileNameInArchive,StringStream);
 RESULT:=StringStream.Text;
 StringStream.Free;
END;

PROCEDURE TBeRoArchive.Delete(FileNameInArchive:STRING);
VAR Nc,Nr,Next,Gelesen:LONGWORD;
    F:TBeRoMemoryStream;
    fFile:TBeRoArchiveFile;
    fFileParam:TBeRoArchiveFileParam;
    fBuf:TBeRoArchiveBuf;
BEGIN
 IF fOpen THEN BEGIN
  F:=TBeRoMemoryStream.Create;

  fStream.Seek(0);
  F.Seek(0);

  fStream.Read(fHeader,SIZEOF(TBeRoArchiveHeader));
  F.Write(fHeader,SIZEOF(TBeRoArchiveHeader));

  InitSearch;
  WHILE fStream.Position<fStream.Size DO BEGIN
   fFileParam:=FindNextEx;
   fFile:=fFileParam.Data;

   Next:=LONGWORD(fStream.Position)+fFile.Size;
   IF (fFileParam.FileName=FileNameInArchive) AND (fFile.FileType=ftFile) THEN BEGIN
    fStream.Seek(Next);
   END ELSE BEGIN
    Encode(fFile,SIZEOF(TBeRoArchiveFile),fKey);
    F.Write(fFile,SIZEOF(TBeRoArchiveFile));
    Decode(fFile,SIZEOF(TBeRoArchiveFile),fKey);
    F.WriteString(Encode(fFileParam.FileName,fKey));

    Nc:=fFile.Size DIV SIZEOF(fBuf);
    Nr:=fFile.Size-(Nc*SIZEOF(fBuf));
    WHILE Nc>0 DO BEGIN
     Gelesen:=fStream.Read(fBuf,SIZEOF(fBuf));
     F.Write(fBuf,Gelesen);
     DEC(Nc);
    END;
    Gelesen:=fStream.Read(fBuf,Nr);
    F.Write(fBuf,Gelesen);
   END;
  END;

  fStream.Clear;
  fStream.Assign(F);

  F.Free;
 END;
END;

PROCEDURE RTL_OUTPUTBLOCK(Klasse:POINTER;BlockNummer:INTEGER); PASCAL;
VAR S:STRING;
BEGIN
 IF ASSIGNED(Klasse) THEN BEGIN
  IF (BlockNummer>=0) AND (BlockNummer<LENGTH(TBeRoScript(Klasse).Blocks)) THEN BEGIN
   TBeRoScript(Klasse).OutputBlock(BlockNummer);
  END;
 END;
END;

PROCEDURE RTL_PRINTF_FIXEDSTRING(Klasse,Zeiger:POINTER;Laenge:LONGWORD); PASCAL;
VAR S:STRING;
BEGIN
 IF ASSIGNED(Klasse) THEN BEGIN
  IF ASSIGNED(Zeiger) THEN BEGIN
   SETLENGTH(S,Laenge);
   MOVE(Zeiger^,S[1],Laenge);
   TBeRoScript(Klasse).FPrint(nil, S);
//   TBeRoScript(Klasse).Output:=TBeRoScript(Klasse).Output+S;
   IF TBeRoScript(Klasse).OutDirect THEN WRITE(S);
  END;
 END;
END;

PROCEDURE RTL_PRINTF_STRING(Klasse,Zeiger:POINTER); PASCAL;
VAR S:STRING;
    Laenge:LONGWORD;
BEGIN
 IF ASSIGNED(Klasse) THEN BEGIN
  IF ASSIGNED(Zeiger) THEN BEGIN
   Laenge:=PBeroScriptString(LONGWORD(LONGWORD(Zeiger)-strStartOffset))^.Length;
   SETLENGTH(S,Laenge);
   MOVE(Zeiger^,S[1],Laenge);
//   TBeRoScript(Klasse).Output:=TBeRoScript(Klasse).Output+S;
   TBeRoScript(Klasse).FPrint(nil, S);
   IF TBeRoScript(Klasse).OutDirect THEN WRITE(S);
  END;
 END;
END;

PROCEDURE RTL_PRINTF_NUMBER_SIGNED(Klasse:POINTER;Number:LONGINT); PASCAL;
VAR S:STRING;
BEGIN
 IF ASSIGNED(Klasse) THEN BEGIN
  STR(Number,S);
//  TBeRoScript(Klasse).Output:=TBeRoScript(Klasse).Output+S;
  TBeRoScript(Klasse).FPrint(nil, S);
  IF TBeRoScript(Klasse).OutDirect THEN WRITE(S);
 END;
END;

PROCEDURE RTL_PRINTF_NUMBER_UNSIGNED(Klasse:POINTER;Number:LONGWORD); PASCAL;
VAR S:STRING;
BEGIN
 IF ASSIGNED(Klasse) THEN BEGIN
  STR(Number,S);
//  TBeRoScript(Klasse).Output:=TBeRoScript(Klasse).Output+S;
  TBeRoScript(Klasse).FPrint(nil, S);
  IF TBeRoScript(Klasse).OutDirect THEN WRITE(S);
 END;
END;

PROCEDURE RTL_PRINTF_PCHAR(Klasse:POINTER;Zeiger:PCHAR); PASCAL;
VAR S:STRING;
BEGIN
 IF ASSIGNED(Klasse) THEN BEGIN
  IF ASSIGNED(Zeiger) THEN BEGIN
   S:=Zeiger;
//   TBeRoScript(Klasse).Output:=TBeRoScript(Klasse).Output+S;
   TBeRoScript(Klasse).FPrint(nil, S);
   IF TBeRoScript(Klasse).OutDirect THEN WRITE(S);
  END;
 END;
END;

PROCEDURE RTL_PRINTF_CHAR(Klasse:POINTER;Zeichen:LONGWORD); PASCAL;
BEGIN
 IF ASSIGNED(Klasse) THEN BEGIN
//  TBeRoScript(Klasse).Output:=TBeRoScript(Klasse).Output+CHR(Zeichen);
  TBeRoScript(Klasse).FPrint(nil, CHR(Zeichen));
  IF TBeRoScript(Klasse).OutDirect THEN WRITE(CHR(Zeichen));
 END;
END;

PROCEDURE RTL_PRINTF_FLOAT(Klasse:POINTER;Number:SINGLE); PASCAL;
VAR S:STRING;
BEGIN
 IF ASSIGNED(Klasse) THEN BEGIN
  STR(Number,S);
//  TBeRoScript(Klasse).Output:=TBeRoScript(Klasse).Output+S;
  TBeRoScript(Klasse).FPrint(nil, S);
  IF TBeRoScript(Klasse).OutDirect THEN WRITE(S);
 END;
END;

PROCEDURE ThreadSafeDecrease(S:POINTER); PASCAL; ASSEMBLER;
ASM
 MOV EDX,DWORD PTR S
 TEST EDX,EDX
 JE @Exit
 LOCK DEC DWORD PTR [EDX]
 @Exit:
END;

PROCEDURE ThreadSafeIncrease(S:POINTER); PASCAL; ASSEMBLER;
ASM
 MOV EDX,DWORD PTR S
 TEST EDX,EDX
 JE @Exit
 LOCK INC DWORD PTR [EDX]
 @Exit:
END;

FUNCTION RTL_STRING_NEW(MyLength:LONGWORD):POINTER; PASCAL;
VAR S:PBeRoScriptString;
BEGIN
 RESULT:=NIL;
 GETMEM(S,strRecordLength+MyLength);
 FILLCHAR(S^,strRecordLength+MyLength,#0);
{$IFDEF FPC}
 S^.MaxLength:=MyLength;
 S^.Length:=0;
{$ELSE}
 S^.Length:=MyLength;
{$ENDIF}
 S^.Reference:=1;
 S^.FirstChar:=#0;
 RESULT:=POINTER(LONGWORD(LONGWORD(S)+strStartOffset));
END;

PROCEDURE RTL_STRING_DISPOSE(VAR S:POINTER); PASCAL;
BEGIN
 IF ASSIGNED(S) THEN BEGIN
  S:=POINTER(LONGWORD(LONGWORD(S)-strStartOffset));
  FREEMEM(S);
  S:=NIL;
 END;
END;

FUNCTION RTL_STRING_DECREASE(S:POINTER):POINTER; PASCAL;
VAR MySrc:PBeRoScriptString;
    L:PLONGINT;
BEGIN
 RESULT:=S;
 IF ASSIGNED(S) THEN BEGIN
  MySrc:=POINTER(LONGWORD(LONGWORD(S)-strStartOffset));
  L:=@MySrc^.Reference;
  IF L^>=0 THEN BEGIN
   ThreadSafeDecrease(L);
   IF L^=0 THEN FREEMEM(MySrc);
   RESULT:=NIL;
  END;
 END;
END;

FUNCTION RTL_STRING_INCREASE(S:POINTER):POINTER; PASCAL;
VAR MySrc:PBeRoScriptString;
    L:PLONGINT;
BEGIN
 RESULT:=S;
 IF ASSIGNED(S) THEN BEGIN
  MySrc:=POINTER(LONGWORD(LONGWORD(S)-strStartOffset));
  L:=@MySrc^.Reference;
  IF L^>=0 THEN BEGIN
   ThreadSafeIncrease(L);
  END;
 END;
END;

FUNCTION RTL_STRING_ASSIGN(Src,Dst:POINTER):POINTER; PASCAL;
VAR S:PBeRoScriptString;
BEGIN
 IF ASSIGNED(Src) THEN BEGIN
  S:=POINTER(LONGWORD(LONGWORD(Src)-strStartOffset));
  ThreadSafeIncrease(@S^.Reference);
 END;
 RTL_STRING_DECREASE(Dst);
 RESULT:=Src;
END;

FUNCTION RTL_STRING_LENGTH(S:POINTER):LONGWORD; PASCAL;
BEGIN
 RESULT:=0;
 IF ASSIGNED(S) THEN BEGIN
  RESULT:=PBeRoScriptString(LONGWORD(LONGWORD(S)-strStartOffset))^.Length;
 END;
END;

PROCEDURE RTL_STRING_SETLENGTH(VAR S:POINTER;NewLength:LONGWORD); PASCAL;
VAR MyStr,TempStr:PBeRoScriptString;
    TempPointer:POINTER;
    CopyLength:LONGWORD;
BEGIN
 IF NewLength>0 THEN BEGIN
  IF ASSIGNED(S) THEN BEGIN
   MyStr:=POINTER(LONGWORD(LONGWORD(S)-strStartOffset));
{$IFDEF FPC}
   IF (MyStr^.MaxLength<NewLength) OR (MyStr^.Reference<>1) THEN BEGIN
{$ELSE}
   IF (MyStr^.Length<>NewLength) OR (MyStr^.Reference<>1) THEN BEGIN
{$ENDIF}
    TempPointer:=RTL_STRING_NEW(NewLength);
    TempStr:=POINTER(LONGWORD(LONGWORD(TempPointer)-strStartOffset));
    IF MyStr^.Length>0 THEN BEGIN
     IF NewLength<=MyStr^.Length THEN BEGIN
      CopyLength:=NewLength;
     END ELSE BEGIN
      CopyLength:=MyStr^.Length+1;
     END;
     MOVE(S^,TempPointer^,CopyLength);
    END;
    RTL_STRING_DECREASE(S);
    S:=TempPointer;
   END;
  END ELSE BEGIN
   S:=RTL_STRING_NEW(NewLength);
  END;
  PBYTE(LONGWORD(LONGWORD(S)+NewLength))^:=0;
  PBeroScriptString(LONGWORD(LONGWORD(S)-strStartOffset))^.Length:=NewLength;
 END ELSE BEGIN
  IF ASSIGNED(S) THEN BEGIN
   RTL_STRING_DECREASE(S);
  END;
  S:=NIL;
 END;
END;

FUNCTION RTL_STRING_UNIQUE(S:POINTER):POINTER; PASCAL;
VAR N:POINTER;
    L:LONGWORD;
BEGIN
 RESULT:=S;
 IF ASSIGNED(S) THEN BEGIN
  IF PBeRoScriptString(LONGWORD(LONGWORD(S)-strStartOffset))^.Reference<>1 THEN BEGIN
   L:=RTL_STRING_LENGTH(S);
   N:=RTL_STRING_NEW(L);
   MOVE(S^,N^,L+1);
   RTL_STRING_DECREASE(S);
   RESULT:=N;
  END;
 END;
END;

FUNCTION RTL_STRING_CHARCONVERT(Value:LONGWORD):POINTER; PASCAL;
BEGIN
 RESULT:=NIL;
 RTL_STRING_SETLENGTH(RESULT,1);
 BYTE(RESULT^):=Value;
END;

FUNCTION RTL_STRING_GET(Src,Dst:POINTER):POINTER; PASCAL;
VAR L:LONGWORD;
BEGIN
 L:=RTL_STRING_LENGTH(Src);
 RTL_STRING_DECREASE(Dst);
 RESULT:=RTL_STRING_NEW(L);
 RTL_STRING_SETLENGTH(RESULT,L);
 MOVE(Src^,RESULT^,L);
END;

FUNCTION RTL_STRING_CONCAT(Src1,Src2,Dst:POINTER):POINTER; PASCAL;
VAR Size1,Size2:LONGWORD;
BEGIN
 RESULT:=Dst;
 IF NOT ASSIGNED(Src1) THEN BEGIN
  RESULT:=RTL_STRING_ASSIGN(Src2,RESULT);
 END ELSE IF NOT ASSIGNED(Src2) THEN BEGIN
  RESULT:=RTL_STRING_ASSIGN(Src1,RESULT);
 END ELSE BEGIN
  IF ASSIGNED(RESULT) THEN BEGIN
   RESULT:=RTL_STRING_DECREASE(RESULT);
  END;
  Size1:=RTL_STRING_LENGTH(Src1);
  Size2:=RTL_STRING_LENGTH(Src2);
  RTL_STRING_SETLENGTH(RESULT,Size1+Size2);
  IF Size2>0 THEN BEGIN
   IF Size1>0 THEN BEGIN
    MOVE(Src1^,RESULT^,Size1);
    MOVE(Src2^,POINTER(LONGWORD(LONGWORD(RESULT)+Size1))^,Size2+1);
   END ELSE BEGIN
    MOVE(Src2^,RESULT^,Size2);
   END;
  END ELSE IF Size1>0 THEN BEGIN
   MOVE(Src1^,RESULT^,Size1);
  END;
 END;
END;

FUNCTION RTL_STRING_SELF_CONCAT(SrcDst,Src:POINTER):POINTER; PASCAL;
VAR Size1,Size2:LONGWORD;
BEGIN
 RESULT:=SrcDst;
 IF NOT ASSIGNED(SrcDst) THEN BEGIN
  RESULT:=RTL_STRING_ASSIGN(Src,RESULT);
 END ELSE IF NOT ASSIGNED(Src) THEN BEGIN
  RESULT:=RTL_STRING_ASSIGN(SrcDst,RESULT);
 END ELSE BEGIN
  Size1:=RTL_STRING_LENGTH(SrcDst);
  Size2:=RTL_STRING_LENGTH(Src);
  RTL_STRING_SETLENGTH(RESULT,Size1+Size2);
  IF Size2>0 THEN BEGIN
   MOVE(Src^,POINTER(LONGWORD(LONGWORD(RESULT)+Size1))^,Size2+1);
  END;
 END;
END;

FUNCTION RTL_STRING_COMPARE(Src1,Src2:POINTER):INTEGER; PASCAL;
VAR Size1,Size2:LONGINT;
    Size,Position:LONGINT;
    B1,B2:PBYTE;
BEGIN
 RESULT:=0;
 Size1:=RTL_STRING_LENGTH(Src1);
 Size2:=RTL_STRING_LENGTH(Src2);
 IF Size1<Size2 THEN BEGIN
  Size:=Size1;
 END ELSE BEGIN
  Size:=Size2;
 END;
 Position:=0;
 B1:=Src1;
 B2:=Src2;
 WHILE (Position<Size) AND (RESULT=0) DO BEGIN
  RESULT:=B1^-B2^;
  INC(B1);
  INC(B2);
  INC(Position);
 END;
 IF RESULT=0 THEN BEGIN
  RESULT:=Size1-Size2;
 END;
END;

FUNCTION RTL_ROUND(Value:SINGLE):INTEGER; PASCAL;
BEGIN
 RESULT:=ROUND(Value);
END;

FUNCTION RTL_TRUNC(Value:SINGLE):INTEGER; PASCAL;
BEGIN
 RESULT:=TRUNC(Value);
END;

FUNCTION RTL_SIN(Value:SINGLE):SINGLE; PASCAL;
BEGIN
 RESULT:=SIN(Value);
END;

FUNCTION RTL_COS(Value:SINGLE):SINGLE; PASCAL;
BEGIN
 RESULT:=COS(Value);
END;

FUNCTION RTL_ABS(Value:SINGLE):SINGLE; PASCAL;
BEGIN
 RESULT:=ABS(Value);
END;

FUNCTION RTL_FRAC(Value:SINGLE):SINGLE; PASCAL;
BEGIN
 RESULT:=FRAC(Value);
END;

FUNCTION RTL_EXP(Value:SINGLE):SINGLE; PASCAL;
BEGIN
 RESULT:=EXP(Value);
END;

FUNCTION RTL_LN(Value:SINGLE):SINGLE; PASCAL;
BEGIN
 RESULT:=LN(Value);
END;

FUNCTION RTL_SQR(Value:SINGLE):SINGLE; PASCAL;
BEGIN
 RESULT:=SQR(Value);
END;

FUNCTION RTL_SQRT(Value:SINGLE):SINGLE; PASCAL;
BEGIN
 RESULT:=SQRT(Value);
END;

FUNCTION RTL_RANDOM:SINGLE; PASCAL;
BEGIN
 RESULT:=RandomFloatValue;
END;

FUNCTION RTL_PI:SINGLE; PASCAL;
BEGIN
 RESULT:=PI;
END;

FUNCTION RTL_READFLOAT:SINGLE; PASCAL;
var
s:string;
C:INTEGER;
BEGIN
  s:=InputBox('Input a float number', 'number', '');
  VAL(S,RESULT,C);
END;

FUNCTION RTL_READINT:LONGINT; PASCAL;
BEGIN
// READ(RESULT);
RESULT:=StrToInt(InputBox('Input a integer', 'number', ''));
END;

FUNCTION RTL_READUINT:LONGWORD; PASCAL;
var
s:string;
C:INTEGER;
BEGIN
// READ(RESULT);
  s:=InputBox('Input a unsigned integer', 'number', '');
  VAL(S,RESULT,C);
END;

FUNCTION RTL_READSTRING:POINTER; PASCAL;
VAR S:STRING;
    L:LONGWORD;
BEGIN
// READ(S);
 s:=InputBox('input','','');
 L:=LENGTH(S);
 RESULT:=NIL;
 RTL_STRING_SETLENGTH(RESULT,L);
 IF L>0 THEN MOVE(S[1],RESULT^,L);
END;

FUNCTION RTL_READCHAR:CHAR; PASCAL;
var s:string;
BEGIN
// READ(RESULT);
  s:=InputBox('Input a char', '', '');
  if s<>'' then
    RESULT:=s[1]
  else
    RESULT:=' ';
END;

function RTL_READLN:string; PASCAL;
BEGIN
// READLN;
END;

PROCEDURE RTL_FLUSHIN; PASCAL;
BEGIN
 FLUSH(INPUT);
END;

PROCEDURE RTL_FLUSH; PASCAL;
BEGIN
 FLUSH(OUTPUT);
END;

PROCEDURE RTL_FLUSHOUT; PASCAL;
BEGIN
 FLUSH(OUTPUT);
END;

FUNCTION RTL_TRIM(Src:POINTER):POINTER; PASCAL;
VAR StartPos,Laenge:INTEGER;
    S:PBYTE;
BEGIN
 RESULT:=NIL;
 Laenge:=RTL_STRING_LENGTH(Src);
 IF Laenge>0 THEN BEGIN
  S:=PBYTE(LONGWORD(LONGWORD(Src)+LONGWORD(Laenge)-1));
  WHILE (Laenge>0) AND (S^ IN [0..32]) DO BEGIN
   DEC(Laenge);
   DEC(S);
  END;
  StartPos:=0;
  S:=Src;
  WHILE (StartPos<Laenge) AND (S^ IN [0..32]) DO BEGIN
   INC(StartPos);
   INC(S);
  END;
  Laenge:=Laenge-StartPos;
  RTL_STRING_SETLENGTH(RESULT,Laenge);
  S:=PBYTE(LONGWORD(LONGWORD(Src)+LONGWORD(StartPos)));
  MOVE(S^,RESULT^,Laenge);
 END;
END;

FUNCTION RTL_COPY(Src:POINTER;Index,Count:LONGINT):POINTER; PASCAL;
VAR Start,Laenge,CopyCount:INTEGER;
BEGIN
 RESULT:=NIL;
 Laenge:=RTL_STRING_LENGTH(Src);
 IF Laenge>0 THEN BEGIN
  Start:=Index;
  IF Start<0 THEN Start:=0;
  CopyCount:=Count;
  IF (CopyCount>Laenge) OR ((Start+CopyCount)>Laenge) THEN BEGIN
   CopyCount:=Laenge-Start;
  END;
  IF CopyCount>0 THEN BEGIN
   RTL_STRING_SETLENGTH(RESULT,CopyCount);
   MOVE(PBYTE(LONGWORD(LONGWORD(Src)+LONGWORD(Start)))^,RESULT^,CopyCount);
  END;
 END;
END;

FUNCTION RTL_LENGTH(Src:POINTER):INTEGER; PASCAL;
BEGIN
 RESULT:=0;
 IF ASSIGNED(Src) THEN BEGIN
  RESULT:=PBeRoScriptString(LONGWORD(LONGWORD(Src)-strStartOffset))^.Length;
 END;
END;

FUNCTION RTL_CHARAT(Src:POINTER;Index:LONGWORD):BYTE; PASCAL;
BEGIN
 RESULT:=0;
 IF Index<RTL_STRING_LENGTH(Src) THEN BEGIN
  RESULT:=PBYTE(LONGWORD(LONGWORD(Src)+Index))^;
 END;
END;

FUNCTION RTL_CHARPOINTERAT(Src:POINTER;Index:LONGWORD):POINTER; PASCAL;
BEGIN
 RESULT:=NIL;
 IF Index<RTL_STRING_LENGTH(Src) THEN BEGIN
  RESULT:=PBYTE(LONGWORD(LONGWORD(Src)+Index));
 END;
END;

FUNCTION ConvertFromBeRoString(Src:BeRoString):STRING;
VAR Laenge:LONGWORD;
BEGIN
 Laenge:=RTL_STRING_LENGTH(Src);
 SETLENGTH(RESULT,Laenge);
 MOVE(Src^,RESULT[1],Laenge);
END;

FUNCTION ConvertToBeRoString(Src:STRING):BeRoString;
VAR Laenge:LONGWORD;
BEGIN
 RESULT:=NIL;
 Laenge:=LENGTH(Src);
 RTL_STRING_SETLENGTH(RESULT,Laenge);
 MOVE(Src[1],RESULT^,Laenge);
 Src:='';
END;

FUNCTION RTL_DELETE(Src:POINTER;Index,Count:LONGINT):POINTER; PASCAL;
VAR Laenge,CopyCount:INTEGER;
BEGIN
 RESULT:=NIL;
 Laenge:=RTL_STRING_LENGTH(Src);
 IF Laenge>0 THEN BEGIN
  IF (Index>=Laenge) OR (Index<0) OR (Count<=0) THEN BEGIN
   RESULT:=RTL_STRING_ASSIGN(Src,RESULT);
  END ELSE BEGIN
   RESULT:=RTL_STRING_UNIQUE(Src);
   CopyCount:=Count;
   IF (Index+CopyCount)>Laenge THEN CopyCount:=Laenge-Index+2;
   IF CopyCount<=(Laenge-Index) THEN BEGIN
    MOVE(PBYTE(LONGWORD(LONGWORD(RESULT)+LONGWORD(Index+CopyCount)))^,PBYTE(LONGWORD(LONGWORD(RESULT)+LONGWORD(Index)))^,Laenge-Index-CopyCount+1);
    RTL_STRING_SETLENGTH(RESULT,Laenge-CopyCount);
   END;
  END;
 END;
END;

FUNCTION RTL_INSERT(Src,Dst:POINTER;Index:LONGINT):POINTER; PASCAL;
VAR SourceLaenge,Laenge,CopyCount:INTEGER;
BEGIN
 RESULT:=NIL;
 SourceLaenge:=RTL_STRING_LENGTH(Src);
 Laenge:=RTL_STRING_LENGTH(Dst);
 IF SourceLaenge>0 THEN BEGIN
  IF Laenge>0 THEN BEGIN
   IF Index<0 THEN Index:=0;
   IF Index>=Laenge THEN Index:=Laenge;
   RESULT:=NIL;
   RTL_STRING_SETLENGTH(RESULT,SourceLaenge+Laenge);
   FILLCHAR(RESULT^,SourceLaenge+Laenge,#0);
   MOVE(Dst^,RESULT^,Index);
   MOVE(Src^,PBYTE(LONGWORD(LONGWORD(RESULT)+LONGWORD(Index)))^,SourceLaenge);
   IF (Laenge-Index)>0 THEN BEGIN
    MOVE(PBYTE(LONGWORD(LONGWORD(Dst)+LONGWORD(Index)))^,PBYTE(LONGWORD(LONGWORD(RESULT)+LONGWORD(Index)+LONGWORD(SourceLaenge)))^,Laenge-Index);
   END;
  END ELSE BEGIN
   RESULT:=RTL_STRING_ASSIGN(Src,RESULT);
  END;
 END ELSE BEGIN
  IF Laenge>0 THEN BEGIN
   RESULT:=RTL_STRING_ASSIGN(Dst,RESULT);
  END;
 END;
END;

FUNCTION RTL_SETSTRING(Src:POINTER;Laenge:LONGINT):POINTER; PASCAL;
BEGIN
 RESULT:=NIL;
 IF Laenge>0 THEN BEGIN
  RTL_STRING_SETLENGTH(RESULT,Laenge);
  MOVE(Src^,RESULT^,Laenge);
 END;
END;

FUNCTION RTL_LOWERCASE(Src:POINTER):POINTER; PASCAL;
VAR Laenge,Position:INTEGER;
    B:PBYTE;
BEGIN
 RESULT:=NIL;
 Laenge:=RTL_STRING_LENGTH(Src);
 IF Laenge>0 THEN BEGIN
  RESULT:=RTL_STRING_UNIQUE(Src);
  B:=RESULT;
  FOR Position:=1 TO Laenge DO BEGIN
   IF CHAR(B^) IN ['A'..'Z'] THEN INC(B^,ORD('a')-ORD('A'));
   INC(B);
  END;
 END;
END;

FUNCTION RTL_UPPERCASE(Src:POINTER):POINTER; PASCAL;
VAR Laenge,Position:INTEGER;
    B:PBYTE;
BEGIN
 RESULT:=NIL;
 Laenge:=RTL_STRING_LENGTH(Src);
 IF Laenge>0 THEN BEGIN
  RESULT:=RTL_STRING_UNIQUE(Src);
  B:=RESULT;
  FOR Position:=1 TO Laenge DO BEGIN
   IF CHAR(B^) IN ['a'..'z'] THEN DEC(B^,ORD('a')-ORD('A'));
   INC(B);
  END;
 END;
END;

FUNCTION RTL_LOCASE(Src:LONGWORD):CHAR; PASCAL;
BEGIN
 RESULT:=CHR(Src);
 IF RESULT IN ['A'..'Z'] THEN INC(BYTE(RESULT),ORD('a')-ORD('A'));
END;

FUNCTION RTL_UPCASE(Src:LONGWORD):CHAR; PASCAL;
BEGIN
 RESULT:=CHR(Src);
 IF RESULT IN ['a'..'z'] THEN DEC(BYTE(RESULT),ORD('a')-ORD('A'));
END;

FUNCTION RTL_POS(SubStr,Str:POINTER;First:LONGINT):LONGINT; PASCAL;
VAR SubLaenge,Laenge,Position,SubPosition:INTEGER;
    PositionByte,ScanByte,SubScanByte:PBYTE;
BEGIN
 RESULT:=-1;
 SubLaenge:=RTL_STRING_LENGTH(SubStr);
 Laenge:=RTL_STRING_LENGTH(Str);
 IF (First<Laenge) AND ((First+SubLaenge)<=Laenge) THEN BEGIN
  PositionByte:=Str;
  INC(PositionByte,First);
  Position:=First;
  WHILE Position<Laenge DO BEGIN
   ScanByte:=PositionByte;
   SubScanByte:=SubStr;
   SubPosition:=0;
   IF ((Position+SubPosition)<Laenge) AND (SubPosition<SubLaenge) THEN BEGIN
    WHILE ((Position+SubPosition)<Laenge) AND (SubPosition<SubLaenge) AND (ScanByte^=SubScanByte^) DO BEGIN
     INC(ScanByte);
     INC(SubScanByte);
     INC(SubPosition);
    END;
    IF SubPosition=SubLaenge THEN BEGIN
     RESULT:=Position;
     EXIT;
    END;
   END;
   INC(PositionByte);
   INC(Position);
  END;
 END;
END;

FUNCTION RTL_POSEX(SubStr,Str:POINTER;First:LONGINT):LONGINT; PASCAL;
VAR SubLaenge,Laenge,Position,SubPosition:INTEGER;
    PositionByte,ScanByte,SubScanByte:PBYTE;
    A,B:BYTE;
BEGIN
 RESULT:=-1;
 SubLaenge:=RTL_STRING_LENGTH(SubStr);
 Laenge:=RTL_STRING_LENGTH(Str);
 IF (First<Laenge) AND ((First+SubLaenge)<=Laenge) THEN BEGIN
  PositionByte:=Str;
  INC(PositionByte,First);
  Position:=First;
  WHILE Position<Laenge DO BEGIN
   ScanByte:=PositionByte;
   SubScanByte:=SubStr;
   SubPosition:=0;
   IF ((Position+SubPosition)<Laenge) AND (SubPosition<SubLaenge) THEN BEGIN
    A:=ScanByte^;
    B:=SubScanByte^;
    IF CHAR(A) IN ['A'..'Z'] THEN INC(A,ORD('a')-ORD('A'));
    IF CHAR(B) IN ['A'..'Z'] THEN INC(B,ORD('a')-ORD('A'));
    WHILE ((Position+SubPosition)<Laenge) AND (SubPosition<SubLaenge) AND (A=B) DO BEGIN
     INC(ScanByte);
     INC(SubScanByte);
     INC(SubPosition);
     A:=ScanByte^;
     B:=SubScanByte^;
     IF CHAR(A) IN ['A'..'Z'] THEN INC(A,ORD('a')-ORD('A'));
     IF CHAR(B) IN ['A'..'Z'] THEN INC(B,ORD('a')-ORD('A'));
    END;
    IF SubPosition=SubLaenge THEN BEGIN
     RESULT:=Position;
     EXIT;
    END;
   END;
   INC(PositionByte);
   INC(Position);
  END;
 END;
END;

FUNCTION RTL_INTTOSTR(Number,Digits:LONGINT):POINTER; PASCAL;
VAR S:STRING;
    I:INTEGER;
BEGIN
 STR(Number:Digits,S);
 FOR I:=1 TO LENGTH(S) DO IF BYTE(S[I])<=32 THEN S[I]:='0';
 RESULT:=ConvertToBeRoString(S);
 S:='';
END;

FUNCTION RTL_GETMEM(Size:LONGINT):POINTER; PASCAL;
BEGIN
 GETMEM(RESULT,Size);
END;

PROCEDURE RTL_FREEMEM(S:POINTER); PASCAL;
BEGIN
 FREEMEM(S);
END;

FUNCTION RTL_MALLOC(Size:LONGINT):POINTER; PASCAL;
BEGIN
 GETMEM(RESULT,Size);
END;

PROCEDURE RTL_FREE(S:POINTER); PASCAL;
BEGIN
 FREEMEM(S);
END;

FUNCTION RTL_FILEOPEN(FileName:BeRoString):POINTER; PASCAL;
VAR S:TBeRoFileStream;
BEGIN
 S:=TBeRoFileStream.Create(ConvertFromBeRoString(FileName));
 RESULT:=POINTER(S);
END;

FUNCTION RTL_FILECREATE(FileName:BeRoString):POINTER; PASCAL;
VAR S:TBeRoFileStream;
BEGIN
 S:=TBeRoFileStream.CreateNew(ConvertFromBeRoString(FileName));
 RESULT:=POINTER(S);
END;

PROCEDURE RTL_FILECLOSE(S:POINTER); PASCAL;
BEGIN
 TBeRoFileStream(S).Free;
END;

FUNCTION RTL_FILESEEK(S:POINTER;Position:INTEGER):INTEGER; PASCAL;
BEGIN
 RESULT:=TBeRoFileStream(S).Seek(Position);
END;

FUNCTION RTL_FILEPOSITION(S:POINTER):INTEGER; PASCAL;
BEGIN
 RESULT:=TBeRoFileStream(S).Position;
END;

FUNCTION RTL_FILESIZE(S:POINTER):INTEGER; PASCAL;
BEGIN
 RESULT:=TBeRoFileStream(S).Size;
END;

FUNCTION RTL_FILEEOF(S:POINTER):INTEGER; PASCAL;
BEGIN
 IF TBeRoFileStream(S).Position<TBeRoFileStream(S).Size THEN BEGIN
  RESULT:=0;
 END ELSE BEGIN
  RESULT:=1;
 END;
END;

FUNCTION RTL_FILEREAD(S,Buffer:POINTER;Counter:INTEGER):INTEGER; PASCAL;
BEGIN
 RESULT:=TBeRoFileStream(S).Read(Buffer^,Counter);
END;

FUNCTION RTL_FILEWRITE(S,Buffer:POINTER;Counter:INTEGER):INTEGER; PASCAL;
BEGIN
 RESULT:=TBeRoFileStream(S).Write(Buffer^,Counter);
END;

FUNCTION RTL_FILEREADLINE(S:POINTER):BeRoString; PASCAL;
BEGIN
 RESULT:=ConvertToBeRoString(TBeRoFileStream(S).ReadLine);
END;

PROCEDURE RTL_FILEWRITELINE(S:POINTER;Str:BeRoString); PASCAL;
BEGIN
 TBeRoFileStream(S).WriteLine(ConvertFromBeRoString(Str));
END;

FUNCTION RTL_GETTICKCOUNT:LONGWORD; PASCAL;
BEGIN
 RESULT:=GetTickCount();
END;

FUNCTION RTL_EXEC(FileName,Parameter:BeRoString):INTEGER; PASCAL;
BEGIN
 IF Ausfuehren(ConvertFromBeRoString(FileName),ConvertFromBeRoString(Parameter)) THEN BEGIN
  RESULT:=1;
 END ELSE BEGIN
  RESULT:=0;
 END;
END;

FUNCTION RTL_INTTOBASE(Value,Base:INTEGER):BeRoString; PASCAL;
BEGIN
 RESULT:=ConvertToBeRoString(IntToBase(Value,Base));
END;

FUNCTION RTL_INTTOHEX(Value:INTEGER):BeRoString; PASCAL;
BEGIN
 RESULT:=ConvertToBeRoString(IntToHex(Value));
END;

FUNCTION RTL_UINTTOBASE(Value,Base:LONGWORD):BeRoString; PASCAL;
BEGIN
 RESULT:=ConvertToBeRoString(LongWordToBase(Value,Base));
END;

FUNCTION RTL_UINTTOHEX(Value:LONGWORD):BeRoString; PASCAL;
BEGIN
 RESULT:=ConvertToBeRoString(LongWordToHex(Value));
END;

CONSTRUCTOR TBeRoScript.Create(TheCacheDir:STRING;SubCacheDir:STRING='BeRoScriptCache');
BEGIN
 INHERITED Create;
 CacheCompression:=TRUE;
 FastCacheCompression:=TRUE;
 Alignment:=TRUE;
 OutDirect:=FALSE;
 Debug:=FALSE;
 fOnOwnPreCode:=NIL;
 fOnOwnNativesPointers:=NIL;
 fOnOwnNativesDefinitions:=NIL;
 CacheDir:=TheCacheDir;
 IF LENGTH(CacheDir)>0 THEN BEGIN
  IF CacheDir[LENGTH(CacheDir)]<>'\' THEN CacheDir:=CacheDir+'\';
  IF LENGTH(SubCacheDir)>0 THEN CacheDir:=CacheDir+SubCacheDir+'\';
  {$I-}MKDIR(CacheDir);{$I+}IOResult;
 END;
 LineDifference:=0;
 NameTabelle:=NIL;
 TypTabelle:=NIL;
 NativeTabelle:=NIL;
 ImportTabelle:=NIL;
 LabelFixUpTabelle:=NIL;
 UseFixUpTabelle:=NIL;
 ProcTabelle:=NIL;
 VariableTabelle:=NIL;
 Defines:=NIL;
 ContinueLabel:=NIL;
 BreakLabel:=NIL;
 LabelArray:=NIL;
 LinesInfo.PreparsedLines:=NIL;
 LinesInfo.Lines:=NIL;
 LinesInfo.Files:=NIL;
 QuellStream:=TBeRoMemoryStream.Create;
 QuellStream.Clear;
 CodeStream:=TBeRoMemoryStream.Create;
 CodePointer:=NIL;
 CodeProc:=NIL;
 CodeLength:=0;
 BSSGroesse:=0;
 DynamicLinkLibrarys:=NIL;
 Errors:='';
 BeginBlock:=-1;
 EndBlock:=-1;
 Blocks:=NIL;
 Archive:=NIL;
 Clear;
END;

DESTRUCTOR TBeRoScript.Destroy;
BEGIN
 Clear;
 QuellStream.Free;
 CodeStream.Free;
 INHERITED Destroy;
END;

PROCEDURE TBeRoScript.ClearBlocks;
VAR Counter:INTEGER;
BEGIN
 BeginBlock:=-1;
 EndBlock:=-1;
 FOR Counter:=0 TO LENGTH(Blocks)-1 DO Blocks[Counter]:='';
 SETLENGTH(Blocks,0);
END;

PROCEDURE TBeRoScript.Clear;
VAR I,J:INTEGER;
BEGIN
 IF CodePointer<>NIL THEN BEGIN
  VirtualFree(CodePointer,0,MEM_RELEASE);
  CodePointer:=NIL;
 END;
 IF ASSIGNED(NameTabelle) THEN BEGIN
  FOR I:=0 TO tnZaehler DO BEGIN
   NameTabelle[I].Name:='';
   NameTabelle[I].StructName:='';
   NameTabelle[I].Proc:='';
   NameTabelle[I].AsmVarName:='';
   SETLENGTH(NameTabelle[I].Param,0);
  END;
  SETLENGTH(NameTabelle,0);
 END;
 IF ASSIGNED(TypTabelle) THEN BEGIN
  FOR I:=0 TO ttZaehler-1 DO BEGIN
   TypTabelle[I].Name:='';
   SETLENGTH(TypTabelle[I].Variable,0);
   SETLENGTH(TypTabelle[I].Extends,0);
   SETLENGTH(TypTabelle[I].ExtendsOffsets,0);
  END;
  SETLENGTH(TypTabelle,0);
 END;
 IF ASSIGNED(NativeTabelle) THEN BEGIN
  FOR I:=0 TO tnpZaehler-1 DO BEGIN
   NativeTabelle[I].Name:='';
   NativeTabelle[I].AsmVarName:='';
  END;
  SETLENGTH(NativeTabelle,0);
 END;
 IF ASSIGNED(ImportTabelle) THEN BEGIN
  FOR I:=0 TO LENGTH(ImportTabelle)-1 DO BEGIN
   ImportTabelle[I].Name:='';
   ImportTabelle[I].AsmVarName:='';
   ImportTabelle[I].LibraryName:='';
   ImportTabelle[I].LibraryFunction:='';
  END;
  SETLENGTH(ImportTabelle,0);
 END;
 IF ASSIGNED(LabelFixUpTabelle) THEN BEGIN
  FOR I:=0 TO LENGTH(LabelFixUpTabelle)-1 DO LabelFixUpTabelle[I].Name:='';
  SETLENGTH(LabelFixUpTabelle,0);
 END;
 IF ASSIGNED(UseFixUpTabelle) THEN BEGIN
  FOR I:=0 TO LENGTH(UseFixUpTabelle)-1 DO UseFixUpTabelle[I].Name:='';
  SETLENGTH(UseFixUpTabelle,0);
 END;
 IF ASSIGNED(ProcTabelle) THEN BEGIN
  FOR I:=0 TO LENGTH(ProcTabelle)-1 DO ProcTabelle[I].Name:='';
  SETLENGTH(ProcTabelle,0);
 END;
 IF ASSIGNED(VariableTabelle) THEN BEGIN
  FOR I:=0 TO LENGTH(VariableTabelle)-1 DO VariableTabelle[I].Name:='';
  SETLENGTH(VariableTabelle,0);
 END;
 IF ASSIGNED(Defines) THEN BEGIN
  FOR I:=0 TO LENGTH(Defines)-1 DO BEGIN
   Defines[I].Name:='';
   Defines[I].Lines:='';
   FOR J:=0 TO LENGTH(Defines[I].Parameter)-1 DO Defines[I].Parameter[J]:='';
   SETLENGTH(Defines[I].Parameter,0);
  END;
  SETLENGTH(Defines,0);
 END;
 IF ASSIGNED(LabelArray) THEN BEGIN
  FOR I:=0 TO LENGTH(LabelArray)-1 DO LabelArray[I]:='';
  SETLENGTH(LabelArray,0);
 END;
 IF ASSIGNED(DynamicLinkLibrarys) THEN BEGIN
  FOR I:=0 TO LENGTH(DynamicLinkLibrarys)-1 DO DynamicLinkLibrarys[I].Free;
  SETLENGTH(DynamicLinkLibrarys,0);
 END;
 IF ASSIGNED(LinesInfo.PreparsedLines) THEN BEGIN
  SETLENGTH(LinesInfo.PreparsedLines,0);
 END;
 IF ASSIGNED(LinesInfo.Lines) THEN BEGIN
  SETLENGTH(LinesInfo.Lines,0);
 END;
 IF ASSIGNED(LinesInfo.Files) THEN BEGIN
  FOR I:=0 TO LENGTH(LinesInfo.Files)-1 DO LinesInfo.Files[I]:='';
  SETLENGTH(LinesInfo.Files,0);
 END;
 ClearBlocks;
 IsCompiled:=FALSE;
 Output:='';
 tnZaehler:=0;
 ttZaehler:=0;
 tnpZaehler:=0;
 tnSubZaehler:=0;
 CodeStream.Clear;
 CodePointer:=NIL;
 CodeProc:=NIL;
 CodeLength:=0;
 BSSGroesse:=0;
 CodeFileName:='';
 CodeName:='';
 SourceChecksumme:=0;
 IsTermSigned:=FALSE;
 Fehler:=FALSE;
END;

FUNCTION TBeRoScript.MTRIM(S:STRING):STRING;
VAR StartPos,Laenge:INTEGER;
BEGIN
 Laenge:=LENGTH(S);
 IF Laenge>0 THEN BEGIN
  WHILE (Laenge>0) AND (S[Laenge] IN [#0..#32]) DO DEC(Laenge);
  StartPos:=1;
  WHILE (StartPos<=Laenge) AND (S[StartPos] IN [#0..#32]) DO INC(StartPos);
  RESULT:=COPY(S,StartPos,Laenge-StartPos+1);
 END ELSE BEGIN
  RESULT:='';
 END;
END;

FUNCTION TBeRoScript.MUPPERCASE(S:STRING):STRING;
VAR I,L:INTEGER;
BEGIN
 RESULT:='';
 L:=LENGTH(S);
 I:=1;
 WHILE I<=L DO BEGIN
  IF S[I] IN ['a'..'z'] THEN BEGIN
   RESULT:=RESULT+CHAR(BYTE(S[I])-32);
  END ELSE BEGIN
   RESULT:=RESULT+S[I];
  END;
  INC(I);
 END;
END;

FUNCTION TBeRoScript.MeinePosition(Wo,Was:STRING;AbWo:INTEGER):INTEGER;
VAR I,K,J,H,G,L,O,M,N:INTEGER;
 PROCEDURE Checken;
 BEGIN
  IF (J>0) AND (J<=LENGTH(Wo)) THEN IF Wo[J] IN ['A'..'Z','a'..'z','0'..'9','_'] THEN L:=0;
 END;
BEGIN
 O:=0;
 IF AbWo<1 THEN BEGIN
  I:=1;
 END ELSE BEGIN
  I:=AbWo;
 END;
 M:=LENGTH(Was);
 N:=LENGTH(Wo);
 K:=N-M+1;
 WHILE I<=K DO BEGIN
  J:=I;
  H:=J+M;
  G:=1;
  L:=0;
  WHILE (J<H) AND (J<=LENGTH(Wo)) AND (G<=LENGTH(Was)) DO BEGIN
   IF Wo[J]=Was[G] THEN BEGIN
    INC(L);
   END ELSE BEGIN
    BREAK;
   END;
   INC(J);
   INC(G);
  END;
  IF L<>M THEN L:=0;
  IF L>0 THEN BEGIN
   J:=I-1;
   IF J>0 THEN Checken;
   J:=H;
   IF J<=N THEN Checken;
   IF L>0 THEN BEGIN
    O:=I;
    BREAK;
   END;
  END;
  INC(I);
 END;
 RESULT:=O;
END;

FUNCTION TBeRoScript.StringErsetzen(Wo,Von,Mit:STRING):STRING;
VAR I,J:INTEGER;
    N,M:STRING;
    Ok:BOOLEAN;
BEGIN
 RESULT:='';
 Ok:=TRUE;
 N:=Wo;
 J:=1;
 WHILE Ok DO BEGIN
  Ok:=FALSE;
  I:=MeinePosition(N,Von,J);
  IF I>0 THEN BEGIN
   M:=COPY(N,1,I-1);
   M:=M+Mit;
   M:=M+COPY(N,I+LENGTH(Von),LENGTH(N)-I-LENGTH(Von)+1);
   N:=M;
   J:=I+LENGTH(Mit);
   IF J<1 THEN J:=1;
   Ok:=TRUE;
  END;
 END;
 IF MUPPERCASE(N)<>'' THEN RESULT:=N;
END;

PROCEDURE TBeRoScript.CompilerCreate;
BEGIN
 Init;
 GeneratiereLabelNr:=0;
 AsmVarNr:=0;
 SBuf:='';
END;

PROCEDURE TBeRoScript.IncLevel;
BEGIN
 INC(Level);
 SETLENGTH(BreakLabel,Level+1);
 SETLENGTH(ContinueLabel,Level+1);
END;

PROCEDURE TBeRoScript.DecLevel;
BEGIN
 BreakLabel[Level]:='';
 ContinueLabel[Level]:='';
 DEC(Level);
 SETLENGTH(BreakLabel,Level+1);
 SETLENGTH(ContinueLabel,Level+1);
END;

PROCEDURE TBeRoScript.SetError(err:INTEGER);
VAR S,Zeile,Spalte,Datei:STRING;
    Line,LineNumber,FileIndex:INTEGER;
BEGIN
 CASE err OF
  ceUndefErr:S:='Unknown error';
  ceLParenExp:S:='''('' expected';
  ceRParenExp:S:=''')'' expected';
  ceThenExp:S:='THEN expected';
  ceErrInExpr:S:='Error in expression';
  ceExpectEql:S:='''=='' expected';
  ceExpectSet:S:='''='' expected';
  ceUnexpectedEOF:S:='Unexpected file END';
  ceVarNotDef:S:='Variable not defined';
  ceVarDoppelDefiniert:S:='Variable already defined';
  ceZahlenWertErwartet:S:='Number value expected';
  ceKRParentErwartet:S:=''']'' expected';
  ceKeinArray:S:='Variable isn''t a array';
  ceBezeichnerErwartet:S:='Identifier expected';
  ceFuncParamDefFehler:S:='Error in function parameter definition';
  ceFuncParamNumFehler:S:='Invalid function parameters';
  ceFuncParamSetError:S:='Invalid function parameters';
  ceWhileErwartet:S:='''WHILE'' expected';
  ceSemiColonErwartet:S:=''';'' expected';
  ceBeginErwartet:S:='''{'' expected';
  ceEndErwartet:S:='''}'' expected';
  ceNativeProcNichtGefunden:S:='Native function/procedure not found';
  ceNativeProcIsNull:S:='Native function/procedure is a null pointer';
  ceCaseErwartet:S:='''case'' expected';
  ceDoppelPunktErwartet:S:=''':'' expected';
  ceFixUpFehler:S:='Code fix up error';
  ceStructNotDefined:S:='Struct not defined';
  ceTypeExpected:S:='Type expected';
  ceNotStruct:S:='No struct';
  ceWrongType:S:='Wrong type';
  ceFloatTypeExpected:S:='Float type expected';
  ceFloatOperationError:S:='Invalid float operation';
  ceFloatInHexError:S:='A float number cann''t be heximal';
  cePreprocessorError:S:='Preprocessor error';
  ceLabelDoppelDefiniert:S:='Label already defined';
  ceLabelNotFound:S:='Label not found';
  ceLabelNameVariableDefiniert:S:='Label name as a variable already defined';
  ceENumAlreadyDefined:S:='enum already defined';
  ceENumStructAlreadyUsed:S:='enum object name already used';
  ceStringTypeExpected:S:='string type expected';
  ceStringExpected:S:='string expected';
  ceIllegalStringOperation:S:='Illegal string operation';
  ceStructExpected:S:='Struct expected';
  ceIllegalStructOperation:S:='Illegal struct operation';
  ceStructOrUnionOrObjectStatementExpected:S:='Struct, union or object statement expected';
  ceStructOrUnionOrObjectDoppelDefiniert:S:='Struct, union or object already defined';
  ceOnlyInMethodAllowed:S:='Only in a method allowed';
  ceNoInheritedCallPossible:S:='No inherited call possible';
  ceCommaExp:S:=''','' expected';
  ceImportProcNichtGefunden:S:='Import function/procedure not found';
  ceImportProcIsNull:S:='Import function/procedure is a null pointer';
  ELSE S:='Unknown error';
 END;
 IF QuelltextZeile<LineDifference THEN BEGIN
  STR(QuelltextZeile+LineDifference,Zeile);
  STR(QuelltextSpalte,Spalte);
  Errors:=Errors+'OwnPreCode('+Zeile+','+Spalte+')';
 END ELSE IF QuelltextZeile=LineDifference THEN BEGIN
  STR(QuelltextZeile+LineDifference,Zeile);
  STR(QuelltextSpalte,Spalte);
  Errors:=Errors+'NativePart('+Zeile+','+Spalte+')';
 END ELSE IF QuelltextZeile>LineDifference THEN BEGIN
  Line:=QuelltextZeile-LineDifference;
  IF Line<LENGTH(LinesInfo.Lines) THEN BEGIN
   LineNumber:=LinesInfo.Lines[Line].LineNumber;
   FileIndex:=LinesInfo.Lines[Line].FileIndex;
   IF FileIndex<LENGTH(LinesInfo.Files) THEN BEGIN
    Datei:=LinesInfo.Files[FileIndex];
   END ELSE BEGIN
    Datei:='-';
   END;
   STR(LineNumber,Zeile);
   STR(QuelltextSpalte,Spalte);
   Errors:=Errors+'['+Datei+']('+Zeile+','+Spalte+')';
  END ELSE BEGIN
   Errors:=Errors+'[?]';
  END;
 END;
 Errors:=Errors+' Error: '+S+#13#10;
 ferror:=TRUE;
END;

PROCEDURE TBeRoScript.ByteHinzufuegen(B:BYTE);
BEGIN
 CodeStream.Write(B,SIZEOF(BYTE));
END;

PROCEDURE TBeRoScript.WordHinzufuegen(W:WORD);
BEGIN
 CodeStream.Write(W,SIZEOF(WORD));
END;

PROCEDURE TBeRoScript.DWordHinzufuegen(DW:LONGWORD);
BEGIN
 CodeStream.Write(DW,SIZEOF(LONGWORD));
END;

PROCEDURE TBeRoScript.ProcHinzufuegen(S,SO:STRING);
VAR I:INTEGER;
BEGIN
 I:=LENGTH(ProcTabelle);
 SETLENGTH(ProcTabelle,I+1);
 IF LENGTH(SO)>0 THEN BEGIN
  ProcTabelle[I].Name:=SO+'.'+S;
 END ELSE BEGIN
  ProcTabelle[I].Name:=S;
 END;
 ProcTabelle[I].Offset:=CodeStream.Position;
END;

PROCEDURE TBeRoScript.VariableHinzufuegen(S,SO:STRING);
VAR I:INTEGER;
BEGIN
 I:=LENGTH(VariableTabelle);
 SETLENGTH(VariableTabelle,I+1);
 IF LENGTH(SO)>0 THEN BEGIN
  VariableTabelle[I].Name:=SO+'.'+S;
 END ELSE BEGIN
  VariableTabelle[I].Name:=S;
 END;
 VariableTabelle[I].Offset:=CodeStream.Position;
END;

PROCEDURE TBeRoScript.DifferenzLabelFixUpHinzufuegen(S:STRING);
VAR I:INTEGER;
BEGIN
 I:=LENGTH(UseFixUpTabelle);
 SETLENGTH(UseFixUpTabelle,I+1);
 UseFixUpTabelle[I].Typ:=tufutAbsolut;
 UseFixUpTabelle[I].Name:=S;
 UseFixUpTabelle[I].Offset:=CodeStream.Position;
 UseFixUpTabelle[I].AddOffset:=0;
END;

PROCEDURE TBeRoScript.JumpLabelFixUpHinzufuegen(S:STRING);
VAR I:INTEGER;
BEGIN
 I:=LENGTH(UseFixUpTabelle);
 SETLENGTH(UseFixUpTabelle,I+1);
 UseFixUpTabelle[I].Typ:=tufutJump;
 UseFixUpTabelle[I].Name:=S;
 UseFixUpTabelle[I].Offset:=CodeStream.Position;
 UseFixUpTabelle[I].AddOffset:=0;
END;

PROCEDURE TBeRoScript.LabelFixUpHinzufuegen(S:STRING;Offset:LONGINT);
VAR I:INTEGER;
BEGIN
 I:=LENGTH(UseFixUpTabelle);
 SETLENGTH(UseFixUpTabelle,I+1);
 UseFixUpTabelle[I].Typ:=tufutAbsolut;
 UseFixUpTabelle[I].Name:=S;
 UseFixUpTabelle[I].Offset:=CodeStream.Position;
 UseFixUpTabelle[I].AddOffset:=Offset;
END;

PROCEDURE TBeRoScript.LabelAdresseHinzufuegen(S:STRING);
BEGIN
 LabelFixUpHinzufuegen(S,0);
 DWordHinzufuegen(0);
END;

PROCEDURE TBeRoScript.LabelAdresseOffsetHinzufuegen(S:STRING;Offset:LONGINT);
BEGIN
 LabelFixUpHinzufuegen(S,Offset);
 DWordHinzufuegen(0);
END;

PROCEDURE TBeRoScript.LabelHinzufuegen(S:STRING);
VAR I:INTEGER;
BEGIN
 I:=LENGTH(LabelFixUpTabelle);
 SETLENGTH(LabelFixUpTabelle,I+1);
 LabelFixUpTabelle[I].Name:=S;
 LabelFixUpTabelle[I].Offset:=CodeStream.Position;
END;

PROCEDURE TBeRoScript.NativeFixUpHinzufuegen(NativeName:STRING);
VAR I:INTEGER;
BEGIN
 I:=LENGTH(UseFixUpTabelle);
 SETLENGTH(UseFixUpTabelle,I+1);
 UseFixUpTabelle[I].Typ:=tufutNative;
 UseFixUpTabelle[I].Name:=NativeName;
 UseFixUpTabelle[I].Offset:=CodeStream.Position;
 UseFixUpTabelle[I].AddOffset:=0;
END;

PROCEDURE TBeRoScript.NativeRelativeFixUpHinzufuegen(NativeName:STRING);
VAR I:INTEGER;
BEGIN
 I:=LENGTH(UseFixUpTabelle);
 SETLENGTH(UseFixUpTabelle,I+1);
 UseFixUpTabelle[I].Typ:=tufutNativeRelative;
 UseFixUpTabelle[I].Name:=NativeName;
 UseFixUpTabelle[I].Offset:=CodeStream.Position;
 UseFixUpTabelle[I].AddOffset:=0;
END;

PROCEDURE TBeRoScript.ImportFixUpHinzufuegen(ImportName:STRING);
VAR I:INTEGER;
BEGIN
 I:=LENGTH(UseFixUpTabelle);
 SETLENGTH(UseFixUpTabelle,I+1);
 UseFixUpTabelle[I].Typ:=tufutImport;
 UseFixUpTabelle[I].Name:=ImportName;
 UseFixUpTabelle[I].Offset:=CodeStream.Position;
 UseFixUpTabelle[I].AddOffset:=0;
END;

PROCEDURE TBeRoScript.ImportRelativeFixUpHinzufuegen(ImportName:STRING);
VAR I:INTEGER;
BEGIN
 I:=LENGTH(UseFixUpTabelle);
 SETLENGTH(UseFixUpTabelle,I+1);
 UseFixUpTabelle[I].Typ:=tufutImportRelative;
 UseFixUpTabelle[I].Name:=ImportName;
 UseFixUpTabelle[I].Offset:=CodeStream.Position;
 UseFixUpTabelle[I].AddOffset:=0;
END;

PROCEDURE TBeRoScript.ClassPointerFixUpHinzufuegen;
VAR I:INTEGER;
BEGIN
 I:=LENGTH(UseFixUpTabelle);
 SETLENGTH(UseFixUpTabelle,I+1);
 UseFixUpTabelle[I].Typ:=tufutClassPointer;
 UseFixUpTabelle[I].Name:='';
 UseFixUpTabelle[I].Offset:=CodeStream.Position;
 UseFixUpTabelle[I].AddOffset:=0;
END;

PROCEDURE TBeRoScript.CodeFixen(CodeOffset:LONGWORD);
VAR I,J,L,K,M,N,O:INTEGER;
    LibraryStream:TBeRoStream;
    Proc:POINTER;
BEGIN
 FOR I:=0 TO LENGTH(UseFixUpTabelle)-1 DO BEGIN
  IF UseFixUpTabelle[I].Typ=tufutClassPointer THEN BEGIN
   CodeStream.Seek(UseFixUpTabelle[I].Offset);
   DWordHinzufuegen(LONGWORD(POINTER(SELF)));
  END ELSE IF UseFixUpTabelle[I].Typ IN [tufutNative,tufutNativeRelative] THEN BEGIN
   K:=-1;
   FOR J:=0 TO LENGTH(NativeTabelle)-1 DO BEGIN
    IF UseFixUpTabelle[I].Name=NativeTabelle[J].Name THEN BEGIN
     K:=J;
     BREAK;
    END;
   END;
   IF K>=0 THEN BEGIN
    IF NativeTabelle[K].Proc=NIL THEN BEGIN
     SetError(ceNativeProcIsNull);
     CONTINUE;
    END;
    CodeStream.Seek(UseFixUpTabelle[I].Offset);
    CASE UseFixUpTabelle[I].Typ OF
     tufutNative:DWordHinzufuegen(LONGWORD(NativeTabelle[K].Proc));
     tufutNativeRelative:BEGIN
      L:=LONGINT(NativeTabelle[K].Proc)-(UseFixUpTabelle[I].Offset+LONGINT(CodeOffset))-4;
      DWordHinzufuegen(LONGWORD(L));
     END;
    END;
   END ELSE BEGIN
    SetError(ceFixUpFehler);
   END;
  END ELSE IF UseFixUpTabelle[I].Typ IN [tufutImport,tufutImportRelative] THEN BEGIN
   K:=-1;
   FOR J:=0 TO LENGTH(ImportTabelle)-1 DO BEGIN
    IF UseFixUpTabelle[I].Name=ImportTabelle[J].Name THEN BEGIN
     K:=J;
     BREAK;
    END;
   END;
   IF K>=0 THEN BEGIN
    Proc:=NIL;
    IF (LENGTH(ImportTabelle[K].LibraryName)>0) AND (LENGTH(ImportTabelle[K].LibraryFunction)>0) THEN BEGIN
     M:=LookDLL(ImportTabelle[K].LibraryName);
     IF M<0 THEN BEGIN
      M:=LENGTH(DynamicLinkLibrarys);
      SETLENGTH(DynamicLinkLibrarys,M+1);
      DynamicLinkLibrarys[M]:=TDynamicLinkLibrary.Create(ImportTabelle[K].LibraryName);
      IF NOT DynamicLinkLibrarys[M].LoadFile(ImportTabelle[K].LibraryName) THEN BEGIN
       IF ASSIGNED(Archive) THEN BEGIN
        LibraryStream:=TBeRoMemoryStream.Create;
        Archive.Extract(ImportTabelle[K].LibraryName,LibraryStream);
        IF NOT DynamicLinkLibrarys[M].Load(LibraryStream) THEN BEGIN
         LibraryStream.Free;
         SetError(ceFixUpFehler);
         CONTINUE;
        END ELSE BEGIN
         LibraryStream.Free;
        END;
       END ELSE BEGIN
        SetError(ceFixUpFehler);
       END;
      END;
     END;
     Proc:=DynamicLinkLibrarys[M].FindExport(ImportTabelle[K].LibraryFunction);
     IF Proc=NIL THEN BEGIN
      SetError(ceFixUpFehler);
      CONTINUE;
     END;
    END ELSE BEGIN
     SetError(ceFixUpFehler);
     CONTINUE;
    END;
    IF Proc=NIL THEN BEGIN
     SetError(ceImportProcIsNull);
     CONTINUE;
    END;
    CodeStream.Seek(UseFixUpTabelle[I].Offset);
    CASE UseFixUpTabelle[I].Typ OF
     tufutImport:DWordHinzufuegen(LONGWORD(Proc));
     tufutImportRelative:BEGIN
      L:=LONGINT(Proc)-(UseFixUpTabelle[I].Offset+LONGINT(CodeOffset))-4;
      DWordHinzufuegen(LONGWORD(L));
     END;
    END;
   END ELSE BEGIN
    SetError(ceFixUpFehler);
   END;
  END ELSE BEGIN
   K:=-1;
   Proc:=NIL;
   O:=LookImport(UseFixUpTabelle[I].Name);
   IF O>=0 THEN BEGIN
    IF (LENGTH(ImportTabelle[O].LibraryName)>0) AND (LENGTH(ImportTabelle[O].LibraryFunction)>0) THEN BEGIN
     M:=LookDLL(ImportTabelle[O].LibraryName);
     IF M<0 THEN BEGIN
      M:=LENGTH(DynamicLinkLibrarys);
      SETLENGTH(DynamicLinkLibrarys,M+1);
      DynamicLinkLibrarys[M]:=TDynamicLinkLibrary.Create(ImportTabelle[O].LibraryName);
      IF NOT DynamicLinkLibrarys[M].LoadFile(ImportTabelle[O].LibraryName) THEN BEGIN
       IF ASSIGNED(Archive) THEN BEGIN
        LibraryStream:=TBeRoMemoryStream.Create;
        Archive.Extract(ImportTabelle[K].LibraryName,LibraryStream);
        IF NOT DynamicLinkLibrarys[M].Load(LibraryStream) THEN BEGIN
         LibraryStream.Free;
         SetError(ceFixUpFehler);
         CONTINUE;
        END ELSE BEGIN
         LibraryStream.Free;
        END;
       END ELSE BEGIN
        SetError(ceFixUpFehler);
       END;
      END;
     END;
     Proc:=DynamicLinkLibrarys[M].FindExport(ImportTabelle[O].LibraryFunction);
     IF Proc=NIL THEN BEGIN
      SetError(ceFixUpFehler);
      CONTINUE;
     END;
    END ELSE BEGIN
     SetError(ceFixUpFehler);
     CONTINUE;
    END;
   END ELSE BEGIN
    O:=LookNative(UseFixUpTabelle[I].Name);
    IF O>=0 THEN BEGIN
     Proc:=NativeTabelle[I].Proc;
    END ELSE BEGIN
     FOR J:=0 TO LENGTH(LabelFixUpTabelle)-1 DO BEGIN
      IF UseFixUpTabelle[I].Name=LabelFixUpTabelle[J].Name THEN BEGIN
       K:=LabelFixUpTabelle[J].Offset;
       BREAK;
      END;
     END;
    END;
   END;
   IF (K<0) AND ASSIGNED(Proc) THEN K:=LONGWORD(Proc)-CodeOffset;
   IF K>=0 THEN BEGIN
    CASE UseFixUpTabelle[I].Typ OF
     tufutDifferenz:BEGIN
      L:=K-UseFixUpTabelle[I].Offset+UseFixUpTabelle[I].AddOffset;
      CodeStream.Seek(UseFixUpTabelle[I].Offset);
      DWordHinzufuegen(LONGWORD(L));
     END;
     tufutAbsolut:BEGIN
      L:=K+UseFixUpTabelle[I].AddOffset;
      CodeStream.Seek(UseFixUpTabelle[I].Offset);
      DWordHinzufuegen(LONGWORD(L)+CodeOffset);
     END;
     tufutJump:BEGIN
      L:=K-UseFixUpTabelle[I].Offset-4+UseFixUpTabelle[I].AddOffset;
      CodeStream.Seek(UseFixUpTabelle[I].Offset);
      DWordHinzufuegen(LONGWORD(L));
     END;
    END;
   END ELSE BEGIN
    SetError(ceFixUpFehler);
   END;
  END;
 END;
 FOR I:=0 TO LENGTH(ProcTabelle)-1 DO BEGIN
  INC(ProcTabelle[I].Offset,CodeOffset);
 END;
 FOR I:=0 TO LENGTH(VariableTabelle)-1 DO BEGIN
  INC(VariableTabelle[I].Offset,CodeOffset);
 END;
 CodeStream.Seek(CodeStream.Size);
END;

PROCEDURE TBeRoScript.CallLabel(S:STRING);
BEGIN
 ByteHinzufuegen($E8);
 JumpLabelFixUpHinzufuegen(S);
 DWordHinzufuegen(0);
END;

PROCEDURE TBeRoScript.JZLabel(S:STRING);
BEGIN
 ByteHinzufuegen($0F);
 ByteHinzufuegen($84);
 JumpLabelFixUpHinzufuegen(S);
 DWordHinzufuegen(0);
END;

PROCEDURE TBeRoScript.JNZLabel(S:STRING);
BEGIN
 ByteHinzufuegen($0F);
 ByteHinzufuegen($85);
 JumpLabelFixUpHinzufuegen(S);
 DWordHinzufuegen(0);
END;

PROCEDURE TBeRoScript.JumpLabel(S:STRING);
BEGIN
 ByteHinzufuegen($E9);
 JumpLabelFixUpHinzufuegen(S);
 DWordHinzufuegen(0);
END;

FUNCTION TBeRoScript.GeneratiereLabel:STRING;
VAR S:STRING;
BEGIN
 STR(GeneratiereLabelnr,S);
 RESULT:='GL@'+S;
 INC(GeneratiereLabelnr);
END;

FUNCTION TBeRoScript.AsmVar:STRING;
VAR S:STRING;
BEGIN
 STR(AsmVarNr,S);
 RESULT:='AV@'+S;
 INC(AsmVarNr);
END;

FUNCTION TBeRoScript.GetLabelName(S:STRING):STRING;
BEGIN
 RESULT:='UL!'+AktProcName+'@'+S;
END;

FUNCTION TBeRoScript.GetStructTempVariableName(TypLink:INTEGER):STRING;
VAR S,A:STRING;
    Adr:TWert;
BEGIN
 S:='STVN!'+AktProcName+'@'+TypTabelle[TypLink].Name+'?'+GeneratiereLabel;
 IF NOT LockVar(S,'',A,Adr,FALSE,-1) THEN BEGIN
  adr:=AddObjekt(S,'',_ident,tType,0,0,aLokal,FALSE,FALSE,TypLink,0);
 END;
 RESULT:=S;
END;

FUNCTION TBeRoScript.GetObjectTempVariableName(TypLink:INTEGER):STRING;
VAR S,A:STRING;
    Adr:TWert;
BEGIN
 S:='OBJTEMP?'+GeneratiereLabel;
 IF NOT LockVar(S,'',A,Adr,FALSE,-1) THEN BEGIN
  adr:=AddObjekt(S,'',_ident,tType,0,0,aLokal,TRUE,FALSE,TypLink,0);
 END;
 RESULT:=S;
END;

FUNCTION TBeRoScript.GetStringTempVariableName(Nummer:INTEGER):STRING;
VAR S,A:STRING;
    Adr:TWert;
BEGIN
 S:='TEMPSTR!'+AktProcName+'@'+INTTOSTR(Nummer)+'?'+GeneratiereLabel;
 IF NOT LockVar(S,'',A,Adr,FALSE,-1) THEN BEGIN
  adr:=AddObjekt(S,'',_ident,tString,0,0,aLokal,FALSE,FALSE,0,0);
  OutPushAx;
  OutXorAxAx;
  OutMovVarAx(S,0,FALSE,FALSE);
  OutPopAx;
 END;
 RESULT:=S;
END;

FUNCTION TBeRoScript.GetStringLevelVariableName:STRING;
VAR S,A:STRING;
    Adr:TWert;
BEGIN
 S:='TEMPLEVELSTR!'+AktProcName+'@'+INTTOSTR(StringLevel)+'?'+GeneratiereLabel;
 IF NOT LockVar(S,'',A,Adr,FALSE,-1) THEN BEGIN
  adr:=AddObjekt(S,'',_ident,tString,0,0,aLokal,FALSE,FALSE,0,0);
  OutPushAx;
  OutXorAxAx;
  OutMovVarAx(S,0,FALSE,FALSE);
  OutPopAx;
 END;
 RESULT:=S;
END;

FUNCTION TBeRoScript.GetStringVariableName:STRING;
VAR S,A:STRING;
    Adr:TWert;
BEGIN
 S:='STRTEMP!'+AktProcName+'?'+GeneratiereLabel;
 IF NOT LockVar(S,'',A,Adr,FALSE,-1) THEN BEGIN
  adr:=AddObjekt(S,'',_ident,tString,0,0,aLokal,FALSE,FALSE,0,0);
  OutPushAx;
  OutXorAxAx;
  OutMovVarAx(S,0,FALSE,FALSE);
  OutPopAx;
 END;
 RESULT:=S;
END;

FUNCTION TBeRoScript.AddObjekt(Name,StructName:STRING;Obj:BYTE;Typ:TTyp;Adr:TWert;ArrayDim:INTEGER;Art:TArt;Zeiger,InTyp:BOOLEAN;TypLink,Wert:INTEGER):WORD;
VAR A,B:INTEGER;
BEGIN
 INC(tnZaehler);
 SETLENGTH(NameTabelle,tnZaehler+1);
 NameTabelle[tnZaehler].Name:=Name;
 NameTabelle[tnZaehler].StructName:=StructName;
 NameTabelle[tnZaehler].Proc:=AktProcName;
 NameTabelle[tnZaehler].AsmVarName:='';
 IF Obj IN [_ident,_call,_type] THEN NameTabelle[tnZaehler].AsmVarName:=AsmVar;
 NameTabelle[tnZaehler].Obj:=Obj;
 NameTabelle[tnZaehler].Typ:=Typ;
 NameTabelle[tnZaehler].TypLink:=TypLink;
 NameTabelle[tnZaehler].InTypLink:=-1;
 NameTabelle[tnZaehler].Zeiger:=Zeiger;
 NameTabelle[tnZaehler].IstArray:=ArrayDim<>0;
 NameTabelle[tnZaehler].ArrayDim:=ArrayDim;
 NameTabelle[tnZaehler].storage:=0;
 NameTabelle[tnZaehler].StackPtr:=0;
 NameTabelle[tnZaehler].symptr:=0;
 NameTabelle[tnZaehler].StackAlloc:=0;
 NameTabelle[tnZaehler].Bytes2Pass:=0;
 NameTabelle[tnZaehler].ProcNr:=-1;
 NameTabelle[tnZaehler].ParamNum:=0;
 NameTabelle[tnZaehler].ShadowParamNum:=0;
 NameTabelle[tnZaehler].TotalParamNum:=0;
 NameTabelle[tnZaehler].SubNum:=0;
 NameTabelle[tnZaehler].Size:=0;
 NameTabelle[tnZaehler].BTyp:=-1;
 NameTabelle[tnZaehler].Feld_Offset:=0;
 NameTabelle[tnZaehler].native:=FALSE;
 NameTabelle[tnZaehler].import:=FALSE;
 NameTabelle[tnZaehler].isstdcall:=FALSE;
 NameTabelle[tnZaehler].EinTyp:=TypLink>=0;
 NameTabelle[tnZaehler].InTyp:=InTyp;
 NameTabelle[tnZaehler].Art:=Art;
 NameTabelle[tnZaehler].Param:=NIL;
 NameTabelle[tnZaehler].Wert:=Wert;
 A:=NameTabelle[tnZaehler].ArrayDim;
 IF A=0 THEN A:=1;
 VarSize:=0;
 B:=0;
 CASE Obj OF
  _ident:BEGIN
   Adr:=DP;
   INC(DP,SIZEOF(TWert));
   NameTabelle[tnZaehler].Adr:=Adr;
   IF NameTabelle[tnZaehler].Zeiger THEN BEGIN
    NameTabelle[tnZaehler].Size:=4;
   END ELSE BEGIN
    CASE NameTabelle[tnZaehler].Typ OF
     tuChar,tChar,tByte,tuByte:NameTabelle[tnZaehler].Size:=1;
     tuShortInt,tShortInt:NameTabelle[tnZaehler].Size:=2;
     tuInt,tInt,tFloat,tString,tVoid:NameTabelle[tnZaehler].Size:=4;
     tType:NameTabelle[tnZaehler].Size:=TypTabelle[TypLink].Size;
    END;
   END;
   VarSize:=NameTabelle[tnZaehler].Size;
   IF (AktProc>=0) AND (NameTabelle[tnZaehler].Art=aLokal) AND NOT InTyp THEN BEGIN
    IF NameTabelle[tnZaehler].Zeiger THEN BEGIN
     INC(NameTabelle[AktProc].StackAlloc,4);
    END ELSE BEGIN
     CASE NameTabelle[tnZaehler].Typ OF
      tuChar,tChar,tByte,tuByte:B:=A;
      tuShortInt,tShortInt:B:=2*A;
      tuInt,tInt,tFloat,tString,tVoid:B:=4*A;
      tType:B:=TypTabelle[TypLink].Size*A;
     END;
     IF Alignment THEN IF (B MOD 4)<>0 THEN B:=B+(4-(B MOD 4));
     INC(NameTabelle[AktProc].StackAlloc,B);
    END;
    NameTabelle[tnZaehler].StackPtr:=NameTabelle[AktProc].StackAlloc;
   END;
   IF (AktProc>=0) AND (NameTabelle[tnZaehler].Art IN [aParam,aShadowParam]) AND NOT InTyp THEN BEGIN
    NameTabelle[tnZaehler].ProcNr:=AktProc;
    INC(NameTabelle[AktProc].TotalParamNum);
    CASE NameTabelle[tnZaehler].Art OF
     aParam:INC(NameTabelle[AktProc].ParamNum);
     aShadowParam:INC(NameTabelle[AktProc].ShadowParamNum);
    END;
    IF NameTabelle[tnZaehler].Zeiger THEN BEGIN
     INC(NameTabelle[tnZaehler].Bytes2Pass,4);
    END ELSE BEGIN
     CASE NameTabelle[tnZaehler].Typ OF
      tuChar,tChar,tByte,tuByte:B:=A;
      tuShortInt,tShortInt:B:=2*A;
      tuInt,tInt,tFloat,tString,tVoid:B:=4*A;
      tType:B:=TypTabelle[TypLink].Size*A;
     END;
     IF Alignment THEN IF (B MOD 4)<>0 THEN B:=B+(4-(B MOD 4));
     INC(NameTabelle[tnZaehler].Bytes2Pass,B);
    END;
    INC(NameTabelle[AktProc].Bytes2Pass,NameTabelle[tnZaehler].Bytes2Pass);
    NameTabelle[tnZaehler].StackPtr:=NameTabelle[AktProc].Bytes2Pass;
    SETLENGTH(NameTabelle[AktProc].Param,NameTabelle[AktProc].TotalParamNum);
    NameTabelle[AktProc].Param[NameTabelle[AktProc].TotalParamNum-1]:=tnZaehler;
   END;
   IF NameTabelle[tnZaehler].Art=aStructVar THEN BEGIN
    NameTabelle[tnZaehler].InTypLink:=ttZaehler;
    INC(TypTabelle[ttZaehler].VariableNum);
    IF NameTabelle[tnZaehler].Zeiger THEN BEGIN
     INC(TypTabelle[ttZaehler].StackAlloc,4);
     INC(TypTabelle[ttZaehler].Size,4);
     INC(TypTabelle[ttZaehler].Bytes2Pass,4);
    END ELSE BEGIN
     CASE NameTabelle[tnZaehler].Typ OF
      tuChar,tChar,tByte,tuByte:B:=A;
      tuShortInt,tShortInt:B:=2*A;
      tuInt,tInt,tFloat,tString,tVoid:B:=4*A;
      tType:B:=TypTabelle[TypLink].Size*A;
     END;
     IF Alignment AND NOT TypTabelle[ttZaehler].IsPacked THEN BEGIN
      IF (B MOD 4)<>0 THEN BEGIN
       B:=B+(4-(B MOD 4));
      END;
     END;
     INC(NameTabelle[tnZaehler].Bytes2Pass,B);
     NameTabelle[tnZaehler].StackPtr:=NameTabelle[tnZaehler].Bytes2Pass;
     INC(TypTabelle[ttZaehler].StackAlloc,NameTabelle[tnZaehler].Bytes2Pass);
     INC(TypTabelle[ttZaehler].Size,NameTabelle[tnZaehler].Bytes2Pass);
     INC(TypTabelle[ttZaehler].Bytes2Pass,NameTabelle[tnZaehler].Bytes2Pass);
    END;
    NameTabelle[tnZaehler].StackPtr:=TypTabelle[ttZaehler].Bytes2Pass;
    SETLENGTH(TypTabelle[ttZaehler].Variable,TypTabelle[ttZaehler].VariableNum);
    TypTabelle[ttZaehler].Variable[TypTabelle[ttZaehler].VariableNum-1]:=tnZaehler;
   END;
  END;
  _keyword:NameTabelle[tnZaehler].Tok:=BYTE(Adr);
  _call:BEGIN
   Adr:=0;
   NameTabelle[tnZaehler].Adr:=Adr;
  END;
 END;
 RESULT:=Adr;
END;

FUNCTION TBeRoScript.Find(Name,StructName:STRING;Ident:BOOLEAN;VAR ENT:TNameTabelleEintrag;VAR SymNr:INTEGER;TypLink:INTEGER):BOOLEAN;
VAR B:BOOLEAN;
 FUNCTION MeinFind(MeineProc:STRING):BOOLEAN;
 VAR I,J:LONGWORD;
     c:BOOLEAN;
 BEGIN
  RESULT:=TRUE;
  J:=0;
  FOR I:=1 TO tnZaehler DO BEGIN
   IF Ident THEN BEGIN
    IF NameTabelle[I].Obj IN [_ident,_call,_enumstruct,_enumvalue,_labelident] THEN BEGIN
     c:=TRUE;
    END ELSE BEGIN
     c:=FALSE;
    END;
   END ELSE BEGIN
    c:=TRUE;
   END;
   IF (NameTabelle[I].Name=Name) AND (NameTabelle[I].StructName=StructName) THEN BEGIN
    IF NameTabelle[I].Art IN [aParam,aShadowParam] THEN BEGIN
     IF NameTabelle[I].ProcNr<>AktProc THEN BEGIN
      CONTINUE;
     END;
    END;
    IF NOT NameTabelle[I].InTyp THEN BEGIN
     IF MTRIM(NameTabelle[I].Proc)=MeineProc THEN BEGIN
      IF c THEN BEGIN
       J:=I;
       SymNr:=J;
       BREAK;
      END;
     END;
    END;
   END;
  END;
  ENT:=NameTabelle[J];
  IF J=0 THEN RESULT:=FALSE;
 END;
 FUNCTION TypFind:BOOLEAN;
 VAR I,J:LONGWORD;
     c:BOOLEAN;
 BEGIN
  RESULT:=TRUE;
  J:=0;
  FOR I:=tnZaehler DOWNTO 1 DO BEGIN
   IF Ident THEN BEGIN
    IF NameTabelle[I].Obj IN [_ident,_call,_enumstruct,_enumvalue,_labelident] THEN BEGIN
     c:=TRUE;
    END ELSE BEGIN
     c:=FALSE;
    END;
   END ELSE BEGIN
    c:=TRUE;
   END;
   IF (NameTabelle[I].Name=Name) AND (NameTabelle[I].StructName=StructName) AND (NameTabelle[I].InTypLink=TypLink) THEN BEGIN
    IF NameTabelle[I].Art IN [aParam,aShadowParam] THEN BEGIN
     IF NameTabelle[I].ProcNr<>AktProc THEN BEGIN
      CONTINUE;
     END;
    END;
    IF NameTabelle[I].BTyp=TypLink THEN BEGIN
     IF c THEN BEGIN
      J:=I;
      SymNr:=J;
      BREAK;
     END;
    END;
   END;
  END;
  ENT:=NameTabelle[J];
  IF J=0 THEN RESULT:=FALSE;
 END;
BEGIN
 SymNr:=0;
 NameTabelle[0].Name:='';
 NameTabelle[0].StructName:='';
 NameTabelle[0].Proc:='';
 IF TypLink>=0 THEN BEGIN
  RESULT:=TypFind;
 END ELSE IF LENGTH(MTRIM(AktProcName))>0 THEN BEGIN
  B:=MeinFind(MTRIM(AktProcName));
  IF NOT B THEN B:=MeinFind('');
  RESULT:=B;
 END ELSE BEGIN
  RESULT:=MeinFind('');
 END;
END;

FUNCTION TBeRoScript.LockKey(Name:STRING):BYTE;
VAR ENT:TNameTabelleEintrag;
    I:INTEGER;
BEGIN
 LockKey:=_ident;
 IF Find(Name,'',FALSE,ENT,I,-1) THEN BEGIN
  IF ENT.Obj=_keyword THEN LockKey:=ENT.Tok;
  IF ENT.Obj IN [_call,_enumstruct,_enumvalue,_labelident] THEN LockKey:=ENT.Obj;
 END;
END;

FUNCTION TBeRoScript.LockVar(Name,StructName:STRING;VAR AsmVarName:STRING;VAR Adr:TWert;define:BOOLEAN;TypLink:INTEGER):BOOLEAN;
VAR ENT:TNameTabelleEintrag;
    B:BOOLEAN;
    I:INTEGER;
BEGIN
 AktSymPtr:=-1;
 B:=Find(Name,StructName,TRUE,ENT,I,TypLink);
 IF (I>=0) AND (I<=tnZaehler) THEN AktSymPtr:=I;
 IF define THEN BEGIN
  IF (LENGTH(MTRIM(ENT.Proc))=0) AND (LENGTH(MTRIM(AktProcName))<>0) THEN BEGIN
   RESULT:=FALSE;
  END ELSE BEGIN
   RESULT:=B;
  END;
 END ELSE BEGIN
  RESULT:=B;
 END;
 Adr:=ENT.Adr;
 AsmVarName:=ENT.AsmVarName;
 AktTyp:=ENT.Typ;
END;

PROCEDURE TBeRoScript.OutJmp(S:STRING);
BEGIN
 JumpLabel(S);
END;

PROCEDURE TBeRoScript.OutLabel(S:STRING);
BEGIN
 LabelHinzufuegen(S);
END;

PROCEDURE TBeRoScript.OutRet;
BEGIN
{IF inmain THEN BEGIN
  JumpLabel('C_exit');
 END ELSE BEGIN}
  OutRetEx;
{END;}
END;

PROCEDURE TBeRoScript.OutRetEx;
BEGIN
 ByteHinzufuegen($C3);
END;

PROCEDURE TBeRoScript.OutRetValue(I:LONGWORD);
BEGIN
 IF I=0 THEN BEGIN
  OutRetEx;
 END ELSE IF I<=$FFFF THEN BEGIN
  ByteHinzufuegen($C2);
  WordHinzufuegen(I);
 END ELSE BEGIN
  OutAddESP(I);
  OutRetEx;
 END;
END;

PROCEDURE TBeRoScript.OutOutputBlock;
BEGIN
 UseOutputBlock:=TRUE;
 CallLabel('C_OutputBlock');
END;

PROCEDURE TBeRoScript.OutWrtAXSigned;
BEGIN
 UseWrtAXSigned:=TRUE;
 CallLabel('C_WRITENUMSIGNED');
 ByteHinzufuegen($31); ByteHinzufuegen($C0); // XOR EAX,EAX
 ByteHinzufuegen($31); ByteHinzufuegen($DB); // XOR EBX,EBX
END;

PROCEDURE TBeRoScript.OutWrtAXUnsigned;
BEGIN
// UseWrtAXUnsigned:=TRUE;
// CallLabel('C_WRITENUMUNSIGNED');
 UseWrtAXSigned:=TRUE;
 CallLabel('C_WRITENUMSIGNED');
 ByteHinzufuegen($31); ByteHinzufuegen($C0); // XOR EAX,EAX
 ByteHinzufuegen($31); ByteHinzufuegen($DB); // XOR EBX,EBX
END;

PROCEDURE TBeRoScript.OutWrtFloatAX;
BEGIN
 UseWrtFloat:=TRUE;
 CallLabel('C_PrintFloat');
 ByteHinzufuegen($31); ByteHinzufuegen($C0); // XOR EAX,EAX
 ByteHinzufuegen($31); ByteHinzufuegen($DB); // XOR EBX,EBX
END;

PROCEDURE TBeRoScript.OutWrtStr;
BEGIN
 UseWrtSTR:=TRUE;
 CallLabel('C_PrintString');
END;

PROCEDURE TBeRoScript.OutWrtPCharString;
BEGIN
 UseWrtPCharString:=TRUE;
 CallLabel('C_PrintPCharString');
END;

PROCEDURE TBeRoScript.OutWrtChar;
BEGIN
 UseWrtChar:=TRUE;
 CallLabel('C_PrintChar');
END;

PROCEDURE TBeRoScript.OutStrNew;
BEGIN
 UseStrNew:=TRUE;
 CallLabel('C_StrNew');
END;

PROCEDURE TBeRoScript.OutStrIncrease;
BEGIN
 OutPushAx;
 OutCallNative('RTL_STRING_INCREASE');
END;

PROCEDURE TBeRoScript.OutStrDecrease;
BEGIN
 OutPushAx;
 OutCallNative('RTL_STRING_DECREASE');
END;

PROCEDURE TBeRoScript.OutStrAssign;
BEGIN
 UseStrAssign:=TRUE;
 CallLabel('C_StrAssign');
END;

PROCEDURE TBeRoScript.OutStrLength;
BEGIN
 UseStrLength:=TRUE;
 CallLabel('C_StrLength');
END;

PROCEDURE TBeRoScript.OutStrSetLength;
BEGIN
 UseStrSetLength:=TRUE;
 CallLabel('C_StrSetLength');
END;

PROCEDURE TBeRoScript.OutStrUnique;
BEGIN
 UseStrUnique:=TRUE;
 CallLabel('C_StrUnique');
END;

PROCEDURE TBeRoScript.OutStrCharConvert;
BEGIN
 UseStrCharConvert:=TRUE;
 CallLabel('C_StrCharConvert');
END;

PROCEDURE TBeRoScript.OutStrGet;
BEGIN
 UseStrGet:=TRUE;
 CallLabel('C_StrGet');
END;

PROCEDURE TBeRoScript.OutStrConcat;
BEGIN
 UseStrConcat:=TRUE;
 CallLabel('C_StrConcat');
END;

PROCEDURE TBeRoScript.OutStrSelfConcat;
BEGIN
 UseStrSelfConcat:=TRUE;
 CallLabel('C_StrSelfConcat');
END;

PROCEDURE TBeRoScript.OutStrCompare;
BEGIN
 UseStrCompare:=TRUE;
 CallLabel('C_StrCompare');
END;

PROCEDURE TBeRoScript.OutClrESPStr;
BEGIN
 ByteHinzufuegen($C7); // MOV DWORD PTR [ESP-4],0
 ByteHinzufuegen($44);
 ByteHinzufuegen($24);
 ByteHinzufuegen($FC);
 DWordHinzufuegen($00);
END;

PROCEDURE TBeRoScript.OutLeaESPStr;
BEGIN
 ByteHinzufuegen($8D); // LEA EAX,[ESP-4]
 ByteHinzufuegen($44);
 ByteHinzufuegen($24);
 ByteHinzufuegen($FC);
END;

PROCEDURE TBeRoScript.OutMovESPStr;
BEGIN
 ByteHinzufuegen($8B); // MOV EAX,[ESP-4]
 ByteHinzufuegen($44);
 ByteHinzufuegen($24);
 ByteHinzufuegen($FC);
END;

PROCEDURE TBeRoScript.OutLeaESPStruct;
BEGIN
 ByteHinzufuegen($8D); // LEA EAX,[ESP]
 ByteHinzufuegen($04);
 ByteHinzufuegen($24);
END;

PROCEDURE TBeRoScript.OutMovESPStruct;
BEGIN
 ByteHinzufuegen($8B); // MOV EAX,[ESP]
 ByteHinzufuegen($04);
 ByteHinzufuegen($24);
END;

PROCEDURE TBeRoScript.OutMovEAXStruct(Size:LONGWORD);
BEGIN
 CASE Size OF
  1:BEGIN
   // MOV AL,[EAX]
   ByteHinzufuegen($8A);
   ByteHinzufuegen($00);
   ByteHinzufuegen($25); DWordHinzufuegen($FF); // AND EAX,$FF
  END;
  2:BEGIN
   // MOV AX,[EAX]
   ByteHinzufuegen($66);
   ByteHinzufuegen($8B);
   ByteHinzufuegen($00);
   ByteHinzufuegen($25); DWordHinzufuegen($FFFF); // AND EAX,$FFFF
  END;
  4:BEGIN
   // MOV EAX,[EAX]
   ByteHinzufuegen($8B);
   ByteHinzufuegen($00);
  END;
 END;
END;

PROCEDURE TBeRoScript.OutMovEBXEAXStruct(Size:LONGWORD);
BEGIN
 CASE Size OF    
  1:BEGIN
   // MOV [EAX],BL
   ByteHinzufuegen($88);
   ByteHinzufuegen($18);
  END;
  2:BEGIN
   // MOV [EAX],BX
   ByteHinzufuegen($66);
   ByteHinzufuegen($89);
   ByteHinzufuegen($18);
  END;
  4:BEGIN
   // MOV [EAX],EBX
   ByteHinzufuegen($89);
   ByteHinzufuegen($18);
  END;
 END;
END;

PROCEDURE TBeRoScript.OutJzIf(S:STRING);
BEGIN
 ByteHinzufuegen($85); ByteHinzufuegen($C0); // TEST EAX,EAX
 JZLabel(S);
END;

PROCEDURE TBeRoScript.OutJzIfBx(S:STRING);
BEGIN
 ByteHinzufuegen($85); ByteHinzufuegen($DB); // TEST EBX,EBX
 JZLabel(S);
END;

PROCEDURE TBeRoScript.OutEql;
BEGIN
 ByteHinzufuegen($39); ByteHinzufuegen($D8); // CMP EAX,EBX
 ByteHinzufuegen($0F); ByteHinzufuegen($94); ByteHinzufuegen($C0); // SETZ AL
 ByteHinzufuegen($25); DWordHinzufuegen($FF); // AND EAX,$FF
END;

PROCEDURE TBeRoScript.OutNe;
BEGIN
 ByteHinzufuegen($39); ByteHinzufuegen($D8); // CMP EAX,EBX
 ByteHinzufuegen($0F); ByteHinzufuegen($95); ByteHinzufuegen($C0); // SETNZ AL
 ByteHinzufuegen($25); DWordHinzufuegen($FF); // AND EAX,$FF
END;

PROCEDURE TBeRoScript.OutLss;
BEGIN
 ByteHinzufuegen($39); ByteHinzufuegen($D8); // CMP EAX,EBX
 ByteHinzufuegen($0F); ByteHinzufuegen($9C); ByteHinzufuegen($C0); // SETL AL
 ByteHinzufuegen($25); DWordHinzufuegen($FF); // AND EAX,$FF
END;

PROCEDURE TBeRoScript.OutLea;
BEGIN
 ByteHinzufuegen($39); ByteHinzufuegen($D8); // CMP EAX,EBX
 ByteHinzufuegen($0F); ByteHinzufuegen($9E); ByteHinzufuegen($C0); // SETLE AL
 ByteHinzufuegen($25); DWordHinzufuegen($FF); // AND EAX,$FF
END;

PROCEDURE TBeRoScript.OutGre;
BEGIN
 ByteHinzufuegen($39); ByteHinzufuegen($D8); // CMP EAX,EBX
 ByteHinzufuegen($0F); ByteHinzufuegen($9F); ByteHinzufuegen($C0); // SETG AL
 ByteHinzufuegen($25); DWordHinzufuegen($FF); // AND EAX,$FF
END;

PROCEDURE TBeRoScript.OutGra;
BEGIN
 ByteHinzufuegen($39); ByteHinzufuegen($D8); // CMP EAX,EBX
 ByteHinzufuegen($0F); ByteHinzufuegen($9D); ByteHinzufuegen($C0); // SETGE AL
 ByteHinzufuegen($25); DWordHinzufuegen($FF); // AND EAX,$FF
END;

PROCEDURE TBeRoScript.OutStrBXTest;
BEGIN
 ByteHinzufuegen($85); ByteHinzufuegen($DB); // TEST EBX,EBX
 ByteHinzufuegen($0F); ByteHinzufuegen($94); ByteHinzufuegen($C0); // SETZ AL
 ByteHinzufuegen($25); DWordHinzufuegen($FF); // AND EAX,$FF
END;

PROCEDURE TBeRoScript.OutStrEql;
BEGIN
 OutStrCompare;
 ByteHinzufuegen($85); ByteHinzufuegen($C0); // TEST EAX,EAX
 ByteHinzufuegen($0F); ByteHinzufuegen($94); ByteHinzufuegen($C0); // SETZ AL
 ByteHinzufuegen($25); DWordHinzufuegen($FF); // AND EAX,$FF
END;

PROCEDURE TBeRoScript.OutStrNe;
BEGIN
 OutStrCompare;
 ByteHinzufuegen($85); ByteHinzufuegen($C0); // TEST EAX,EAX
 ByteHinzufuegen($0F); ByteHinzufuegen($95); ByteHinzufuegen($C0); // SETNZ AL
 ByteHinzufuegen($25); DWordHinzufuegen($FF); // AND EAX,$FF
END;

PROCEDURE TBeRoScript.OutStrLss;
BEGIN
 OutStrCompare;
 ByteHinzufuegen($83); ByteHinzufuegen($F8); ByteHinzufuegen($00); // CMP EAX,0
 ByteHinzufuegen($0F); ByteHinzufuegen($9C); ByteHinzufuegen($C0); // SETL AL
 ByteHinzufuegen($25); DWordHinzufuegen($FF); // AND EAX,$FF
END;

PROCEDURE TBeRoScript.OutStrLea;
BEGIN
 OutStrCompare;
 ByteHinzufuegen($83); ByteHinzufuegen($F8); ByteHinzufuegen($00); // CMP EAX,0
 ByteHinzufuegen($0F); ByteHinzufuegen($9E); ByteHinzufuegen($C0); // SETLE AL
 ByteHinzufuegen($25); DWordHinzufuegen($FF); // AND EAX,$FF
END;

PROCEDURE TBeRoScript.OutStrGre;
BEGIN
 OutStrCompare;
 ByteHinzufuegen($83); ByteHinzufuegen($F8); ByteHinzufuegen($00); // CMP EAX,0
 ByteHinzufuegen($0F); ByteHinzufuegen($9F); ByteHinzufuegen($C0); // SETG AL
 ByteHinzufuegen($25); DWordHinzufuegen($FF); // AND EAX,$FF
END;

PROCEDURE TBeRoScript.OutStrGra;
BEGIN
 OutStrCompare;
 ByteHinzufuegen($83); ByteHinzufuegen($F8); ByteHinzufuegen($00); // CMP EAX,0
 ByteHinzufuegen($0F); ByteHinzufuegen($9D); ByteHinzufuegen($C0); // SETGE AL
 ByteHinzufuegen($25); DWordHinzufuegen($FF); // AND EAX,$FF
END;

PROCEDURE TBeRoScript.OutNotAxBoolean;
VAR S1,S2:STRING;
BEGIN
 S1:=GeneratiereLabel;
 S2:=GeneratiereLabel;
 ByteHinzufuegen($85); ByteHinzufuegen($C0); // TEST EAX,EAX
 JZLabel(S1);
 ByteHinzufuegen($33); ByteHinzufuegen($C0); // XOR EAX,EAX
 JumpLabel(S2);
 OutLabel(S1);
 ByteHinzufuegen($33); ByteHinzufuegen($C0); // XOR EAX,EAX
 ByteHinzufuegen($40); // INC EAX
 OutLabel(S2);
END;

PROCEDURE TBeRoScript.OutNotAxBitwise;
BEGIN
 ByteHinzufuegen($F7); ByteHinzufuegen($D0); // NOT EAX
END;

PROCEDURE TBeRoScript.OutNegAx;
BEGIN
 ByteHinzufuegen($F7); ByteHinzufuegen($D8); // NEG EAX
END;

PROCEDURE TBeRoScript.OutPushSi;
BEGIN
 ByteHinzufuegen($56); // PUSH ESI
END;

PROCEDURE TBeRoScript.OutPopSi;
BEGIN
 ByteHinzufuegen($5E); // POP ESI
END;

PROCEDURE TBeRoScript.OutPushDi;
BEGIN
 ByteHinzufuegen($57); // PUSH EDI
END;

PROCEDURE TBeRoScript.OutPopDi;
BEGIN
 ByteHinzufuegen($5F); // POP EDI
END;

PROCEDURE TBeRoScript.OutMovCxSp;
BEGIN
 ByteHinzufuegen($8B); ByteHinzufuegen($CC); // MOV ECX,ESP
END;

PROCEDURE TBeRoScript.OutMovSpCx;
BEGIN
 ByteHinzufuegen($8B); ByteHinzufuegen($E1); // MOV ESP,ECX
END;

PROCEDURE TBeRoScript.OutMovBpSp;
BEGIN
 ByteHinzufuegen($89); ByteHinzufuegen($E5); // MOV EBP,ESP
END;

PROCEDURE TBeRoScript.OutMovSpBp;
BEGIN
 ByteHinzufuegen($89); ByteHinzufuegen($EC); // MOV ESP,EBP
END;

PROCEDURE TBeRoScript.OutMovSiAx;
BEGIN
 ByteHinzufuegen($8B); ByteHinzufuegen($F0); // MOV ESI,EAX
END;

PROCEDURE TBeRoScript.OutMovBxSi;
BEGIN
 ByteHinzufuegen($8B); ByteHinzufuegen($DE); // MOV EBX,ESI
END;

PROCEDURE TBeRoScript.OutMoveFromEBXToStack(Size:LONGWORD;Position:LONGINT);
BEGIN
 ByteHinzufuegen($8B); ByteHinzufuegen($F3); // MOV ESI,EBX
 OutSubESP(Size);
 ByteHinzufuegen($8B); ByteHinzufuegen($FC); // MOV EDI,ESP
 If Position<>0 THEN BEGIN
  ByteHinzufuegen($81); ByteHinzufuegen($C7); // ADD EDI,Position
  DWordHinzufuegen(LONGWORD(Position));
 END;
 OutMovBxCx;
 IF (Size MOD 4)=0 THEN BEGIN
  ByteHinzufuegen($B9); DWordHinzufuegen(Size SHR 2); // MOV ECX,Size>>2
  ByteHinzufuegen($F3); ByteHinzufuegen($A5); // REP MOVSD
 END ELSE IF (Size MOD 2)=0 THEN BEGIN
  ByteHinzufuegen($B9); DWordHinzufuegen(Size SHR 1); // MOV ECX,Size>>1
  ByteHinzufuegen($66); ByteHinzufuegen($F3); ByteHinzufuegen($A5); // REP MOVSW
 END ELSE BEGIN
  ByteHinzufuegen($B9); DWordHinzufuegen(Size); // MOV ECX,Size
  ByteHinzufuegen($F3); ByteHinzufuegen($A4); // REP MOVSD
 END;
 OutMovCxBx;
END;

PROCEDURE TBeRoScript.OutMoveFromEBXToEAX(Size:LONGWORD);
BEGIN
 ByteHinzufuegen($8B); ByteHinzufuegen($F3); // MOV ESI,EBX
 ByteHinzufuegen($89); ByteHinzufuegen($C7); // MOV EDI,EAX
 OutMovBxCx;
 IF (Size MOD 4)=0 THEN BEGIN
  ByteHinzufuegen($B9); DWordHinzufuegen(Size SHR 2); // MOV ECX,Size>>2
  ByteHinzufuegen($F3); ByteHinzufuegen($A5); // REP MOVSD
 END ELSE IF (Size MOD 2)=0 THEN BEGIN
  ByteHinzufuegen($B9); DWordHinzufuegen(Size SHR 1); // MOV ECX,Size>>1
  ByteHinzufuegen($66); ByteHinzufuegen($F3); ByteHinzufuegen($A5); // REP MOVSW
 END ELSE BEGIN
  ByteHinzufuegen($B9); DWordHinzufuegen(Size); // MOV ECX,Size
  ByteHinzufuegen($F3); ByteHinzufuegen($A4); // REP MOVSD
 END;
 OutMovCxBx;
END;

PROCEDURE TBeRoScript.OutPush32(I:LONGWORD);
BEGIN
 ByteHinzufuegen($68); // PUSH I
 DWordHinzufuegen(I);
END;

PROCEDURE TBeRoScript.OutPushClassPointer;
BEGIN
 ByteHinzufuegen($68); // PUSH POINTER(SELF)
 ClassPointerFixUpHinzufuegen;
 DWordHinzufuegen(0);
END;

PROCEDURE TBeRoScript.OutPushAx32;
BEGIN
 ByteHinzufuegen($50); // PUSH EAX
END;

PROCEDURE TBeRoScript.OutPushAx16;
BEGIN
 ByteHinzufuegen($66); ByteHinzufuegen($50); // PUSH EAX
END;

PROCEDURE TBeRoScript.OutPushAx8;
BEGIN
 ByteHinzufuegen($4C); // DEC ESP
 ByteHinzufuegen($88); ByteHinzufuegen($04); ByteHinzufuegen($24); // MOV [ESP],AL
END;

PROCEDURE TBeRoScript.OutPushAx;
BEGIN
 ByteHinzufuegen($50); // PUSH EAX
END;

PROCEDURE TBeRoScript.OutPushBx;
BEGIN
 ByteHinzufuegen($53); // PUSH EBX
END;

PROCEDURE TBeRoScript.OutPopAx;
BEGIN
 ByteHinzufuegen($58); // POP EAX
END;

PROCEDURE TBeRoScript.OutPopBx;
BEGIN
 ByteHinzufuegen($5B); // POP EBX
END;

PROCEDURE TBeRoScript.OutPushCx;
BEGIN
 ByteHinzufuegen($51); // PUSH ECX
END;

PROCEDURE TBeRoScript.OutPushDx;
BEGIN
 ByteHinzufuegen($52); // PUSH EDX
END;

PROCEDURE TBeRoScript.OutPopCx;
BEGIN
 ByteHinzufuegen($59); // POP ECX
END;

PROCEDURE TBeRoScript.OutPopDx;
BEGIN
 ByteHinzufuegen($5A); // POP EDX
END;

PROCEDURE TBeRoScript.OutPushBp;
BEGIN
 ByteHinzufuegen($55); // PUSH EEP
END;

PROCEDURE TBeRoScript.OutPopBp;
BEGIN
 ByteHinzufuegen($5D); // PUSH EEP
END;

PROCEDURE TBeRoScript.OutMulDx;
BEGIN
 ByteHinzufuegen($F7); ByteHinzufuegen($E2); // MUL EDX
END;

PROCEDURE TBeRoScript.OutMulBx;
BEGIN
 ByteHinzufuegen($F7); ByteHinzufuegen($E3); // MUL EBX
END;

PROCEDURE TBeRoScript.OutDivBx;
BEGIN
 ByteHinzufuegen($31); ByteHinzufuegen($D2); // XOR EDX,EDX
 ByteHinzufuegen($F7); ByteHinzufuegen($F3); // DIV EBX
END;

PROCEDURE TBeRoScript.OutModBx;
BEGIN
 ByteHinzufuegen($31); ByteHinzufuegen($D2); // XOR EDX,EDX
 ByteHinzufuegen($F7); ByteHinzufuegen($F3); // DIV EBX
 ByteHinzufuegen($89); ByteHinzufuegen($D0); // MOV EAX,EDX
END;

PROCEDURE TBeRoScript.OutIMulBx;
BEGIN
 ByteHinzufuegen($F7); ByteHinzufuegen($EB); // IMUL EBX
END;

PROCEDURE TBeRoScript.OutIDivBx;
BEGIN
 ByteHinzufuegen($99); // CDQ
 ByteHinzufuegen($F7); ByteHinzufuegen($FB); // IDIV EBX
END;

PROCEDURE TBeRoScript.OutIModBx;
BEGIN
 ByteHinzufuegen($99); // CDQ
 ByteHinzufuegen($F7); ByteHinzufuegen($FB); // IDIV EBX
 ByteHinzufuegen($89); ByteHinzufuegen($D0); // MOV EAX,EDX
END;

PROCEDURE TBeRoScript.OutAndBx;
BEGIN
 ByteHinzufuegen($21); ByteHinzufuegen($D8); // AND EAX,EBX
END;

PROCEDURE TBeRoScript.OutOrBx;
BEGIN
 ByteHinzufuegen($09); ByteHinzufuegen($D8); // OR EAX,EBX
END;

PROCEDURE TBeRoScript.OutShlCx(I:BYTE);
BEGIN
 IF I=1 THEN BEGIN
  ByteHinzufuegen($D1); ByteHinzufuegen($E1); // SHL ECX,1
 END ELSE IF I>1 THEN BEGIN
  ByteHinzufuegen($C1); ByteHinzufuegen($E1); ByteHinzufuegen(I); // SHL ECX,I
 END;
END;

PROCEDURE TBeRoScript.OutShlBx;
BEGIN
 OutPushCx;
 ByteHinzufuegen($89); ByteHinzufuegen($D9); // MOV ECX,EBX
 ByteHinzufuegen($D3); ByteHinzufuegen($E0); // SHL EAX,CL
 OutPopCx;
END;

PROCEDURE TBeRoScript.OutShrBx;
BEGIN
 OutPushCx;
 ByteHinzufuegen($89); ByteHinzufuegen($D9); // MOV ECX,EBX
 ByteHinzufuegen($D3); ByteHinzufuegen($E8); // SHR EAX,CL
 OutPopCx;
END;

PROCEDURE TBeRoScript.OutSalBx;
BEGIN
 OutPushCx;
 ByteHinzufuegen($89); ByteHinzufuegen($D9); // MOV ECX,EBX
 ByteHinzufuegen($D3); ByteHinzufuegen($E0); // SHL EAX,CL (SHL=SAL!)
 OutPopCx;
END;

PROCEDURE TBeRoScript.OutSarBx;
BEGIN
 OutPushCx;
 ByteHinzufuegen($89); ByteHinzufuegen($D9); // MOV ECX,EBX
 ByteHinzufuegen($D3); ByteHinzufuegen($F8); // SAR EAX,CL
 OutPopCx;
END;

PROCEDURE TBeRoScript.OutXorBx;
BEGIN
 ByteHinzufuegen($31); ByteHinzufuegen($D8); // XOR EAX,EBX
END;

PROCEDURE TBeRoScript.OutXorAxAx;
BEGIN
 ByteHinzufuegen($31); ByteHinzufuegen($C0); // XOR EAX,EAX
END;

PROCEDURE TBeRoScript.OutXorBxBx;
BEGIN
 ByteHinzufuegen($31); ByteHinzufuegen($DB); // XOR EBX,EBX
END;

PROCEDURE TBeRoScript.OutXorCxCx;
BEGIN
 ByteHinzufuegen($31); ByteHinzufuegen($C9); // XOR ECX,ECX
END;

PROCEDURE TBeRoScript.OutAddAxBx;
BEGIN
 ByteHinzufuegen($01); ByteHinzufuegen($D8); // ADD EAX,EBX
END;

PROCEDURE TBeRoScript.OutAddAxCx;
BEGIN
 ByteHinzufuegen($01); ByteHinzufuegen($C8); // ADD EAX,ECX
END;

PROCEDURE TBeRoScript.OutAddBxAx;
BEGIN
 ByteHinzufuegen($01); ByteHinzufuegen($C3); // ADD EBX,EAX
END;

PROCEDURE TBeRoScript.OutAddBxCx;
BEGIN
 ByteHinzufuegen($01); ByteHinzufuegen($CB); // ADD EBX,ECX
END;

PROCEDURE TBeRoScript.OutSubAxBx;
BEGIN
 ByteHinzufuegen($29); ByteHinzufuegen($D8); // SUB EAX,EBX
END;

PROCEDURE TBeRoScript.OutMovBxAx;
BEGIN
 ByteHinzufuegen($89); ByteHinzufuegen($C3); // MOV EBX,EAX
END;

PROCEDURE TBeRoScript.OutLeaBxAxPlusOne;
BEGIN
 // LEA EBX,[EAX+1]
 ByteHinzufuegen($8D);
 ByteHinzufuegen($58);
 ByteHinzufuegen($01);
END;

PROCEDURE TBeRoScript.OutMovAxBx;
BEGIN
 ByteHinzufuegen($89); ByteHinzufuegen($D8); // MOV EAX,EBX
END;

PROCEDURE TBeRoScript.OutMovCxAx;
BEGIN
 ByteHinzufuegen($89); ByteHinzufuegen($C1); // MOV ECX,EAX
END;

PROCEDURE TBeRoScript.OutMovCxBx;
BEGIN
 ByteHinzufuegen($89); ByteHinzufuegen($D9); // MOV ECX,EBX
END;

PROCEDURE TBeRoScript.OutMovBxFromBx;
BEGIN
 ByteHinzufuegen($8B); ByteHinzufuegen($1B); // MOV EBX,[EBX]
END;

PROCEDURE TBeRoScript.OutMovCxFromBx;
BEGIN
 ByteHinzufuegen($8B); ByteHinzufuegen($0B); // MOV ECX,[EBX]
END;

PROCEDURE TBeRoScript.OutMovBxCx;
BEGIN
 ByteHinzufuegen($8B); ByteHinzufuegen($D9); // MOV EBX,ECX
END;

PROCEDURE TBeRoScript.OutMovDxImmSigned(S:LONGINT);
BEGIN
 ByteHinzufuegen($BA); DWordHinzufuegen(LONGWORD(S)); // MOV EAX,S
END;

PROCEDURE TBeRoScript.OutMovDxImmUnsigned(S:LONGWORD);
BEGIN
 ByteHinzufuegen($BA); DWordHinzufuegen(S); // MOV EAX,S
END;

PROCEDURE TBeRoScript.OutMovAxImmSigned(S:LONGINT);
BEGIN
 ByteHinzufuegen($B8); DWordHinzufuegen(LONGWORD(S)); // MOV EAX,S
END;

PROCEDURE TBeRoScript.OutMulAxImmSigned(S:LONGINT);
VAR SI:SHORTINT;
    Bit,BitValue:LONGWORD;
    Done:BOOLEAN;
BEGIN
 Done:=FALSE;
 IF S=1 THEN BEGIN
  Done:=TRUE;
 END ELSE IF S=0 THEN BEGIN
  OutXorAxAx;
  Done:=TRUE;
 END ELSE IF (S AND (S-1))=0 THEN BEGIN
  BitValue:=0;
  FOR Bit:=0 TO 31 DO BEGIN
   IF (S AND ((1 SHL (Bit+1))-1))<>0 THEN BEGIN
    BitValue:=Bit;
    BREAK;
   END;
  END;
  IF BitValue=1 THEN BEGIN
   ByteHinzufuegen($D1);
   ByteHinzufuegen($E0);
   Done:=TRUE;
  END ELSE BEGIN
   IF BitValue>0 THEN BEGIN
    ByteHinzufuegen($C1);
    ByteHinzufuegen($E0);
    ByteHinzufuegen(BitValue);
    Done:=TRUE;
   END;
  END;
 END;
 IF NOT Done THEN BEGIN
  IF (S>=-128) AND (S<=127) THEN BEGIN
   ByteHinzufuegen($6B);
   ByteHinzufuegen($C0);
   SI:=S;
   ByteHinzufuegen(BYTE(SI));
  END ELSE BEGIN
   ByteHinzufuegen($69);
   ByteHinzufuegen($C0);
   DWordHinzufuegen(LONGWORD(S));
  END;
 END;
END;

PROCEDURE TBeRoScript.OutMovAxImmUnsigned(S:LONGWORD);
BEGIN
 ByteHinzufuegen($B8); DWordHinzufuegen(S); // MOV EAX,S
END;

PROCEDURE TBeRoScript.OutMovAxImmLabel(S:STRING);
BEGIN
 // MOV EAX,OFFSET S
 ByteHinzufuegen($B8);
 LabelAdresseHinzufuegen(S);
END;

PROCEDURE TBeRoScript.OutMovAxVar32(S:STRING);
BEGIN
 // MOV EAX,[S]
 ByteHinzufuegen($8B);
 ByteHinzufuegen($05);
 LabelAdresseHinzufuegen(S);
END;

PROCEDURE TBeRoScript.OutMovAxVarLabel(S:STRING;Size:BYTE);
BEGIN
 IF (Size=1) OR (Size=2) OR (Size=4) THEN BEGIN
  IF Size=1 THEN BEGIN
   ByteHinzufuegen($A0);
  END ELSE IF (Size=2) OR (Size=4) THEN BEGIN
   IF Size=2 THEN ByteHinzufuegen($66);
   ByteHinzufuegen($8B);
   ByteHinzufuegen($05);
  END;
  LabelAdresseHinzufuegen(S);
 END;
END;

PROCEDURE TBeRoScript.OutMovsxAxVarLabel(S:STRING;Size:BYTE);
BEGIN
 IF Size=4 THEN BEGIN
  OutMovAxVarLabel(S,Size);
 END ELSE IF (Size=1) OR (Size=2) THEN BEGIN
  ByteHinzufuegen($0F);
  IF Size=1 THEN BEGIN
   ByteHinzufuegen($BE);
  END ELSE IF Size=2 THEN BEGIN
   ByteHinzufuegen($BF);
  END;
  ByteHinzufuegen($05);
  LabelAdresseHinzufuegen(S);
 END;
END;

PROCEDURE TBeRoScript.OutMovAxVarEBXLabel(S:STRING;Size:BYTE);
BEGIN
 IF (Size=1) OR (Size=2) OR (Size=4) THEN BEGIN
  IF Size=1 THEN BEGIN
   ByteHinzufuegen($8A);
  END ELSE IF (Size=2) OR (Size=4) THEN BEGIN
   IF Size=2 THEN ByteHinzufuegen($66);
   ByteHinzufuegen($8B);
  END;
  ByteHinzufuegen($83);
  LabelAdresseHinzufuegen(S);
 END;
END;

PROCEDURE TBeRoScript.OutMovsxAxVarEBXLabel(S:STRING;Size:BYTE);
BEGIN
 IF Size=4 THEN BEGIN
  OutMovAxVarEBXLabel(S,Size);
 END ELSE IF (Size=1) OR (Size=2) THEN BEGIN
  ByteHinzufuegen($0F);
  IF Size=1 THEN BEGIN
   ByteHinzufuegen($BE);
  END ELSE IF Size=2 THEN BEGIN
   ByteHinzufuegen($BF);
  END;
  ByteHinzufuegen($83);
  LabelAdresseHinzufuegen(S);
 END;
END;

PROCEDURE TBeRoScript.OutMovESPAx(Offset:INTEGER;Size:BYTE);
VAR SI:SHORTINT;
BEGIN
 IF (Size=1) OR (Size=2) OR (Size=4) THEN BEGIN
  IF Offset=0 THEN BEGIN
   IF Size=1 THEN BEGIN
    ByteHinzufuegen($88);
   END ELSE IF (Size=2) OR (Size=4) THEN BEGIN
    IF Size=2 THEN ByteHinzufuegen($66);
    ByteHinzufuegen($89);
   END;
   ByteHinzufuegen($04);
   ByteHinzufuegen($24);
  END ELSE IF (Offset>=-128) AND (Offset<=127) THEN BEGIN
   IF Size=1 THEN BEGIN
    ByteHinzufuegen($88);
   END ELSE IF (Size=2) OR (Size=4) THEN BEGIN
    IF Size=2 THEN ByteHinzufuegen($66);
    ByteHinzufuegen($89);
   END;
   ByteHinzufuegen($44);
   ByteHinzufuegen($24);
   SI:=Offset;
   ByteHinzufuegen(BYTE(SI));
  END ELSE BEGIN
   IF Size=1 THEN BEGIN
    ByteHinzufuegen($88);
    ByteHinzufuegen($84);
   END ELSE IF (Size=2) OR (Size=4) THEN BEGIN
    IF Size=2 THEN ByteHinzufuegen($66);
    ByteHinzufuegen($89);
    ByteHinzufuegen($84);
   END;
   ByteHinzufuegen($24);
   DWordHinzufuegen(LONGWORD(Offset));
  END;
 END;
END;

PROCEDURE TBeRoScript.OutMovAxVarEBP(Offset:INTEGER;Size:BYTE);
VAR SI:SHORTINT;
BEGIN
 IF (Size=1) OR (Size=2) OR (Size=4) THEN BEGIN
  IF (Offset>=-128) AND (Offset<=127) THEN BEGIN
   IF Size=1 THEN BEGIN
    ByteHinzufuegen($8A);
   END ELSE IF (Size=2) OR (Size=4) THEN BEGIN
    IF Size=2 THEN ByteHinzufuegen($66);
    ByteHinzufuegen($8B);
   END;
   ByteHinzufuegen($45);
   SI:=Offset;
   ByteHinzufuegen(BYTE(SI));
  END ELSE BEGIN
   IF Size=1 THEN BEGIN
    ByteHinzufuegen($8A);
   END ELSE IF (Size=2) OR (Size=4) THEN BEGIN
    IF Size=2 THEN ByteHinzufuegen($66);
    ByteHinzufuegen($8B);
   END;
   ByteHinzufuegen($85);
   DWordHinzufuegen(LONGWORD(Offset));
  END;
 END;
END;

PROCEDURE TBeRoScript.OutMovsxAxVarEBP(Offset:INTEGER;Size:BYTE);
VAR SI:SHORTINT;
BEGIN
 IF Size=4 THEN BEGIN
  OutMovAxVarEBP(Offset,Size);
 END ELSE IF (Size=1) OR (Size=2) THEN BEGIN
  IF (Offset>=-128) AND (Offset<=127) THEN BEGIN
   ByteHinzufuegen($0F);
   IF Size=1 THEN BEGIN
   ByteHinzufuegen($BE);
   END ELSE IF Size=2 THEN BEGIN
    ByteHinzufuegen($BF);
   END;
   ByteHinzufuegen($45);
   SI:=Offset;
   ByteHinzufuegen(BYTE(SI));
  END ELSE BEGIN
   ByteHinzufuegen($0F);
   IF Size=1 THEN BEGIN
   ByteHinzufuegen($BE);
   END ELSE IF Size=2 THEN BEGIN
    ByteHinzufuegen($BF);
   END;
   ByteHinzufuegen($85);
   DWordHinzufuegen(LONGWORD(Offset));
  END;
 END;
END;

PROCEDURE TBeRoScript.OutMovAxVarEBX(Offset:INTEGER;Size:BYTE);
VAR SI:SHORTINT;
BEGIN
 IF (Size=1) OR (Size=2) OR (Size=4) THEN BEGIN
  IF Offset=0 THEN BEGIN
   IF Size=1 THEN BEGIN
    ByteHinzufuegen($8A);
   END ELSE IF (Size=2) OR (Size=4) THEN BEGIN
    IF Size=2 THEN ByteHinzufuegen($66);
    ByteHinzufuegen($8B);
   END;
   ByteHinzufuegen($03);
  END ELSE IF (Offset>=-128) AND (Offset<=127) THEN BEGIN
   IF Size=1 THEN BEGIN
    ByteHinzufuegen($8A);
   END ELSE IF (Size=2) OR (Size=4) THEN BEGIN
    IF Size=2 THEN ByteHinzufuegen($66);
    ByteHinzufuegen($8B);
   END;
   ByteHinzufuegen($43);
   SI:=Offset;
   ByteHinzufuegen(BYTE(SI));
  END ELSE BEGIN
   IF Size=1 THEN BEGIN
    ByteHinzufuegen($8A);
   END ELSE IF (Size=2) OR (Size=4) THEN BEGIN
    IF Size=2 THEN ByteHinzufuegen($66);
    ByteHinzufuegen($8B);
   END;
   ByteHinzufuegen($83);
   DWordHinzufuegen(LONGWORD(Offset));
  END;
 END;
END;

PROCEDURE TBeRoScript.OutMovsxAxVarEBX(Offset:INTEGER;Size:BYTE);
VAR SI:SHORTINT;
BEGIN
 IF Size=4 THEN BEGIN
  OutMovAxVarEBX(Offset,Size);
 END ELSE IF (Size=1) OR (Size=2) THEN BEGIN
  IF Offset=0 THEN BEGIN
   ByteHinzufuegen($0F);
   IF Size=1 THEN BEGIN
    ByteHinzufuegen($BE);
   END ELSE IF Size=2 THEN BEGIN
    ByteHinzufuegen($BF);
   END;
   ByteHinzufuegen($03);
  END ELSE IF (Offset>=-128) AND (Offset<=127) THEN BEGIN
   ByteHinzufuegen($0F);
   IF Size=1 THEN BEGIN
    ByteHinzufuegen($BE);
   END ELSE IF Size=2 THEN BEGIN
    ByteHinzufuegen($BF);
   END;
   ByteHinzufuegen($43);
   SI:=Offset;
   ByteHinzufuegen(BYTE(SI));
  END ELSE BEGIN
   ByteHinzufuegen($0F);
   IF Size=1 THEN BEGIN
    ByteHinzufuegen($BE);
   END ELSE IF Size=2 THEN BEGIN
    ByteHinzufuegen($BF);
   END;
   ByteHinzufuegen($83);
   DWordHinzufuegen(LONGWORD(Offset));
  END;
 END;
END;

PROCEDURE TBeRoScript.OutMovBxVarLabel(S:STRING;Size:BYTE);
BEGIN
 IF (Size=1) OR (Size=2) OR (Size=4) THEN BEGIN
  IF Size=1 THEN BEGIN
   ByteHinzufuegen($8A);
   ByteHinzufuegen($1D);
  END ELSE IF (Size=2) OR (Size=4) THEN BEGIN
   IF Size=2 THEN ByteHinzufuegen($66);
   ByteHinzufuegen($8B);
   ByteHinzufuegen($1D);
  END;
  LabelAdresseHinzufuegen(S);
 END;
END;

PROCEDURE TBeRoScript.OutMovBxVarEBP(Offset:INTEGER;Size:BYTE);
VAR SI:SHORTINT;
BEGIN
 IF (Size=1) OR (Size=2) OR (Size=4) THEN BEGIN
  IF (Offset>=-128) AND (Offset<=127) THEN BEGIN
   IF Size=1 THEN BEGIN
    ByteHinzufuegen($8A);
    ByteHinzufuegen($5D);
   END ELSE IF (Size=2) OR (Size=4) THEN BEGIN
    IF Size=2 THEN ByteHinzufuegen($66);
    ByteHinzufuegen($8B);
    ByteHinzufuegen($5D);
   END;
   SI:=Offset;
   ByteHinzufuegen(BYTE(SI));
  END ELSE BEGIN
   IF Size=1 THEN BEGIN
    ByteHinzufuegen($8A);
    ByteHinzufuegen($9D);
   END ELSE IF (Size=2) OR (Size=4) THEN BEGIN
    IF Size=2 THEN ByteHinzufuegen($66);
    ByteHinzufuegen($8B);
    ByteHinzufuegen($9D);
   END;
   DWordHinzufuegen(LONGWORD(Offset));
  END;
 END;
END;

PROCEDURE TBeRoScript.OutMovCxVarEBP(Offset:INTEGER;Size:BYTE);
VAR SI:SHORTINT;
BEGIN
 IF (Size=1) OR (Size=2) OR (Size=4) THEN BEGIN
  IF (Offset>=-128) AND (Offset<=127) THEN BEGIN
   IF Size=1 THEN BEGIN
    ByteHinzufuegen($8A);
    ByteHinzufuegen($4D);
   END ELSE IF (Size=2) OR (Size=4) THEN BEGIN
    IF Size=2 THEN ByteHinzufuegen($66);
    ByteHinzufuegen($8B);
    ByteHinzufuegen($4D);
   END;
   SI:=Offset;
   ByteHinzufuegen(BYTE(SI));
  END ELSE BEGIN
   IF Size=1 THEN BEGIN
    ByteHinzufuegen($8A);
    ByteHinzufuegen($8D);
   END ELSE IF (Size=2) OR (Size=4) THEN BEGIN
    IF Size=2 THEN ByteHinzufuegen($66);
    ByteHinzufuegen($8B);
    ByteHinzufuegen($8D);
   END;
   DWordHinzufuegen(LONGWORD(Offset));
  END;
 END;
END;

PROCEDURE TBeRoScript.OutMovVarLabelAx(S:STRING;Size:BYTE);
BEGIN
 IF (Size=1) OR (Size=2) OR (Size=4) THEN BEGIN
  IF Size=1 THEN BEGIN
   ByteHinzufuegen($A2);
  END ELSE IF (Size=2) OR (Size=4) THEN BEGIN
   IF Size=2 THEN ByteHinzufuegen($66);
   ByteHinzufuegen($89);
   ByteHinzufuegen($05);
  END;
  LabelAdresseHinzufuegen(S);
 END;
END;

PROCEDURE TBeRoScript.OutMovVarEBPAx(Offset:INTEGER;Size:BYTE);
VAR SI:SHORTINT;
BEGIN
 IF (Size=1) OR (Size=2) OR (Size=4) THEN BEGIN
  IF (Offset>=-128) AND (Offset<=127) THEN BEGIN
   IF Size=1 THEN BEGIN
    ByteHinzufuegen($88);
    ByteHinzufuegen($45);
   END ELSE IF (Size=2) OR (Size=4) THEN BEGIN
    IF Size=2 THEN ByteHinzufuegen($66);
    ByteHinzufuegen($89);
    ByteHinzufuegen($45);
   END;
   SI:=Offset;
   ByteHinzufuegen(BYTE(SI));
  END ELSE BEGIN
   IF Size=1 THEN BEGIN
    ByteHinzufuegen($88);
    ByteHinzufuegen($85);
   END ELSE IF (Size=2) OR (Size=4) THEN BEGIN
    IF Size=2 THEN ByteHinzufuegen($66);
    ByteHinzufuegen($89);
    ByteHinzufuegen($85);
   END;
   DWordHinzufuegen(LONGWORD(Offset));
  END;
 END;
END;

PROCEDURE TBeRoScript.OutMovVarEBXAX(Offset:INTEGER;Size:BYTE);
VAR SI:SHORTINT;
BEGIN
 IF (Size=1) OR (Size=2) OR (Size=4) THEN BEGIN
  IF Offset=0 THEN BEGIN
   IF Size=1 THEN BEGIN
    ByteHinzufuegen($88);
    ByteHinzufuegen($03);
   END ELSE IF (Size=2) OR (Size=4) THEN BEGIN
    IF Size=2 THEN ByteHinzufuegen($66);
    ByteHinzufuegen($89);
    ByteHinzufuegen($03);
   END;
  END ELSE IF (Offset>=-128) AND (Offset<=127) THEN BEGIN
   IF Size=1 THEN BEGIN
    ByteHinzufuegen($88);
    ByteHinzufuegen($43);
   END ELSE IF (Size=2) OR (Size=4) THEN BEGIN
    IF Size=2 THEN ByteHinzufuegen($66);
    ByteHinzufuegen($89);
    ByteHinzufuegen($43);
   END;
   SI:=Offset;
   ByteHinzufuegen(BYTE(SI));
  END ELSE BEGIN
   IF Size=1 THEN BEGIN
    ByteHinzufuegen($88);
    ByteHinzufuegen($83);
   END ELSE IF (Size=2) OR (Size=4) THEN BEGIN
    IF Size=2 THEN ByteHinzufuegen($66);
    ByteHinzufuegen($89);
    ByteHinzufuegen($83);
   END;
   DWordHinzufuegen(LONGWORD(Offset));
  END;
 END;
END;

PROCEDURE TBeRoScript.OutMovVarEBXLabelAx(S:STRING;Size:BYTE);
BEGIN
 IF (Size=1) OR (Size=2) OR (Size=4) THEN BEGIN
  IF Size=1 THEN BEGIN
   ByteHinzufuegen($88);
   ByteHinzufuegen($83);
  END ELSE IF (Size=2) OR (Size=4) THEN BEGIN
   IF Size=2 THEN ByteHinzufuegen($66);
   ByteHinzufuegen($89);
   ByteHinzufuegen($83);
  END;
  LabelAdresseHinzufuegen(S);
 END;
END;

PROCEDURE TBeRoScript.OutIncVarEBX(Offset:INTEGER;Size:BYTE);
VAR SI:SHORTINT;
BEGIN
 IF (Size=1) OR (Size=2) OR (Size=4) THEN BEGIN
  IF Offset=0 THEN BEGIN
   IF Size=1 THEN BEGIN
    ByteHinzufuegen($FE);
    ByteHinzufuegen($03);
   END ELSE IF (Size=2) OR (Size=4) THEN BEGIN
    IF Size=2 THEN ByteHinzufuegen($66);
    ByteHinzufuegen($FF);
    ByteHinzufuegen($03);
   END;
  END ELSE IF (Offset>=-128) AND (Offset<=127) THEN BEGIN
   IF Size=1 THEN BEGIN
    ByteHinzufuegen($FE);
    ByteHinzufuegen($43);
   END ELSE IF (Size=2) OR (Size=4) THEN BEGIN
    IF Size=2 THEN ByteHinzufuegen($66);
    ByteHinzufuegen($FF);
    ByteHinzufuegen($43);
   END;
   SI:=Offset;
   ByteHinzufuegen(BYTE(SI));
  END ELSE BEGIN
   IF Size=1 THEN BEGIN
    ByteHinzufuegen($FE);
    ByteHinzufuegen($83);
   END ELSE IF (Size=2) OR (Size=4) THEN BEGIN
    IF Size=2 THEN ByteHinzufuegen($66);
    ByteHinzufuegen($FF);
    ByteHinzufuegen($83);
   END;
   DWordHinzufuegen(LONGWORD(Offset));
  END;
 END;
END;

PROCEDURE TBeRoScript.OutDecVarEBX(Offset:INTEGER;Size:BYTE);
VAR SI:SHORTINT;
BEGIN
 IF (Size=1) OR (Size=2) OR (Size=4) THEN BEGIN
  IF Offset=0 THEN BEGIN
   IF Size=1 THEN BEGIN
    ByteHinzufuegen($FE);
    ByteHinzufuegen($0B);
   END ELSE IF (Size=2) OR (Size=4) THEN BEGIN
    IF Size=2 THEN ByteHinzufuegen($66);
    ByteHinzufuegen($FF);
    ByteHinzufuegen($0B);
   END;
  END ELSE IF (Offset>=-128) AND (Offset<=127) THEN BEGIN
   IF Size=1 THEN BEGIN
    ByteHinzufuegen($FE);
    ByteHinzufuegen($4B);
   END ELSE IF (Size=2) OR (Size=4) THEN BEGIN
    IF Size=2 THEN ByteHinzufuegen($66);
    ByteHinzufuegen($FF);
    ByteHinzufuegen($4B);
   END;
   SI:=Offset;
   ByteHinzufuegen(BYTE(SI));
  END ELSE BEGIN
   IF Size=1 THEN BEGIN
    ByteHinzufuegen($FE);
    ByteHinzufuegen($8B);
   END ELSE IF (Size=2) OR (Size=4) THEN BEGIN
    IF Size=2 THEN ByteHinzufuegen($66);
    ByteHinzufuegen($FF);
    ByteHinzufuegen($8B);
   END;
   DWordHinzufuegen(LONGWORD(Offset));
  END;
 END;
END;

PROCEDURE TBeRoScript.OutIncVarEBP(Offset:INTEGER;Size:BYTE);
VAR SI:SHORTINT;
BEGIN
 IF (Size=1) OR (Size=2) OR (Size=4) THEN BEGIN
  IF (Offset>=-128) AND (Offset<=127) THEN BEGIN
   IF Size=1 THEN BEGIN
    ByteHinzufuegen($FE);
    ByteHinzufuegen($45);
   END ELSE IF (Size=2) OR (Size=4) THEN BEGIN
    IF Size=2 THEN ByteHinzufuegen($66);
    ByteHinzufuegen($FF);
    ByteHinzufuegen($45);
   END;
   SI:=Offset;
   ByteHinzufuegen(BYTE(SI));
  END ELSE BEGIN
   IF Size=1 THEN BEGIN
    ByteHinzufuegen($FE);
    ByteHinzufuegen($85);
   END ELSE IF (Size=2) OR (Size=4) THEN BEGIN
    IF Size=2 THEN ByteHinzufuegen($66);
    ByteHinzufuegen($FF);
    ByteHinzufuegen($85);
   END;
   DWordHinzufuegen(LONGWORD(Offset));
  END;
 END;
END;

PROCEDURE TBeRoScript.OutDecVarEBP(Offset:INTEGER;Size:BYTE);
VAR SI:SHORTINT;
BEGIN
 IF (Size=1) OR (Size=2) OR (Size=4) THEN BEGIN
  IF (Offset>=-128) AND (Offset<=127) THEN BEGIN
   IF Size=1 THEN BEGIN
    ByteHinzufuegen($FE);
    ByteHinzufuegen($4D);
   END ELSE IF (Size=2) OR (Size=4) THEN BEGIN
    IF Size=2 THEN ByteHinzufuegen($66);
    ByteHinzufuegen($FF);
    ByteHinzufuegen($4D);
   END;
   SI:=Offset;
   ByteHinzufuegen(BYTE(SI));
  END ELSE BEGIN
   IF Size=1 THEN BEGIN
    ByteHinzufuegen($FE);
    ByteHinzufuegen($8D);
   END ELSE IF (Size=2) OR (Size=4) THEN BEGIN
    IF Size=2 THEN ByteHinzufuegen($66);
    ByteHinzufuegen($FF);
    ByteHinzufuegen($8D);
   END;
   DWordHinzufuegen(LONGWORD(Offset));
  END;
 END;
END;

PROCEDURE TBeRoScript.OutIncVarLabel(S:STRING;Size:BYTE);
BEGIN
 IF (Size=1) OR (Size=2) OR (Size=4) THEN BEGIN
  IF Size=1 THEN BEGIN
   ByteHinzufuegen($FE);
   ByteHinzufuegen($05);
  END ELSE IF (Size=2) OR (Size=4) THEN BEGIN
   IF Size=2 THEN ByteHinzufuegen($66);
   ByteHinzufuegen($FF);
   ByteHinzufuegen($05);
  END;
  LabelAdresseHinzufuegen(S);
 END;
END;

PROCEDURE TBeRoScript.OutDecVarLabel(S:STRING;Size:BYTE);
BEGIN
 IF (Size=1) OR (Size=2) OR (Size=4) THEN BEGIN
  IF Size=1 THEN BEGIN
   ByteHinzufuegen($FE);
   ByteHinzufuegen($0D);
  END ELSE IF (Size=2) OR (Size=4) THEN BEGIN
   IF Size=2 THEN ByteHinzufuegen($66);
   ByteHinzufuegen($FF);
   ByteHinzufuegen($0D);
  END;
  LabelAdresseHinzufuegen(S);
 END;
END;

PROCEDURE TBeRoScript.OutIncVarLabelEBX(S:STRING;Size:BYTE);
BEGIN
 IF (Size=1) OR (Size=2) OR (Size=4) THEN BEGIN
  IF Size=1 THEN BEGIN
   ByteHinzufuegen($FE);
   ByteHinzufuegen($83);
  END ELSE IF (Size=2) OR (Size=4) THEN BEGIN
   IF Size=2 THEN ByteHinzufuegen($66);
   ByteHinzufuegen($FF);
   ByteHinzufuegen($83);
  END;
  LabelAdresseHinzufuegen(S);
 END;
END;

PROCEDURE TBeRoScript.OutDecVarLabelEBX(S:STRING;Size:BYTE);
BEGIN
 IF (Size=1) OR (Size=2) OR (Size=4) THEN BEGIN
  IF Size=1 THEN BEGIN
   ByteHinzufuegen($FE);
   ByteHinzufuegen($8B);
  END ELSE IF (Size=2) OR (Size=4) THEN BEGIN
   IF Size=2 THEN ByteHinzufuegen($66);
   ByteHinzufuegen($FF);
   ByteHinzufuegen($8B);
  END;
  LabelAdresseHinzufuegen(S);
 END;
END;

PROCEDURE TBeRoScript.OutAddVarLabel(S:STRING;Size:BYTE;Value:LONGWORD);
BEGIN
 IF (Size=1) OR (Size=2) OR (Size=4) THEN BEGIN
  IF Value<=$FF THEN BEGIN
   IF Size=1 THEN BEGIN
    ByteHinzufuegen($80);
    ByteHinzufuegen($05);
   END ELSE IF (Size=2) OR (Size=4) THEN BEGIN
    IF Size=2 THEN ByteHinzufuegen($66);
    ByteHinzufuegen($83);
    ByteHinzufuegen($05);
   END;
   LabelAdresseHinzufuegen(S);
   ByteHinzufuegen(Value);
  END ELSE BEGIN
   IF Size=1 THEN BEGIN
    ByteHinzufuegen($80);
    ByteHinzufuegen($05);
    ByteHinzufuegen(Value AND $FF);
   END ELSE IF (Size=2) OR (Size=4) THEN BEGIN
    IF Size=2 THEN ByteHinzufuegen($66);
    ByteHinzufuegen($81);
    ByteHinzufuegen($05);
    LabelAdresseHinzufuegen(S);
    IF Size=2 THEN BEGIN
     WordHinzufuegen(Value AND $FFFF);
    END ELSE IF Size=4 THEN BEGIN
     DWordHinzufuegen(Value);
    END;
   END;
  END;
 END;
END;

PROCEDURE TBeRoScript.OutSubVarLabel(S:STRING;Size:BYTE;Value:LONGWORD);
BEGIN
 IF (Size=1) OR (Size=2) OR (Size=4) THEN BEGIN
  IF Value<=$FF THEN BEGIN
   IF Size=1 THEN BEGIN
    ByteHinzufuegen($80);
    ByteHinzufuegen($2D);
   END ELSE IF (Size=2) OR (Size=4) THEN BEGIN
    IF Size=2 THEN ByteHinzufuegen($66);
    ByteHinzufuegen($83);
    ByteHinzufuegen($2D);
   END;
   LabelAdresseHinzufuegen(S);
   ByteHinzufuegen(Value);
  END ELSE BEGIN
   IF Size=1 THEN BEGIN
    ByteHinzufuegen($80);
    ByteHinzufuegen($2D);
    ByteHinzufuegen(Value AND $FF);
   END ELSE IF (Size=2) OR (Size=4) THEN BEGIN
    IF Size=2 THEN ByteHinzufuegen($66);
    ByteHinzufuegen($81);
    ByteHinzufuegen($2D);
    LabelAdresseHinzufuegen(S);
    IF Size=2 THEN BEGIN
     WordHinzufuegen(Value AND $FFFF);
    END ELSE IF Size=4 THEN BEGIN
     DWordHinzufuegen(Value);
    END;
   END;
  END;
 END;
END;

PROCEDURE TBeRoScript.OutAddVarEBP(Offset:INTEGER;Size:BYTE;Value:LONGWORD);
VAR SI:SHORTINT;
BEGIN
 IF (Size=1) OR (Size=2) OR (Size=4) THEN BEGIN
  IF Value<=$FF THEN BEGIN
   IF (Offset>=-128) AND (Offset<=127) THEN BEGIN
    IF Size=1 THEN BEGIN
     ByteHinzufuegen($80);
     ByteHinzufuegen($45);
    END ELSE IF (Size=2) OR (Size=4) THEN BEGIN
     IF Size=2 THEN ByteHinzufuegen($66);
     ByteHinzufuegen($83);
     ByteHinzufuegen($45);
    END;
   END ELSE BEGIN
    IF Size=1 THEN BEGIN
     ByteHinzufuegen($80);
     ByteHinzufuegen($85);
    END ELSE IF (Size=2) OR (Size=4) THEN BEGIN
     IF Size=2 THEN ByteHinzufuegen($66);
     ByteHinzufuegen($83);
     ByteHinzufuegen($85);
    END;
   END;
  END ELSE BEGIN
   IF (Offset>=-128) AND (Offset<=127) THEN BEGIN
    IF Size=1 THEN BEGIN
     ByteHinzufuegen($80);
     ByteHinzufuegen($45);
    END ELSE IF (Size=2) OR (Size=4) THEN BEGIN
     IF Size=2 THEN ByteHinzufuegen($66);
     ByteHinzufuegen($81);
     ByteHinzufuegen($45);
    END;
   END ELSE BEGIN
    IF Size=1 THEN BEGIN
     ByteHinzufuegen($80);
     ByteHinzufuegen($45);
    END ELSE IF (Size=2) OR (Size=4) THEN BEGIN
     IF Size=2 THEN ByteHinzufuegen($66);
     ByteHinzufuegen($81);
     ByteHinzufuegen($85);
    END;
   END;
  END;
  IF (Offset>=-128) AND (Offset<=127) THEN BEGIN
   SI:=Offset;
   ByteHinzufuegen(BYTE(SI));
  END ELSE BEGIN
   DWordHinzufuegen(LONGWORD(Offset));
  END;
  IF Value<=$FF THEN BEGIN
   ByteHinzufuegen(Value);
  END ELSE BEGIN
   IF Size=1 THEN BEGIN
    ByteHinzufuegen(Value AND $FF);
   END ELSE IF Size=2 THEN BEGIN
    WordHinzufuegen(Value AND $FFFF);
   END ELSE IF Size=4 THEN BEGIN
    DWordHinzufuegen(Value);
   END;
  END;
 END;
END;

PROCEDURE TBeRoScript.OutSubVarEBP(Offset:INTEGER;Size:BYTE;Value:LONGWORD);
VAR SI:SHORTINT;
BEGIN
 IF (Size=1) OR (Size=2) OR (Size=4) THEN BEGIN
  IF Value<=$FF THEN BEGIN
   IF (Offset>=-128) AND (Offset<=127) THEN BEGIN
    IF Size=1 THEN BEGIN
     ByteHinzufuegen($80);
     ByteHinzufuegen($6D);
    END ELSE IF (Size=2) OR (Size=4) THEN BEGIN
     IF Size=2 THEN ByteHinzufuegen($66);
     ByteHinzufuegen($83);
     ByteHinzufuegen($6D);
    END;
   END ELSE BEGIN
    IF Size=1 THEN BEGIN
     ByteHinzufuegen($80);
     ByteHinzufuegen($AD);
    END ELSE IF (Size=2) OR (Size=4) THEN BEGIN
     IF Size=2 THEN ByteHinzufuegen($66);
     ByteHinzufuegen($83);
     ByteHinzufuegen($AD);
    END;
   END;
  END ELSE BEGIN
   IF (Offset>=-128) AND (Offset<=127) THEN BEGIN
    IF Size=1 THEN BEGIN
     ByteHinzufuegen($80);
     ByteHinzufuegen($6D);
    END ELSE IF (Size=2) OR (Size=4) THEN BEGIN
     IF Size=2 THEN ByteHinzufuegen($66);
     ByteHinzufuegen($81);
     ByteHinzufuegen($6D);
    END;
   END ELSE BEGIN
    IF Size=1 THEN BEGIN
     ByteHinzufuegen($80);
     ByteHinzufuegen($AD);
    END ELSE IF (Size=2) OR (Size=4) THEN BEGIN
     IF Size=2 THEN ByteHinzufuegen($66);
     ByteHinzufuegen($81);
     ByteHinzufuegen($AD);
    END;
   END;
  END;
  IF (Offset>=-128) AND (Offset<=127) THEN BEGIN
   SI:=Offset;
   ByteHinzufuegen(BYTE(SI));
  END ELSE BEGIN
   DWordHinzufuegen(LONGWORD(Offset));
  END;
  IF Value<=$FF THEN BEGIN
   ByteHinzufuegen(Value);
  END ELSE BEGIN
   IF Size=1 THEN BEGIN
    ByteHinzufuegen(Value AND $FF);
   END ELSE IF Size=2 THEN BEGIN
    WordHinzufuegen(Value AND $FFFF);
   END ELSE IF Size=4 THEN BEGIN
    DWordHinzufuegen(Value);
   END;
  END;
 END;
END;

PROCEDURE TBeRoScript.OutMovEAXEBP;
BEGIN
 ByteHinzufuegen($89); ByteHinzufuegen($E8); // MOV EAX,EBP
END;

PROCEDURE TBeRoScript.OutLeaEAXEBP(Offset:INTEGER);
VAR SI:SHORTINT;
BEGIN
 ByteHinzufuegen($8D);
 IF (Offset>=-128) AND (Offset<=127) THEN BEGIN
  ByteHinzufuegen($45);
  SI:=Offset;
  ByteHinzufuegen(BYTE(SI));
 END ELSE BEGIN
  ByteHinzufuegen($85);
  DWordHinzufuegen(LONGWORD(Offset));
 END;
END;

PROCEDURE TBeRoScript.OutLeaEAXEBPECX(Offset:INTEGER;Size:BYTE);
VAR SI:SHORTINT;
BEGIN
 ByteHinzufuegen($8D);
 IF (Offset>=-128) AND (Offset<=127) THEN BEGIN
  ByteHinzufuegen($44);
 END ELSE BEGIN
  ByteHinzufuegen($84);
 END;
 CASE Size OF
  1:ByteHinzufuegen($0D);
  2:ByteHinzufuegen($4D);
  4:ByteHinzufuegen($8D);
  8:ByteHinzufuegen($CD);
 END;
 IF (Offset>=-128) AND (Offset<=127) THEN BEGIN
  SI:=Offset;
  ByteHinzufuegen(BYTE(SI));
 END ELSE BEGIN
  DWordHinzufuegen(LONGWORD(Offset));
 END;
END;

PROCEDURE TBeRoScript.OutLeaEAXImmLabelECX(S:STRING;Size:BYTE);
BEGIN
 ByteHinzufuegen($8D);
 IF Size=1 THEN BEGIN
  ByteHinzufuegen($81);
 END ELSE BEGIN
  ByteHinzufuegen($04);
  CASE Size OF
   1:ByteHinzufuegen($0D);
   2:ByteHinzufuegen($4D);
   4:ByteHinzufuegen($8D);
   8:ByteHinzufuegen($CD);
  END;
 END;
 LabelAdresseHinzufuegen(S);
END;

PROCEDURE TBeRoScript.OutLeaEAXEBPEBX(Offset:INTEGER;Size:BYTE);
VAR SI:SHORTINT;
BEGIN
 ByteHinzufuegen($8D);
 IF (Offset>=-128) AND (Offset<=127) THEN BEGIN
  ByteHinzufuegen($44);
 END ELSE BEGIN
  ByteHinzufuegen($84);
 END;
 CASE Size OF
  1:ByteHinzufuegen($1D);
  2:ByteHinzufuegen($5D);
  4:ByteHinzufuegen($9D);
  8:ByteHinzufuegen($DD);
 END;
 IF (Offset>=-128) AND (Offset<=127) THEN BEGIN
  SI:=Offset;
  ByteHinzufuegen(BYTE(SI));
 END ELSE BEGIN
  DWordHinzufuegen(LONGWORD(Offset));
 END;
END;

PROCEDURE TBeRoScript.OutLeaEAXImmLabelEBX(S:STRING;Size:BYTE);
BEGIN
 ByteHinzufuegen($8D);
 IF Size=1 THEN BEGIN
  ByteHinzufuegen($83);
 END ELSE BEGIN
  ByteHinzufuegen($04);
  CASE Size OF
   1:ByteHinzufuegen($1D);
   2:ByteHinzufuegen($5D);
   4:ByteHinzufuegen($9D);
   8:ByteHinzufuegen($DD);
  END;
 END;
 LabelAdresseHinzufuegen(S);
END;

PROCEDURE TBeRoScript.OutLeaEBXEBP(Offset:INTEGER);
VAR SI:SHORTINT;
BEGIN
 ByteHinzufuegen($8D);
 IF (Offset>=-128) AND (Offset<=127) THEN BEGIN
  ByteHinzufuegen($5D);
  SI:=Offset;
  ByteHinzufuegen(BYTE(SI));
 END ELSE BEGIN
  ByteHinzufuegen($9D);
  DWordHinzufuegen(LONGWORD(Offset));
 END;
END;

PROCEDURE TBeRoScript.OutSubESP(I:LONGWORD);
BEGIN
 ByteHinzufuegen($81); ByteHinzufuegen($EC); // SUB ESP,I
 DWordHinzufuegen(I);
END;

PROCEDURE TBeRoScript.OutAddESP(I:LONGWORD);
BEGIN
 IF I<>0 THEN BEGIN
  ByteHinzufuegen($81); ByteHinzufuegen($C4); // ADD ESP,I
  DWordHinzufuegen(I);
 END
END;

PROCEDURE TBeRoScript.OutSubEAX(I:LONGWORD);
BEGIN
 IF I<>0 THEN BEGIN
  IF I<=$FF THEN BEGIN
   ByteHinzufuegen($83);
   ByteHinzufuegen($E8);
   ByteHinzufuegen(I);
  END ELSE BEGIN
   ByteHinzufuegen($2D);
   DWordHinzufuegen(I);
  END;
 END;
END;

PROCEDURE TBeRoScript.OutAddEAX(I:LONGWORD);
BEGIN
 IF I<>0 THEN BEGIN
  IF I<=$FF THEN BEGIN
   ByteHinzufuegen($83);
   ByteHinzufuegen($C0);
   ByteHinzufuegen(I);
  END ELSE BEGIN
   ByteHinzufuegen($05);
   DWordHinzufuegen(I);
  END;
 END;
END;

PROCEDURE TBeRoScript.OutMovBxImmSigned(S:LONGINT);
BEGIN
 ByteHinzufuegen($BB); DWordHinzufuegen(LONGWORD(S)); // MOV EBX,S
END;

PROCEDURE TBeRoScript.OutMovBxImmUnsigned(S:LONGWORD);
BEGIN
 ByteHinzufuegen($BB); DWordHinzufuegen(S); // MOV EBX,S
END;

PROCEDURE TBeRoScript.OutMovBxImmLabel(S:STRING);
BEGIN
 // MOV EBX,OFFSET S
 ByteHinzufuegen($BB);
 LabelAdresseHinzufuegen(S);
END;

PROCEDURE TBeRoScript.OutMovBxImmLabelOffset(S:STRING;Offset:INTEGER);
BEGIN
 // MOV EBX,OFFSET S+Offset
 ByteHinzufuegen($BB);
 LabelAdresseOffsetHinzufuegen(S,Offset);
END;

PROCEDURE TBeRoScript.OutMovEBXEBP;
BEGIN
 ByteHinzufuegen($89); ByteHinzufuegen($EB); // MOV EBX,EBP
END;

PROCEDURE TBeRoScript.OutMovzxEAXAL;
BEGIN
 ByteHinzufuegen($0F); ByteHinzufuegen($B6); ByteHinzufuegen($C0); // MOVZX EAX,AL
END;

PROCEDURE TBeRoScript.OutSubEBX(I:LONGWORD);
BEGIN
 IF I<=$FF THEN BEGIN
  ByteHinzufuegen($83);
  ByteHinzufuegen($EB);
  ByteHinzufuegen(I);
 END ELSE BEGIN
  ByteHinzufuegen($81);
  ByteHinzufuegen($EB);
  ByteHinzufuegen($05);
  DWordHinzufuegen(I);
 END;
END;

PROCEDURE TBeRoScript.OutAddEBX(I:LONGWORD);
BEGIN
 IF I<=$FF THEN BEGIN
  ByteHinzufuegen($83);
  ByteHinzufuegen($C3);
  ByteHinzufuegen(I);
 END ELSE BEGIN
  ByteHinzufuegen($81);
  ByteHinzufuegen($C3);
  DWordHinzufuegen(I);
 END;
END;

PROCEDURE TBeRoScript.OutAddECX(I:LONGWORD);
BEGIN
 IF I<=$FF THEN BEGIN
  ByteHinzufuegen($83);
  ByteHinzufuegen($C1);
  ByteHinzufuegen(I);
 END ELSE BEGIN
  ByteHinzufuegen($81);
  ByteHinzufuegen($C1);
  DWordHinzufuegen(I);
 END;
END;

PROCEDURE TBeRoScript.OutMovAxVarAdr(S:STRING;Index:Integer;Zeiger,UseArray:BOOLEAN);
VAR Adr,Size:INTEGER;
    A:STRING;
BEGIN
 IF LockVar(S,'',a,Adr,FALSE,-1) THEN BEGIN
  IF NOT NameTabelle[AktSymPtr].Zeiger THEN BEGIN
   IF NOT (NameTabelle[AktSymPtr].IstArray AND UseArray) THEN BEGIN
    IF NameTabelle[AktSymPtr].Art IN [aGlobal,aStatic] THEN BEGIN
     OutMovAxImmLabel(a);
    END ELSE IF NameTabelle[AktSymPtr].Art=aLokal THEN BEGIN
     OutLeaEAXEBP(-NameTabelle[AktSymPtr].StackPtr);
    END ELSE IF NameTabelle[AktSymPtr].Art IN [aParam,aShadowParam] THEN BEGIN
     OutLeaEAXEBP(NameTabelle[AktSymPtr].StackPtr);
    END;
   END ELSE BEGIN
    OutPushBx;
    Size:=1;
    IF AktTyp IN [tuShortInt,tShortInt] THEN Size:=2;
    IF AktTyp IN [tuInt,tInt,tFloat,tString,tVoid] THEN Size:=4;
    IF NameTabelle[AktSymPtr].IstArray AND UseArray THEN BEGIN
     IF AktTyp IN [tuShortInt,tShortInt] THEN OutShlCx(1);
     IF AktTyp IN [tuInt,tInt,tFloat,tString,tVoid] THEN OutShlCx(2);
     OutMovBxCx;
    END;
    IF NameTabelle[AktSymPtr].Art IN [aGlobal,aStatic] THEN BEGIN
     OutLeaEAXImmLabelEBX(a,size);
    END ELSE IF NameTabelle[AktSymPtr].Art=aLokal THEN BEGIN
     OutLeaEAXEBPEBX(-NameTabelle[AktSymPtr].StackPtr,Size);
    END ELSE IF NameTabelle[AktSymPtr].Art IN [aParam,aShadowParam] THEN BEGIN
     OutLeaEAXEBPEBX(NameTabelle[AktSymPtr].StackPtr,Size);
    END;
    OutPopBx;
   END;
  END ELSE BEGIN
   IF Zeiger THEN BEGIN
    IF NameTabelle[AktSymPtr].Art IN [aGlobal,aStatic] THEN BEGIN
     OutMovAxVar32(a);
    END ELSE IF NameTabelle[AktSymPtr].Art=aLokal THEN BEGIN
     OutMovAxVarEBP(-NameTabelle[AktSymPtr].StackPtr,4);
    END ELSE IF NameTabelle[AktSymPtr].Art IN [aParam,aShadowParam] THEN BEGIN
     OutMovAxVarEBP(NameTabelle[AktSymPtr].StackPtr,4);
    END;
    IF NameTabelle[AktSymPtr].IstArray AND UseArray THEN BEGIN
     IF AktTyp IN [tuShortInt,tShortInt] THEN OutShlCx(1);
     IF AktTyp IN [tuInt,tInt,tFloat,tString,tVoid] THEN OutShlCx(2);
     OutAddAxCx;
    END;
   END ELSE BEGIN
    IF NameTabelle[AktSymPtr].IstArray AND UseArray THEN BEGIN
     Size:=1;
     IF AktTyp IN [tuShortInt,tShortInt] THEN Size:=2;
     IF AktTyp IN [tuInt,tInt,tFloat,tString,tVoid] THEN Size:=4;
     IF AktTyp IN [tuShortInt,tShortInt] THEN OutShlCx(1);
     IF AktTyp IN [tuInt,tInt,tFloat,tString,tVoid] THEN OutShlCx(2);
     IF NameTabelle[AktSymPtr].Art IN [aGlobal,aStatic] THEN BEGIN
      OutLeaEAXImmLabelECX(a,size);
     END ELSE IF NameTabelle[AktSymPtr].Art=aLokal THEN BEGIN
      OutLeaEAXEBPECX(-NameTabelle[AktSymPtr].StackPtr,Size);
     END ELSE IF NameTabelle[AktSymPtr].Art IN [aParam,aShadowParam] THEN BEGIN
      OutLeaEAXEBPECX(NameTabelle[AktSymPtr].StackPtr,Size);
     END;
    END ELSE BEGIN
     IF NameTabelle[AktSymPtr].Art IN [aGlobal,aStatic] THEN BEGIN
      OutMovAxImmLabel(a);
     END ELSE IF NameTabelle[AktSymPtr].Art=aLokal THEN BEGIN
      OutLeaEAXEBP(-NameTabelle[AktSymPtr].StackPtr);
     END ELSE IF NameTabelle[AktSymPtr].Art IN [aParam,aShadowParam] THEN BEGIN
      OutLeaEAXEBP(NameTabelle[AktSymPtr].StackPtr);
     END;
    END;
   END;
  END;
 END;
END;

PROCEDURE TBeRoScript.OutMovAxVar(S:STRING;Index:Integer;Zeiger,UseArray:BOOLEAN);
VAR Adr:INTEGER;
    a:STRING;
    Size:BYTE;
BEGIN
 IF LockVar(S,'',a,Adr,FALSE,-1) THEN BEGIN
  IF NOT NameTabelle[AktSymPtr].Zeiger THEN BEGIN
   IF AktTyp IN [tuByte,tByte,tuChar,tChar,tuShortInt,tShortInt] THEN OutXorAxAx;
   IF NOT (NameTabelle[AktSymPtr].IstArray AND UseArray) THEN BEGIN
    Size:=0;
    IF AktTyp IN [tuByte,tByte,tuChar,tChar] THEN Size:=1;
    IF AktTyp IN [tuShortInt,tShortInt] THEN Size:=2;
    IF AktTyp IN [tuInt,tInt,tFloat,tString,tVoid] THEN Size:=4;
    IF AktTyp IN [tByte,tChar,tShortInt,tInt] THEN BEGIN
     IF NameTabelle[AktSymPtr].Art IN [aGlobal,aStatic] THEN BEGIN
      OutMovsxAxVarLabel(a,Size);
     END ELSE IF NameTabelle[AktSymPtr].Art=aLokal THEN BEGIN
      OutMovsxAxVarEBP(-NameTabelle[AktSymPtr].StackPtr,Size);
     END ELSE IF NameTabelle[AktSymPtr].Art IN [aParam,aShadowParam] THEN BEGIN
      OutMovsxAxVarEBP(NameTabelle[AktSymPtr].StackPtr,Size);
     END;
    END ELSE BEGIN
     IF NameTabelle[AktSymPtr].Art IN [aGlobal,aStatic] THEN BEGIN
      OutMovAxVarLabel(a,Size);
     END ELSE IF NameTabelle[AktSymPtr].Art=aLokal THEN BEGIN
      OutMovAxVarEBP(-NameTabelle[AktSymPtr].StackPtr,Size);
     END ELSE IF NameTabelle[AktSymPtr].Art IN [aParam,aShadowParam] THEN BEGIN
      OutMovAxVarEBP(NameTabelle[AktSymPtr].StackPtr,Size);
     END;
    END;            
   END ELSE BEGIN
    OutPushBx;
    IF NOT (NameTabelle[AktSymPtr].Art IN [aGlobal,aStatic]) THEN BEGIN
     IF AktTyp IN [tuShortInt,tShortInt] THEN OutShlCx(1);
     IF AktTyp IN [tuInt,tInt,tFloat,tString,tVoid] THEN OutShlCx(2);
     OutMovEBXEBP;
     OutAddBxCx;
    END ELSE BEGIN
     IF AktTyp IN [tuShortInt,tShortInt] THEN OutShlCx(1);
     IF AktTyp IN [tuInt,tInt,tFloat,tString,tVoid] THEN OutShlCx(2);
     OutMovBxCx;
    END;
    Size:=0;
    IF AktTyp IN [tuByte,tByte,tuChar,tChar] THEN Size:=1;
    IF AktTyp IN [tuShortInt,tShortInt] THEN Size:=2;
    IF AktTyp IN [tuInt,tInt,tFloat,tString,tVoid] THEN Size:=4;
    IF AktTyp IN [tByte,tChar,tShortInt,tInt] THEN BEGIN
     IF NameTabelle[AktSymPtr].Art IN [aGlobal,aStatic] THEN BEGIN
      OutMovsxAxVarEBXLabel(a,Size);
     END ELSE IF NameTabelle[AktSymPtr].Art=aLokal THEN BEGIN
      OutMovsxAxVarEBX(-NameTabelle[AktSymPtr].StackPtr,Size);
     END ELSE IF NameTabelle[AktSymPtr].Art IN [aParam,aShadowParam] THEN BEGIN
      OutMovsxAxVarEBX(NameTabelle[AktSymPtr].StackPtr,Size);
     END;
    END ELSE BEGIN
     IF NameTabelle[AktSymPtr].Art IN [aGlobal,aStatic] THEN BEGIN
      OutMovAxVarEBXLabel(a,Size);
     END ELSE IF NameTabelle[AktSymPtr].Art=aLokal THEN BEGIN
      OutMovAxVarEBX(-NameTabelle[AktSymPtr].StackPtr,Size);
     END ELSE IF NameTabelle[AktSymPtr].Art IN [aParam,aShadowParam] THEN BEGIN
      OutMovAxVarEBX(NameTabelle[AktSymPtr].StackPtr,Size);
     END;
    END;
    OutPopBx;
   END;
  END ELSE BEGIN
   IF Zeiger THEN BEGIN
    OutPushBx;
    IF NameTabelle[AktSymPtr].Art IN [aGlobal,aStatic] THEN BEGIN
     OutMovBxVarLabel(a,4);
    END ELSE IF NameTabelle[AktSymPtr].Art=aLokal THEN BEGIN
     OutMovBxVarEBP(-NameTabelle[AktSymPtr].StackPtr,4);
    END ELSE IF NameTabelle[AktSymPtr].Art IN [aParam,aShadowParam] THEN BEGIN
     OutMovBxVarEBP(NameTabelle[AktSymPtr].StackPtr,4);
    END;
    IF NameTabelle[AktSymPtr].IstArray AND UseArray THEN BEGIN
     IF AktTyp IN [tuShortInt,tShortInt] THEN OutShlCx(1);
     IF AktTyp IN [tuInt,tInt,tFloat,tString,tVoid] THEN OutShlCx(2);
     OutAddBxCx;
    END;
    IF AktTyp IN [tuByte,tByte,tuChar,tChar,tuShortInt,tShortInt] THEN OutXorAxAx;
    Size:=0;
    IF AktTyp IN [tuByte,tByte,tuChar,tChar] THEN Size:=1;
    IF AktTyp IN [tuShortInt,tShortInt] THEN Size:=2;
    IF AktTyp IN [tuInt,tInt,tFloat,tString,tVoid] THEN Size:=4;
    IF AktTyp IN [tByte,tChar,tShortInt,tInt] THEN BEGIN
     OutMovsxAxVarEBX(0,Size);
    END ELSE BEGIN
     OutMovAxVarEBX(0,Size);
    END;
    OutPopBx;
   END ELSE BEGIN
    IF AktTyp IN [tByte,tChar,tShortInt,tInt] THEN BEGIN
     IF NameTabelle[AktSymPtr].Art IN [aGlobal,aStatic] THEN BEGIN
      OutMovsxAxVarLabel(a,4);
     END ELSE IF NameTabelle[AktSymPtr].Art=aLokal THEN BEGIN
      OutMovsxAxVarEBP(-NameTabelle[AktSymPtr].StackPtr,4);
     END ELSE IF NameTabelle[AktSymPtr].Art IN [aParam,aShadowParam] THEN BEGIN
      OutMovsxAxVarEBP(NameTabelle[AktSymPtr].StackPtr,4);
     END;
    END ELSE BEGIN
     IF NameTabelle[AktSymPtr].Art IN [aGlobal,aStatic] THEN BEGIN
      OutMovAxVarLabel(a,4);
     END ELSE IF NameTabelle[AktSymPtr].Art=aLokal THEN BEGIN
      OutMovAxVarEBP(-NameTabelle[AktSymPtr].StackPtr,4);
     END ELSE IF NameTabelle[AktSymPtr].Art IN [aParam,aShadowParam] THEN BEGIN
      OutMovAxVarEBP(NameTabelle[AktSymPtr].StackPtr,4);
     END;
    END;
   END;
  END;
 END;
END;

PROCEDURE TBeRoScript.OutMovVarAx(S:STRING;Index:Integer;Zeiger,UseArray:BOOLEAN);
VAR Adr:INTEGER;
    a:STRING;
    Size:BYTE;
BEGIN
 IF LockVar(S,'',a,Adr,FALSE,-1) THEN BEGIN
  IF NOT NameTabelle[AktSymPtr].Zeiger THEN BEGIN
   IF NOT (NameTabelle[AktSymPtr].IstArray AND UseArray) THEN BEGIN
    Size:=0;
    IF AktTyp IN [tuByte,tByte,tuChar,tChar] THEN Size:=1;
    IF AktTyp IN [tuShortInt,tShortInt] THEN Size:=2;
    IF AktTyp IN [tuInt,tInt,tFloat,tString,tVoid] THEN Size:=4;
    IF NameTabelle[AktSymPtr].Art IN [aGlobal,aStatic] THEN BEGIN
     OutMovVarLabelAX(a,Size);
    END ELSE IF NameTabelle[AktSymPtr].Art=aLokal THEN BEGIN
     OutMovVarEBPAX(-NameTabelle[AktSymPtr].StackPtr,Size);
    END ELSE IF NameTabelle[AktSymPtr].Art IN [aParam,aShadowParam] THEN BEGIN
     OutMovVarEBPAX(NameTabelle[AktSymPtr].StackPtr,Size);
    END;
   END ELSE BEGIN
    OutPushBx;
    IF NOT (NameTabelle[AktSymPtr].Art IN [aGlobal,aStatic]) THEN BEGIN
     IF AktTyp IN [tuShortInt,tShortInt] THEN OutShlCx(1);
     IF AktTyp IN [tuInt,tInt,tFloat,tString,tVoid] THEN OutShlCx(2);
     OutMovEBXEBP;
     OutAddBxCx;
    END ELSE BEGIN
     IF AktTyp IN [tuShortInt,tShortInt] THEN OutShlCx(1);
     IF AktTyp IN [tuInt,tInt,tFloat,tString,tVoid] THEN OutShlCx(2);
     OutMovBxCx;
    END;
    Size:=0;
    IF AktTyp IN [tuByte,tByte,tuChar,tChar] THEN Size:=1;
    IF AktTyp IN [tuShortInt,tShortInt] THEN Size:=2;
    IF AktTyp IN [tuInt,tInt,tFloat,tString,tVoid] THEN Size:=4;
    IF NameTabelle[AktSymPtr].Art IN [aGlobal,aStatic] THEN BEGIN
     OutMovVarEBXLabelAx(a,Size);
    END ELSE IF NameTabelle[AktSymPtr].Art=aLokal THEN BEGIN
     OutMovVarEBXAx(-NameTabelle[AktSymPtr].StackPtr,Size);
    END ELSE IF NameTabelle[AktSymPtr].Art IN [aParam,aShadowParam] THEN BEGIN
     OutMovVarEBXAx(NameTabelle[AktSymPtr].StackPtr,Size);
    END;
    OutPopBx;
   END;
  END ELSE BEGIN
   IF Zeiger THEN BEGIN
    OutPushBx;
    IF NameTabelle[AktSymPtr].Art IN [aGlobal,aStatic] THEN BEGIN
     OutMovBxVarLabel(a,4);
    END ELSE IF NameTabelle[AktSymPtr].Art=aLokal THEN BEGIN
     OutMovBxVarEBP(-NameTabelle[AktSymPtr].StackPtr,4);
    END ELSE IF NameTabelle[AktSymPtr].Art IN [aParam,aShadowParam] THEN BEGIN
     OutMovBxVarEBP(NameTabelle[AktSymPtr].StackPtr,4);
    END;
    IF NameTabelle[AktSymPtr].IstArray AND UseArray THEN BEGIN
     IF AktTyp IN [tuShortInt,tShortInt] THEN OutShlCx(1);
     IF AktTyp IN [tuInt,tInt,tFloat,tString,tVoid] THEN OutShlCx(2);
     OutAddBxCx;
    END;
    Size:=0;
    IF AktTyp IN [tuByte,tByte,tuChar,tChar] THEN Size:=1;
    IF AktTyp IN [tuShortInt,tShortInt] THEN Size:=2;
    IF AktTyp IN [tuInt,tInt,tFloat,tString,tVoid] THEN Size:=4;
    OutMovVarEBXAx(0,Size);
    OutPopBx;
   END ELSE BEGIN
    IF NameTabelle[AktSymPtr].Art IN [aGlobal,aStatic] THEN BEGIN
     OutMovVarLabelAX(a,4);
    END ELSE IF NameTabelle[AktSymPtr].Art=aLokal THEN BEGIN
     OutMovVarEBPAX(-NameTabelle[AktSymPtr].StackPtr,4);
    END ELSE IF NameTabelle[AktSymPtr].Art IN [aParam,aShadowParam] THEN BEGIN
     OutMovVarEBPAX(NameTabelle[AktSymPtr].StackPtr,4);
    END;
   END;
  END;
 END;
END;

PROCEDURE TBeRoScript.OutIncVar(S:STRING;Zeiger,UseArray:BOOLEAN);
VAR Adr:INTEGER;
    a:STRING;
    Size:BYTE;
BEGIN
 IF LockVar(S,'',a,Adr,FALSE,-1) THEN BEGIN
  IF NameTabelle[AktSymPtr].Zeiger THEN BEGIN
   IF Zeiger THEN BEGIN
    OutPushBx;
    IF NameTabelle[AktSymPtr].Art IN [aGlobal,aStatic] THEN BEGIN
     OutMovBxVarLabel(a,4);
    END ELSE IF NameTabelle[AktSymPtr].Art=aLokal THEN BEGIN
     OutMovBxVarEBP(-NameTabelle[AktSymPtr].StackPtr,4);
    END ELSE IF NameTabelle[AktSymPtr].Art IN [aParam,aShadowParam] THEN BEGIN
     OutMovBxVarEBP(NameTabelle[AktSymPtr].StackPtr,4);
    END;
    IF NameTabelle[AktSymPtr].IstArray AND UseArray THEN BEGIN
     IF AktTyp IN [tuShortInt,tShortInt] THEN OutShlCx(1);
     IF AktTyp IN [tuInt,tInt,tFloat,tString,tVoid] THEN OutShlCx(2);
     OutAddBxCx;
    END;
    Size:=0;
    IF AktTyp IN [tuByte,tByte,tuChar,tChar] THEN Size:=1;
    IF AktTyp IN [tuShortInt,tShortInt] THEN Size:=2;
    IF AktTyp IN [tuInt,tInt,tFloat,tString,tVoid] THEN Size:=4;
    OutIncVarEBX(0,Size);
    OutPopBx;
   END ELSE BEGIN
    Size:=0;
    IF AktTyp IN [tuByte,tByte,tuChar,tChar] THEN Size:=1;
    IF AktTyp IN [tuShortInt,tShortInt] THEN Size:=2;
    IF AktTyp IN [tuInt,tInt,tFloat,tString,tVoid] THEN Size:=4;
    IF Size>1 THEN BEGIN
     IF NameTabelle[AktSymPtr].Art IN [aGlobal,aStatic] THEN BEGIN
      OutAddVarLabel(a,4,Size);
     END ELSE IF NameTabelle[AktSymPtr].Art=aLokal THEN BEGIN
      OutAddVarEBP(-NameTabelle[AktSymPtr].StackPtr,4,Size);
     END ELSE IF NameTabelle[AktSymPtr].Art IN [aParam,aShadowParam] THEN BEGIN
      OutAddVarEBP(NameTabelle[AktSymPtr].StackPtr,4,Size);
     END;
    END ELSE IF Size=1 THEN BEGIN
     IF NameTabelle[AktSymPtr].Art IN [aGlobal,aStatic] THEN BEGIN
      OutIncVarLabel(a,4);
     END ELSE IF NameTabelle[AktSymPtr].Art=aLokal THEN BEGIN
      OutIncVarEBP(-NameTabelle[AktSymPtr].StackPtr,4);
     END ELSE IF NameTabelle[AktSymPtr].Art IN [aParam,aShadowParam] THEN BEGIN
      OutIncVarEBP(NameTabelle[AktSymPtr].StackPtr,4);
     END;
    END;
   END;
  END ELSE BEGIN
   IF NOT (NameTabelle[AktSymPtr].IstArray AND UseArray) THEN BEGIN
    Size:=0;
    IF AktTyp IN [tuByte,tByte,tuChar,tChar] THEN Size:=1;
    IF AktTyp IN [tuShortInt,tShortInt] THEN Size:=2;
    IF AktTyp IN [tuInt,tInt,tFloat,tString,tVoid] THEN Size:=4;
    IF NameTabelle[AktSymPtr].Art IN [aGlobal,aStatic] THEN BEGIN
     OutIncVarLabel(a,Size);
    END ELSE IF NameTabelle[AktSymPtr].Art=aLokal THEN BEGIN
     OutIncVarEBP(-NameTabelle[AktSymPtr].StackPtr,Size);
    END ELSE IF NameTabelle[AktSymPtr].Art IN [aParam,aShadowParam] THEN BEGIN
     OutIncVarEBP(NameTabelle[AktSymPtr].StackPtr,Size);
    END;
   END ELSE BEGIN
    OutPushBx;
    IF NOT (NameTabelle[AktSymPtr].Art IN [aGlobal,aStatic]) THEN BEGIN
     IF AktTyp IN [tuShortInt,tShortInt] THEN OutShlCx(1);
     IF AktTyp IN [tuInt,tInt,tFloat,tString,tVoid] THEN OutShlCx(2);
     OutMovEBXEBP;
     OutAddBxCx;
    END ELSE BEGIN
     IF AktTyp IN [tuShortInt,tShortInt] THEN OutShlCx(1);
     IF AktTyp IN [tuInt,tInt,tFloat,tString,tVoid] THEN OutShlCx(2);
     OutMovBxCx;
    END;
    Size:=0;
    IF AktTyp IN [tuByte,tByte,tuChar,tChar] THEN Size:=1;
    IF AktTyp IN [tuShortInt,tShortInt] THEN Size:=2;
    IF AktTyp IN [tuInt,tInt,tFloat,tString,tVoid] THEN Size:=4;
    IF NameTabelle[AktSymPtr].Art IN [aGlobal,aStatic] THEN BEGIN
     OutIncVarLabelEBX(a,Size);
    END ELSE IF NameTabelle[AktSymPtr].Art=aLokal THEN BEGIN
     OutIncVarEBX(-NameTabelle[AktSymPtr].StackPtr,Size);
    END ELSE IF NameTabelle[AktSymPtr].Art IN [aParam,aShadowParam] THEN BEGIN
     OutIncVarEBX(NameTabelle[AktSymPtr].StackPtr,Size);
    END;
    OutPopBx;
   END;
  END;
 END;
END;

PROCEDURE TBeRoScript.OutDecVar(S:STRING;Zeiger,UseArray:BOOLEAN);
VAR Adr,Size:INTEGER;
    a:STRING;
BEGIN
 IF LockVar(S,'',a,Adr,FALSE,-1) THEN BEGIN
  IF NameTabelle[AktSymPtr].Zeiger THEN BEGIN
   IF Zeiger THEN BEGIN
    OutPushBx;
    IF NameTabelle[AktSymPtr].Art IN [aGlobal,aStatic] THEN BEGIN
     OutMovBxVarLabel(a,4);
    END ELSE IF NameTabelle[AktSymPtr].Art=aLokal THEN BEGIN
     OutMovBxVarEBP(-NameTabelle[AktSymPtr].StackPtr,4);
    END ELSE IF NameTabelle[AktSymPtr].Art IN [aParam,aShadowParam] THEN BEGIN
     OutMovBxVarEBP(NameTabelle[AktSymPtr].StackPtr,4);
    END;
    IF NameTabelle[AktSymPtr].IstArray AND UseArray THEN BEGIN
     IF AktTyp IN [tuShortInt,tShortInt] THEN OutShlCx(1);
     IF AktTyp IN [tuInt,tInt,tFloat,tString,tVoid] THEN OutShlCx(2);
     OutAddBxCx;
    END;
    Size:=0;
    IF AktTyp IN [tuByte,tByte,tuChar,tChar] THEN Size:=1;
    IF AktTyp IN [tuShortInt,tShortInt] THEN Size:=2;
    IF AktTyp IN [tuInt,tInt,tFloat,tString,tVoid] THEN Size:=4;
    OutDecVarEBX(0,Size);
    OutPopBx;
   END ELSE BEGIN
    Size:=0;
    IF AktTyp IN [tuByte,tByte,tuChar,tChar] THEN Size:=1;
    IF AktTyp IN [tuShortInt,tShortInt] THEN Size:=2;
    IF AktTyp IN [tuInt,tInt,tFloat,tString,tVoid] THEN Size:=4;
    IF Size>1 THEN BEGIN
     IF NameTabelle[AktSymPtr].Art IN [aGlobal,aStatic] THEN BEGIN
      OutSubVarLabel(a,4,Size);
     END ELSE IF NameTabelle[AktSymPtr].Art=aLokal THEN BEGIN
      OutSubVarEBP(-NameTabelle[AktSymPtr].StackPtr,4,Size);
     END ELSE IF NameTabelle[AktSymPtr].Art IN [aParam,aShadowParam] THEN BEGIN
      OutSubVarEBP(NameTabelle[AktSymPtr].StackPtr,4,Size);
     END;
    END ELSE IF Size=1 THEN BEGIN
     IF NameTabelle[AktSymPtr].Art IN [aGlobal,aStatic] THEN BEGIN
      OutDecVarLabel(a,4);
     END ELSE IF NameTabelle[AktSymPtr].Art=aLokal THEN BEGIN
      OutDecVarEBP(-NameTabelle[AktSymPtr].StackPtr,4);
     END ELSE IF NameTabelle[AktSymPtr].Art IN [aParam,aShadowParam] THEN BEGIN
      OutDecVarEBP(NameTabelle[AktSymPtr].StackPtr,4);
     END;
    END;
   END;
  END ELSE BEGIN
   IF NOT (NameTabelle[AktSymPtr].IstArray AND UseArray) THEN BEGIN
    Size:=0;
    IF AktTyp IN [tuByte,tByte,tuChar,tChar] THEN Size:=1;
    IF AktTyp IN [tuShortInt,tShortInt] THEN Size:=2;
    IF AktTyp IN [tuInt,tInt,tFloat,tString,tVoid] THEN Size:=4;
    IF NameTabelle[AktSymPtr].Art IN [aGlobal,aStatic] THEN BEGIN
     OutDecVarLabel(a,Size);
    END ELSE IF NameTabelle[AktSymPtr].Art=aLokal THEN BEGIN
     OutDecVarEBP(-NameTabelle[AktSymPtr].StackPtr,Size);
    END ELSE IF NameTabelle[AktSymPtr].Art IN [aParam,aShadowParam] THEN BEGIN
     OutDEcVarEBP(NameTabelle[AktSymPtr].StackPtr,Size);
    END;
   END ELSE BEGIN
    OutPushBx;
    IF NOT (NameTabelle[AktSymPtr].Art IN [aGlobal,aStatic]) THEN BEGIN
     IF AktTyp IN [tuShortInt,tShortInt] THEN OutShlCx(1);
     IF AktTyp IN [tuInt,tInt,tFloat,tString,tVoid] THEN OutShlCx(2);
     OutMovEBXEBP;
     OutAddBxCx;
    END ELSE BEGIN
     IF AktTyp IN [tuShortInt,tShortInt] THEN OutShlCx(1);
     IF AktTyp IN [tuInt,tInt,tFloat,tString,tVoid] THEN OutShlCx(2);
     OutMovBxCx;
    END;
    Size:=0;
    IF AktTyp IN [tuByte,tByte,tuChar,tChar] THEN Size:=1;
    IF AktTyp IN [tuShortInt,tShortInt] THEN Size:=2;
    IF AktTyp IN [tuInt,tInt,tFloat,tString,tVoid] THEN Size:=4;
    IF NameTabelle[AktSymPtr].Art IN [aGlobal,aStatic] THEN BEGIN
     OutDecVarLabelEBX(a,Size);
    END ELSE IF NameTabelle[AktSymPtr].Art=aLokal THEN BEGIN
     OutDecVarEBX(-NameTabelle[AktSymPtr].StackPtr,Size);
    END ELSE IF NameTabelle[AktSymPtr].Art IN [aParam,aShadowParam] THEN BEGIN
     OutDecVarEBX(NameTabelle[AktSymPtr].StackPtr,Size);
    END;
    OutPopBx;
   END;
  END;
 END;
END;

PROCEDURE TBeRoScript.OutIncStructVar;
VAR Size:INTEGER;
BEGIN
 Size:=0;
 IF AktTyp IN [tuByte,tByte,tuChar,tChar] THEN Size:=1;
 IF AktTyp IN [tuShortInt,tShortInt] THEN Size:=2;
 IF AktTyp IN [tuInt,tInt,tFloat,tString,tVoid] THEN Size:=4;
 IF Size=0 THEN BEGIN
  SetError(ceWrongType);
 END ELSE BEGIN
  OutIncVarEBX(0,Size);
 END;
END;

PROCEDURE TBeRoScript.OutDecStructVar;
VAR Size:INTEGER;
BEGIN
 Size:=0;
 IF AktTyp IN [tuByte,tByte,tuChar,tChar] THEN Size:=1;
 IF AktTyp IN [tuShortInt,tShortInt] THEN Size:=2;
 IF AktTyp IN [tuInt,tInt,tFloat,tString,tVoid] THEN Size:=4;
 IF Size=0 THEN BEGIN
  SetError(ceWrongType);
 END ELSE BEGIN
  OutDecVarEBX(0,Size);
 END;
END;

PROCEDURE TBeRoScript.OutIncFPU;
BEGIN
 OutAXToStack;
 OutFPULD1;
 OutFPUAddEx;
 OutFPUToAX;
END;

PROCEDURE TBeRoScript.OutDecFPU;
BEGIN
 OutMovBxAx;
 OutFPULD1;
 OutFPUToAX;
 OutXChgAxBx;
 OutAxToFPU;
 OutXChgAxBx;
 OutAXToStack;
 OutFPUSubEx;
 OutFPUToAX;
END;

PROCEDURE TBeRoScript.OutMovToStructVar(Variable:INTEGER);
VAR Size:INTEGER;
BEGIN
 AktTyp:=NameTabelle[Variable].Typ;
 IF NameTabelle[Variable].Zeiger THEN BEGIN
  Size:=4;
 END ELSE BEGIN
  Size:=0;
  IF AktTyp IN [tuByte,tByte,tuChar,tChar] THEN Size:=1;
  IF AktTyp IN [tuShortInt,tShortInt] THEN Size:=2;
  IF AktTyp IN [tuInt,tInt,tFloat,tString,tVoid] THEN Size:=4;
 END;
 IF Size=0 THEN BEGIN
  SetError(ceWrongType);
 END ELSE BEGIN
  OutMovVarEBXAx(0,Size);
 END;
END;

PROCEDURE TBeRoScript.OutMovFromStructVar(Variable:INTEGER);
VAR Size:INTEGER;
BEGIN
 AktTyp:=NameTabelle[Variable].Typ;
 IF NameTabelle[Variable].Zeiger THEN BEGIN
  Size:=4;
 END ELSE BEGIN
  Size:=0;
  IF AktTyp IN [tuByte,tByte,tuChar,tChar,tuShortInt,tShortInt] THEN OutXorAxAx;
  IF AktTyp IN [tuByte,tByte,tuChar,tChar] THEN Size:=1;
  IF AktTyp IN [tuShortInt,tShortInt] THEN Size:=2;
  IF AktTyp IN [tuInt,tInt,tFloat,tString,tVoid] THEN Size:=4;
 END;
 IF Size=0 THEN BEGIN
  SetError(ceWrongType);
 END ELSE BEGIN
  IF AktTyp IN [tByte,tChar,tShortInt,tInt] THEN BEGIN
   OutMovsxAxVarEBX(0,Size);
  END ELSE BEGIN
   OutMovAxVarEBX(0,Size);
  END;
 END;
END;

PROCEDURE TBeRoScript.OutCall(S,SO:STRING);
VAR Adr:TWert;
    a:STRING;
BEGIN
 IF LockVar(S,SO,a,Adr,FALSE,-1) THEN CallLabel(a);
END;

PROCEDURE TBeRoScript.OutCallAx;
BEGIN
 ByteHinzufuegen($FF);
 ByteHinzufuegen($D0);
END;

PROCEDURE TBeRoScript.OutCallBx;
BEGIN
 ByteHinzufuegen($FF);
 ByteHinzufuegen($D3);
END;

PROCEDURE TBeRoScript.OutCallNative(Name:STRING);
VAR I,J:INTEGER;
BEGIN
 J:=-1;
 FOR I:=0 TO tnpZaehler-1 DO BEGIN
  IF NativeTabelle[I].Name=Name THEN BEGIN
   J:=I;
   BREAK;
  END;
 END;
 IF J>=0 THEN BEGIN
  ByteHinzufuegen($E8);
  NativeRelativeFixUpHinzufuegen(Name);
  DWordHinzufuegen(0); // CALL Relative NativeAdresse
 END ELSE BEGIN
  SetError(ceNativeProcNichtGefunden);
 END;
END;

PROCEDURE TBeRoScript.OutCallImport(Name:STRING);
VAR I,J:INTEGER;
BEGIN
 J:=-1;
 FOR I:=0 TO tnpZaehler-1 DO BEGIN
  IF ImportTabelle[I].Name=Name THEN BEGIN
   J:=I;
   BREAK;
  END;
 END;
 IF J>=0 THEN BEGIN
  ByteHinzufuegen($E8);
  ImportRelativeFixUpHinzufuegen(Name);
  DWordHinzufuegen(0); // CALL Relative NativeAdresse
 END ELSE BEGIN
  SetError(ceImportProcNichtGefunden);
 END;
END;

FUNCTION TBeRoScript.HexB(B:BYTE):STRING;
CONST Hex:ARRAY[0..$F] OF CHAR='0123456789ABCDEF';
BEGIN
 RESULT:=Hex[B SHR 4]+Hex[B AND $F];
END;

FUNCTION TBeRoScript.HexW(W:WORD):STRING;
BEGIN
 HexW:=HexB(W SHR 8)+HexB(W AND $FF);
END;

FUNCTION TBeRoScript.FlagIsSet(Flags:BYTE;FlagMask:BYTE):BOOLEAN;
BEGIN
 FlagIsSet:=(Flags AND FlagMask)<>0;
END;

FUNCTION TBeRoScript.LeseNaechstesZeichen:CHAR;
VAR MeinNaechstesZeichen:CHAR;
BEGIN
 IF QuellStream.Position<QuellStream.Size THEN BEGIN
  IF QuellStream.Read(MeinNaechstesZeichen,SIZEOF(CHAR))=SIZEOF(CHAR) THEN BEGIN
   SBuf:=SBuf+MeinNaechstesZeichen;
   IF MeinNaechstesZeichen>#32 THEN INC(QuelltextSpalte);
  END ELSE BEGIN
   feof:=TRUE;
   MeinNaechstesZeichen:=#32;
  END;
 END ELSE BEGIN
  feof:=TRUE;
  MeinNaechstesZeichen:=#32;
 END;
 IF NOT feof THEN INC(QuelltextPos);
 LeseNaechstesZeichen:=MeinNaechstesZeichen;
END;

PROCEDURE TBeRoScript.Get;
VAR sch:CHAR;
 PROCEDURE GetIdent;
 BEGIN
  sTok:='';
  WHILE (UPCASE(ch) IN ['A'..'Z','0'..'9','_']) AND NOT feof DO BEGIN
   sTok:=sTok+ch;
   ch:=LeseNaechstesZeichen;
  END;
  IF ch=':' THEN BEGIN
   tTok:=LockKey(sTok);
   IF (tTok=_ident) AND NOT IsStruct(sTok) THEN BEGIN
    tTok:=_label;
    ch:=LeseNaechstesZeichen;
   END;
  END ELSE BEGIN
   tTok:=LockKey(sTok);
  END;
 END;
 PROCEDURE GetNum;
 VAR e:INT64;
     Basis:INTEGER;
     a:BYTE;
     f,fp:SINGLE;
     UseFloat:BOOLEAN;
 BEGIN
  Basis:=10;
  sTok:='';
  e:=0;
  UseFloat:=FALSE;
  WHILE (ch IN ['0'..'9','A'..'F','a'..'f','x','X','.']) AND NOT feof DO BEGIN
   IF ch IN ['x','X'] THEN BEGIN
    Basis:=16;
   END ELSE BEGIN
    IF Basis=10 THEN BEGIN
     IF ch IN ['0'..'9'] THEN BEGIN
      a:=BYTE(ch)-BYTE('0');
      e:=(e*10)+a;
     END ELSE IF ch='.' THEN BEGIN
      UseFloat:=TRUE;
      BREAK;
     END;
    END ELSE IF Basis=16 THEN BEGIN
     IF ch IN ['0'..'9'] THEN BEGIN
      a:=BYTE(ch)-BYTE('0');
     END ELSE IF ch IN ['A'..'F'] THEN BEGIN
      a:=BYTE(ch)-BYTE('A')+10;
     END ELSE IF ch IN ['a'..'f'] THEN BEGIN
      a:=BYTE(ch)-BYTE('A')+10;
     END ELSE IF ch='.' THEN BEGIN
      SetError(ceFloatInHexError);
      a:=0;
     END ELSE BEGIN
      a:=0;
     END;
     e:=(e*16)+a;
    END;
    sTok:=sTok+ch;
   END;
   ch:=LeseNaechstesZeichen;
  END;
  IF useFloat THEN BEGIN
   f:=e;
   fp:=10;
   ch:=LeseNaechstesZeichen;
   WHILE (ch IN ['0'..'9']) AND NOT feof DO BEGIN
    IF ch IN ['0'..'9'] THEN BEGIN
     a:=BYTE(ch)-BYTE('0');
     f:=f+(a/fp);
     fp:=fp*10;
    END;
    ch:=LeseNaechstesZeichen;
   END;
   fTok:=f;
   iTok:=e;
   tTok:=_floatnum;
  END ELSE BEGIN
   fTok:=e;
   iTok:=e;
   tTok:=_integer;
  END;
 END;
 PROCEDURE GetStr;
 VAR a,e:BYTE;
 BEGIN
  AktStr:='';
  StrWert:=0;
  WHILE (ch<>sch) AND NOT feof DO BEGIN
   IF (ch='\') AND NOT feof THEN BEGIN
    ch:=LeseNaechstesZeichen;
    IF ch='r' THEN ch:=#13;
    IF ch='n' THEN ch:=#10;
    IF ch='\' THEN ch:='\';
    IF ch='''' THEN ch:='''';
    IF ch='"' THEN ch:='"';
    IF ch='B' THEN ch:=#7;
    IF ch='u' THEN ch:=#8;
    IF ch='t' THEN ch:=#9;
    IF ch='0' THEN ch:=#0;
    IF ch='x' THEN BEGIN
     IF NOT feof THEN BEGIN
      ch:=LeseNaechstesZeichen;
     END ELSE BEGIN
      ch:='0';
     END;
     IF ch IN ['0'..'9'] THEN BEGIN
      a:=BYTE(ch)-BYTE('0');
     END ELSE IF ch IN ['A'..'F'] THEN BEGIN
      a:=BYTE(ch)-BYTE('A')+10;
     END ELSE IF ch IN ['a'..'f'] THEN BEGIN
      a:=BYTE(ch)-BYTE('A')+10;
     END ELSE BEGIN
      a:=0;
     END;
     e:=a;
     IF NOT feof THEN BEGIN
      ch:=LeseNaechstesZeichen;
     END ELSE BEGIN
      ch:='0';
     END;
     IF ch IN ['0'..'9'] THEN BEGIN
      a:=BYTE(ch)-BYTE('0');
     END ELSE IF ch IN ['A'..'F'] THEN BEGIN
      a:=BYTE(ch)-BYTE('A')+10;
     END ELSE IF ch IN ['a'..'f'] THEN BEGIN
      a:=BYTE(ch)-BYTE('A')+10;
     END ELSE BEGIN
      a:=0;
     END;
     e:=(e SHL 4)+a;
     ch:=CHAR(e);
    END;
   END;
   StrWert:=(StrWert SHL 8)+BYTE(ch);
   AktStr:=AktStr+ch;
   ch:=LeseNaechstesZeichen;
  END;
  tTok:=_string;
 END;
BEGIN
 AktStr:='';
 WHILE (ch IN [#9,#32,#10,#13]) AND NOT feof DO BEGIN
  IF ch=#10 THEN BEGIN
   INC(QuelltextZeile);
   QuelltextSpalte:=0;
  END;
  ch:=LeseNaechstesZeichen;
 END;
 stok:=ch;
 CASE UPCASE(ch) OF
  '_':GetIdent;
  'A'..'Z':GetIdent;
  '0'..'9':GetNum;
  ',':BEGIN
   tTok:=_comma;
   ch:=LeseNaechstesZeichen;
  END;
  '"','''':BEGIN
   sch:=ch;
   ch:=LeseNaechstesZeichen;
   GetStr;
   ch:=LeseNaechstesZeichen;
  END;
  '{':BEGIN
   tTok:=_begin;
   ch:=LeseNaechstesZeichen;
  END;
  '}':BEGIN
   tTok:=_end;
   ch:=LeseNaechstesZeichen;
  END;
  ';':BEGIN
   tTok:=_semicolon;
   ch:=LeseNaechstesZeichen;
  END;
  '+':BEGIN
   tTok:=_plus;
   ch:=LeseNaechstesZeichen;
   IF ch='+' THEN BEGIN
    tTok:=_plusplus;
    ch:=LeseNaechstesZeichen;
   END;
  END;
  '-':BEGIN
   tTok:=_minus;
   ch:=LeseNaechstesZeichen;
   IF ch='-' THEN BEGIN
    tTok:=_minusminus;
    ch:=LeseNaechstesZeichen;
   END ELSE IF ch='>' THEN BEGIN
    tTok:=_usepointer;
    ch:=LeseNaechstesZeichen;
   END;
  END;
  '*':BEGIN
   tTok:=_mul;
   ch:=LeseNaechstesZeichen;
  END;
  '.':BEGIN
   tTok:=_dot;
   ch:=LeseNaechstesZeichen;
  END;
  '/':BEGIN
   ch:=LeseNaechstesZeichen;
   IF ch='*' THEN BEGIN
    sch:='*';
    ch:=LeseNaechstesZeichen;
    WHILE NOT (((sch='*') AND (ch='/')) OR feof) DO BEGIN
     IF ch=#10 THEN BEGIN
      INC(QuelltextZeile);
      QuelltextSpalte:=0;
     END;
     sch:=ch;
     ch:=LeseNaechstesZeichen;
    END;
    ch:=LeseNaechstesZeichen;
    Get;
   END ELSE IF ch='/' THEN BEGIN
    ch:=LeseNaechstesZeichen;
    WHILE NOT ((ch=#10) OR feof) DO ch:=LeseNaechstesZeichen;
    IF ch=#10 THEN BEGIN
     INC(QuelltextZeile);
     QuelltextSpalte:=0;
    END;
    ch:=LeseNaechstesZeichen;
    Get;
   END ELSE BEGIN
    tTok:=_div;
   END;
  END;
  '%':BEGIN
   tTok:=_mod;
   ch:=LeseNaechstesZeichen;
  END;
  '&':BEGIN
   tTok:=_and;
   ch:=LeseNaechstesZeichen;
   IF ch='&' THEN ch:=LeseNaechstesZeichen;
  END;
  '|':BEGIN
   tTok:=_or;
   ch:=LeseNaechstesZeichen;
   IF ch='|' THEN ch:=LeseNaechstesZeichen;
  END;
  '(': BEGIN
   tTok:=_lparent;
   ch:=LeseNaechstesZeichen;
  END;
  ')':BEGIN
   tTok:=_rparent;
   ch:=LeseNaechstesZeichen;
  END;
  '[':BEGIN
   tTok:=_klparent;
   ch:=LeseNaechstesZeichen;
  END;
  ']':BEGIN
   tTok:=_krparent;
   ch:=LeseNaechstesZeichen;
  END;
  '^':BEGIN
   tTok:=_xor;
   ch:=LeseNaechstesZeichen;
  END;
  '!':BEGIN
   tTok:=_not;
   ch:=LeseNaechstesZeichen;
   IF ch='=' THEN BEGIN
    tTok:=_isnot;
    ch:=LeseNaechstesZeichen;
   END;
  END;
  '~':BEGIN
   tTok:=_notbitwise;
   ch:=LeseNaechstesZeichen;
  END;
  '=':BEGIN
   tTok:=_set;
   ch:=LeseNaechstesZeichen;
   IF ch='=' THEN BEGIN
    tTok:=_eql;
    ch:=LeseNaechstesZeichen;
   END;
  END;
  '<':BEGIN
   ch:=LeseNaechstesZeichen;
   IF ch='=' THEN BEGIN
    tTok:=_lea;
    ch:=LeseNaechstesZeichen;
   END ELSE IF ch= '>' THEN BEGIN
    tTok:=_neg;
    ch:=LeseNaechstesZeichen;
   END ELSE IF ch= '<' THEN BEGIN
    tTok:=_shl;
    ch:=LeseNaechstesZeichen;
   END ELSE BEGIN
    tTok:=_lss;
   END;
  END;
  '>':BEGIN
   ch:=LeseNaechstesZeichen;
   IF ch='=' THEN BEGIN
    tTok:=_gra;
    ch:=LeseNaechstesZeichen;
   END ELSE IF ch= '>' THEN BEGIN
    tTok:=_shr;
    ch:=LeseNaechstesZeichen;
   END ELSE BEGIN
    tTok:=_gre;
   END;
  END;
  ':':BEGIN
   tTok:=_doublepoint;
   ch:=LeseNaechstesZeichen;
   IF ch=':' THEN BEGIN
    tTok:=_doubledoublepoint;
    ch:=LeseNaechstesZeichen;
   END;
  END;
  '?':BEGIN
   tTok:=_shortif;
   ch:=LeseNaechstesZeichen;
  END;
  #26:SetError(ceUnexpectedEOF);
  ELSE BEGIN
   tTok:=_unknow;
  END;
 END;
END;

PROCEDURE TBeRoScript.OutXChgAxBx;
BEGIN
 ByteHinzufuegen($93); // XCHG EAX,EBX
END;

PROCEDURE TBeRoScript.OutFPULD1;
BEGIN
 ByteHinzufuegen($D9); ByteHinzufuegen($E8); // FLD1
END;

PROCEDURE TBeRoScript.OutIntAXtoFPU;
BEGIN
 ByteHinzufuegen($89); ByteHinzufuegen($44); ByteHinzufuegen($24); ByteHinzufuegen($FC); // MOV [ESP-4],EAX
 ByteHinzufuegen($DB); ByteHinzufuegen($44); ByteHinzufuegen($24); ByteHinzufuegen($FC); // FILD [ESP-4]
END;

PROCEDURE TBeRoScript.OutFPUToIntAX;
BEGIN
 ByteHinzufuegen($DB); ByteHinzufuegen($5C); ByteHinzufuegen($24); ByteHinzufuegen($FC); // FISTP [ESP-4]
 ByteHinzufuegen($8B); ByteHinzufuegen($44); ByteHinzufuegen($24); ByteHinzufuegen($FC); // MOV EAX,[ESP-4]
END;

PROCEDURE TBeRoScript.OutAXtoFPU;
BEGIN
 ByteHinzufuegen($89); ByteHinzufuegen($44); ByteHinzufuegen($24); ByteHinzufuegen($FC); // MOV [ESP-4],EAX
 ByteHinzufuegen($D9); ByteHinzufuegen($44); ByteHinzufuegen($24); ByteHinzufuegen($FC); // FLD [ESP-4]
END;

PROCEDURE TBeRoScript.OutFPUtoAX;
BEGIN
 ByteHinzufuegen($D9); ByteHinzufuegen($5C); ByteHinzufuegen($24); ByteHinzufuegen($FC); // FSTP [ESP-4]
 ByteHinzufuegen($8B); ByteHinzufuegen($44); ByteHinzufuegen($24); ByteHinzufuegen($FC); // MOV EAX,[ESP-4]
END;

PROCEDURE TBeRoScript.OutAXtoStack;
BEGIN
 ByteHinzufuegen($89); ByteHinzufuegen($44); ByteHinzufuegen($24); ByteHinzufuegen($FC); // MOV [ESP-4],EAX
END;

PROCEDURE TBeRoScript.OutStacktoAX;
BEGIN
 ByteHinzufuegen($8B); ByteHinzufuegen($44); ByteHinzufuegen($24); ByteHinzufuegen($FC); // MOV EAX,[ESP-4]
END;

PROCEDURE TBeRoScript.OutFPUAddEx;
BEGIN
 ByteHinzufuegen($D8); ByteHinzufuegen($44); ByteHinzufuegen($24); ByteHinzufuegen($FC); // FADD [ESP-4]
END;

PROCEDURE TBeRoScript.OutFPUSubEx;
BEGIN
 ByteHinzufuegen($D8); ByteHinzufuegen($64); ByteHinzufuegen($24); ByteHinzufuegen($FC); // FSUB [ESP-4]
END;

PROCEDURE TBeRoScript.OutFPUAdd;
BEGIN
 ByteHinzufuegen($D8); ByteHinzufuegen($04); ByteHinzufuegen($24); // FADD [ESP]
END;

PROCEDURE TBeRoScript.OutFPUSub;
BEGIN
 ByteHinzufuegen($D8); ByteHinzufuegen($24); ByteHinzufuegen($24); // FSUB [ESP]
END;

PROCEDURE TBeRoScript.OutFPUMul;
BEGIN
 ByteHinzufuegen($D8); ByteHinzufuegen($0C); ByteHinzufuegen($24); // FMUL [ESP]
END;

PROCEDURE TBeRoScript.OutFPUDiv;
BEGIN
 ByteHinzufuegen($D8); ByteHinzufuegen($34); ByteHinzufuegen($24); // FDIV [ESP]
END;

PROCEDURE TBeRoScript.OutFPUWait;
BEGIN
 ByteHinzufuegen($9B); // FWAIT
END;

PROCEDURE TBeRoScript.OutFPULss;
BEGIN
 OutXorAxAx;
 ByteHinzufuegen($D8); ByteHinzufuegen($1C); ByteHinzufuegen($24); // FCOMP [ESP]
 ByteHinzufuegen($DF); ByteHinzufuegen($E0); // FSTSW AX
 ByteHinzufuegen($9E); // SAHF
 ByteHinzufuegen($0F); ByteHinzufuegen($92); ByteHinzufuegen($C0); // SETB AL
 ByteHinzufuegen($25); DWordHinzufuegen($FF); // AND EAX,$FF
END;

PROCEDURE TBeRoScript.OutFPULea;
BEGIN
 OutXorAxAx;
 ByteHinzufuegen($D8); ByteHinzufuegen($1C); ByteHinzufuegen($24); // FCOMP [ESP]
 ByteHinzufuegen($DF); ByteHinzufuegen($E0); // FSTSW AX
 ByteHinzufuegen($9E); // SAHF
 ByteHinzufuegen($0F); ByteHinzufuegen($96); ByteHinzufuegen($C0); // SETBE AL
 ByteHinzufuegen($25); DWordHinzufuegen($FF); // AND EAX,$FF
END;

PROCEDURE TBeRoScript.OutFPUGre;
BEGIN
 OutXorAxAx;
 ByteHinzufuegen($D8); ByteHinzufuegen($1C); ByteHinzufuegen($24); // FCOMP [ESP]
 ByteHinzufuegen($DF); ByteHinzufuegen($E0); // FSTSW AX
 ByteHinzufuegen($9E); // SAHF
 ByteHinzufuegen($0F); ByteHinzufuegen($97); ByteHinzufuegen($C0); // SETA AL
 ByteHinzufuegen($25); DWordHinzufuegen($FF); // AND EAX,$FF
END;

PROCEDURE TBeRoScript.OutFPUGra;
BEGIN
 OutXorAxAx;
 ByteHinzufuegen($D8); ByteHinzufuegen($1C); ByteHinzufuegen($24); // FCOMP [ESP]
 ByteHinzufuegen($DF); ByteHinzufuegen($E0); // FSTSW AX
 ByteHinzufuegen($9E); // SAHF
 ByteHinzufuegen($0F); ByteHinzufuegen($93); ByteHinzufuegen($C0); // SETAE AL
 ByteHinzufuegen($25); DWordHinzufuegen($FF); // AND EAX,$FF
END;

PROCEDURE TBeRoScript.FloatFactor;
VAR Adr:TWert;
    S,a:STRING;
    I,AltTok:INTEGER;
    Zeiger,HoleZeiger,UseArray,StringArray,ObjectVar:BOOLEAN;
    AltStringHandling:TStringHandling;
    UseEBX:BOOLEAN;
    AltSymPtr,AltAktSymPtr:INTEGER;
BEGIN
 IsFloatExpression:=TRUE;
 Zeiger:=FALSE;
 HoleZeiger:=FALSE;
 UseArray:=FALSE;
 ObjectVar:=FALSE;
 AltTok:=0;
 IF tTok IN [_plusplus,_minusminus] THEN BEGIN
  AltTok:=tTok;
  Get;
 END;
 IF tTok IN [_mul] THEN BEGIN
  Zeiger:=TRUE;
  Get;
 END;
 IF tTok IN [_and] THEN BEGIN
  HoleZeiger:=TRUE;
  Get;
 END;
 IF tTok=_not THEN BEGIN
  Get;
  Factor;
  OutNotAxBoolean;
 END ELSE IF tTok=_notbitwise THEN BEGIN
  Get;
  Factor;
  OutNotAxBitwise;
 END ELSE IF tTok=_sizeof THEN BEGIN
  SizeOfStatement;
  OutIntAxToFPU;
  OutFPUToAx;
 END ELSE IF tTok=_inherited THEN BEGIN
  InheritedStatement;
  IF (NameTabelle[AktSymPtr].Typ<>tFloat) AND NOT NameTabelle[AktSymPtr].Zeiger THEN BEGIN
   OutIntAxToFPU;
   OutFPUToAx;
  END;
 END ELSE IF tTok=_ident THEN BEGIN
  IF LockVar(sTok,'',A,Adr,FALSE,-1) THEN BEGIN
   IF NameTabelle[AktSymPtr].Art=aGlobal THEN BEGIN
    AltAktSymPtr:=AktSymPtr;
    IF LookStructVar(sTok)<0 THEN BEGIN
     AktSymPtr:=AltAktSymPtr;
    END ELSE BEGIN
     ObjectVar:=TRUE;
    END;
   END;
  END ELSE BEGIN
   IF LookStructVar(sTok)<0 THEN BEGIN
    SetError(ceVarNotDef);
   END ELSE BEGIN
    ObjectVar:=TRUE;
   END;
  END;
  IF ObjectVar THEN BEGIN
   OutPushBx;
   UseEBX:=TRUE;
   StringArray:=StructAssignment(Zeiger,FALSE,TRUE,FALSE);
   AltSymPtr:=AktSymPtr;
   S:=stok;
  END ELSE IF NameTabelle[AktSymPtr].EinTyp THEN BEGIN
   OutPushBx;
   UseEBX:=TRUE;
   StringArray:=StructAssignment(Zeiger,FALSE,FALSE,FALSE);
   AltSymPtr:=AktSymPtr;
   IF (NameTabelle[AltSymPtr].Obj=_call) AND (tTok=_lparent) AND NOT HoleZeiger THEN BEGIN
    I:=CallState(FALSE,TRUE,TRUE);
    IF (NameTabelle[I].Typ=tFloat) AND NOT NameTabelle[I].Zeiger THEN BEGIN
     OutFPUToAX;
    END;
    IF (NameTabelle[I].Typ<>tFloat) AND NOT NameTabelle[I].Zeiger THEN BEGIN
     OutIntAxToFPU;
     OutFPUToAx;
    END;
    IsFloatExpression:=TRUE;
    EXIT;
   END;
   S:=stok;
  END ELSE BEGIN
   UseEBX:=FALSE;
   AltSymPtr:=AktSymPtr;
   S:=stok;
   Get;
  END;
  IF (tTok=_klparent) AND NOT UseEBX THEN BEGIN
   UseArray:=TRUE;
   IF NameTabelle[AktSymPtr].IstArray THEN BEGIN
    Get;
    AltStringHandling:=StringHandling;
    StringHandling.IstZeiger:=FALSE;
    IsTermSigned:=FALSE;
    DoExpressionEx;
    StringHandling:=AltStringHandling;
    IF tTok=_krparent THEN BEGIN
     OutMovCxAx;
     Get;
    END ELSE BEGIN
     SetError(ceKRParentErwartet);
    END;
   END ELSE BEGIN
    SetError(ceKeinArray);
   END;
  END;
  IF AltTok IN [_plusplus,_minusminus] THEN BEGIN
   IF (NameTabelle[AktSymPtr].Typ=tFloat) AND NOT NameTabelle[AktSymPtr].Zeiger THEN BEGIN
    IF UseEBX THEN BEGIN
     CASE AltTok OF
      _plusplus:BEGIN
       OutMovFromStructVar(AltSymPtr);
       OutIncFPU;
       OutMovToStructVar(AltSymPtr);
      END;
      _minusminus:BEGIN
       OutMovFromStructVar(AltSymPtr);
       OutDecFPU;
       OutMovToStructVar(AltSymPtr);
      END;
     END;
    END ELSE BEGIN
     CASE AltTok OF
      _plusplus:BEGIN
       OutMovAxVar(S,0,Zeiger,UseArray);
       OutIncFPU;
       OutMovVarAx(S,0,Zeiger,UseArray);
      END;
      _minusminus:BEGIN
       OutMovAxVar(S,0,Zeiger,UseArray);
       OutDecFPU;
       OutMovVarAx(S,0,Zeiger,UseArray);
      END;
     END;
    END;
   END ELSE BEGIN
    IF UseEBX THEN BEGIN
     CASE AltTok OF
      _plusplus:OutIncStructVar;
      _minusminus:OutDecStructVar;
     END;
    END ELSE BEGIN
     CASE AltTok OF
      _plusplus:OutIncVar(S,Zeiger,UseArray);
      _minusminus:OutDecVar(S,Zeiger,UseArray);
     END;
    END;
   END;
  END;
  IF UseEBX THEN BEGIN
   IF HoleZeiger THEN BEGIN
    SetError(ceFloatTypeExpected);
   END ELSE BEGIN
    OutMovFromStructVar(AltSymPtr);
    IF (NameTabelle[AktSymPtr].Typ<>tFloat) AND NOT NameTabelle[AktSymPtr].Zeiger THEN BEGIN
     OutIntAxToFPU;
     OutFPUToAx;
    END;
   END;
  END ELSE BEGIN
   IF HoleZeiger THEN BEGIN
    SetError(ceFloatTypeExpected);
   END ELSE BEGIN
    OutMovAxVar(S,0,Zeiger,UseArray);
    IF (NameTabelle[AktSymPtr].Typ<>tFloat) AND NOT NameTabelle[AktSymPtr].Zeiger THEN BEGIN
     OutIntAxToFPU;
     OutFPUToAx;
    END;
   END;
  END;
  IF tTok IN [_plusplus,_minusminus] THEN BEGIN
   IF (NameTabelle[AktSymPtr].Typ=tFloat) AND NOT NameTabelle[AktSymPtr].Zeiger THEN BEGIN
    IF UseEBX THEN BEGIN
     CASE tTok OF
      _plusplus:BEGIN
       OutMovFromStructVar(AltSymPtr);
       OutIncFPU;
       OutMovToStructVar(AltSymPtr);
      END;
      _minusminus:BEGIN
       OutMovFromStructVar(AltSymPtr);
       OutDecFPU;
       OutMovToStructVar(AltSymPtr);
      END;
     END;
    END ELSE BEGIN
     CASE tTok OF
      _plusplus:BEGIN
       OutMovAxVar(S,0,Zeiger,UseArray);
       OutIncFPU;
       OutMovVarAx(S,0,Zeiger,UseArray);
      END;
      _minusminus:BEGIN
       OutMovAxVar(S,0,Zeiger,UseArray);
       OutDecFPU;
       OutMovVarAx(S,0,Zeiger,UseArray);
      END;
     END;
    END;
   END ELSE BEGIN
    IF UseEBX THEN BEGIN
     CASE tTok OF
      _plusplus:OutIncStructVar;
      _minusminus:OutDecStructVar;
     END;
    END ELSE BEGIN
     CASE tTok OF
      _plusplus:OutIncVar(S,Zeiger,UseArray);
      _minusminus:OutDecVar(S,Zeiger,UseArray);
     END;
    END;
   END;
   Get;
  END;
  IF UseEBX THEN OutPopBx;
 END ELSE IF tTok=_call THEN BEGIN
  IF HoleZeiger THEN BEGIN
   SetError(ceFloatTypeExpected);
  END ELSE BEGIN
   I:=CallState(TRUE,FALSE,TRUE);
   IF (NameTabelle[I].Typ=tFloat) AND NOT NameTabelle[I].Zeiger THEN BEGIN
    OutFPUToAX;
   END;
   IF (NameTabelle[I].Typ<>tFloat) AND NOT NameTabelle[I].Zeiger THEN BEGIN
    OutIntAxToFPU;
    OutFPUToAx;
   END;
  END;
 END ELSE IF tTok=_string THEN BEGIN
  SetError(ceFloatTypeExpected);
 END ELSE BEGIN
  CASE tTok OF
   _enumvalue:BEGIN
    IF LockVar(sTok,'',a,Adr,FALSE,-1) THEN BEGIN
     OutMovAxImmSigned(NameTabelle[AktSymPtr].Wert);
    END ELSE BEGIN
     SetError(ceVarNotDef);
    END;
    OutIntAxToFPU;
    OutFPUToAx;
   END;
   _integer:BEGIN
    OutMovAxImmSigned(iTok);
    OutIntAxToFPU;
    OutFPUToAx;
   END;
   _floatnum:BEGIN
    OutMovAxImmSigned(LONGWORD(POINTER(@fTok)^));
   END;
   _lparent:BEGIN
    Get;
    FloatBoolExpression;
    IF tTok<>_rparent THEN SetError(ceRParenExp);
   END;
   ELSE SetError(ceErrInExpr);
  END;
  Get;
 END;
END;

PROCEDURE TBeRoScript.FloatTerm;
VAR op:BYTE;
BEGIN
 IsFloatExpression:=TRUE;
 FloatFactor;
 WHILE (tTok IN [_mul,_div,_mod,_and,_or,_shl,_shr,_xor]) AND NOT (feof OR ferror) DO BEGIN
  op:=tTok;
  OutPushAx;
  Get;
  FloatFactor;
  CASE op OF
   _mul:BEGIN
    OutPopBx;
    OutAXToFPU;
    OutPushBx;
    OutFPUMul;
    OutPopBx;
    OutFPUToAx;
   END;
   _div:BEGIN
    OutPopBx;
    OutXChgAxBx;
    OutAXToFPU;
    OutPushBx;
    OutFPUDiv;
    OutPopBx;
    OutFPUToAx;
   END;
   _mod:BEGIN
    SetError(ceFloatOperationError);
   END;
   _and:BEGIN
    SetError(ceFloatOperationError);
   END;
   _or:BEGIN
    SetError(ceFloatOperationError);
   END;
   _shl:BEGIN
    SetError(ceFloatOperationError);
   END;
   _shr:BEGIN
    SetError(ceFloatOperationError);
   END;
   _xor:BEGIN
    SetError(ceFloatOperationError);
   END;
  END;
  OutFPUWait;
 END;
END;

PROCEDURE TBeRoScript.FloatExpression;
VAR op:BYTE;
BEGIN
 IsFloatExpression:=TRUE;
 IF tTok IN [_plus,_minus] THEN BEGIN
  OutXorAxAx;
  OutIntAxToFPU;
  OutFPUToAx;
 END ELSE BEGIN
  FloatTerm;
 END;
 WHILE (tTok IN [_plus,_minus]) AND NOT (feof OR ferror) DO BEGIN
  op:=tTok;
  OutPushAx;
  Get;
  FloatTerm;
  CASE op OF
   _plus:BEGIN
    OutPopBx;
    OutAXToFPU;
    OutPushBx;
    OutFPUAdd;
    OutPopBx;
    OutFPUToAx;
   END;
   _minus:BEGIN
    OutPopBx;
    OutXChgAxBx;
    OutAXToFPU;
    OutPushBx;
    OutFPUSub;
    OutPopBx;
    OutFPUToAx;
   END;
  END;
  OutFPUWait;
 END;
END;

PROCEDURE TBeRoScript.FloatBoolExpression;
VAR op:BYTE;
    SNO,SE:STRING;
BEGIN
 IsFloatExpression:=TRUE;
 FloatExpression;
 IF tTok=_shortif THEN BEGIN
  Get;
  SNO:=GeneratiereLabel;
  SE:=GeneratiereLabel;
  OutFPUToIntAX;
  OutXorBxBx;
  OutNe;
  OutJZIF(SNO);
  FloatBoolExpression;
  OutJMP(SE);
  IF tTok=_doublepoint THEN BEGIN
   Get;
  END ELSE BEGIN
   SetError(ceDoppelPunktErwartet);
  END;
  OutLabel(SNO);
  FloatBoolExpression;
  OutLabel(SE);
 END ELSE IF tTok IN [_eql,_neg,_lss,_lea,_gre,_gra,_isnot] THEN BEGIN
  op:=tTok;
  OutPushAx;
  Get;
  FloatExpression;
  OutMovBxAx;
  OutPopAx;
  CASE op OF
   _eql:BEGIN
    OutEql;
    IsFloatExpression:=FALSE;
   END;
   _neg,_isnot:BEGIN
    OutNe;
    IsFloatExpression:=FALSE;
   END;
   _lss:BEGIN
    OutAXToFPU;
    OutPushBx;
    OutFPULss;
    OutPopBx;
    IsFloatExpression:=FALSE;
   END;
   _lea:BEGIN
    OutAXToFPU;
    OutPushBx;
    OutFPULea;
    OutPopBx;
    IsFloatExpression:=FALSE;
   END;
   _gre:BEGIN
    OutAXToFPU;
    OutPushBx;
    OutFPUGre;
    OutPopBx;
    IsFloatExpression:=FALSE;
   END;
   _gra:BEGIN
    OutAXToFPU;
    OutPushBx;
    OutFPUGra;
    OutPopBx;
    IsFloatExpression:=FALSE;
   END;
  END;
  OutFPUWait;
 END;
END;

PROCEDURE TBeRoScript.FloatBoolExpressionEx;
VAR op:BYTE;
    SNO,SE:STRING;
BEGIN
 IsFloatExpression:=TRUE;
 IF tTok=_shortif THEN BEGIN
  Get;
  SNO:=GeneratiereLabel;
  SE:=GeneratiereLabel;
  OutFPUToIntAX;
  OutXorBxBx;
  OutNe;
  OutJZIF(SNO);
  FloatBoolExpression;
  OutJMP(SE);
  IF tTok=_doublepoint THEN BEGIN
   Get;
  END ELSE BEGIN
   SetError(ceDoppelPunktErwartet);
  END;
  OutLabel(SNO);
  FloatBoolExpression;
  OutLabel(SE);
 END ELSE IF tTok IN [_eql,_neg,_lss,_lea,_gre,_gra,_isnot] THEN BEGIN
  op:=tTok;
  OutPushAx;
  Get;
  FloatExpression;
  OutMovBxAx;
  OutPopAx;
  CASE op OF
   _eql:BEGIN
    OutEql;
    IsFloatExpression:=FALSE;
   END;
   _neg,_isnot:BEGIN
    OutNe;
    IsFloatExpression:=FALSE;
   END;
   _lss:BEGIN
    OutAXToFPU;
    OutPushBx;
    OutFPULss;
    OutPopBx;
    IsFloatExpression:=FALSE;
   END;
   _lea:BEGIN
    OutAXToFPU;
    OutPushBx;
    OutFPULea;
    OutPopBx;
    IsFloatExpression:=FALSE;
   END;
   _gre:BEGIN
    OutAXToFPU;
    OutPushBx;
    OutFPUGre;
    OutPopBx;
    IsFloatExpression:=FALSE;
   END;
   _gra:BEGIN
    OutAXToFPU;
    OutPushBx;
    OutFPUGra;
    OutPopBx;
    IsFloatExpression:=FALSE;
   END;
  END;
  OutFPUWait;
 END;
END;

FUNCTION TBeRoScript.Factor:BOOLEAN;
VAR Adr:TWert;
    S,a,S1,S2:STRING;
    AltTok:INTEGER;
    Zeiger,HoleZeiger,UseArray,StringArray,ObjectVar:BOOLEAN;
    B,LB:LONGWORD;
    AltStringHandling:TStringHandling;
    UseEBX:BOOLEAN;
    I,AltSymPtr,AltAktSymPtr:INTEGER;
    _T:BOOLEAN;
BEGIN
 UseEBX:=FALSE;
 IF tTok=_ident THEN BEGIN
  IF LockVar(sTok,'',A,Adr,FALSE,-1) THEN BEGIN
   IF NameTabelle[AktSymPtr].Art=aGlobal THEN BEGIN
    AltAktSymPtr:=AktSymPtr;
    IF LookStructVar(sTok)<0 THEN BEGIN
     AktSymPtr:=AltAktSymPtr;
    END;
   END;
  END ELSE BEGIN
   IF LookStructVar(sTok)<0 THEN BEGIN
    SetError(ceVarNotDef);
   END;
  END;
  IF fError THEN BEGIN
  END ELSE IF NOT NameTabelle[AktSymPtr].Zeiger THEN BEGIN
   IF NameTabelle[AktSymPtr].Typ=tFloat THEN BEGIN
    FloatBoolExpression;
    RESULT:=IsFloatExpression;
    EXIT;
   END;
   IF NameTabelle[AktSymPtr].Typ=tString THEN BEGIN
    IsStringTerm:=TRUE;
    MustBeStringTerm:=FALSE;
    StringLevel:=0;
    StringBoolExpression(TRUE);
    RESULT:=IsFloatExpression;
    EXIT;
   END;
  END;
 END ELSE IF tTok=_floatnum THEN BEGIN
  FloatBoolExpression;
  RESULT:=IsFloatExpression;
  EXIT;
 END;
 Zeiger:=FALSE;
 HoleZeiger:=FALSE;
 UseArray:=FALSE;
 ObjectVar:=FALSE;
 AltTok:=0;
 IF tTok IN [_plusplus,_minusminus] THEN BEGIN
  AltTok:=tTok;
  Get;
 END;
 IF tTok IN [_mul] THEN BEGIN
  Zeiger:=TRUE;
  Get;
 END;
 IF tTok IN [_and] THEN BEGIN
  HoleZeiger:=TRUE;
  Get;
 END;
 IF tTok=_not THEN BEGIN
  Get;
  _T:=Factor;
  OutNotAxBoolean;
 END ELSE IF tTok=_notbitwise THEN BEGIN
  Get;
  _T:=Factor;
  OutNotAxBitwise;
 END ELSE IF tTok=_sizeof THEN BEGIN
  SizeOfStatement;
  IF IsFloatExpression THEN BEGIN
   OutIntAxToFPU;
   OutFPUToAx;
  END;
 END ELSE IF tTok=_inherited THEN BEGIN
  InheritedStatement;
 END ELSE IF (tTok=_ident) OR ((tTok=_call) AND HoleZeiger) THEN BEGIN
  IF LockVar(sTok,'',A,Adr,FALSE,-1) THEN BEGIN
   IF NameTabelle[AktSymPtr].Art=aGlobal THEN BEGIN
    AltAktSymPtr:=AktSymPtr;
    IF LookStructVar(sTok)<0 THEN BEGIN
     AktSymPtr:=AltAktSymPtr;
    END ELSE BEGIN
     ObjectVar:=TRUE;
    END;
   END;
  END ELSE BEGIN
   IF LookStructVar(sTok)<0 THEN BEGIN
    SetError(ceVarNotDef);
   END ELSE BEGIN
    ObjectVar:=TRUE;
   END;
  END;
  IF ObjectVar THEN BEGIN
   OutPushBx;
   UseEBX:=TRUE;
   StringArray:=StructAssignment(Zeiger,FALSE,TRUE,FALSE);
   AltSymPtr:=AktSymPtr;
   S:=stok;
  END ELSE IF NameTabelle[AktSymPtr].EinTyp THEN BEGIN
   OutPushBx;
   UseEBX:=TRUE;
   StringArray:=StructAssignment(Zeiger,FALSE,FALSE,FALSE);
   AltSymPtr:=AktSymPtr;
   IF (NameTabelle[AltSymPtr].Obj=_call) AND (tTok=_lparent) AND NOT HoleZeiger THEN BEGIN
    I:=CallState(FALSE,TRUE,TRUE);
    IF NameTabelle[AktSymPtr].Typ=tString THEN BEGIN
     IF NameTabelle[I].Typ<>tString THEN BEGIN
      SetError(ceStringTypeExpected);
     END;
     IsStringTerm:=TRUE;
     MustBeStringTerm:=FALSE;
     StringLevel:=0;
     StringBoolExpression(TRUE);
     RESULT:=IsFloatExpression;
     EXIT;
    END ELSE BEGIN
     IsTermSigned:=IsTermSigned OR (NameTabelle[I].Typ IN [tByte,tChar,tShortInt,tInt]);
     IF (NameTabelle[I].Typ=tFloat) AND NOT NameTabelle[I].Zeiger THEN BEGIN
      OutFPUToAX;
      IsFloatExpression:=TRUE;
     END;
     IF IsFloatExpression THEN BEGIN
      IF (NameTabelle[I].Typ<>tFloat) AND NOT NameTabelle[I].Zeiger THEN BEGIN
       OutIntAxToFPU;
       OutFPUToAx;
      END;
     END ELSE BEGIN
      IF (NameTabelle[I].Typ=tFloat) AND NOT NameTabelle[I].Zeiger THEN BEGIN
       IsFloatExpression:=TRUE;
      END;
     END;
    END;
    RESULT:=IsFloatExpression;
    EXIT;
   END;
   S:=stok;
  END ELSE BEGIN
   UseEBX:=FALSE;
   AltSymPtr:=AktSymPtr;
   S:=stok;
   Get;
  END;
  IF (tTok=_klparent) AND NOT UseEBX THEN BEGIN
   UseArray:=TRUE;
   IF NameTabelle[AktSymPtr].IstArray THEN BEGIN
    Get;
    AltStringHandling:=StringHandling;
    StringHandling.IstZeiger:=FALSE;
    IsTermSigned:=FALSE;
    DoExpressionEx;
    StringHandling:=AltStringHandling;
    IF tTok=_krparent THEN BEGIN
     OutMovCxAx;
     Get;
    END ELSE BEGIN
     SetError(ceKRParentErwartet);
    END;
   END ELSE BEGIN
    SetError(ceKeinArray);
   END;
  END;
  IsTermSigned:=IsTermSigned OR (NameTabelle[AltSymPtr].Typ IN [tByte,tChar,tShortInt,tInt]);
  IF AltTok IN [_plusplus,_minusminus] THEN BEGIN
   IF (NameTabelle[AktSymPtr].Typ=tFloat) AND NOT NameTabelle[AktSymPtr].Zeiger THEN BEGIN
    IF UseEBX THEN BEGIN
     CASE AltTok OF
      _plusplus:BEGIN
       OutMovFromStructVar(AltSymPtr);
       OutIncFPU;
       OutMovToStructVar(AltSymPtr);
      END;
      _minusminus:BEGIN
       OutMovFromStructVar(AltSymPtr);
       OutDecFPU;
       OutMovToStructVar(AltSymPtr);
      END;
     END;
    END ELSE BEGIN
     CASE AltTok OF
      _plusplus:BEGIN
       OutMovAxVar(S,0,Zeiger,UseArray);
       OutIncFPU;
       OutMovVarAx(S,0,Zeiger,UseArray);
      END;
      _minusminus:BEGIN
       OutMovAxVar(S,0,Zeiger,UseArray);
       OutDecFPU;
       OutMovVarAx(S,0,Zeiger,UseArray);
      END;
     END;
    END;
   END ELSE BEGIN
    IF UseEBX THEN BEGIN
     CASE AltTok OF
      _plusplus:OutIncStructVar;
      _minusminus:OutDecStructVar;
     END;
    END ELSE BEGIN
     CASE AltTok OF
      _plusplus:OutIncVar(S,Zeiger,UseArray);
      _minusminus:OutDecVar(S,Zeiger,UseArray);
     END;
    END;
   END;
  END;             
  IF UseEBX THEN BEGIN
   IF HoleZeiger THEN BEGIN
    OutMovAxBx;
   END ELSE BEGIN
    OutMovFromStructVar(AltSymPtr);
   END;
  END ELSE BEGIN
   IF HoleZeiger THEN BEGIN
    OutMovAxVarAdr(S,0,Zeiger,UseArray);
   END ELSE BEGIN
    OutMovAxVar(S,0,Zeiger,UseArray);
   END;
  END;
  IF (NameTabelle[AktSymPtr].Typ=tString) AND NOT NameTabelle[AktSymPtr].Zeiger THEN BEGIN
   IsStringTerm:=TRUE;
   MustBeStringTerm:=FALSE;
   StringLevel:=0;
   StringBoolExpression(FALSE);
   RESULT:=IsFloatExpression;
   EXIT;
  END;
  IF tTok IN [_plusplus,_minusminus] THEN BEGIN
   IF (NameTabelle[AktSymPtr].Typ=tFloat) AND NOT NameTabelle[AktSymPtr].Zeiger THEN BEGIN
    IF UseEBX THEN BEGIN
     CASE tTok OF
      _plusplus:BEGIN
       OutMovFromStructVar(AltSymPtr);
       OutIncFPU;
       OutMovToStructVar(AltSymPtr);
      END;
      _minusminus:BEGIN
       OutMovFromStructVar(AltSymPtr);
       OutDecFPU;
       OutMovToStructVar(AltSymPtr);
      END;
     END;
    END ELSE BEGIN
     CASE tTok OF
      _plusplus:BEGIN
       OutMovAxVar(S,0,Zeiger,UseArray);
       OutIncFPU;
       OutMovVarAx(S,0,Zeiger,UseArray);
      END;
      _minusminus:BEGIN
       OutMovAxVar(S,0,Zeiger,UseArray);
       OutDecFPU;
       OutMovVarAx(S,0,Zeiger,UseArray);
      END;
     END;
    END;
   END ELSE BEGIN
    IF UseEBX THEN BEGIN
     CASE tTok OF
      _plusplus:OutIncStructVar;
      _minusminus:OutDecStructVar;
     END;
    END ELSE BEGIN
     CASE tTok OF
      _plusplus:OutIncVar(S,Zeiger,UseArray);
      _minusminus:OutDecVar(S,Zeiger,UseArray);
     END;
    END;
   END;
   Get;
  END;
  IF UseEBX THEN OutPopBx;
 END ELSE IF tTok=_call THEN BEGIN
  IF NOT UseEBX THEN BEGIN
   IF LockVar(sTok,'',A,Adr,FALSE,-1) THEN BEGIN
    IF NameTabelle[AktSymPtr].Art=aGlobal THEN BEGIN
     AltAktSymPtr:=AktSymPtr;
     IF LookStructVar(sTok)<0 THEN BEGIN
      AktSymPtr:=AltAktSymPtr;
     END;
    END;
   END ELSE BEGIN
    IF LookStructVar(sTok)<0 THEN BEGIN
     SetError(ceVarNotDef);
    END;
   END;
  END;
  IF HoleZeiger THEN BEGIN
   OutMovAxVarAdr(S,0,Zeiger,UseArray);
  END ELSE BEGIN
   IF NameTabelle[AktSymPtr].Typ=tString THEN BEGIN
    I:=CallState(TRUE,FALSE,TRUE);
    IF NameTabelle[I].Typ<>tString THEN BEGIN
     SetError(ceStringTypeExpected);
    END;
    IsStringTerm:=TRUE;
    MustBeStringTerm:=FALSE;
    StringLevel:=0;
    StringBoolExpression(TRUE);
    RESULT:=IsFloatExpression;
    EXIT;
   END ELSE BEGIN
    I:=CallState(TRUE,FALSE,TRUE);
    IsTermSigned:=IsTermSigned OR (NameTabelle[I].Typ IN [tByte,tChar,tShortInt,tInt]);
    IF (NameTabelle[I].Typ=tFloat) AND NOT NameTabelle[I].Zeiger THEN BEGIN
     OutFPUToAX;
     IsFloatExpression:=TRUE;
    END;
    IF IsFloatExpression THEN BEGIN
     IF (NameTabelle[I].Typ<>tFloat) AND NOT NameTabelle[I].Zeiger THEN BEGIN
      OutIntAxToFPU;
      OutFPUToAx;
     END;
    END ELSE BEGIN
     IF (NameTabelle[I].Typ=tFloat) AND NOT NameTabelle[I].Zeiger THEN BEGIN
      IsFloatExpression:=TRUE;
     END;
    END;
   END;
  END;
 END ELSE IF tTok=_string THEN BEGIN
  IF StringHandling.IstZeiger THEN BEGIN
   StringFactor;
  END ELSE BEGIN
   B:=0;
   LB:=LENGTH(AktStr);
   IF LB>4 THEN LB:=4;
   IF LB>0 THEN MOVE(AktStr[1],B,LB);
   OutMovAxImmSigned(B);
   Get;
  END;
 END ELSE BEGIN
  CASE tTok OF
   _enumvalue:BEGIN
    IF LockVar(sTok,'',a,Adr,FALSE,-1) THEN BEGIN
     OutMovAxImmSigned(NameTabelle[AktSymPtr].Wert);
    END ELSE BEGIN
     SetError(ceVarNotDef);
    END;
   END;
   _integer:BEGIN
    OutMovAxImmSigned(iTok);
    IsTermSigned:=IsTermSigned OR (iTok<0);
    IF IsFloatExpression THEN BEGIN
     OutIntAXToFPU;
     OutFPUToAX;
    END;
   END;
   _lparent:BEGIN
    Get;
    BoolExpression;
    IF tTok<>_rparent THEN SetError(ceRParenExp);
   END;
   ELSE SetError(ceErrInExpr);
  END;
  Get;
 END;
 RESULT:=IsFloatExpression;
END;

FUNCTION TBeRoScript.Term:BOOLEAN;
VAR op:BYTE;
    S:STRING;
    Adr:TWert;
    BA,BB:BOOLEAN;
    AltAktSymPtr:INTEGER;
BEGIN
 IF tTok=_ident THEN BEGIN
  IF LockVar(sTok,'',S,Adr,FALSE,-1) THEN BEGIN
   IF NameTabelle[AktSymPtr].Art=aGlobal THEN BEGIN
    AltAktSymPtr:=AktSymPtr;
    IF LookStructVar(sTok)<0 THEN BEGIN
     AktSymPtr:=AltAktSymPtr;
    END;
   END;
  END ELSE BEGIN
   IF LookStructVar(sTok)<0 THEN BEGIN
    SetError(ceVarNotDef);
   END;
  END;
  IF fError THEN BEGIN
  END ELSE IF NOT NameTabelle[AktSymPtr].Zeiger THEN BEGIN
   IF NameTabelle[AktSymPtr].Typ=tFloat THEN BEGIN
    FloatBoolExpression;
    RESULT:=IsFloatExpression;
    EXIT;
   END;
   IF NameTabelle[AktSymPtr].Typ=tString THEN BEGIN
    IsStringTerm:=TRUE;
    MustBeStringTerm:=FALSE;
    StringLevel:=0;
    StringBoolExpression(TRUE);
    RESULT:=IsFloatExpression;
    EXIT;
   END;
  END;
 END ELSE IF tTok=_floatnum THEN BEGIN
  FloatBoolExpression;
  RESULT:=IsFloatExpression;
  EXIT;
 END;
 BA:=Factor;
 WHILE (tTok IN [_mul,_div,_mod,_and,_or,_shl,_shr,_xor]) AND NOT (feof OR ferror) DO BEGIN
  op:=tTok;
  OutPushAx;
  Get;
  BB:=Factor;
  IF IsFloatExpression THEN BEGIN
   IF NOT BA THEN BEGIN
    OutPopBx;
    OutXChgAxBx;
    OutIntAXToFPU;
    OutFPUToAX;
    OutXChgAxBx;
    OutPushBx;
   END;
   IF NOT BB THEN BEGIN
    OutIntAXToFPU;
    OutFPUToAX;
   END;
   CASE op OF
    _mul:BEGIN
     OutPopBx;
     OutAXToFPU;
     OutPushBx;
     OutFPUMul;
     OutPopBx;
     OutFPUToAx;
    END;
    _div:BEGIN
     OutPopBx;
     OutXChgAxBx;
     OutAXToFPU;
     OutPushBx;
     OutFPUDiv;
     OutPopBx;
     OutFPUToAx;
    END;
    _mod:BEGIN
     SetError(ceFloatOperationError);
    END;
    _and:BEGIN
     SetError(ceFloatOperationError);
    END;
    _or:BEGIN
     SetError(ceFloatOperationError);
    END;
    _shl:BEGIN
     SetError(ceFloatOperationError);
    END;
    _shr:BEGIN
     SetError(ceFloatOperationError);
    END;
    _xor:BEGIN
     SetError(ceFloatOperationError);
    END;
   END;
   OutFPUWait;
  END ELSE BEGIN
   CASE op OF
    _mul:BEGIN
     OutPopBx;
     IF IsTermSigned THEN BEGIN
      OutIMulBx;
     END ELSE BEGIN
      OutMulBx;
     END;
    END;
    _div:BEGIN
     OutMovBxAx;
     OutPopAx;
     IF IsTermSigned THEN BEGIN
      OutIDivBx;
     END ELSE BEGIN
      OutDivBx;
     END;
    END;
    _mod:BEGIN
     OutMovBxAx;
     OutPopAx;
     IF IsTermSigned THEN BEGIN
      OutIModBx;
     END ELSE BEGIN
      OutModBx;
     END;
    END;
    _and:BEGIN
     OutMovBxAx;
     OutPopAx;
     OutAndBx;
    END;
    _or:BEGIN
     OutMovBxAx;
     OutPopAx;
     OutOrBx;
    END;
    _shl:BEGIN
     OutMovBxAx;
     OutPopAx;
     OutShlBx;
    END;
    _shr:BEGIN
     OutMovBxAx;
     OutPopAx;
     OutShrBx;
    END;
    _xor:BEGIN
     OutMovBxAx;
     OutPopAx;
     OutXorBx;
    END;
   END;
  END;
 END;
 RESULT:=IsFloatExpression;
END;

FUNCTION TBeRoScript.Expression:BOOLEAN;
VAR op:BYTE;
    S:STRING;
    Adr:TWert;
    BA,BB:BOOLEAN;
    AltAktSymPtr:INTEGER;
BEGIN
 IF tTok=_ident THEN BEGIN
  IF LockVar(sTok,'',S,Adr,FALSE,-1) THEN BEGIN
   IF NameTabelle[AktSymPtr].Art=aGlobal THEN BEGIN
    AltAktSymPtr:=AktSymPtr;
    IF LookStructVar(sTok)<0 THEN BEGIN
     AktSymPtr:=AltAktSymPtr;
    END;
   END;
  END ELSE BEGIN
   IF LookStructVar(sTok)<0 THEN BEGIN
    SetError(ceVarNotDef);
   END;
  END;
  IF fError THEN BEGIN
  END ELSE IF NOT NameTabelle[AktSymPtr].Zeiger THEN BEGIN
   IF NameTabelle[AktSymPtr].Typ=tFloat THEN BEGIN
    FloatBoolExpression;
    RESULT:=IsFloatExpression;
    EXIT;
   END;
   IF NameTabelle[AktSymPtr].Typ=tString THEN BEGIN
    IsStringTerm:=TRUE;
    MustBeStringTerm:=FALSE;
    StringLevel:=0;
    StringBoolExpression(TRUE);
    RESULT:=IsFloatExpression;
    EXIT;
   END;
  END;
 END ELSE IF tTok=_floatnum THEN BEGIN
  FloatBoolExpression;
  RESULT:=IsFloatExpression;
  EXIT;
 END;
 IF tTok IN [_plus,_minus] THEN BEGIN
  OutXorAxAx;
  BA:=FALSE;
  IsTermSigned:=IsTermSigned OR (tTok=_minus);
 END ELSE BEGIN
  BA:=Term;
 END;
 WHILE (tTok IN [_plus,_minus]) AND NOT (feof OR ferror) DO BEGIN
  op:=tTok;
  OutPushAx;
  Get;
  BB:=Term;
  IF IsFloatExpression THEN BEGIN
   IF NOT BA THEN BEGIN
    OutPopBx;
    OutXChgAxBx;
    OutIntAXToFPU;
    OutFPUToAX;
    OutXChgAxBx;
    OutPushBx;
   END;
   IF NOT BB THEN BEGIN
    OutIntAXToFPU;
    OutFPUToAX;
   END;
   CASE op OF
    _plus:BEGIN
     OutPopBx;
     OutAXToFPU;
     OutPushBx;
     OutFPUAdd;
     OutPopBx;
     OutFPUToAx;
    END;
    _minus:BEGIN
     OutPopBx;
     OutXChgAxBx;
     OutAXToFPU;
     OutPushBx;
     OutFPUSub;
     OutPopBx;
     OutFPUToAx;
    END;
   END;
   OutFPUWait;
  END ELSE BEGIN
   CASE op OF
    _plus:BEGIN
     OutPopBx;
     OutAddAxBx;
    END;
    _minus:BEGIN
     OutMovBxAx;
     OutPopAx;
     OutSubAxBx;
    END;
   END;
  END;
 END;
 RESULT:=IsFloatExpression;
END;

FUNCTION TBeRoScript.BoolExpression:BOOLEAN;
VAR op:BYTE;
    S,SNO,SE:STRING;
    Adr:TWert;
    Skip,BA,BB:BOOLEAN;
    AltAktSymPtr:INTEGER;
    _T:BOOLEAN;
BEGIN
 Skip:=FALSE;
 IF tTok=_ident THEN BEGIN
  IF LockVar(sTok,'',S,Adr,FALSE,-1) THEN BEGIN
   IF NameTabelle[AktSymPtr].Art=aGlobal THEN BEGIN
    AltAktSymPtr:=AktSymPtr;
    IF LookStructVar(sTok)<0 THEN BEGIN
     AktSymPtr:=AltAktSymPtr;
    END;
   END;
  END ELSE BEGIN
   IF LookStructVar(sTok)<0 THEN BEGIN
    SetError(ceVarNotDef);
   END;
  END;
  IF fError THEN BEGIN
  END ELSE IF NOT NameTabelle[AktSymPtr].Zeiger THEN BEGIN
   IF NameTabelle[AktSymPtr].Typ=tFloat THEN BEGIN
    FloatBoolExpression;
    RESULT:=IsFloatExpression;
    EXIT;
   END;
   IF NameTabelle[AktSymPtr].Typ=tString THEN BEGIN
    IsStringTerm:=TRUE;
    MustBeStringTerm:=FALSE;
    StringLevel:=0;
    StringBoolExpression(TRUE);
    IF IsStringTerm THEN BEGIN
     RESULT:=IsFloatExpression;
     EXIT;
    END;
    Skip:=TRUE;
   END;
  END;
 END ELSE IF tTok=_floatnum THEN BEGIN
  FloatBoolExpression;
  RESULT:=IsFloatExpression;
  EXIT;
 END;
 IF Skip THEN BEGIN
  BA:=IsFloatExpression;
 END ELSE BEGIN
  BA:=Expression;
 END;
 IF IsFloatExpression AND (tTok IN [_eql,_neg,_lss,_lea,_gre,_gra,_isnot]) THEN BEGIN
  FloatBoolExpressionEx;
  RESULT:=IsFloatExpression;
  EXIT;
 END;
 IF tTok=_shortif THEN BEGIN
  Get;
  SNO:=GeneratiereLabel;
  SE:=GeneratiereLabel;
  OutXorBxBx;
  OutNe;
  OutJZIF(SNO);
  _T:=BoolExpression;
  OutJMP(SE);
  IF tTok=_doublepoint THEN BEGIN
   Get;
  END ELSE BEGIN
   SetError(ceDoppelPunktErwartet);
  END;
  OutLabel(SNO);
  _T:=BoolExpression;
  OutLabel(SE);
 END ELSE IF tTok IN [_eql,_neg,_lss,_lea,_gre,_gra,_isnot] THEN BEGIN
  op:=tTok;
  OutPushAx;
  Get;
  BB:=Expression;
  OutMovBxAx;
  OutPopAx;
  IF IsFloatExpression THEN BEGIN
   IF NOT BA THEN BEGIN
    OutPopBx;
    OutXChgAxBx;
    OutIntAXToFPU;
    OutFPUToAX;
    OutXChgAxBx;
    OutPushBx;
   END;
   IF NOT BB THEN BEGIN
    OutIntAXToFPU;
    OutFPUToAX;
   END;
   CASE op OF
    _eql:OutEql;
    _neg,_isnot:OutNe;
    _lss:BEGIN
     OutAXToFPU;
     OutPushBx;
     OutFPULss;
     OutPopBx;
    END;
    _lea:BEGIN
     OutAXToFPU;
     OutPushBx;
     OutFPULea;
     OutPopBx;
    END;
    _gre:BEGIN
     OutAXToFPU;
     OutPushBx;
     OutFPUGre;
     OutPopBx;
    END;
    _gra:BEGIN
     OutAXToFPU;
     OutPushBx;
     OutFPUGra;
     OutPopBx;
    END;
   END;
   OutFPUWait;
  END ELSE BEGIN
   CASE op OF
    _eql:OutEql;
    _neg,_isnot:OutNe;
    _lss:OutLss;
    _lea:OutLea;
    _gre:OutGre;
    _gra:OutGra;
   END;
  END;
 END;
 RESULT:=IsFloatExpression;
END;

PROCEDURE TBeRoScript.StringFactor;
VAR Adr:TWert;
    S,a,S1,S2:STRING;
    AltTok:INTEGER;
    Zeiger,HoleZeiger,UseArray,StringArray:BOOLEAN;
    B,LB:LONGWORD;
    AltStringHandling:TStringHandling;
    UseEBX:BOOLEAN;
    I,AltSymPtr,AltAktSymPtr:INTEGER;
    AltMustBeStringTerm,ObjectVar:BOOLEAN;
BEGIN
 IsStringTerm:=TRUE;
 Zeiger:=FALSE;
 HoleZeiger:=FALSE;
 UseArray:=FALSE;
 StringArray:=FALSE;
 ObjectVar:=FALSE;
 AltTok:=0;
 IF tTok IN [_plusplus,_minusminus] THEN BEGIN
  AltTok:=tTok;
  Get;
 END;
 IF tTok IN [_mul] THEN BEGIN
  Zeiger:=TRUE;
  Get;
 END;
 IF tTok IN [_and] THEN BEGIN
  HoleZeiger:=TRUE;
  Get;
 END;
 IF tTok=_not THEN BEGIN
  Get;
  StringFactor;
  SetError(ceIllegalStringOperation);
 END ELSE IF tTok=_notbitwise THEN BEGIN
  Get;
  StringFactor;
  OutNotAxBitwise;
  SetError(ceIllegalStringOperation);
 END ELSE IF tTok=_inherited THEN BEGIN
  InheritedStatement;
  IF NameTabelle[AktSymPtr].Typ=tChar THEN BEGIN
   OutStrCharConvert;
  END ELSE IF NameTabelle[AktSymPtr].Typ<>tString THEN BEGIN
   SetError(ceStringTypeExpected);
  END ELSE BEGIN
   OutStrIncrease;
   IsStringTerm:=TRUE;
  END;
 END ELSE IF (tTok=_ident) OR ((tTok=_call) AND HoleZeiger) THEN BEGIN
  IF LockVar(sTok,'',A,Adr,FALSE,-1) THEN BEGIN
   IF NameTabelle[AktSymPtr].Art=aGlobal THEN BEGIN
    AltAktSymPtr:=AktSymPtr;
    IF LookStructVar(sTok)<0 THEN BEGIN
     AktSymPtr:=AltAktSymPtr;
    END ELSE BEGIN
     ObjectVar:=TRUE;
    END;
   END;
  END ELSE BEGIN
   IF LookStructVar(sTok)<0 THEN BEGIN
    SetError(ceVarNotDef);
   END ELSE BEGIN
    ObjectVar:=TRUE;
   END;
  END;
  IF ObjectVar THEN BEGIN
   OutPushBx;
   UseEBX:=TRUE;
   StringArray:=StructAssignment(Zeiger,FALSE,TRUE,FALSE);
   AltSymPtr:=AktSymPtr;
   S:=stok;
  END ELSE IF NameTabelle[AktSymPtr].EinTyp THEN BEGIN
   OutPushBx;
   UseEBX:=TRUE;
   StringArray:=StructAssignment(Zeiger,FALSE,FALSE,FALSE);
   AltSymPtr:=AktSymPtr;
   IF (NameTabelle[AltSymPtr].Obj=_call) AND (tTok=_lparent) AND NOT HoleZeiger THEN BEGIN
    I:=CallState(FALSE,TRUE,TRUE);
    IF NameTabelle[I].Typ=tChar THEN BEGIN
     OutStrCharConvert;
    END ELSE IF NameTabelle[I].Typ<>tString THEN BEGIN
     SetError(ceStringTypeExpected);
    END ELSE BEGIN
     OutStrIncrease;
     IsStringTerm:=TRUE;
    END;
    EXIT;
   END;
   S:=stok;
  END ELSE BEGIN
   UseEBX:=FALSE;
   AltSymPtr:=AktSymPtr;
   S:=stok;
   Get;
  END;
  IF (tTok=_klparent) AND NOT UseEBX THEN BEGIN
   UseArray:=TRUE;
   IF NameTabelle[AktSymPtr].IstArray THEN BEGIN
    Get;
    AltStringHandling:=StringHandling;
    StringHandling.IstZeiger:=FALSE;
    IsTermSigned:=FALSE;
    DoExpressionEx;
    StringHandling:=AltStringHandling;
    IF tTok=_krparent THEN BEGIN
     OutMovCxAx;
     Get;
    END ELSE BEGIN
     SetError(ceKRParentErwartet);
    END;
   END ELSE IF (NameTabelle[AktSymPtr].Typ=tString) AND NOT HoleZeiger THEN BEGIN
    IF UseEBX THEN BEGIN
     OutMovAxBx;
    END ELSE BEGIN
     OutMovAxVarAdr(S,0,Zeiger,UseArray);
    END;
    Get;
    OutPushAx;
    AltMustBeStringTerm:=MustBeStringTerm;
    DoExpressionEx;
    MustBeStringTerm:=AltMustBeStringTerm;
    OutMovBxAx;
    OutPopAx;
    IF tTok=_krparent THEN BEGIN
     Get;
    END ELSE BEGIN
     SetError(ceKRParentErwartet);
    END;
    OutMovEAXStruct(4);
    OutPushAx;
    OutPushBx;
    OutCallNative('charat');
    StringArray:=TRUE;
    IF MustBeStringTerm THEN BEGIN
     OutStrCharConvert;
    END ELSE BEGIN
     IsStringTerm:=FALSE;
    END;
   END ELSE BEGIN
    SetError(ceKeinArray);
   END;
  END;
  IsTermSigned:=IsTermSigned OR (NameTabelle[AltSymPtr].Typ IN [tByte,tChar,tShortInt,tInt]);
  IF AltTok IN [_plusplus,_minusminus] THEN BEGIN
   SetError(ceIllegalStringOperation);
  END;
  IF NOT StringArray THEN BEGIN
   IF UseEBX THEN BEGIN
    IF HoleZeiger THEN BEGIN
     OutMovAxBx;
    END ELSE BEGIN
     OutMovFromStructVar(AltSymPtr);
    END;
   END ELSE BEGIN
    IF HoleZeiger THEN BEGIN
     OutMovAxVarAdr(S,0,Zeiger,UseArray);
    END ELSE BEGIN
     OutMovAxVar(S,0,Zeiger,UseArray);
    END;
   END;
   IF NameTabelle[AltSymPtr].Typ=tChar THEN BEGIN
    OutStrCharConvert;
   END ELSE IF NameTabelle[AltSymPtr].Typ<>tString THEN BEGIN
    SetError(ceStringTypeExpected);
   END ELSE BEGIN
    OutStrIncrease;
   END;
  END;
  IF tTok IN [_plusplus,_minusminus] THEN BEGIN
   SetError(ceIllegalStringOperation);
   Get;
  END;
  IF UseEBX THEN OutPopBx;
 END ELSE IF tTok=_call THEN BEGIN
  IF HoleZeiger THEN BEGIN
   SetError(ceStringTypeExpected);
  END ELSE BEGIN
   I:=CallState(TRUE,FALSE,TRUE);
   IF NameTabelle[I].Typ=tChar THEN BEGIN
    OutStrCharConvert;
   END ELSE IF NameTabelle[I].Typ<>tString THEN BEGIN
    SetError(ceStringTypeExpected);
   END ELSE BEGIN
    OutStrIncrease;
    IsStringTerm:=TRUE;
   END;
  END;
 END ELSE IF tTok=_string THEN BEGIN
  S1:=GeneratiereLabel;
  S2:=GeneratiereLabel;
  OutJmp(S1);
  DWordHinzufuegen(LENGTH(AktStr));
{$IFDEF FPC}
  DWordHinzufuegen(LENGTH(AktStr));
  DWordHinzufuegen($FFFFFFFF);
{$ELSE}
  DWordHinzufuegen($FFFFFFFF);
  DWordHinzufuegen(LENGTH(AktStr));
{$ENDIF}
  OutLabel(S2);
  FOR LB:=1 TO LENGTH(AktStr) DO ByteHinzufuegen(BYTE(AktStr[LB]));
  ByteHinzufuegen(0);
  OutLabel(S1);
  OutMovAxImmLabel(S2);
  Get;
 END ELSE BEGIN
  CASE tTok OF
   _enumvalue:BEGIN
    SetError(ceStringExpected);
   END;
   _integer:BEGIN
    SetError(ceStringExpected);
   END;
   _lparent:BEGIN
    Get;
    StringLevel:=0;
    MustBeStringTerm:=TRUE;
    StringExpression(TRUE);
    IF tTok<>_rparent THEN SetError(ceRParenExp);
   END;
   ELSE SetError(ceErrInExpr);
  END;
  Get;
 END;
END;

PROCEDURE TBeRoScript.StringTerm;
VAR op:BYTE;
    S:STRING;
    Adr:INTEGER;
BEGIN
 IsStringTerm:=TRUE;
 StringFactor;
 IF IsStringTerm THEN BEGIN
  WHILE (tTok IN [_mul,_div,_mod,_and,_or,_shl,_shr,_xor]) AND NOT (feof OR ferror) DO BEGIN
   MustBeStringTerm:=TRUE;
   op:=tTok;
   OutPushAx;
   Get;
   StringFactor;
   SetError(ceIllegalStringOperation);
  END;
 END;
END;

PROCEDURE TBeRoScript.StringExpression(Standalone:BOOLEAN);
VAR op:BYTE;
    S:STRING;
    Adr:INTEGER;
BEGIN
 IsStringTerm:=TRUE;
 INC(StringLevel);
 IF Standalone THEN BEGIN
  IF tTok IN [_plus,_minus] THEN BEGIN
   OutXorAxAx;
  END ELSE BEGIN
   StringTerm;
  END;
 END;
 IF IsStringTerm THEN BEGIN
  WHILE (tTok IN [_plus,_minus]) AND NOT (feof OR ferror) DO BEGIN
   op:=tTok;
   OutPushAx;
   Get;
   MustBeStringTerm:=TRUE;
   StringTerm;
   CASE op OF
    _plus:BEGIN
     OutPopBx;
     OutPushAx;
     S:=GetStringLevelVariableName;
     OutMovAxVar(S,0,FALSE,FALSE);
     OutStrDecrease;
     OutMovVarAx(S,0,FALSE,FALSE);
     OutPushAx;
     OutPopCx;
     OutPopAx;
     OutStrConcat;
    END;
    _minus:BEGIN
     SetError(ceIllegalStringOperation);
    END;
   END;
  END;
 END;
END;

PROCEDURE TBeRoScript.StringBoolExpression(Standalone:BOOLEAN);
VAR op:BYTE;
    S,SNO,SE:STRING;
    Adr:TWert;
    ShortIfOk,BA,BB:BOOLEAN;
    AltAktSymPtr:INTEGER;
BEGIN
 ShortIfOk:=FALSE;
 IF Standalone THEN BEGIN
  IF tTok=_integer THEN BEGIN
   ShortIfOk:=TRUE;
  END ELSE IF tTok=_ident THEN BEGIN
   IF LockVar(sTok,'',S,Adr,FALSE,-1) THEN BEGIN
    IF NameTabelle[AktSymPtr].Art=aGlobal THEN BEGIN
     AltAktSymPtr:=AktSymPtr;
     IF LookStructVar(sTok)<0 THEN BEGIN
      AktSymPtr:=AltAktSymPtr;
     END;
    END;
    IF NOT NameTabelle[AktSymPtr].Zeiger THEN BEGIN
     IF NameTabelle[AktSymPtr].Typ=tFloat THEN BEGIN
      DoExpressionEx;
      ShortIfOk:=TRUE;
     END;
    END;
   END ELSE BEGIN
    IF LookStructVar(sTok)<0 THEN BEGIN
     SetError(ceVarNotDef);
    END;
   END;
  END;
 END;
 IF NOT ShortIfOk THEN StringExpression(Standalone);
 IF (tTok=_shortif) AND ShortIfOk THEN BEGIN
  Get;
  SNO:=GeneratiereLabel;
  SE:=GeneratiereLabel;
  OutXorBxBx;
  OutNe;
  OutJZIF(SNO);
  StringExpression(TRUE);
  OutJMP(SE);
  IF tTok=_doublepoint THEN BEGIN
   Get;
  END ELSE BEGIN
   SetError(ceDoppelPunktErwartet);
  END;
  OutLabel(SNO);
  StringExpression(TRUE);
  OutLabel(SE);
 END ELSE IF tTok IN [_eql,_neg,_lss,_lea,_gre,_gra,_isnot] THEN BEGIN
  op:=tTok;
  OutPushAx;
  Get;
  StringExpression(TRUE);
  IsStringTerm:=FALSE;
  OutMovBxAx;
  OutPopAx;
  CASE op OF
   _eql:OutStrEql;
   _neg,_isnot:OutStrNe;
   _lss:OutStrLss;
   _lea:OutStrLea;
   _gre:OutStrGre;
   _gra:OutStrGra;
  END;
 END;
END;

PROCEDURE TBeRoScript.StructFactor;
VAR Adr:TWert;
    S,a,S1,S2:STRING;
    AltTok:INTEGER;
    Zeiger,HoleZeiger,UseArray,StringArray,ObjectVar:BOOLEAN;
    B,LB:LONGWORD;
    AltStringHandling:TStringHandling;
    UseEBX:BOOLEAN;
    I,AltSymPtr,AltAktSymPtr:INTEGER;
BEGIN
 Zeiger:=FALSE;
 HoleZeiger:=FALSE;
 UseArray:=FALSE;
 ObjectVar:=FALSE;
 AltTok:=0;
 IF tTok IN [_plusplus,_minusminus] THEN BEGIN
  AltTok:=tTok;
  Get;
 END;
 IF tTok IN [_mul] THEN BEGIN
  Zeiger:=TRUE;
  Get;
 END;
 IF tTok IN [_and] THEN BEGIN
  SetError(ceIllegalStructOperation);
  HoleZeiger:=TRUE;
  Get;
 END;
 IF tTok=_not THEN BEGIN
  Get;
  StringFactor;
  SetError(ceIllegalStructOperation);
 END ELSE IF tTok=_notbitwise THEN BEGIN
  Get;
  StringFactor;
  OutNotAxBitwise;
  SetError(ceIllegalStructOperation);
 END ELSE IF tTok=_inherited THEN BEGIN
  InheritedStatement;
  IF NameTabelle[AktSymPtr].Typ<>tType THEN BEGIN
   SetError(ceStructExpected);
  END;
 END ELSE IF (tTok=_ident) OR ((tTok=_call) AND HoleZeiger) THEN BEGIN
  IF LockVar(sTok,'',A,Adr,FALSE,-1) THEN BEGIN
   IF NameTabelle[AktSymPtr].Art=aGlobal THEN BEGIN
    AltAktSymPtr:=AktSymPtr;
    IF LookStructVar(sTok)<0 THEN BEGIN
     AktSymPtr:=AltAktSymPtr;
    END ELSE BEGIN
     ObjectVar:=TRUE;
    END;
   END;
  END ELSE BEGIN
   IF LookStructVar(sTok)<0 THEN BEGIN
    SetError(ceVarNotDef);
   END ELSE BEGIN
    ObjectVar:=TRUE;
   END;
  END;
  IF ObjectVar THEN BEGIN
   OutPushBx;
   UseEBX:=TRUE;
   StringArray:=StructAssignment(Zeiger,FALSE,TRUE,FALSE);
   AltSymPtr:=AktSymPtr;
   S:=stok;
  END ELSE IF NameTabelle[AktSymPtr].EinTyp THEN BEGIN
   OutPushBx;
   UseEBX:=TRUE;
   StringArray:=StructAssignment(Zeiger,FALSE,FALSE,FALSE);
   AltSymPtr:=AktSymPtr;
   IF (NameTabelle[AltSymPtr].Obj=_call) AND (tTok=_lparent) AND NOT HoleZeiger THEN BEGIN
    I:=CallState(FALSE,TRUE,TRUE);
    IF NameTabelle[I].Typ<>tType THEN BEGIN
     SetError(ceStructExpected);
    END;
    EXIT;
   END;
   S:=stok;
  END ELSE BEGIN
   UseEBX:=FALSE;
   AltSymPtr:=AktSymPtr;
   S:=stok;
   Get;
  END;
  IF (tTok=_klparent) AND NOT UseEBX THEN BEGIN
   UseArray:=TRUE;
   IF NameTabelle[AktSymPtr].IstArray THEN BEGIN
    Get;
    AltStringHandling:=StringHandling;
    StringHandling.IstZeiger:=FALSE;
    IsTermSigned:=FALSE;
    DoExpressionEx;
    StringHandling:=AltStringHandling;
    IF tTok=_krparent THEN BEGIN
     OutMovCxAx;
     Get;
    END ELSE BEGIN
     SetError(ceKRParentErwartet);
    END;
   END ELSE BEGIN
    SetError(ceKeinArray);
   END;
  END;
  IsTermSigned:=IsTermSigned OR (NameTabelle[AltSymPtr].Typ IN [tByte,tChar,tShortInt,tInt]);
  IF AltTok IN [_plusplus,_minusminus] THEN BEGIN
   SetError(ceIllegalStructOperation);
  END;
  IF UseEBX THEN BEGIN
   OutMovAxBx;
   OutPopBx;
  END ELSE BEGIN
   OutMovAxVarAdr(S,0,Zeiger,UseArray);
  END;
  IF TypTabelle[NameTabelle[AktProc].TypLink].Size IN [1,2,4] THEN BEGIN
   OutMovEAXStruct(TypTabelle[NameTabelle[AktProc].TypLink].Size);
  END;
  IF tTok IN [_plusplus,_minusminus] THEN BEGIN
   SetError(ceIllegalStringOperation);
   Get;
  END;
 END ELSE IF tTok=_call THEN BEGIN
  IF HoleZeiger THEN BEGIN
   SetError(ceStringTypeExpected);
  END ELSE BEGIN
   I:=CallState(TRUE,FALSE,TRUE);
   IF NameTabelle[I].Typ<>tType THEN BEGIN
    SetError(ceStructExpected);
   END;
  END;
 END ELSE IF tTok=_string THEN BEGIN
  SetError(ceIllegalStructOperation);
  Get;
 END ELSE BEGIN
  CASE tTok OF
   _enumvalue:BEGIN
    SetError(ceStructExpected);
   END;
   _integer:BEGIN
    SetError(ceStructExpected);
   END;
   _lparent:BEGIN
    SetError(ceIllegalStructOperation);
   END;
   ELSE SetError(ceErrInExpr);
  END;
  Get;
 END;
END;

PROCEDURE TBeRoScript.PrntStatement;
 PROCEDURE Teil;
 VAR S,a:STRING;
     Adr:TWert;
     CharVerarbeiten,StringVerarbeiten,LongStringVerarbeiten:BOOLEAN;
     AltAktSymPtr:INTEGER;
 BEGIN
  Get;
  IF tTok=_string THEN BEGIN
   StringFactor;
   OutWrtStr;
  END ELSE BEGIN
   CharVerarbeiten:=FALSE;
   StringVerarbeiten:=FALSE;
   LongStringVerarbeiten:=FALSE;
   IF tTok IN [_ident,_call] THEN BEGIN
    IF NOT LockVar(sTok,'',a,Adr,FALSE,-1) THEN BEGIN
     IF LookStructVar(sTok)<0 THEN BEGIN
      SetError(ceVarNotDef);
     END;
    END ELSE BEGIN
     IF NameTabelle[AktSymPtr].Art=aGlobal THEN BEGIN
      AltAktSymPtr:=AktSymPtr;
      IF LookStructVar(sTok)<0 THEN BEGIN
       AktSymPtr:=AltAktSymPtr;
      END;
     END;
    END;
    S:=sTok;
    IF (NameTabelle[AktSymPtr].Typ IN [tuChar,tChar]) AND NOT NameTabelle[AktSymPtr].Zeiger THEN CharVerarbeiten:=TRUE;
    IF NameTabelle[AktSymPtr].Zeiger AND (NameTabelle[AktSymPtr].Typ IN [tuChar,tChar]) THEN StringVerarbeiten:=TRUE;
    IF NameTabelle[AktSymPtr].Typ=tString THEN LongStringVerarbeiten:=TRUE;
   END;
   MustBeStringTerm:=FALSE;
   IF LongStringVerarbeiten THEN BEGIN
    IsStringTerm:=TRUE;
    StringLevel:=0;
    StringBoolExpression(TRUE);
    IF IsStringTerm THEN BEGIN
     OutWrtStr;
    END ELSE BEGIN
     OutWrtChar;
    END;
   END ELSE IF StringVerarbeiten THEN BEGIN
    StringHandling.IstZeiger:=TRUE;
    IsTermSigned:=FALSE;
    DoExpressionEx;
    OutWrtPCharString;
   END ELSE IF CharVerarbeiten THEN BEGIN
    IsTermSigned:=FALSE;
    DoExpressionEx;
    OutWrtChar;
   END ELSE BEGIN
    StringHandling.IstZeiger:=TRUE;
    IsTermSigned:=FALSE;
    IsStringTerm:=FALSE;
    DoExpression;
    IF tTok=_ident THEN BEGIN
     IF IsStringTerm THEN BEGIN
      OutWrtStr;
     END ELSE IF (NameTabelle[AktSymPtr].Typ=tString) AND NOT NameTabelle[AktSymPtr].Zeiger THEN BEGIN
      OutWrtStr;
     END ELSE IF NameTabelle[AktSymPtr].Zeiger AND (NameTabelle[AktSymPtr].Typ IN [tuChar,tChar]) THEN BEGIN
      OutWrtPCharString;
     END ELSE IF NameTabelle[AktSymPtr].Typ IN [tuChar,tChar] THEN BEGIN
      OutWrtChar;
     END ELSE BEGIN
      IF IsStringTerm THEN BEGIN
       OutWrtStr;
      END ELSE BEGIN
       IF IsFloatExpression THEN BEGIN
        OutWrtFloatAX;
       END ELSE BEGIN
        IF IsTermSigned THEN BEGIN
         OutWrtAXSigned;
        END ELSE BEGIN
         OutWrtAXUnsigned;
        END;
       END;
      END;
     END;
    END ELSE BEGIN
     IF IsStringTerm THEN BEGIN
      OutWrtStr;
     END ELSE BEGIN
      IF IsFloatExpression THEN BEGIN
       OutWrtFloatAX;
      END ELSE BEGIN
       IF IsTermSigned THEN BEGIN
        OutWrtAXSigned;
       END ELSE BEGIN
        OutWrtAXUnsigned;
       END;
      END;
     END;
    END;
   END;
  END;
 END;
BEGIN
 Get;
 IF tTok=_lparent THEN BEGIN
  Teil;
  WHILE (tTok=_comma) AND NOT (feof OR ferror) DO BEGIN
   Teil;
  END;
  IF tTok=_rparent THEN BEGIN
   Get;
  END ELSE BEGIN
   SetError(ceRParenExp);
  END;
 END ELSE BEGIN
  SetError(ceLParenExp);
 END;
END;

PROCEDURE TBeRoScript.DoExpression;
BEGIN
 IsStringTerm:=FALSE;
 MustBeStringTerm:=FALSE;
 IsFloatExpression:=FALSE;
 BoolExpression;
END;

PROCEDURE TBeRoScript.DoExpressionEx;
VAR StringHandlingIstZeigerAlt,IsStringTermAlt,MustBeStringTermAlt,
    IsFloatExpressionAlt:BOOLEAN;
BEGIN
 StringHandlingIstZeigerAlt:=StringHandling.IstZeiger;
 IsStringTermAlt:=IsStringTerm;
 MustBeStringTermAlt:=MustBeStringTerm;
 IsFloatExpressionAlt:=IsFloatExpression;
 DoExpression;
 StringHandling.IstZeiger:=StringHandlingIstZeigerAlt;
 IsStringTerm:=IsStringTermAlt;
 MustBeStringTerm:=MustBeStringTermAlt;
 IsFloatExpression:=IsFloatExpressionAlt;
END;

PROCEDURE TBeRoScript.ASMStatement;
VAR l:ANSISTRING;
    ch:CHAR;
BEGIN
 Get;
 IF tTok=_begin THEN BEGIN
  l:='';
  ch:=LeseNaechstesZeichen;
  WHILE (ch<>'}') AND NOT (feof OR ferror) DO BEGIN
   IF ch=#10 THEN BEGIN
    INC(QuelltextZeile);
    QuelltextSpalte:=0;
//  SchreibeZeileAssembler(l,TRUE);
    l:='';
   END ELSE IF ch=#13 THEN BEGIN
   END ELSE BEGIN
    l:=l+ch;
    INC(QuelltextSpalte);
   END;
   ch:=LeseNaechstesZeichen;
  END;
// SchreibeZeileAssembler(l,TRUE);
  Get;
 END;
END;

PROCEDURE TBeRoScript.ReturnStatement;
BEGIN
 Get;
 StringHandling.IstZeiger:=FALSE;
 IF tTok<>_semicolon THEN BEGIN
  IF (NameTabelle[AktProc].Typ=tString) AND NOT NameTabelle[AktProc].Zeiger THEN BEGIN
   StringLevel:=0;
   MustBeStringTerm:=TRUE;
   StringBoolExpression(TRUE);
   OutStrUnique;
   OutMovVarAx(tnFunctionResult,0,TRUE,FALSE);
  END ELSE IF (NameTabelle[AktProc].Typ=tType) AND NOT NameTabelle[AktProc].Zeiger THEN BEGIN
   StructFactor;
   IF NOT (TypTabelle[NameTabelle[AktProc].TypLink].Size IN [1,2,4]) THEN BEGIN
    OutMovBxAx;
    OutMovAxVar(tnFunctionResult,0,FALSE,FALSE);
    OutMoveFromEBXToEAX(TypTabelle[NameTabelle[AktProc].TypLink].Size);
    OutAddESP(TypTabelle[NameTabelle[AktProc].TypLink].Size);
   END;
  END ELSE BEGIN
   IsFloatExpression:=FALSE;
   IsTermSigned:=NameTabelle[AktProc].Typ IN [tByte,tChar,tShortInt,tInt];
   DoExpression;
   IF (NameTabelle[AktProc].Typ=tFloat) AND NOT NameTabelle[AktProc].Zeiger THEN BEGIN
    IF NOT IsFloatExpression THEN BEGIN
     OutIntAXToFPU;
     OutFPUToAX;
    END
   END ELSE BEGIN
    IF IsFloatExpression THEN BEGIN
     SetError(ceWrongType);
    END;
   END;
  END;
 END;
 IF AktProc>=0 THEN BEGIN
  OutJmp('Return'+NameTabelle[AktProc].AsmVarName);
 END ELSE BEGIN
  OutRet;
 END;
END;

PROCEDURE TBeRoScript.Assignment;
VAR adr:TWert;
    I,AltTok,OldTok:INTEGER;
    B,c,Zeiger,UseArray:BOOLEAN;
    S,a,SNO,SE,S1,S2:STRING;
    AltStringHandling:TStringHandling;
    AltSymPtr,AltAktSymPtr:INTEGER;
    UseEBX:BOOLEAN;
    EBXZeiger,StringArray,AltMustBeStringTerm,ObjectVar:BOOLEAN;
BEGIN
 AltTok:=0;
 OldTok:=0;
 B:=FALSE;
 c:=FALSE;
 StringHandling.IstZeiger:=FALSE;
 Zeiger:=FALSE;
 UseArray:=FALSE;
 EBXZeiger:=FALSE;
 StringArray:=FALSE;
 ObjectVar:=FALSE;
 IF tTok IN [_plusplus,_minusminus] THEN BEGIN
  AltTok:=tTok;
  Get;
 END;
 IF tTok=_mul THEN BEGIN
  Zeiger:=TRUE;
  Get;
  StringHandling.IstZeiger:=TRUE;
 END;
 IF LockVar(sTok,'',A,Adr,FALSE,-1) THEN BEGIN
  IF NameTabelle[AktSymPtr].Art=aGlobal THEN BEGIN
   AltAktSymPtr:=AktSymPtr;
   IF LookStructVar(sTok)<0 THEN BEGIN
    AktSymPtr:=AltAktSymPtr;
   END ELSE BEGIN
    ObjectVar:=TRUE;
   END;
  END;
 END ELSE BEGIN
  IF LookStructVar(sTok)<0 THEN BEGIN
   SetError(ceVarNotDef);
  END ELSE BEGIN
   ObjectVar:=TRUE;
  END;
 END;
 IF fError THEN EXIT;
 IF ObjectVar THEN BEGIN
  OutPushBx;
  UseEBX:=TRUE;
  StringArray:=StructAssignment(Zeiger,FALSE,TRUE,FALSE);
  AltSymPtr:=AktSymPtr;
  S:=stok;
 END ELSE IF NameTabelle[AktSymPtr].EinTyp THEN BEGIN
  UseEBX:=TRUE;
  StringArray:=StructAssignment(Zeiger,TRUE,FALSE,FALSE);
  AltSymPtr:=AktSymPtr;
  S:=stok;
  EBXZeiger:=NameTabelle[AltSymPtr].Zeiger;
 END ELSE BEGIN
  UseEBX:=FALSE;
  AltSymPtr:=AktSymPtr;
  S:=stok;
  Get;
 END;
 IF (NameTabelle[AltSymPtr].Obj=_call) AND (tTok=_lparent) THEN BEGIN
  IF NameTabelle[AltSymPtr].Zeiger THEN BEGIN
   IF Zeiger THEN BEGIN
    IF UseEBX THEN BEGIN
     OutMovFromStructVar(AltSymPtr);
    END ELSE BEGIN
     OutMovAxVar(S,0,FALSE,UseArray);
     OutMovBxAx;
    END;
    I:=CallState(FALSE,TRUE,TRUE);
    EXIT;
   END;
  END ELSE BEGIN
   I:=CallState(FALSE,UseEBX,TRUE);
   EXIT;
  END;
 END ELSE IF NameTabelle[AltSymPtr].Zeiger AND (NameTabelle[AltSymPtr].Typ IN [tuChar,tChar]) THEN BEGIN
  IF NOT Zeiger THEN BEGIN
   StringHandling.IstZeiger:=TRUE;
  END ELSE BEGIN
   StringHandling.IstZeiger:=FALSE;
  END;
 END;
 IF tTok=_klparent THEN BEGIN
  IF NameTabelle[AltSymPtr].Zeiger AND (NameTabelle[AltSymPtr].Typ IN [tuChar,tChar]) THEN BEGIN
   StringHandling.IstZeiger:=FALSE;
   IF NOT Zeiger THEN Zeiger:=TRUE;
  END;
  IF NOT UseEBX THEN BEGIN
   IF NameTabelle[AktSymPtr].IstArray THEN BEGIN
    UseArray:=TRUE;
    Get;
    AltStringHandling:=StringHandling;
    StringHandling.IstZeiger:=FALSE;
    IsTermSigned:=FALSE;
    DoExpressionEx;
    StringHandling:=AltStringHandling;
    IF tTok=_krparent THEN BEGIN
     OutMovCxAx;
     Get;
    END ELSE BEGIN
     SetError(ceKRParentErwartet);
    END;
   END ELSE IF NameTabelle[AktSymPtr].Typ=tString THEN BEGIN
    IF UseEBX THEN BEGIN
     OutMovAxBx;
    END ELSE BEGIN
     OutMovAxVarAdr(S,0,Zeiger,UseArray);
    END;
    Get;
    OutPushAx;
    AltMustBeStringTerm:=MustBeStringTerm;
    DoExpressionEx;
    MustBeStringTerm:=AltMustBeStringTerm;
    OutMovBxAx;
    OutPopAx;
    IF tTok=_krparent THEN BEGIN
     Get;
    END ELSE BEGIN
     SetError(ceKRParentErwartet);
    END;
    OutMovEAXStruct(4);
    OutPushAx;
    OutPushBx;
    OutCallNative('charpointerat');
    OutMovBxAx;
    StringArray:=TRUE;
   END ELSE BEGIN
    SetError(ceKeinArray);
   END;
  END ELSE BEGIN
   SetError(ceKeinArray);
  END;
 END;
 IF tTok=_set THEN BEGIN
  Get;
  B:=TRUE;
 END ELSE IF tTok=_shortif THEN BEGIN
  Get;
  IF UseEBX THEN BEGIN
   OutMovFromStructVar(AltSymPtr);
  END ELSE BEGIN
   OutMovAxVar(S,0,Zeiger,UseArray);
  END;
  SNO:=GeneratiereLabel;
  SE:=GeneratiereLabel;
  OutXorBxBx;
  OutNe;
  OutJZIF(SNO);
  Statement(FALSE);
  OutJMP(SE);
  IF tTok=_doublepoint THEN BEGIN
   Get;
  END ELSE BEGIN
   SetError(ceDoppelPunktErwartet);
  END;
  OutLabel(SNO);
  Statement(FALSE);
  OutLabel(SE);
  B:=FALSE;
 END ELSE IF tTok IN [_plus,_minus,_mul,_div,_and,_or,_mod,_shl,_shr,_xor] THEN BEGIN
  OldTok:=tTok;
  Get;
  IF tTok=_set THEN BEGIN
   Get;
   B:=TRUE;
   c:=TRUE;
  END ELSE BEGIN
   SetError(ceExpectSet);
  END;
 END ELSE IF tTok IN [_plusplus,_minusminus] THEN BEGIN
  IF (NameTabelle[AktSymPtr].Typ=tFloat) AND NOT NameTabelle[AktSymPtr].Zeiger THEN BEGIN
   IF UseEBX THEN BEGIN
    CASE tTok OF
     _plusplus:BEGIN
      OutMovFromStructVar(AltSymPtr);
      OutIncFPU;
      OutMovToStructVar(AltSymPtr);
     END;
     _minusminus:BEGIN
      OutMovFromStructVar(AltSymPtr);
      OutDecFPU;
      OutMovToStructVar(AltSymPtr);
     END;
    END;
   END ELSE BEGIN
    CASE tTok OF
     _plusplus:BEGIN
      OutMovAxVar(S,0,Zeiger,UseArray);
      OutIncFPU;
      OutMovVarAx(S,0,Zeiger,UseArray);
     END;
     _minusminus:BEGIN
      OutMovAxVar(S,0,Zeiger,UseArray);
      OutDecFPU;
      OutMovVarAx(S,0,Zeiger,UseArray);
     END;
    END;
   END;
  END ELSE BEGIN
   IF UseEBX THEN BEGIN
    CASE tTok OF
     _plusplus:OutIncStructVar;
     _minusminus:OutDecStructVar;
    END;
   END ELSE BEGIN
    CASE tTok OF
     _plusplus:OutIncVar(S,Zeiger,UseArray);
     _minusminus:OutDecVar(S,Zeiger,UseArray);
    END;
   END;
  END;
  Get;
 END ELSE IF AltTok IN [_plusplus,_minusminus] THEN BEGIN
  IF (NameTabelle[AktSymPtr].Typ=tFloat) AND NOT NameTabelle[AktSymPtr].Zeiger THEN BEGIN
   IF UseEBX THEN BEGIN
    CASE AltTok OF
     _plusplus:BEGIN
      OutMovFromStructVar(AltSymPtr);
      OutIncFPU;
      OutMovToStructVar(AltSymPtr);
     END;
     _minusminus:BEGIN
      OutMovFromStructVar(AltSymPtr);
      OutDecFPU;
      OutMovToStructVar(AltSymPtr);
     END;
    END;
   END ELSE BEGIN
    CASE AltTok OF
     _plusplus:BEGIN
      OutMovAxVar(S,0,Zeiger,UseArray);
      OutIncFPU;
      OutMovVarAx(S,0,Zeiger,UseArray);
     END;
     _minusminus:BEGIN
      OutMovAxVar(S,0,Zeiger,UseArray);
      OutDecFPU;
      OutMovVarAx(S,0,Zeiger,UseArray);
     END;
    END;
   END;
  END ELSE BEGIN
   IF UseEBX THEN BEGIN
    CASE AltTok OF
     _plusplus:OutIncStructVar;
     _minusminus:OutDecStructVar;
    END;
   END ELSE BEGIN
    CASE AltTok OF
     _plusplus:OutIncVar(S,Zeiger,UseArray);
     _minusminus:OutDecVar(S,Zeiger,UseArray);
    END;
   END;
  END;
 END ELSE BEGIN
  SetError(ceExpectSet);
 END;
 IF B AND StringArray THEN BEGIN
  IsTermSigned:=FALSE;
  IF UseArray THEN OutPushCX;
  DoExpression;
  IF UseArray THEN OutPopCX;
  S1:=GeneratiereLabel;
  S2:=GeneratiereLabel;
  OutJzIfBx(S2);
  OutJmp(S1);
  OutLabel(S1);
  OutMovVarEBXAx(0,1);
  OutLabel(S2);
 END ELSE IF B AND (NameTabelle[AltSymPtr].Typ=tType) AND NOT NameTabelle[AltSymPtr].Zeiger THEN BEGIN
  IF UseEBX THEN OutPushBX;
  IF UseArray THEN OutPushCX;
  StructFactor;
  IF UseArray THEN OutPopCX;
  IF c THEN BEGIN
   SetError(ceIllegalStructOperation);
  END ELSE BEGIN
   IF TypTabelle[NameTabelle[AltSymPtr].TypLink].Size IN [1,2,4] THEN BEGIN
    IF UseEBX THEN BEGIN
     OutPopBX;
     OutXChgAxBx;
    END ELSE BEGIN
     OutMovBxAx;
     IF UseArray THEN OutPushCX;
     OutMovAxVarAdr(S,0,Zeiger,UseArray);
     IF UseArray THEN OutPopCX;
    END;
    OutMovEBXEAXStruct(NameTabelle[AltSymPtr].Size);
   END ELSE BEGIN
    IF UseEBX THEN BEGIN
     OutPopBX;
     OutXChgAxBx;
    END ELSE BEGIN
     OutMovBxAx;
     IF UseArray THEN OutPushCX;
     OutMovAxVarAdr(S,0,Zeiger,UseArray);
     IF UseArray THEN OutPopCX;
    END;
    OutMoveFromEBXtoEAX(NameTabelle[AltSymPtr].Size);
   END;
  END;
 END ELSE IF B AND (NameTabelle[AltSymPtr].Typ=tString) THEN BEGIN
  IF UseEBX THEN OutPushBX;
  StringLevel:=0;
  MustBeStringTerm:=TRUE;
  IF UseArray THEN OutPushCX;
  StringBoolExpression(TRUE);
  IF UseArray THEN OutPopCX;
  IF c THEN BEGIN
   IF UseEBX THEN BEGIN
    CASE OldTok OF
     _plus:BEGIN
      OutMovCxBx;
      OutMovBxAx;
      OutPushBx;
      OutMovBxCx;
      OutMovFromStructVar(AltSymPtr);
      OutPopBx;
      OutPushCx;
      OutStrSelfConcat;
      OutPopCx;
      OutMovBxCx;
      OutMovToStructVar(AltSymPtr);
     END;
     ELSE SetError(ceIllegalStringOperation);
    END;
   END ELSE BEGIN
    CASE OldTok OF
     _plus:BEGIN
      OutMovBxAx;
      IF UseArray THEN OutPushCX;
      OutMovAxVar(S,0,Zeiger,UseArray);
      IF UseArray THEN OutPopCX;
      IF UseArray THEN OutPushCX;
      OutStrSelfConcat;
      IF UseArray THEN OutPopCX;
      IF UseArray THEN OutPushCX;
      OutMovVarAx(S,0,Zeiger,UseArray);
      IF UseArray THEN OutPopCX;
     END;
     ELSE SetError(ceIllegalStringOperation);
    END;
   END;
  END ELSE BEGIN
   IF UseEBX THEN BEGIN
    OutPopBx;
    OutPushBx;
    OutPushAx;
    OutMovFromStructVar(AltSymPtr);
    OutPushBx;
    OutStrDecrease;
    OutPopBx;
    OutPopAx;
    OutMovToStructVar(AltSymPtr);
   END ELSE BEGIN
    OutPushAx;
    IF UseArray THEN OutPushCX;
    OutMovAxVar(S,0,Zeiger,UseArray);
    IF UseArray THEN OutPopCX;
    IF UseArray THEN OutPushCX;
    OutStrDecrease;
    IF UseArray THEN OutPopCX;
    OutPopAx;
    IF UseArray THEN OutPushCX;
    OutMovVarAx(S,0,Zeiger,UseArray);
    IF UseArray THEN OutPopCX;
   END;
  END;
 END ELSE IF B THEN BEGIN
  IF UseEBX THEN OutPushBX;
  IF UseArray THEN OutPushCX;
  IF (NOT NameTabelle[AltSymPtr].Zeiger) AND (NameTabelle[AltSymPtr].Typ=tFloat) THEN BEGIN
   FloatBoolExpression;
  END ELSE BEGIN
   IsTermSigned:=NameTabelle[AltSymPtr].Typ IN [tByte,tChar,tShortInt,tInt];
   DoExpression;
  END;
  IF UseArray THEN OutPopCX;
  IF c THEN BEGIN
   IF (NameTabelle[AktSymPtr].Typ=tFloat) AND NOT NameTabelle[AktSymPtr].Zeiger THEN BEGIN
    IF UseEBX THEN BEGIN
     CASE OldTok OF
      _plus:BEGIN
       OutMovCxBx;
       OutMovBxAx;
       OutPushBx;
       OutMovBxCx;
       OutMovFromStructVar(AltSymPtr);
       OutPopBx;
       OutAXToFPU;
       OutPushBx;
       OutFPUAdd;
       OutPopBx;
       OutFPUToAx;
       OutMovBxCx;
       OutMovToStructVar(AltSymPtr);
      END;
      _minus:BEGIN
       OutMovCxBx;
       OutMovBxAx;
       OutPushBx;
       OutMovBxCx;
       OutMovFromStructVar(AltSymPtr);
       OutPopBx;
       OutAXToFPU;
       OutPushBx;
       OutFPUSub;
       OutPopBx;
       OutFPUToAx;
       OutMovBxCx;
       OutMovToStructVar(AltSymPtr);
      END;
      _mul:BEGIN
       OutMovCxBx;
       OutMovBxAx;
       OutPushBx;
       OutMovBxCx;
       OutMovFromStructVar(AltSymPtr);
       OutPopBx;
       OutAXToFPU;
       OutPushBx;
       OutFPUMul;
       OutPopBx;
       OutFPUToAx;
       OutMovBxCx;
       OutMovToStructVar(AltSymPtr);
      END;
      _div:BEGIN
       OutMovCxBx;
       OutMovBxAx;
       OutPushBx;
       OutMovBxCx;
       OutMovFromStructVar(AltSymPtr);
       OutPopBx;
       OutAXToFPU;
       OutPushBx;
       OutFPUDiv;
       OutPopBx;
       OutFPUToAx;
       OutMovBxCx;
       OutMovToStructVar(AltSymPtr);
      END;
      ELSE SetError(ceFloatOperationError);
     END;
    END ELSE BEGIN
     CASE OldTok OF
      _plus:BEGIN
       OutMovBxAx;
       IF UseArray THEN OutPushCX;
       OutMovAxVar(S,0,Zeiger,UseArray);
       IF UseArray THEN OutPopCX;
       OutAXToFPU;
       OutPushBx;
       OutFPUAdd;
       OutPopBx;
       OutFPUToAx;
       IF UseArray THEN OutPushCX;
       OutMovVarAx(S,0,Zeiger,UseArray);
       IF UseArray THEN OutPopCX;
      END;
      _minus:BEGIN
       OutMovBxAx;
       IF UseArray THEN OutPushCX;
       OutMovAxVar(S,0,Zeiger,UseArray);
       IF UseArray THEN OutPopCX;
       OutAXToFPU;
       OutPushBx;
       OutFPUSub;
       OutPopBx;
       OutFPUToAx;
       IF UseArray THEN OutPushCX;
       OutMovVarAx(S,0,Zeiger,UseArray);
       IF UseArray THEN OutPopCX;
      END;
      _mul:BEGIN
       OutMovBxAx;
       IF UseArray THEN OutPushCX;
       OutMovAxVar(S,0,Zeiger,UseArray);
       IF UseArray THEN OutPopCX;
       OutAXToFPU;
       OutPushBx;
       OutFPUMul;
       OutPopBx;
       OutFPUToAx;
       IF UseArray THEN OutPushCX;
       OutMovVarAx(S,0,Zeiger,UseArray);
       IF UseArray THEN OutPopCX;
      END;
      _div:BEGIN
       OutMovBxAx;
       IF UseArray THEN OutPushCX;
       OutMovAxVar(S,0,Zeiger,UseArray);
       IF UseArray THEN OutPopCX;
       OutAXToFPU;
       OutPushBx;
       OutFPUDiv;
       OutPopBx;
       OutFPUToAx;
       IF UseArray THEN OutPushCX;
       OutMovVarAx(S,0,Zeiger,UseArray);
       IF UseArray THEN OutPopCX;
      END;
      ELSE SetError(ceFloatOperationError);
     END;
    END;
   END ELSE BEGIN
    IF UseEBX THEN BEGIN
     CASE OldTok OF
      _plus:BEGIN
       OutMovCxBx;
       OutMovBxAx;
       OutPushBx;
       OutMovBxCx;
       OutMovFromStructVar(AltSymPtr);
       OutPopBx;
       OutAddAxBx;
       OutMovBxCx;
       OutMovToStructVar(AltSymPtr);
      END;
      _minus:BEGIN
       OutMovCxBx;
       OutMovBxAx;
       OutPushBx;
       OutMovBxCx;
       OutMovFromStructVar(AltSymPtr);
       OutPopBx;
       OutSubAxBx;
       OutMovBxCx;
       OutMovToStructVar(AltSymPtr);
      END;
      _mul:BEGIN
       OutMovCxBx;
       OutMovBxAx;
       OutPushBx;
       OutMovBxCx;
       OutMovFromStructVar(AltSymPtr);
       OutPopBx;
       IF IsTermSigned THEN BEGIN
        OutIMulBx;
       END ELSE BEGIN
        OutMulBx;
       END;
       OutMovBxCx;
       OutMovToStructVar(AltSymPtr);
      END;
      _div:BEGIN
       OutMovCxBx;
       OutMovBxAx;
       OutPushBx;
       OutMovBxCx;
       OutMovFromStructVar(AltSymPtr);
       OutPopBx;
       IF IsTermSigned THEN BEGIN
        OutIDivBx;
       END ELSE BEGIN
        OutDivBx;
       END;
       OutMovBxCx;
       OutMovToStructVar(AltSymPtr);
      END;
      _mod:BEGIN
       OutMovCxBx;
       OutMovBxAx;
       OutPushBx;
       OutMovBxCx;
       OutMovFromStructVar(AltSymPtr);
       OutPopBx;
       IF IsTermSigned THEN BEGIN
        OutIModBx;
       END ELSE BEGIN
        OutModBx;
       END;
       OutMovBxCx;
       OutMovToStructVar(AltSymPtr);
      END;
      _and:BEGIN
       OutMovCxBx;
       OutMovBxAx;
       OutPushBx;
       OutMovBxCx;
       OutMovFromStructVar(AltSymPtr);
       OutPopBx;
       OutAndBx;
       OutMovBxCx;
       OutMovToStructVar(AltSymPtr);
      END;
      _or:BEGIN
       OutMovCxBx;
       OutMovBxAx;
       OutPushBx;
       OutMovBxCx;
       OutMovFromStructVar(AltSymPtr);
       OutPopBx;
       OutOrBx;
       OutMovBxCx;
       OutMovToStructVar(AltSymPtr);
      END;
      _shl:BEGIN
       OutMovCxBx;
       OutMovBxAx;
       OutPushBx;
       OutMovBxCx;
       OutMovFromStructVar(AltSymPtr);
       OutPopBx;
       OutShlBx;
       OutMovBxCx;
       OutMovToStructVar(AltSymPtr);
      END;
      _shr:BEGIN
       OutMovCxBx;
       OutMovBxAx;
       OutPushBx;
       OutMovBxCx;
       OutMovFromStructVar(AltSymPtr);
       OutPopBx;
       OutShrBx;
       OutMovBxCx;
       OutMovToStructVar(AltSymPtr);
      END;
      _xor:BEGIN
       OutMovCxBx;
       OutMovBxAx;
       OutPushBx;
       OutMovBxCx;
       OutMovFromStructVar(AltSymPtr);
       OutPopBx;
       OutXorBx;
       OutMovBxCx;
       OutMovToStructVar(AltSymPtr);
      END;
     END;
    END ELSE BEGIN
     CASE OldTok OF
      _plus:BEGIN
       OutMovBxAx;
       IF UseArray THEN OutPushCX;
       OutMovAxVar(S,0,Zeiger,UseArray);
       IF UseArray THEN OutPopCX;
       OutAddAxBx;
       IF UseArray THEN OutPushCX;
       OutMovVarAx(S,0,Zeiger,UseArray);
       IF UseArray THEN OutPopCX;
      END;
      _minus:BEGIN
       OutMovBxAx;
       IF UseArray THEN OutPushCX;
       OutMovAxVar(S,0,Zeiger,UseArray);
       IF UseArray THEN OutPopCX;
       OutSubAxBx;
       IF UseArray THEN OutPushCX;
       OutMovVarAx(S,0,Zeiger,UseArray);
       IF UseArray THEN OutPopCX;
      END;
      _mul:BEGIN
       OutMovBxAx;
       IF UseArray THEN OutPushCX;
       OutMovAxVar(S,0,Zeiger,UseArray);
       IF UseArray THEN OutPopCX;
       IF IsTermSigned THEN BEGIN
        OutIMulBx;
       END ELSE BEGIN
        OutMulBx;
       END;
       IF UseArray THEN OutPushCX;
       OutMovVarAx(S,0,Zeiger,UseArray);
       IF UseArray THEN OutPopCX;
      END;
      _div:BEGIN
       OutMovBxAx;
       IF UseArray THEN OutPushCX;
       OutMovAxVar(S,0,Zeiger,UseArray);
       IF UseArray THEN OutPopCX;
       IF IsTermSigned THEN BEGIN
        OutIDivBx;
       END ELSE BEGIN
        OutDivBx;
       END;
       IF UseArray THEN OutPushCX;
       OutMovVarAx(S,0,Zeiger,UseArray);
       IF UseArray THEN OutPopCX;
      END;
      _mod:BEGIN
       OutMovBxAx;
       IF UseArray THEN OutPushCX;
       OutMovAxVar(S,0,Zeiger,UseArray);
       IF UseArray THEN OutPopCX;
       IF IsTermSigned THEN BEGIN
        OutIModBx;
       END ELSE BEGIN
        OutModBx;
       END;
       IF UseArray THEN OutPushCX;
       OutMovVarAx(S,0,Zeiger,UseArray);
       IF UseArray THEN OutPopCX;
      END;
      _and:BEGIN
       OutMovBxAx;
       IF UseArray THEN OutPushCX;
       OutMovAxVar(S,0,Zeiger,UseArray);
       IF UseArray THEN OutPopCX;
       OutAndBx;
       IF UseArray THEN OutPushCX;
       OutMovVarAx(S,0,Zeiger,UseArray);
       IF UseArray THEN OutPopCX;
      END;
      _or:BEGIN
       OutMovBxAx;
       IF UseArray THEN OutPushCX;
       OutMovAxVar(S,0,Zeiger,UseArray);
       IF UseArray THEN OutPopCX;
       OutOrBx;
       IF UseArray THEN OutPushCX;
       OutMovVarAx(S,0,Zeiger,UseArray);
       IF UseArray THEN OutPopCX;
      END;
      _shl:BEGIN
       OutMovBxAx;
       IF UseArray THEN OutPushCX;
       OutMovAxVar(S,0,Zeiger,UseArray);
       IF UseArray THEN OutPopCX;
       IF UseArray THEN OutPushCX;
       OutShlBx;
       IF UseArray THEN OutPopCX;
       IF UseArray THEN OutPushCX;
       OutMovVarAx(S,0,Zeiger,UseArray);
       IF UseArray THEN OutPopCX;
      END;
      _shr:BEGIN
       OutMovBxAx;
       IF UseArray THEN OutPushCX;
       OutMovAxVar(S,0,Zeiger,UseArray);
       IF UseArray THEN OutPopCX;
       IF UseArray THEN OutPushCX;
       OutShrBx;
       IF UseArray THEN OutPopCX;
       IF UseArray THEN OutPushCX;
       OutMovVarAx(S,0,Zeiger,UseArray);
       IF UseArray THEN OutPopCX;
      END;
      _xor:BEGIN
       OutMovBxAx;
       IF UseArray THEN OutPushCX;
       OutMovAxVar(S,0,Zeiger,UseArray);
       IF UseArray THEN OutPopCX;
       OutXorBx;
       IF UseArray THEN OutPushCX;
       OutMovVarAx(S,0,Zeiger,UseArray);
       IF UseArray THEN OutPopCX;
      END;
     END;
    END;
   END;
  END ELSE BEGIN
   IF UseEBX THEN BEGIN
    OutPopBX;
    OutMovToStructVar(AltSymPtr);
   END ELSE BEGIN
    IF UseArray THEN OutPushCX;
    OutMovVarAx(S,0,Zeiger,UseArray);
    IF UseArray THEN OutPopCX;
   END;
  END;
 END;
END;

FUNCTION TBeRoScript.LookDLL(Name:STRING):INTEGER;
VAR I:INTEGER;
BEGIN
 RESULT:=-1;
 FOR I:=0 TO LENGTH(DynamicLinkLibrarys)-1 DO BEGIN
  IF DynamicLinkLibrarys[I].Name=Name THEN BEGIN
   RESULT:=I;     
   EXIT;
  END;
 END;
END;

FUNCTION TBeRoScript.LookNative(Name:STRING):INTEGER;
VAR I:INTEGER;
BEGIN
 RESULT:=-1;
 FOR I:=0 TO LENGTH(NativeTabelle)-1 DO BEGIN
  IF NativeTabelle[I].AsmVarName=Name THEN BEGIN
   RESULT:=I;
   EXIT;
  END;
 END;
END;

FUNCTION TBeRoScript.LookImport(Name:STRING):INTEGER;
VAR I:INTEGER;
BEGIN
 RESULT:=-1;
 FOR I:=0 TO LENGTH(ImportTabelle)-1 DO BEGIN
  IF ImportTabelle[I].AsmVarName=Name THEN BEGIN
   RESULT:=I;
   EXIT;
  END;
 END;
END;

FUNCTION TBeRoScript.LookNativeAsmVar(Name:STRING):INTEGER;
VAR I:INTEGER;
BEGIN
 RESULT:=-1;
 FOR I:=0 TO LENGTH(NameTabelle)-1 DO BEGIN
  IF (NameTabelle[I].AsmVarName=Name) AND NameTabelle[I].native THEN BEGIN
   RESULT:=I;
   EXIT;
  END;
 END;
END;

FUNCTION TBeRoScript.LookImportAsmVar(Name:STRING):INTEGER;
VAR I:INTEGER;
BEGIN
 RESULT:=-1;
 FOR I:=0 TO LENGTH(NameTabelle)-1 DO BEGIN
  IF (NameTabelle[I].AsmVarName=Name) AND NameTabelle[I].import THEN BEGIN
   RESULT:=I;
   EXIT;
  END;
 END;
END;

FUNCTION TBeRoScript.IsStruct(Name:STRING):BOOLEAN;
VAR I:INTEGER;
BEGIN
 RESULT:=FALSE;
 FOR I:=0 TO ttZaehler-1 DO BEGIN
  IF TypTabelle[I].Name=Name THEN BEGIN
   RESULT:=TRUE;
   EXIT;
  END;
 END;
END;

FUNCTION TBeRoScript.LookStruct(Name:STRING):INTEGER;
VAR I:INTEGER;
BEGIN
 RESULT:=-1;
 FOR I:=0 TO ttZaehler-1 DO BEGIN
  IF TypTabelle[I].Name=Name THEN BEGIN
   RESULT:=I;
   EXIT;
  END;
 END;
END;

FUNCTION TBeRoScript.LookStructVar(Name:STRING):INTEGER;
VAR I,J,K:INTEGER;
    Gefunden:BOOLEAN;
    S:STRING;
    Adr:TWert;
BEGIN
 Gefunden:=FALSE;
 IF AktProc>=0 THEN BEGIN
  I:=LookStruct(NameTabelle[AktProc].StructName);
  IF I>=0 THEN BEGIN
   IF LockVar(Name,'',S,Adr,FALSE,I) THEN BEGIN
    Gefunden:=TRUE;
   END;
  END;
 END;
 IF Gefunden THEN BEGIN
  RESULT:=AktSymPtr;
 END ELSE BEGIN
  RESULT:=-1;
 END;
END;

FUNCTION TBeRoScript.LookVarStruct(SymPtr:INTEGER):INTEGER;
VAR I,J,K:INTEGER;
    Gefunden:BOOLEAN;
    S:STRING;
    Adr:TWert;
BEGIN
 Gefunden:=FALSE;
 I:=0;
 IF AktProc>=0 THEN BEGIN
  I:=LookStruct(NameTabelle[AktProc].StructName);
  IF I>=0 THEN BEGIN
   IF LockVar(NameTabelle[SymPtr].Name,'',S,Adr,FALSE,I) THEN BEGIN
    Gefunden:=TRUE;
   END;
  END;
 END;
 IF Gefunden THEN BEGIN
  RESULT:=I;
 END ELSE BEGIN
  RESULT:=-1;
 END;
END;

FUNCTION TBeRoScript.VarStruct(StartLevel:BOOLEAN):BOOLEAN;
VAR J:INTEGER;
BEGIN
 RESULT:=FALSE;
 J:=LookStruct(sTok);
 IF J>=0 THEN BEGIN
  RESULT:=TRUE;
  VarDefStatement(StartLevel,FALSE,FALSE,J,FALSE);
 END ELSE IF NOT StartLevel THEN BEGIN
  SetError(ceStructNotDefined);
 END;
END;

PROCEDURE TBeRoScript.AddImportProc(Name,LibraryName,FunctionName:STRING);
VAR I:INTEGER;
BEGIN
 I:=LENGTH(ImportTabelle);
 SETLENGTH(ImportTabelle,I+1);
 ImportTabelle[I].Name:=Name;
 ImportTabelle[I].LibraryName:=LibraryName;
 ImportTabelle[I].LibraryFunction:=FunctionName;
END;

PROCEDURE TBeRoScript.AssignmentOrVarStruct;
BEGIN
 IF IsStruct(sTok) THEN BEGIN
  VarStruct(FALSE);
 END ELSE BEGIN
  Assignment;
 END;
END;

PROCEDURE TBeRoScript.WhileState;
VAR S1,S2:STRING;
BEGIN
 IncLevel;
 BreakLabel[Level]:=GeneratiereLabel;
 ContinueLabel[Level]:=GeneratiereLabel;

 S1:=GeneratiereLabel;
 OutLabel(S1);

 OutLabel(ContinueLabel[Level]);

 Get;
 IF tTok=_lparent THEN BEGIN
  Get;
  IF tTok=_rparent THEN BEGIN
   Get;
  END ELSE BEGIN
   StringHandling.IstZeiger:=FALSE;
   IsTermSigned:=FALSE;
   DoExpression;
   IF tTok=_rparent THEN BEGIN
    Get;
   END ELSE BEGIN
    SetError(ceRParenExp);
   END;
  END;
 END ELSE BEGIN
  SetError(ceLParenExp);
 END;

 S2:=GeneratiereLabel;
 OutJzIf(S2);

 IF tTok=_semicolon THEN BEGIN
  Get;
 END ELSE IF tTok=_end THEN BEGIN
 END ELSE BEGIN
  Statement(TRUE);
 END;

 OutJmp(S1);
 OutLabel(S2);
 OutLabel(BreakLabel[Level]);
 DecLevel;
END;

PROCEDURE TBeRoScript.DoWhileState;
VAR S1,S2:STRING;
BEGIN
 IncLevel;
 BreakLabel[Level]:=GeneratiereLabel;
 ContinueLabel[Level]:=GeneratiereLabel;

 Get;
 S1:=GeneratiereLabel;
 OutLabel(S1);

 Statement(FALSE);

 IF tTok=_while THEN BEGIN
  OutLabel(ContinueLabel[Level]);
  Get;
  IF tTok=_lparent THEN BEGIN
   Get;
   IF tTok=_rparent THEN BEGIN
    Get;
   END ELSE BEGIN
    StringHandling.IstZeiger:=FALSE;
    IsTermSigned:=FALSE;
    DoExpression;
    IF tTok=_rparent THEN BEGIN
     Get;
    END ELSE BEGIN
     SetError(ceRParenExp);
    END;
   END;
  END ELSE BEGIN
   SetError(ceLParenExp);
  END;

  S2:=GeneratiereLabel;
  OutJzIf(S2);

  OutJmp(S1);
  OutLabel(S2);
  OutLabel(BreakLabel[Level]);

  IF tTok=_semicolon THEN BEGIN
   Get;
  END ELSE BEGIN
   SetError(ceSemiColonErwartet);
  END;
 END ELSE BEGIN
  SetError(ceWhileErwartet);
 END;

 DecLevel;
END;

PROCEDURE TBeRoScript.ForState;
VAR S1,S2,s3,s4,s5:STRING;
BEGIN
 Get;
 IF tTok=_lparent THEN BEGIN
  IncLevel;
  BreakLabel[Level]:=GeneratiereLabel;
  ContinueLabel[Level]:=GeneratiereLabel;

  Get;
  IF tTok=_semicolon THEN BEGIN
   Get;
  END ELSE BEGIN
   WHILE NOT (feof OR ferror) DO BEGIN
    Statement(FALSE);
    IF tTok=_comma THEN BEGIN
     Get;
    END ELSE BEGIN
     BREAK;
    END;
   END;
   IF tTok=_semicolon THEN BEGIN
    Get;
   END ELSE BEGIN
    SetError(ceSemiColonErwartet);
   END;
  END;

  S1:=GeneratiereLabel;
  OutLabel(S1);

  StringHandling.IstZeiger:=FALSE;
  IsTermSigned:=FALSE;
  IF tTok=_semicolon THEN BEGIN
   Get;
  END ELSE BEGIN
   DoExpression;
   IF tTok=_semicolon THEN BEGIN
    Get;
   END ELSE BEGIN
    SetError(ceSemiColonErwartet);
   END;
  END;
  S2:=GeneratiereLabel;
  OutJzIf(S2);

  s3:=GeneratiereLabel;
  OutJmp(s3);

  s4:=GeneratiereLabel;
  OutLabel(s4);

  OutLabel(ContinueLabel[Level]);

  IF tTok=_rparent THEN BEGIN
   Get;
  END ELSE BEGIN
   WHILE NOT (feof OR ferror) DO BEGIN
    Statement(FALSE);
    IF tTok=_comma THEN BEGIN
     Get;
    END ELSE BEGIN
     BREAK;
    END;
   END;
   IF tTok=_rparent THEN BEGIN
    Get;
   END ELSE BEGIN
   SetError(ceRParenExp);
   END;
  END;

  s5:=GeneratiereLabel;
  OutJmp(s5);

  OutLabel(s3);

  IF tTok=_semicolon THEN BEGIN
   Get;
  END ELSE IF tTok=_end THEN BEGIN
  END ELSE BEGIN
   Statement(TRUE);
  END;

  OutJmp(s4);

  OutLabel(s5);
  OutJmp(S1);
  OutLabel(S2);
  OutLabel(BreakLabel[Level]);
  DecLevel;
 END ELSE BEGIN
  SetError(ceLParenExp);
 END;
END;

PROCEDURE TBeRoScript.IfState;
VAR S1,S2:STRING;
BEGIN
 Get;
 IF tTok=_lparent THEN BEGIN
  Get;
  IF tTok=_rparent THEN BEGIN
   Get;
  END ELSE BEGIN
   StringHandling.IstZeiger:=FALSE;
   IsTermSigned:=FALSE;
   DoExpression;
   IF tTok=_rparent THEN BEGIN
    Get;
   END ELSE BEGIN
    SetError(ceRParenExp);
   END;
  END;
 END ELSE BEGIN
  SetError(ceLParenExp);
 END;

 S1:=GeneratiereLabel;
 OutJzIf(S1);
 IF tTok=_semicolon THEN BEGIN
  Get;
 END ELSE IF tTok=_end THEN BEGIN
 END ELSE IF tTok=_begin THEN BEGIN
  BeginState;
 END ELSE BEGIN
  Statement(TRUE);
 END;
 IF TTok<>_else THEN BEGIN
  OutLabel(S1);
 END ELSE BEGIN
  Get;
  S2:=GeneratiereLabel;
  OutJmp(S2);
  OutLabel(S1);
  Statement(TRUE);
  OutLabel(S2);
 END;
END;

PROCEDURE TBeRoScript.SwitchState;
VAR SE,SOK,SNO,SNEXT:STRING;
    Default:BOOLEAN;
BEGIN
 Get;
 IF tTok=_lparent THEN BEGIN
  Get;
  IncLevel;
  StringHandling.IstZeiger:=FALSE;
  IsTermSigned:=FALSE;
  DoExpression;

  SE:=GeneratiereLabel;
  BreakLabel[Level]:=SE;

  IF tTok=_rparent THEN BEGIN
   Get;
   OutPushSi;
   OutMovSiAx;
   IF tTok=_begin THEN BEGIN
    Get;
    IF tTok IN [_case,_default] THEN BEGIN
     SOK:='';
     SNEXT:=GeneratiereLabel;
     Default:=FALSE;
     WHILE (NOT ((tTok=_end) OR feof OR ferror)) AND (NOT Default) DO BEGIN
      IF LENGTH(SOK)=0 THEN BEGIN
       SOK:=SNEXT;
       SNEXT:=GeneratiereLabel;
      END ELSE BEGIN
       SOK:=SNEXT;
      END;
      ContinueLabel[Level]:=SNEXT;
      IF tTok=_case THEN BEGIN
       Default:=FALSE;
       Get;
       OutPushSi;
       StringHandling.IstZeiger:=FALSE;
       IsTermSigned:=FALSE;
       DoExpression;
       OutPopSi;
       OutMovBxSi;
       OutEql;
       SNO:=GeneratiereLabel;
       OutJZIf(SNO);
      END ELSE IF tTok=_default THEN BEGIN
       Default:=TRUE;
       Get;
      END;
      OutLabel(SOK);
      IF tTok=_doublepoint THEN BEGIN
       Get;
       WHILE NOT ((tTok IN [_case,_default,_end]) OR feof OR ferror) DO BEGIN
        IF NOT (tTok IN [_case,_default,_end]) THEN Statement(TRUE);
       END;
      END ELSE BEGIN
       SetError(ceDoppelPunktErwartet);
      END;
      SNEXT:=GeneratiereLabel;
      OutJmp(SNEXT);
      OutLabel(SNO);
     END;
     Get;
     OutLabel(SNEXT);
     SOK:=GeneratiereLabel;
     SNO:=GeneratiereLabel;
     SNEXT:=GeneratiereLabel;
    END ELSE BEGIN
     SetError(ceCaseErwartet);
    END;
   END ELSE BEGIN
    SetError(ceBeginErwartet);
   END;
   OutLabel(SOK);
   OutLabel(SE);
   OutPopSi;
   DecLevel;
  END ELSE BEGIN
   SetError(ceRParenExp);
  END;
 END ELSE BEGIN
  SetError(ceLParenExp);
 END;
END;

FUNCTION TBeRoScript.CallState(Selbststaendig,UseEBX,Klammern:BOOLEAN):INTEGER;
VAR adr:TWert;
    a,S:STRING;
    TempStructVariable:STRING;
    TempObjectVariable:STRING;
    TempStringVariables:ARRAY OF STRING;
    I,J,K,L,U,Z,B,SC,NSC:INTEGER;
    AktProcPtr,AltAktSymPtr:INTEGER;
    OK,Verarbeiten:BOOLEAN;
 PROCEDURE StoreParameter;
 BEGIN
  IF (I>0) AND (I<=LENGTH(NameTabelle[AktProcPtr].Param)) AND Verarbeiten THEN BEGIN
   IF NameTabelle[AktProcPtr].Param[I-1]>=0 THEN BEGIN
    IF NameTabelle[AktProcPtr].isstdcall THEN BEGIN
     IF NameTabelle[NameTabelle[AktProcPtr].Param[I-1]].Zeiger THEN BEGIN
      OutMovESPAx(J,4);
      INC(J,4);
      INC(L,4);
     END ELSE BEGIN
      IF NameTabelle[NameTabelle[AktProcPtr].Param[I-1]].TypLink>=0 THEN BEGIN
       OutMoveFromEBXToStack(NameTabelle[NameTabelle[AktProcPtr].Param[I-1]].Size,J);
       B:=NameTabelle[NameTabelle[AktProcPtr].Param[I-1]].Size;
       IF Alignment THEN IF (B MOD 4)<>0 THEN B:=B+(4-(B MOD 4));
       INC(J,B);
       INC(L,B);
      END ELSE IF NameTabelle[NameTabelle[AktProcPtr].Param[I-1]].IstArray THEN BEGIN
       OutMoveFromEBXToStack(NameTabelle[NameTabelle[AktProcPtr].Param[I-1]].Size*NameTabelle[NameTabelle[AktProcPtr].Param[I-1]].ArrayDim,J);
       B:=NameTabelle[NameTabelle[AktProcPtr].Param[I-1]].Size*NameTabelle[NameTabelle[AktProcPtr].Param[I-1]].ArrayDim;
       IF Alignment THEN IF (B MOD 4)<>0 THEN B:=B+(4-(B MOD 4));
       INC(J,B);
       INC(L,B);
      END ELSE BEGIN
       IF NameTabelle[NameTabelle[AktProcPtr].Param[I-1]].Typ IN [tuByte,tByte,tuChar,tChar] THEN BEGIN
        IF Alignment THEN BEGIN
         OutMovESPAx(J,4);
         INC(J,4);
         INC(L,4);
        END ELSE BEGIN
         OutMovESPAx(J,1);
         INC(J);
         INC(L);
        END;
       END;
       IF NameTabelle[NameTabelle[AktProcPtr].Param[I-1]].Typ IN [tuShortInt,tShortInt] THEN BEGIN
        IF Alignment THEN BEGIN
         OutMovESPAx(J,4);
         INC(J,4);
         INC(L,4);
        END ELSE BEGIN
         OutMovESPAx(J,2);
         INC(J,2);
         INC(L,2);
        END;
       END;
       IF NameTabelle[NameTabelle[AktProcPtr].Param[I-1]].Typ IN [tuInt,tInt,tFloat,tString,tVoid] THEN BEGIN
        OutMovESPAx(J,4);
        INC(J,4);
        INC(L,4);
       END;
      END;
     END;
    END ELSE BEGIN
     IF NameTabelle[NameTabelle[AktProcPtr].Param[I-1]].Zeiger THEN BEGIN
      OutPushAx;
      INC(L,4);
     END ELSE BEGIN
      IF NameTabelle[NameTabelle[AktProcPtr].Param[I-1]].TypLink>=0 THEN BEGIN
       OutMoveFromEBXToStack(NameTabelle[NameTabelle[AktProcPtr].Param[I-1]].Size,0);
       B:=NameTabelle[NameTabelle[AktProcPtr].Param[I-1]].Size;
       INC(L,B);
       IF Alignment THEN BEGIN
        IF (B MOD 4)<>0 THEN BEGIN
         OutSubESP(4-(B MOD 4));
         INC(L,4-(B MOD 4));
        END;
       END;
      END ELSE IF NameTabelle[NameTabelle[AktProcPtr].Param[I-1]].IstArray THEN BEGIN
       OutMoveFromEBXToStack(NameTabelle[NameTabelle[AktProcPtr].Param[I-1]].Size*NameTabelle[NameTabelle[AktProcPtr].Param[I-1]].ArrayDim,0);
       B:=NameTabelle[NameTabelle[AktProcPtr].Param[I-1]].Size*NameTabelle[NameTabelle[AktProcPtr].Param[I-1]].ArrayDim;
       INC(L,B);
       IF Alignment THEN BEGIN
        IF (B MOD 4)<>0 THEN BEGIN
         OutSubESP(4-(B MOD 4));
         INC(L,4-(B MOD 4));
        END;
       END;
      END ELSE BEGIN
       IF Alignment THEN BEGIN
        OutPushAx32;
        INC(L,4);
       END ELSE BEGIN
        IF NameTabelle[NameTabelle[AktProcPtr].Param[I-1]].Typ IN [tuByte,tByte,tuChar,tChar] THEN BEGIN
         OutPushAx8;
         INC(L);
        END;
        IF NameTabelle[NameTabelle[AktProcPtr].Param[I-1]].Typ IN [tuShortInt,tShortInt] THEN BEGIN
         OutPushAx16;
         INC(L,2);
        END;
        IF NameTabelle[NameTabelle[AktProcPtr].Param[I-1]].Typ IN [tuInt,tInt,tFloat,tString,tVoid] THEN BEGIN
         OutPushAx32;
         INC(L,4);
        END;
       END;
      END;
     END;
    END;
   END;
  END;
 END;
BEGIN
 OK:=FALSE;
 IF Selbststaendig THEN BEGIN
  IF LockVar(sTok,'',a,Adr,FALSE,-1) THEN BEGIN
   IF NameTabelle[AktSymPtr].Obj=_call THEN BEGIN
    OK:=TRUE;
   END;
  END;
 END ELSE BEGIN
  IF NameTabelle[AktSymPtr].Obj=_call THEN BEGIN
   OK:=TRUE;
  END;
 END;
 IF OK THEN BEGIN
  S:=sTok;
  RESULT:=AktSymPtr;
  AktProcPtr:=AktSymPtr;
  IF Selbststaendig THEN Get;
  IF NameTabelle[AktProcPtr].TypLink>=0 THEN BEGIN
   IF NOT (TypTabelle[NameTabelle[AktProcPtr].TypLink].Size IN [1,2,4]) THEN BEGIN
    TempStructVariable:=GetStructTempVariableName(NameTabelle[AktProcPtr].TypLink);
   END ELSE BEGIN
    TempStructVariable:='';
   END;
  END ELSE BEGIN
   TempStructVariable:='';
  END;
  IF NameTabelle[AktProcPtr].StructName<>'' THEN BEGIN
   TempObjectVariable:=GetObjectTempVariableName(LookStruct(NameTabelle[AktProcPtr].StructName));
   OutPushAx;
   OutPushCx;
   OutPopAx;
   OutMovVarAx(TempObjectVariable,0,FALSE,FALSE);
   OutPopAx;
  END ELSE BEGIN
   TempObjectVariable:='';
  END;
  TempStringVariables:=NIL;
  AktSymPtr:=AktProcPtr;
  L:=0;
  SC:=0;
  FOR J:=0 TO LENGTH(NameTabelle[AktProcPtr].Param)-1 DO BEGIN
   IF NameTabelle[NameTabelle[AktProcPtr].Param[J]].Art=aParam THEN BEGIN
    IF NameTabelle[NameTabelle[AktProcPtr].Param[J]].Typ=tString THEN BEGIN
     SETLENGTH(TempStringVariables,LENGTH(TempStringVariables)+1);
     TempStringVariables[LENGTH(TempStringVariables)-1]:=GetStringTempVariableName(SC);
     INC(SC);
     INC(L,4);
    END;
   END;
  END;
  I:=0;
  Z:=0;
  IF tTok=_lparent THEN BEGIN
   K:=0;
   IF NameTabelle[AktProcPtr].isstdcall THEN BEGIN
    J:=0;
    FOR I:=0 TO LENGTH(NameTabelle[AktProcPtr].Param)-1 DO BEGIN
     IF NameTabelle[NameTabelle[AktProcPtr].Param[I]].Zeiger THEN BEGIN
      INC(J,4);
     END ELSE BEGIN
      B:=0;
      IF NameTabelle[NameTabelle[AktProcPtr].Param[I]].TypLink>=0 THEN BEGIN
       B:=NameTabelle[NameTabelle[AktProcPtr].Param[I]].Size;
      END ELSE IF NameTabelle[NameTabelle[AktProcPtr].Param[I]].IstArray THEN BEGIN
       B:=NameTabelle[NameTabelle[AktProcPtr].Param[I]].Size*NameTabelle[NameTabelle[AktProcPtr].Param[I]].ArrayDim;
      END ELSE BEGIN
       IF NameTabelle[NameTabelle[AktProcPtr].Param[I]].Typ IN [tuByte,tByte,tuChar,tChar] THEN B:=1;
       IF NameTabelle[NameTabelle[AktProcPtr].Param[I]].Typ IN [tuShortInt,tShortInt] THEN B:=2;
       IF NameTabelle[NameTabelle[AktProcPtr].Param[I]].Typ IN [tuInt,tInt,tFloat,tString,tVoid] THEN B:=4;
      END;
      IF Alignment THEN IF (B MOD 4)<>0 THEN B:=B+(4-(B MOD 4));
      INC(J,B);
     END;
    END;
    OutSubESP(J);
    Z:=J;
    K:=J;
   END;
   I:=0;
   J:=0;
   L:=0;
   U:=0;
   NSC:=0;
   WHILE (tTok<>_rparent) AND NOT (feof OR ferror) DO BEGIN
    Get;
    IF tTok=_comma THEN BEGIN
     INC(I);
     Verarbeiten:=FALSE;
    END ELSE IF tTok=_rparent THEN BEGIN
     Verarbeiten:=FALSE;
    END ELSE BEGIN
     INC(I);
     IF (I>0) AND (I<=LENGTH(NameTabelle[AktProcPtr].Param)) THEN BEGIN
      IF NameTabelle[AktProcPtr].Param[I-1]>=0 THEN BEGIN
       IF NameTabelle[NameTabelle[AktProcPtr].Param[I-1]].Typ IN [tuChar,tChar] THEN BEGIN
        StringHandling.IstZeiger:=NameTabelle[NameTabelle[AktProcPtr].Param[I-1]].Zeiger;
       END ELSE BEGIN
        StringHandling.IstZeiger:=FALSE;
       END;
       IF (NameTabelle[NameTabelle[AktProcPtr].Param[I-1]].TypLink>=0) AND NOT NameTabelle[NameTabelle[AktProcPtr].Param[I-1]].Zeiger THEN BEGIN
        IF LockVar(sTok,'',a,Adr,FALSE,-1) THEN BEGIN
         IF NameTabelle[AktSymPtr].Art=aGlobal THEN BEGIN
          AltAktSymPtr:=AktSymPtr;
          IF LookStructVar(sTok)<0 THEN BEGIN
           AktSymPtr:=AltAktSymPtr;
           StructAssignment(FALSE,FALSE,FALSE,FALSE);
         END ELSE BEGIN
           StructAssignment(FALSE,FALSE,TRUE,FALSE);
          END;
         END ELSE BEGIN
          StructAssignment(FALSE,FALSE,FALSE,FALSE);
         END;
        END ELSE BEGIN
         IF LookStructVar(sTok)<0 THEN BEGIN
          SetError(ceVarNotDef);
         END ELSE BEGIN
          StructAssignment(FALSE,FALSE,TRUE,FALSE);
         END;
        END;
       END ELSE IF NameTabelle[NameTabelle[AktProcPtr].Param[I-1]].IstArray AND NOT NameTabelle[NameTabelle[AktProcPtr].Param[I-1]].Zeiger THEN BEGIN
        IF LockVar(sTok,'',a,Adr,FALSE,-1) THEN BEGIN
         IF NameTabelle[AktSymPtr].Art=aGlobal THEN BEGIN
          AltAktSymPtr:=AktSymPtr;
          IF LookStructVar(sTok)<0 THEN BEGIN
           AktSymPtr:=AltAktSymPtr;
           StructAssignment(FALSE,FALSE,FALSE,FALSE);
         END ELSE BEGIN
           StructAssignment(FALSE,FALSE,TRUE,FALSE);
          END;
         END ELSE BEGIN
          StructAssignment(FALSE,FALSE,FALSE,FALSE);
         END;
        END ELSE BEGIN
         IF LookStructVar(sTok)<0 THEN BEGIN
          SetError(ceVarNotDef);
         END ELSE BEGIN
          StructAssignment(FALSE,FALSE,TRUE,FALSE);
         END;
        END;
       END ELSE IF NameTabelle[NameTabelle[AktProcPtr].Param[I-1]].Typ=tString THEN BEGIN
        StringLevel:=0;
        MustBeStringTerm:=TRUE;
        StringBoolExpression(TRUE);
        IF NSC<LENGTH(TempStringVariables) THEN BEGIN
         OutStrIncrease;
         OutMovVarAx(TempStringVariables[NSC],0,FALSE,FALSE);
         INC(NSC);
        END;
       END ELSE BEGIN
        IsTermSigned:=NameTabelle[NameTabelle[AktProcPtr].Param[I-1]].Typ IN [tByte,tChar,tShortInt,tInt];
        DoExpression;
        IF NOT IsFloatExpression THEN BEGIN
         IF (NameTabelle[NameTabelle[AktProcPtr].Param[I-1]].Typ=tFloat) AND NOT NameTabelle[NameTabelle[AktProcPtr].Param[I-1]].Zeiger THEN BEGIN
          OutIntAxToFPU;
          OutFPUToAx;
         END;
        END ELSE BEGIN
         IF (NameTabelle[NameTabelle[AktProcPtr].Param[I-1]].Typ<>tFloat) AND NOT NameTabelle[NameTabelle[AktProcPtr].Param[I-1]].Zeiger THEN BEGIN
          SetError(ceWrongType);
         END;
        END;
        IsFloatExpression:=FALSE;
       END;
      END ELSE BEGIN
       OutXorAxAx;
      END;
     END ELSE BEGIN
      OutXorAxAx;
     END;
     Verarbeiten:=TRUE;
    END;
    IF tTok=_rparent THEN BEGIN
    END ELSE IF tTok=_comma THEN BEGIN
    END ELSE BEGIN
     SetError(ceFuncParamSetError);
    END;
    StoreParameter;
   END;
   IF tTok=_rparent THEN BEGIN
    Get;
   END ELSE BEGIN
    SetError(ceRParenExp);
   END;
  END ELSE IF Klammern THEN BEGIN
   SetError(ceLParenExp);
  END;
  IF I<>NameTabelle[AktProcPtr].TotalParamNum THEN BEGIN
   IF NameTabelle[AktProcPtr].StructName<>'' THEN BEGIN
    Verarbeiten:=TRUE;
    INC(I);
    OutMovAxVarAdr(TempObjectVariable,0,TRUE,FALSE);
    StoreParameter;
   END;
   IF NOT NameTabelle[AktProcPtr].Zeiger THEN BEGIN
    IF NameTabelle[AktProcPtr].Typ=tType THEN BEGIN
     IF NOT (TypTabelle[NameTabelle[AktProcPtr].TypLink].Size IN [1,2,4]) THEN BEGIN
      Verarbeiten:=TRUE;
      INC(I);
      OutMovAxVarAdr(TempStructVariable,0,FALSE,FALSE);
      StoreParameter;
     END;
    END;
   END;
  END;
  IF NameTabelle[AktProcPtr].native THEN BEGIN
   OutCallNative(NameTabelle[AktProcPtr].Name);
  END ELSE IF NameTabelle[AktProcPtr].import THEN BEGIN
   OutCallImport(NameTabelle[AktProcPtr].Name);
  END ELSE BEGIN
   IF UseEBX THEN BEGIN
    OutCallBx;
   END ELSE BEGIN
    OutCall(NameTabelle[AktProcPtr].Name,'');
   END;
  END;
  IF NameTabelle[AktProcPtr].TypLink>=0 THEN BEGIN
   IF NOT (TypTabelle[NameTabelle[AktProcPtr].TypLink].Size IN [1,2,4]) THEN BEGIN
    IF LENGTH(TempStructVariable)>0 THEN BEGIN
     OutMovAxVarAdr(TempStructVariable,0,FALSE,FALSE);
    END;
   END;
  END;
  IF SC>0 THEN BEGIN
   NSC:=0;
   OutPushAx;
   FOR J:=0 TO LENGTH(NameTabelle[AktProcPtr].Param)-1 DO BEGIN
    IF NameTabelle[NameTabelle[AktProcPtr].Param[J]].Art=aParam THEN BEGIN
     IF NameTabelle[NameTabelle[AktProcPtr].Param[J]].Typ=tString THEN BEGIN
      OutMovAxVar(TempStringVariables[NSC],0,FALSE,FALSE);
      OutStrDecrease;
      INC(NSC);
     END;
    END;
   END;
   OutPopAx;
  END;
  SETLENGTH(TempStringVariables,0);
  IF I<>NameTabelle[AktProcPtr].TotalParamNum THEN SetError(ceFuncParamNumFehler);
 END ELSE BEGIN
  RESULT:=0;
 END;
END;

PROCEDURE TBeRoScript.BeginState;
BEGIN
 Get;
 WHILE NOT ((tTok=_end) OR feof OR ferror) DO BEGIN
  IF tTok<>_end THEN Statement(TRUE);
 END;
 Get;
END;

FUNCTION TBeRoScript.StructAssignment(IstZeiger,StringWrite,IsObjectVar,NoCode:BOOLEAN):BOOLEAN;
VAR Adr:TWert;
    T,I,J,K,O:INTEGER;
    UsePointer,UseArray,UseZeiger,Start,Schleife,AltMustBeStringTerm,
    Gefunden:BOOLEAN;
    S,LastS:STRING;
    AltStringHandling:TStringHandlinG;
    TypLink,LastSymPtr:INTEGER;
    BufferStart:BOOLEAN;
    BufferStartSymbol:INTEGER;
    BufferOffset:BOOLEAN;
    BufferOffsetValue:INTEGER;
 PROCEDURE WriteBufferStart;
 VAR S:STRING;
 BEGIN
  IF BufferStart AND NOT NoCode THEN BEGIN
   S:=NameTabelle[BufferStartSymbol].AsmVarName;
   IF BufferOffset THEN BEGIN
    IF NameTabelle[BufferStartSymbol].Art IN [aGlobal,aStatic] THEN BEGIN
     OutMovBxImmLabelOffset(S,BufferOffsetValue);
    END ELSE IF NameTabelle[BufferStartSymbol].Art=aLokal THEN BEGIN
     IF NameTabelle[BufferStartSymbol].StackPtr>0 THEN BEGIN
      OutLeaEBXEBP(-NameTabelle[BufferStartSymbol].StackPtr+BufferOffsetValue);
     END ELSE BEGIN
      OutLeaEBXEBP(BufferOffsetValue);
     END;
    END ELSE IF NameTabelle[BufferStartSymbol].Art IN [aParam,aShadowParam] THEN BEGIN
     IF NameTabelle[BufferStartSymbol].StackPtr>0 THEN BEGIN
      OutLeaEBXEBP(NameTabelle[BufferStartSymbol].StackPtr+BufferOffsetValue);
     END ELSE BEGIN
      OutLeaEBXEBP(BufferOffsetValue);
     END;
    END;
    BufferOffset:=FALSE;
    BufferOffsetValue:=0;
   END ELSE BEGIN
    IF NameTabelle[BufferStartSymbol].Art IN [aGlobal,aStatic] THEN BEGIN
     OutMovBxImmLabel(S);
    END ELSE IF NameTabelle[BufferStartSymbol].Art=aLokal THEN BEGIN
     IF NameTabelle[BufferStartSymbol].StackPtr>0 THEN BEGIN
      OutLeaEBXEBP(-NameTabelle[BufferStartSymbol].StackPtr);
     END ELSE BEGIN
      OutMovEBXEBP;
     END;
    END ELSE IF NameTabelle[BufferStartSymbol].Art IN [aParam,aShadowParam] THEN BEGIN
     IF NameTabelle[BufferStartSymbol].StackPtr>0 THEN BEGIN
      OutLeaEBXEBP(NameTabelle[BufferStartSymbol].StackPtr);
     END ELSE BEGIN
      OutMovEBXEBP;
     END;
    END;
   END;
  END;
  BufferStart:=FALSE;
  BufferStartSymbol:=0;
 END;
 PROCEDURE WriteBufferOffset;
 VAR S:STRING;
 BEGIN
  IF BufferOffset AND NOT NoCode THEN BEGIN
   OutAddEBX(BufferOffsetValue);
  END;
  BufferOffset:=FALSE;
  BufferOffsetValue:=0;
 END;
BEGIN
 RESULT:=FALSE;
 UseZeiger:=IstZeiger;
 Schleife:=TRUE;
 Start:=TRUE;
 BufferStart:=FALSE;
 BufferStartSymbol:=0;
 BufferOffset:=FALSE;
 BufferOffsetValue:=0;
 TypLink:=-1;
 LastS:='';
 LastSymPtr:=-1;
 IF IsObjectVar THEN BEGIN
  IF NOT NoCode THEN BEGIN
   OutPushAx;
   OutMovAxVar(tnFunctionObjectPointer,0,FALSE,FALSE);
   OutMovBxAx;
   OutPopAx;
  END;
  BufferStart:=FALSE;
  BufferStartSymbol:=AktSymPtr;
  TypLink:=LookStruct(NameTabelle[AktProc].StructName);
  Start:=FALSE;
 END;
 WHILE Schleife AND NOT (feof OR ferror) DO BEGIN
  Schleife:=FALSE;
  UseArray:=FALSE;
  UsePointer:=FALSE;
  IF NOT Start THEN UseZeiger:=FALSE;
  IF tTok=_mul THEN BEGIN
   UseZeiger:=TRUE;
   Get;
  END;
  IF NOT LockVar(sTok,'',S,Adr,FALSE,TypLink) THEN BEGIN
   I:=LookStruct(LastS);
   IF (I<0) AND (LastSymPtr>=0) THEN BEGIN
    I:=NameTabelle[LastSymPtr].TypLink;
   END;
   IF I>=0 THEN BEGIN
    Gefunden:=FALSE;
    IF NOT LockVar(sTok,TypTabelle[I].Name,S,Adr,FALSE,-1) THEN BEGIN
     FOR J:=LENGTH(TypTabelle[I].Extends)-1 DOWNTO 0 DO BEGIN
      K:=TypTabelle[I].Extends[J];
      IF LockVar(sTok,TypTabelle[K].Name,S,Adr,FALSE,-1) THEN BEGIN
       O:=TypTabelle[I].ExtendsOffsets[J];
       IF O>0 THEN BEGIN
        IF BufferOffset THEN BEGIN
         INC(BufferOffsetValue,O);
        END ELSE BEGIN
         BufferOffsetValue:=O;
        END;
        BufferOffset:=TRUE;
       END;
       Gefunden:=TRUE;
       BREAK;
      END;
     END;
     IF NOT Gefunden THEN BEGIN
      SetError(ceVarNotDef);
     END;
    END ELSE BEGIN
     Gefunden:=TRUE;
    END;
    IF Gefunden AND NOT NoCode THEN BEGIN
     IF BufferStart OR BufferOffset THEN BEGIN
      OutPushAx;
      WriteBufferStart;
      WriteBufferOffset;
      OutMovCxBx;
      OutMovAxImmLabel(S);
      OutMovBxAx;
      OutPopAx;
     END ELSE BEGIN
      OutMovCxBx;
      OutPushAx;
      OutMovAxImmLabel(S);
      OutMovBxAx;
      OutPopAx;
     END;
    END;
   END ELSE BEGIN
    SetError(ceVarNotDef);
    BREAK;
   END;
  END;
  LastS:=sTok;
  LastSymPtr:=AktSymPtr;
  IF (NameTabelle[LastSymPtr].Typ=tFloat) AND NOT NameTabelle[LastSymPtr].Zeiger THEN BEGIN
   IsFloatExpression:=TRUE;
  END;
  T:=NameTabelle[LastSymPtr].BTyp;
  TypLink:=NameTabelle[LastSymPtr].TypLink;
  Get;
  IF tTok=_klparent THEN BEGIN
   UseArray:=TRUE;
   IF NameTabelle[LastSymPtr].IstArray THEN BEGIN
    Get;
    AltStringHandling:=StringHandling;
    StringHandling.IstZeiger:=FALSE;
    IsTermSigned:=FALSE;
    IF NOT NoCode THEN BEGIN
     OutPushAx;
     OutPushBx;
     OutPushCx;
     DoExpression;
     OutPopCx;
     OutPopBx;
    END;
    StringHandling:=AltStringHandling;
    IF tTok=_krparent THEN BEGIN
     Get;
    END ELSE BEGIN
     SetError(ceKRParentErwartet);
    END;
   END ELSE IF (NameTabelle[LastSymPtr].Typ=tString) AND NOT StringWrite THEN BEGIN
    RESULT:=TRUE;
    IF NOT NoCode THEN OutMovAxBx;
    Get;
    OutPushAx;
    AltMustBeStringTerm:=MustBeStringTerm;
    DoExpressionEx;
    MustBeStringTerm:=AltMustBeStringTerm;
    OutMovBxAx;
    OutPopAx;
    IF tTok=_krparent THEN BEGIN
     Get;
    END ELSE BEGIN
     SetError(ceKRParentErwartet);
    END;
    IF NOT NoCode THEN BEGIN
     OutMovEAXStruct(4);
     OutPushAx;
     OutPushBx;
     OutCallNative('charat');
    END;
    IF MustBeStringTerm THEN BEGIN
     IF NOT NoCode THEN BEGIN
      OutStrCharConvert;
     END;
    END ELSE BEGIN
     IsStringTerm:=FALSE;
    END;
   END ELSE IF (NameTabelle[LastSymPtr].Typ=tString) AND StringWrite THEN BEGIN
    RESULT:=TRUE;
    IF NOT NoCode THEN OutMovAxBx;
    Get;
    OutPushAx;
    AltMustBeStringTerm:=MustBeStringTerm;
    DoExpressionEx;
    MustBeStringTerm:=AltMustBeStringTerm;
    OutMovBxAx;
    OutPopAx;
    IF tTok=_krparent THEN BEGIN
     Get;
    END ELSE BEGIN
     SetError(ceKRParentErwartet);
    END;
    IF NOT NoCode THEN BEGIN
     OutMovEAXStruct(4);
     OutPushAx;
     OutPushBx;
     OutCallNative('charpointerat');
    END;
   END ELSE BEGIN
    SetError(ceKeinArray);
   END;
  END;
  IF tTok=_usepointer THEN BEGIN
   UsePointer:=TRUE;
   UseZeiger:=TRUE;
   Get;
  END;
  IF Start THEN BEGIN
   BufferStart:=TRUE;
   BufferStartSymbol:=LastSymPtr;
  END ELSE IF NameTabelle[LastSymPtr].Feld_Offset>0 THEN BEGIN
   BufferOffset:=TRUE;
   BufferOffsetValue:=NameTabelle[LastSymPtr].Feld_Offset;
  END;
  IF UseZeiger THEN BEGIN
   WriteBufferStart;
   WriteBufferOffset;
   IF NOT NoCode THEN OutMovBxFromBx;
  END;
  IF UseArray THEN BEGIN
   IF BufferStart OR BufferOffset THEN BEGIN
    IF NOT NoCode THEN BEGIN
     OutPushAx;
     OutPushCx;
     WriteBufferStart;
     WriteBufferOffset;
     OutPopCx;
     OutPopAx;
    END;
   END;
   IF NOT NoCode THEN BEGIN
    IF NameTabelle[LastSymPtr].BTyp>0 THEN BEGIN
     OutMulAxImmSigned(TypTabelle[T].Size);
    END ELSE BEGIN
     OutMulAxImmSigned(NameTabelle[LastSymPtr].Size);
    END;
    OutAddBxAx;
    OutPopAx;
   END;
  END;
  IF UsePointer THEN BEGIN
   IF TypLink>=0 THEN BEGIN
    Schleife:=TRUE;
   END ELSE BEGIN
    SetError(ceNotStruct);
   END;
  END ELSE IF tTok=_dot THEN BEGIN
   IF TypLink>=0 THEN BEGIN
    Schleife:=TRUE;
    Get;
   END ELSE BEGIN
    SetError(ceNotStruct);
   END;
  END;
  IF Schleife AND NameTabelle[LastSymPtr].Zeiger AND NOT UseZeiger THEN BEGIN
   IF NOT NoCode THEN BEGIN
    OutPushAx;
    OutPushCx;
    WriteBufferStart;
    WriteBufferOffset;
    OutPopCx;
    OutPopAx;
    OutMovBxFromBx;
   END;
  END;
  Start:=FALSE;
 END;
 IF NOT NoCode THEN BEGIN
  OutPushAx;
  OutPushCx;
  WriteBufferStart;
  WriteBufferOffset;
  OutPopCx;
  OutPopAx;
 END;
END;

PROCEDURE TBeRoScript.StructStatement(StartLevel,IsUnion,IsObject:BOOLEAN);
VAR Name,S,A:STRING;
    SZ,I,J,K,H,B,Von,bis:INTEGER;
    ExtendStructs:ARRAY OF INTEGER;
    IsPacked:BOOLEAN;
    Adr:TWert;
    Src,Dst:PNameTabelleEintrag;
BEGIN
 IsPacked:=FALSE;
 ExtendStructs:=NIL;
 S:='';
 IF tTok=_packed THEN BEGIN
  IsPacked:=TRUE;
  Get;
  IF NOT (tTok IN [_struct,_union,_object]) THEN BEGIN
   SetError(ceStructOrUnionOrObjectStatementExpected);
  END;
  IF tTok=_union THEN BEGIN
   IsUnion:=TRUE;
  END ELSE IF tTok=_object THEN BEGIN
   IsObject:=TRUE;
  END;
 END;
 Get;
 IF (tTok=_ident) AND NOT fError THEN BEGIN
  Name:=sTok;
  IF IsStruct(sTok) THEN BEGIN
   SetError(ceStructOrUnionOrObjectDoppelDefiniert);
  END;
  Get;
  IF tTok=_lparent THEN BEGIN
   WHILE NOT (feof OR ferror) DO BEGIN
    Get;
    I:=LookStruct(sTok);
    IF I>=0 THEN BEGIN
     J:=LENGTH(ExtendStructs);
     SETLENGTH(ExtendStructs,J+1);
     ExtendStructs[J]:=I;
    END ELSE BEGIN
     SetError(ceStructExpected);
    END;
    Get;
    IF tTok<>_comma THEN BREAK;
   END;
   IF ferror THEN EXIT;
   IF tTok=_rparent THEN BEGIN
    Get;
   END ELSE BEGIN
    SetError(ceRParenExp);
   END;
  END;
  IF tTok=_begin THEN BEGIN
   SETLENGTH(TypTabelle,ttZaehler+1);
   TypTabelle[ttZaehler].Name:=Name;
   TypTabelle[ttZaehler].IsPacked:=IsPacked;
   TypTabelle[ttZaehler].StackAlloc:=0;
   TypTabelle[ttZaehler].Bytes2Pass:=0;
   TypTabelle[ttZaehler].VariableNum:=0;
   TypTabelle[ttZaehler].Variable:=NIL;
   TypTabelle[ttZaehler].Extends:=NIL;
   TypTabelle[ttZaehler].ExtendsOffsets:=NIL;
   TypTabelle[ttZaehler].Size:=0;
   Von:=tnZaehler+1;
   SETLENGTH(TypTabelle[ttZaehler].Extends,LENGTH(ExtendStructs));
   SETLENGTH(TypTabelle[ttZaehler].ExtendsOffsets,LENGTH(ExtendStructs));
   FOR J:=0 TO LENGTH(ExtendStructs)-1 DO BEGIN
    TypTabelle[ttZaehler].Extends[J]:=ExtendStructs[J];
    TypTabelle[ttZaehler].ExtendsOffsets[J]:=TypTabelle[ttZaehler].Bytes2Pass;
    FOR K:=0 TO TypTabelle[ExtendStructs[J]].VariableNum-1 DO BEGIN
     INC(tnZaehler);
     SETLENGTH(NameTabelle,tnZaehler+1);
     Src:=@NameTabelle[TypTabelle[ExtendStructs[J]].Variable[K]];
     Dst:=@NameTabelle[tnZaehler];
     FILLCHAR(Dst^,SIZEOF(TNameTabelleEintrag),#0);
     Dst^.Name:=Src^.Name;
     Dst^.Proc:=Src^.Proc;
     Dst^.AsmVarName:=Src^.AsmVarName;
     Dst^.Obj:=Src^.Obj;
     Dst^.Typ:=Src^.Typ;
     Dst^.TypLink:=Src^.TypLink;
     IF Src^.Art IN [aGlobal,aLokal,aStatic,aStructVar] THEN BEGIN
      Dst^.InTypLink:=ttZaehler;
     END ELSE BEGIN
      Dst^.InTypLink:=Src^.InTypLink;
     END;
     Dst^.Zeiger:=Src^.Zeiger;
     Dst^.IstArray:=Src^.IstArray;
     Dst^.Art:=Src^.Art;
     Dst^.storage:=Src^.storage;
     Dst^.StackPtr:=Src^.StackPtr+TypTabelle[ttZaehler].ExtendsOffsets[J];
     Dst^.symptr:=Src^.symptr;
     Dst^.StackAlloc:=Src^.StackAlloc+TypTabelle[ttZaehler].ExtendsOffsets[J];
     Dst^.Bytes2Pass:=Src^.Bytes2Pass+TypTabelle[ttZaehler].ExtendsOffsets[J];
     Dst^.SubNum:=Src^.SubNum;
     Dst^.ProcNr:=Src^.ProcNr;
     Dst^.ParamNum:=Src^.ParamNum;
     Dst^.ShadowParamNum:=Src^.ShadowParamNum;
     Dst^.TotalParamNum:=Src^.TotalParamNum;
     Dst^.ArrayDim:=Src^.ArrayDim;
     Dst^.Size:=Src^.Size;
     IF Src^.Art IN [aGlobal,aLokal,aStatic,aStructVar] THEN BEGIN
      Dst^.BTyp:=ttZaehler;
     END ELSE BEGIN
      Dst^.BTyp:=Src^.BTyp;
     END;
     Dst^.Feld_Offset:=Src^.Feld_Offset;
     Dst^.EinTyp:=Src^.EinTyp;
     Dst^.InTyp:=Src^.InTyp;
     Dst^.Wert:=Src^.Wert;
     Dst^.native:=Src^.native;
     Dst^.import:=Src^.import;
     Dst^.isstdcall:=Src^.isstdcall;
     SETLENGTH(Dst^.Param,LENGTH(Src^.Param));
     FOR H:=0 TO LENGTH(Src^.Param)-1 DO Dst^.Param[H]:=Src^.Param[H];
     Dst^.Adr:=Src^.Adr;
     Dst^.Tok:=Src^.Tok;
     INC(TypTabelle[ttZaehler].VariableNum);
     SETLENGTH(TypTabelle[ttZaehler].Variable,TypTabelle[ttZaehler].VariableNum);
     TypTabelle[ttZaehler].Variable[TypTabelle[ttZaehler].VariableNum-1]:=tnZaehler;
    END;
    B:=TypTabelle[ExtendStructs[J]].Size;
    IF Alignment AND NOT TypTabelle[ttZaehler].IsPacked THEN BEGIN
     IF (B MOD 4)<>0 THEN BEGIN
      B:=B+(4-(B MOD 4));
     END;
    END;
    INC(TypTabelle[ttZaehler].Size,B);
    B:=TypTabelle[ExtendStructs[J]].Bytes2Pass;
    IF Alignment AND NOT TypTabelle[ttZaehler].IsPacked THEN BEGIN
     IF (B MOD 4)<>0 THEN BEGIN
      B:=B+(4-(B MOD 4));
     END;
    END;
    INC(TypTabelle[ttZaehler].Bytes2Pass,B);
    B:=TypTabelle[ExtendStructs[J]].StackAlloc;
    IF Alignment AND NOT TypTabelle[ttZaehler].IsPacked THEN BEGIN
     IF (B MOD 4)<>0 THEN BEGIN
      B:=B+(4-(B MOD 4));
     END;
    END;
    INC(TypTabelle[ttZaehler].StackAlloc,B);
   END;
   WHILE (tTok<>_end) AND NOT (feof OR ferror) DO BEGIN
    Get;
    IF tTok<>_end THEN BEGIN
     VarDefStatement(FALSE,FALSE,TRUE,-1,FALSE);
     NameTabelle[tnZaehler].InTypLink:=ttZaehler;
     NameTabelle[tnZaehler].BTyp:=ttZaehler;
    END;
   END;
   Bis:=tnZaehler;
   SZ:=0;
   J:=0;
   FOR I:=Von TO Bis DO BEGIN
    IF NameTabelle[I].Obj IN [_ident,_call] THEN BEGIN
     IF NameTabelle[I].Art IN [aGlobal,aLokal,aStatic,aStructVar] THEN BEGIN
      NameTabelle[I].InTypLink:=ttZaehler;
      NameTabelle[I].BTyp:=ttZaehler;
     END;
    END;
    IF NameTabelle[I].Obj=_ident THEN BEGIN
     IF IsUnion THEN BEGIN
      NameTabelle[I].Feld_Offset:=0;
      IF NameTabelle[I].Zeiger THEN BEGIN
       IF SZ<4 THEN SZ:=4;
      END ELSE BEGIN
       IF NameTabelle[I].IstArray THEN BEGIN
        B:=NameTabelle[I].Size*NameTabelle[I].ArrayDim;
       END ELSE BEGIN
        B:=NameTabelle[I].Size;
       END;
       IF Alignment AND NOT IsPacked THEN BEGIN
        IF (B MOD 4)<>0 THEN BEGIN
         B:=B+(4-(B MOD 4));
        END;
       END;
       IF SZ<B THEN SZ:=B;
      END;
     END ELSE BEGIN
      NameTabelle[I].Feld_Offset:=SZ;
      IF NameTabelle[I].Zeiger THEN BEGIN
       SZ:=SZ+4;
      END ELSE BEGIN
       IF NameTabelle[I].IstArray THEN BEGIN
        B:=NameTabelle[I].Size*NameTabelle[I].ArrayDim;
       END ELSE BEGIN
        B:=NameTabelle[I].Size;
       END;
       IF Alignment AND NOT IsPacked THEN BEGIN
        IF (B MOD 4)<>0 THEN BEGIN
         B:=B+(4-(B MOD 4));
        END;
       END;
       SZ:=SZ+B;
      END;
     END;
     INC(J);
    END;
   END;
   TypTabelle[ttZaehler].Size:=SZ;
   TypTabelle[ttZaehler].Felder:=J;
   IF tTok=_end THEN BEGIN
    Get;
   END ELSE BEGIN
    SetError(ceEndErwartet);
   END;
   INC(ttZaehler);
   VarDefStatement(StartLevel,FALSE,FALSE,ttZaehler-1,TRUE);
  END ELSE BEGIN
   SetError(ceBeginErwartet);
  END;
 END ELSE BEGIN
  SetError(ceBezeichnerErwartet);
 END;
 SETLENGTH(ExtendStructs,0);
END;

FUNCTION TBeRoScript.AreInThatStrings(SymPtr:INTEGER):BOOLEAN;
VAR I,J,T:INTEGER;
BEGIN
 IF NameTabelle[SymPtr].Zeiger THEN BEGIN
  RESULT:=FALSE;
 END ELSE IF NameTabelle[SymPtr].Typ=tString THEN BEGIN
  RESULT:=TRUE;
 END ELSE IF NameTabelle[SymPtr].EinTyp THEN BEGIN
  T:=NameTabelle[SymPtr].TypLink;
  J:=TypTabelle[T].VariableNum;
  RESULT:=FALSE;
  FOR I:=0 TO J-1 DO BEGIN
   RESULT:=RESULT OR AreInThatStrings(TypTabelle[T].Variable[I]);
  END;
 END ELSE BEGIN
  RESULT:=FALSE;
 END;
END;

FUNCTION TBeRoScript.FunctionStringFree(SymPtr:INTEGER;Art:TArt;Offset,SubOffset:INTEGER):INTEGER;
VAR I,J,T,B,O,SO:INTEGER;
BEGIN
 IF AreInThatStrings(SymPtr) THEN BEGIN
  O:=Offset;
  SO:=SubOffset;
  IF (NameTabelle[SymPtr].Name<>tnFunctionResult) AND NOT NameTabelle[SymPtr].Zeiger THEN BEGIN
   IF NameTabelle[SymPtr].Typ=tString THEN BEGIN
    OutMovAxVarEBX(-Offset+SO,NameTabelle[SymPtr].Size);
    OutStrDecrease;    
    RESULT:=NameTabelle[SymPtr].Size;
   END ELSE IF NameTabelle[SymPtr].EinTyp THEN BEGIN
    T:=NameTabelle[SymPtr].TypLink;
    J:=TypTabelle[T].VariableNum;
    FOR I:=0 TO J-1 DO BEGIN
     FunctionStringFree(TypTabelle[T].Variable[I],Art,O,SO+NameTabelle[TypTabelle[T].Variable[I]].Feld_Offset);
    END;
    RESULT:=NameTabelle[SymPtr].Size;
   END ELSE BEGIN
    RESULT:=0;
   END;
  END ELSE BEGIN
   RESULT:=0;
  END;
 END ELSE BEGIN
  RESULT:=0;
 END;
END;

PROCEDURE TBeRoScript.VarDefStatement(StartLevel,FuncParam,Struct:BOOLEAN;Typ:INTEGER;IsStructStatement:BOOLEAN);
VAR T:TTyp;
    A,S,SO,SA,SL,LibName,LibFunc:STRING;
    Adr:TWert;
    Schleife:BOOLEAN;
    P1,P2,m,n,B,ArrayDim:INTEGER;
    unsigned,IstArray,static,native,import,isstdcall,Zeiger:BOOLEAN;
    I,J,P,O1,O2,O3,O4,O5:INTEGER;
    OK,KeinGET:BOOLEAN;
BEGIN
 ArrayDim:=0;
 unsigned:=FALSE;
 IstArray:=FALSE;
 static:=FALSE;
 native:=FALSE;
 import:=FALSE;
 isstdcall:=FALSE;
 KeinGET:=FALSE;
 SO:='';
 IF IsStructStatement THEN BEGIN
  T:=tType;
  IF StartLevel THEN BEGIN
   IF tTok=_semicolon THEN BEGIN
    Get;
    EXIT;
   END;
  END;
  KeinGET:=TRUE;
 END ELSE BEGIN
  Schleife:=TRUE;
  WHILE Schleife AND NOT (feof OR ferror) DO BEGIN
   Schleife:=FALSE;
   IF tTok=_signed THEN BEGIN
    Schleife:=TRUE;
    unsigned:=FALSE;
    Get;
   END;
   IF tTok=_unsigned THEN BEGIN
    Schleife:=TRUE;
    unsigned:=TRUE;
    Get;
   END;
   IF tTok=_static THEN BEGIN
    Schleife:=TRUE;
    static:=TRUE;
    Get;
   END;
   IF tTok=_native THEN BEGIN
    Schleife:=TRUE;
    native:=TRUE;
    import:=FALSE;
    Get;
   END;
   IF tTok=_import THEN BEGIN
    Schleife:=TRUE;
    native:=FALSE;
    import:=TRUE;
    Get;
   END;
   IF tTok=_stdcall THEN BEGIN
    Schleife:=TRUE;
    isstdcall:=TRUE;
    Get;
   END;
  END;
  IF Typ>=0 THEN BEGIN
   T:=tType;
  END ELSE IF tTok=_ident THEN BEGIN
   Typ:=LookStruct(sTok);
   IF Typ>=0 THEN BEGIN
    T:=tType;
   END ELSE BEGIN
    SetError(ceTypeExpected);
    EXIT;
   END;
  END ELSE IF unsigned THEN BEGIN
   CASE tTok OF
    _int:T:=tuInt;
    _shortint:T:=tuShortInt;
    _void:T:=tVoid;
    _byte:T:=tuByte;
    _char:T:=tuChar;
    _float:T:=tFloat;
    _stringtype:T:=tString;
    ELSE BEGIN
     SetError(ceTypeExpected);
     EXIT;
    END;
   END;
  END ELSE BEGIN
   CASE tTok OF
    _int:T:=tInt;
    _shortint:T:=tShortInt;
    _void:T:=tVoid;
    _byte:T:=tByte;
    _char:T:=tChar;
    _float:T:=tFloat;
    _stringtype:T:=tString;
    ELSE BEGIN
     SetError(ceTypeExpected);
     EXIT;
    END;
   END;
  END;
 END;
 Schleife:=TRUE;
 WHILE Schleife AND NOT (feof OR ferror) DO BEGIN
  IstArray:=FALSE;
  Zeiger:=FALSE;
  Schleife:=FALSE;
  IF NOT KeinGET THEN BEGIN
   Get;
   KeinGET:=FALSE;
  END;
  IF tTok=_mul THEN BEGIN
   Zeiger:=TRUE;
   Get;
  END;
  IF tTok=_ident THEN BEGIN
   S:=sTok;
   Get;
   IF (tTok=_doubledoublepoint) OR (tTok=_dot) THEN BEGIN
    SO:=S;
    Get;
    IF tTok=_ident THEN BEGIN
     S:=sTok;
     Get;
    END ELSE BEGIN
     SetError(ceBezeichnerErwartet);
    END;
   END;
  END ELSE BEGIN
   SetError(ceBezeichnerErwartet);
  END;
  IF (tTok=_lparent) AND (StartLevel OR Struct) THEN BEGIN
   IF native OR import THEN BEGIN
    IF LockVar(S,'',A,adr,TRUE,-1) THEN BEGIN
     SetError(ceVarDoppelDefiniert);
    END ELSE BEGIN
     adr:=AddObjekt(S,'',_call,T,0,0,aGlobal,Zeiger,Struct,Typ,0);
    END;
    IF LockVar(S,'',A,adr,TRUE,-1) THEN BEGIN
    END;

    AktProc:=AktSymPtr;
    AktProcName:=S;

    NameTabelle[AktProc].isstdcall:=isstdcall;

    IF tTok=_lparent THEN BEGIN
     WHILE (tTok<>_rparent) AND NOT (feof OR ferror) DO BEGIN
      Get;
      IF tTok<>_rparent THEN VarDefStatement(FALSE,TRUE,FALSE,-1,FALSE);
      IF tTok=_comma THEN BEGIN
      END ELSE IF tTok=_rparent THEN BEGIN
      END ELSE BEGIN
       SetError(ceFuncParamDefFehler);
      END;
     END;
     IF tTok=_rparent THEN BEGIN
      Get;
     END ELSE BEGIN
      SetError(ceRParenExp);
     END;
    END ELSE BEGIN
     SetError(ceLParenExp);
    END;

    IF import THEN BEGIN
     IF tTok=_lparent THEN BEGIN
      Get;
      IF tTok=_string THEN BEGIN
       LibName:=AktStr;
       Get;
       IF tTok=_comma THEN BEGIN
        Get;
        IF tTok=_string THEN BEGIN
         LibFunc:=AktStr;
         Get;
         AddImportProc(AktProcName,LibName,LibFunc);
        END ELSE BEGIN
         SetError(ceStringExpected);
        END;
       END ELSE BEGIN
        SetError(ceCommaExp);
       END;
      END ELSE BEGIN
       SetError(ceStringExpected);
      END;
      IF tTok=_rparent THEN BEGIN
       Get;
      END ELSE BEGIN
       SetError(ceRParenExp);
      END;
     END ELSE BEGIN
      SetError(ceLParenExp);
     END;
    END;

    IF NameTabelle[AktProc].StructName<>'' THEN BEGIN
     adr:=AddObjekt(tnFunctionObjectPointer,'',_ident,tType,0,0,aShadowParam,TRUE,FALSE,LookStruct(NameTabelle[AktProc].StructName),0);
    END;
    IF NOT NameTabelle[AktProc].Zeiger THEN BEGIN
     IF NameTabelle[AktProc].Typ=tType THEN BEGIN
      IF NOT (TypTabelle[NameTabelle[AktProc].TypLink].Size IN [1,2,4]) THEN BEGIN
       adr:=AddObjekt(tnFunctionResult,'',_ident,tType,0,0,aShadowParam,TRUE,FALSE,NameTabelle[AktProc].TypLink,0);
      END;
     END;
    END;

    IF AktProc>=0 THEN BEGIN
     m:=4;
     FOR n:=NameTabelle[AktProc].TotalParamNum DOWNTO 1 DO BEGIN
      NameTabelle[NameTabelle[AktProc].Param[n-1]].StackPtr:=4+M;
      B:=NameTabelle[NameTabelle[AktProc].Param[n-1]].Bytes2Pass;
      m:=m+B;
     END;
     IF isstdcall THEN BEGIN
      FOR n:=NameTabelle[AktProc].TotalParamNum DOWNTO 1 DO BEGIN
       NameTabelle[NameTabelle[AktProc].Param[n-1]].StackPtr:=M;
       DEC(M,NameTabelle[NameTabelle[AktProc].Param[n-1]].Bytes2Pass);
      END;
     END;
    END;

    NameTabelle[AktProc].native:=native;
    NameTabelle[AktProc].import:=import;
    IF native THEN BEGIN
     J:=-1;
     FOR I:=0 TO tnpZaehler-1 DO BEGIN
      IF NativeTabelle[I].Name=S THEN BEGIN
       J:=I;
       BREAK;
      END;
     END;
     IF J>=0 THEN BEGIN
      NativeTabelle[I].AsmVarName:=A;
     END ELSE BEGIN
      SetError(ceNativeProcNichtGefunden);
     END;
    END ELSE BEGIN
     J:=-1;
     FOR I:=0 TO LENGTH(ImportTabelle)-1 DO BEGIN
      IF ImportTabelle[I].Name=S THEN BEGIN
       J:=I;
       BREAK;
      END;
     END;
     IF J>=0 THEN BEGIN
      ImportTabelle[I].AsmVarName:=A;
     END ELSE BEGIN
      SetError(ceImportProcNichtGefunden);
     END;
    END;

    AktProcName:='';
    AktProc:=-1;
    inmain:=FALSE;
   END ELSE BEGIN
    IF NOT Struct THEN BEGIN
     SL:=GeneratiereLabel;
     OutJmp(SL);
    END;
    OK:=TRUE;
    IF Struct THEN BEGIN
     IF LockVar(S,'',A,adr,TRUE,ttZaehler) THEN BEGIN
      SetError(ceVarDoppelDefiniert);
      OK:=FALSE;
     END;
    END ELSE IF LockVar(S,SO,A,adr,TRUE,-1) THEN BEGIN
     SetError(ceVarDoppelDefiniert);
     OK:=FALSE;
    END;
    IF OK THEN BEGIN
     adr:=AddObjekt(S,SO,_call,T,0,0,aGlobal,Zeiger,Struct,Typ,0);
    END;
    IF Struct THEN BEGIN
     NameTabelle[tnZaehler].InTypLink:=ttZaehler;
     NameTabelle[tnZaehler].BTyp:=ttZaehler;
     IF LockVar(S,'',A,adr,TRUE,ttZaehler) THEN BEGIN
     END;
    END ELSE IF LockVar(S,SO,A,adr,TRUE,-1) THEN BEGIN
     OutLabel(A);
    END;
    IF NOT Struct THEN BEGIN
     ProcHinzufuegen(S,SO);
     IF S='main' THEN inmain:=TRUE;
    END;

    AktProc:=AktSymPtr;
    AktProcName:=S;

    NameTabelle[AktProc].isstdcall:=isstdcall;
    IF Struct THEN BEGIN
     NameTabelle[AktProc].InTypLink:=ttZaehler;
     NameTabelle[AktProc].BTyp:=ttZaehler;
    END;

    IF tTok=_lparent THEN BEGIN
     WHILE (tTok<>_rparent) AND NOT (feof OR ferror) DO BEGIN
      Get;
      IF tTok<>_rparent THEN VarDefStatement(FALSE,TRUE,FALSE,-1,FALSE);
      IF tTok=_comma THEN BEGIN
      END ELSE IF tTok=_rparent THEN BEGIN
      END ELSE BEGIN
       SetError(ceFuncParamDefFehler);
      END;
     END;
     IF tTok=_rparent THEN BEGIN
      Get;
     END ELSE BEGIN
      SetError(ceRParenExp);
     END;
    END;

    IF NameTabelle[AktProc].StructName<>'' THEN BEGIN
     adr:=AddObjekt(tnFunctionObjectPointer,'',_ident,tType,0,0,aShadowParam,TRUE,FALSE,LookStruct(NameTabelle[AktProc].StructName),0);
    END;
    IF NOT NameTabelle[AktProc].Zeiger THEN BEGIN
     IF NameTabelle[AktProc].Typ=tType THEN BEGIN
      IF NOT (TypTabelle[NameTabelle[AktProc].TypLink].Size IN [1,2,4]) THEN BEGIN
       adr:=AddObjekt(tnFunctionResult,'',_ident,tType,0,0,aShadowParam,TRUE,FALSE,NameTabelle[AktProc].TypLink,0);
      END;
     END;
    END;

    IF AktProc>=0 THEN BEGIN
     m:=4;
     FOR n:=NameTabelle[AktProc].TotalParamNum DOWNTO 1 DO BEGIN
      NameTabelle[NameTabelle[AktProc].Param[n-1]].StackPtr:=4+M;
      B:=NameTabelle[NameTabelle[AktProc].Param[n-1]].Bytes2Pass;
      m:=m+B;
     END;
     IF isstdcall THEN BEGIN
      FOR n:=NameTabelle[AktProc].TotalParamNum DOWNTO 1 DO BEGIN
       NameTabelle[NameTabelle[AktProc].Param[n-1]].StackPtr:=M;
       DEC(M,NameTabelle[NameTabelle[AktProc].Param[n-1]].Bytes2Pass);
      END;
     END;
    END;

    IF NOT Struct THEN BEGIN
     INC(Level);
     SETLENGTH(BreakLabel,Level+1);
     SETLENGTH(ContinueLabel,Level+1);
     BreakLabel[Level]:='Return'+A;
     ContinueLabel[Level]:='Return'+A;

     OutPushBp;
     OutMovBpSp;
     OutSubESP(0);
     P1:=CodeStream.Position-4;
     OutPushBX;
     OutPushCX;
     OutPushDX;
     OutPushDI;
     OutPushSI;

     ByteHinzufuegen($EB);
     O1:=CodeStream.Position;
     ByteHinzufuegen($00);

     ByteHinzufuegen($B9); // MOV ECX,Laenge
     O2:=CodeStream.Position;
     DWordHinzufuegen($00);

     ByteHinzufuegen($89); ByteHinzufuegen($EF); // MOV EDI,EBP

     ByteHinzufuegen($81); // SUB EDI,NegOffset
     ByteHinzufuegen($EF); //  Laenge
     O3:=CodeStream.Position;
     DWordHinzufuegen($00);

     ByteHinzufuegen($F3); ByteHinzufuegen($AA); // REP STOSB

     O4:=CodeStream.Position;

     CodeStream.Seek(O1);
     ByteHinzufuegen(O4-O1-1);
     CodeStream.Seek(O4);

     FOR n:=1 TO NameTabelle[AktProc].TotalParamNum DO BEGIN
      IF NameTabelle[NameTabelle[AktProc].Param[n-1]].Art=aParam THEN BEGIN
       IF NameTabelle[NameTabelle[AktProc].Param[n-1]].Typ=tString THEN BEGIN
        P:=NameTabelle[NameTabelle[AktProc].Param[n-1]].StackPtr;
        OutMovAxVarEBP(P,4);
//      OutStrGet;
        OutMovVarEBPAx(P,4);
       END;
      END;
     END;

     IF tTok=_begin THEN BeginState;

     OutLabel('Return'+A);

     N:=0;
     FOR I:=1 TO tnZaehler DO BEGIN
      IF NameTabelle[I].Obj=_ident THEN BEGIN
       IF NameTabelle[I].Art=aLokal THEN BEGIN
        IF NameTabelle[I].Proc=AktProcName THEN BEGIN
         IF AreInThatStrings(I) THEN BEGIN
          INC(N);
         END;
        END;
       END;
      END;
     END;

     IF N>0 THEN BEGIN
      OutPushAx;
      FOR I:=1 TO tnZaehler DO BEGIN
       IF NameTabelle[I].Obj=_ident THEN BEGIN
        IF NameTabelle[I].Art=aLokal THEN BEGIN
         IF NameTabelle[I].Proc=AktProcName THEN BEGIN
          IF AreInThatStrings(I) THEN BEGIN
           OutLeaEBXEBP(-NameTabelle[I].StackPtr);
           FunctionStringFree(I,NameTabelle[I].Art,0,0);
          END;
         END;
        END;
       END;
      END;
      OutPopAx;
     END;

     OutPopSI;
     OutPopDI;
     OutPopDX;
     OutPopCX;
     OutPopBX;
     OutMovSpBp;
     OutPopBp;

     IF AktProc>=0 THEN BEGIN
      IF (NameTabelle[AktProc].Typ=tFloat) AND NOT NameTabelle[AktProc].Zeiger THEN BEGIN
       OutAXToFPU;
      END;
      IF NameTabelle[AktProc].Bytes2Pass>0 THEN BEGIN
       OutRetValue(NameTabelle[AktProc].Bytes2Pass);
      END ELSE BEGIN
       OutRetEx;
      END;
     END ELSE BEGIN
      OutRetEx;
     END;

     P2:=CodeStream.Position;
     CodeStream.Seek(P1);
     DWordHinzufuegen(NameTabelle[AktProc].StackAlloc);
     CodeStream.Seek(P2);

     IF NameTabelle[AktProc].StackAlloc>0 THEN BEGIN
      O5:=CodeStream.Position;
      CodeStream.Seek(O1-1);
      ByteHinzufuegen($31); ByteHinzufuegen($C0); // XOR EAX,EAX
      CodeStream.Seek(O2);
      DWordHinzufuegen(NameTabelle[AktProc].StackAlloc);
      CodeStream.Seek(O3);
      DWordHinzufuegen(NameTabelle[AktProc].StackAlloc);
      CodeStream.Seek(O5);
     END;

     OutLabel(SL);
     DEC(Level);
     SETLENGTH(BreakLabel,Level+1);
     SETLENGTH(ContinueLabel,Level+1);
    END;
    AktProcName:='';
    AktProc:=-1;
    inmain:=FALSE;
   END;
  END ELSE IF (tTok=_lparent) AND NOT StartLevel THEN BEGIN
  END ELSE BEGIN
   IF tTok=_klparent THEN BEGIN
    Get;
    IF tTok=_integer THEN BEGIN
     ArrayDim:=iTok;
     Get;
     IF tTok=_krparent THEN BEGIN
      IstArray:=TRUE;
      Get;
     END ELSE BEGIN
      SetError(ceKRParentErwartet);
     END;
    END ELSE BEGIN
     SetError(ceZahlenWertErwartet);
    END;
   END;
   IF NOT IstArray THEN ArrayDim:=0;
   OK:=TRUE;
   IF Struct THEN BEGIN
    IF LockVar(S,'',A,adr,TRUE,ttZaehler) THEN BEGIN
     SetError(ceVarDoppelDefiniert);
     OK:=FALSE;
    END;
   END ELSE IF LockVar(S,'',A,adr,TRUE,-1) THEN BEGIN
    SetError(ceVarDoppelDefiniert);
    OK:=FALSE;
   END;
   IF OK THEN BEGIN
    IF Struct THEN BEGIN
     adr:=AddObjekt(S,'',_ident,T,0,ArrayDim,aStructVar,Zeiger,Struct,Typ,0);
    END ELSE IF LENGTH(MTRIM(AktProcName))=0 THEN BEGIN
     adr:=AddObjekt(S,'',_ident,T,0,ArrayDim,aGlobal,Zeiger,Struct,Typ,0);
    END ELSE IF FuncParam THEN BEGIN
     adr:=AddObjekt(S,'',_ident,T,0,ArrayDim,aParam,Zeiger,Struct,Typ,0);
    END ELSE IF static THEN BEGIN
     adr:=AddObjekt(S,'',_ident,T,0,ArrayDim,aStatic,Zeiger,Struct,Typ,0);
    END ELSE BEGIN
     adr:=AddObjekt(S,'',_ident,T,0,ArrayDim,aLokal,Zeiger,Struct,Typ,0);
    END;
   END;
   IF (tTok=_set) AND IstArray AND (T IN [tChar,tuChar]) AND Zeiger THEN BEGIN
    Get;
    StringHandling.IstZeiger:=TRUE;
    IsTermSigned:=FALSE;
    DoExpression;
    OutMovVarAx(S,0,FALSE,FALSE);
   END ELSE IF (tTok=_set) AND (T=tString) AND NOT (Zeiger OR IstArray) THEN BEGIN
    Get;
    IsStringTerm:=TRUE;
    MustBeStringTerm:=TRUE;
    StringLevel:=0;
    StringBoolExpression(TRUE);
    OutStrUnique;
    OutMovVarAx(S,0,FALSE,FALSE);
   END ELSE IF (tTok=_set) AND NOT IstArray THEN BEGIN
    Get;
    IF T IN [tChar,tuChar] THEN BEGIN
     StringHandling.IstZeiger:=Zeiger;
    END ELSE BEGIN
     StringHandling.IstZeiger:=FALSE;
    END;
    IsTermSigned:=NameTabelle[tnZaehler].Typ IN [tByte,tChar,tShortInt,tInt];
    DoExpression;
    IF (NameTabelle[tnZaehler].Typ=tFloat) AND NOT NameTabelle[tnZaehler].Zeiger THEN BEGIN
     IF NOT IsFloatExpression THEN BEGIN
      OutIntAxToFPU;
      OutFPUToAx;
     END;
    END;
    IF StringHandling.IstZeiger THEN BEGIN
     OutMovVarAx(S,0,FALSE,FALSE);
    END ELSE BEGIN
     OutMovVarAx(S,0,Zeiger,FALSE);
    END;
   END;
   IF (tTok=_comma) AND NOT FuncParam THEN BEGIN
    Schleife:=TRUE;
    KeinGET:=FALSE;
   END;
  END;
 END;
 IF StartLevel THEN IF tTok=_semicolon THEN Get;
END;

PROCEDURE TBeRoScript.LabelStatement;
VAR S:STRING;
    I,J:INTEGER;
    Adr:INTEGER;
    A:STRING;
BEGIN
 S:=GetLabelName(sTok);
 IF LockVar(sTok,'',a,Adr,FALSE,-1) THEN BEGIN
  SetError(ceLabelNameVariableDefiniert);
 END ELSE BEGIN
  J:=-1;
  FOR I:=0 TO LENGTH(LabelArray)-1 DO BEGIN
   IF LabelArray[I]=S THEN BEGIN
    J:=I;
    BREAK;
   END;
  END;
  IF J<0 THEN BEGIN
   AddObjekt(sTok,'',_labelident,tNichts,0,0,aLokal,FALSE,FALSE,-1,0);
   SETLENGTH(LabelArray,LENGTH(LabelArray)+1);
   LabelArray[LENGTH(LabelArray)-1]:=S;
   OutLabel(S);
  END ELSE BEGIN
   SetError(ceLabelDoppelDefiniert);
  END;
 END;
 Get;
END;

PROCEDURE TBeRoScript.GotoStatement;
VAR S:STRING;
    I,J:INTEGER;
BEGIN
 Get;
 IF tTok=_labelident THEN BEGIN
  S:=GetLabelName(sTok);
  J:=-1;
  FOR I:=0 TO LENGTH(LabelArray)-1 DO BEGIN
   IF LabelArray[I]=S THEN BEGIN
    J:=I;
    BREAK;
   END;
  END;
  IF J>=0 THEN BEGIN
   OutJmp(S);
  END ELSE BEGIN
   SetError(ceLabelNotFound);
  END;
  Get;
 END;
END;

PROCEDURE TBeRoScript.enumStatement(Art:TArt);
VAR S,a:STRING;
    I,J,Adr:INTEGER;
    WertArray:ARRAY OF INTEGER;
    Wert,LetzterWert:INTEGER;
BEGIN
 Get;
 IF tTok=_ident THEN BEGIN
  S:=sTok;
  IF NOT LockVar(S,'',a,Adr,FALSE,-1) THEN BEGIN
   AddObjekt(S,'',_enumstruct,tInt,0,0,Art,FALSE,FALSE,-1,0);
  END ELSE BEGIN
   SetError(ceENumStructAlreadyUsed);
  END;
  Get;
 END ELSE IF tTok=_enumstruct THEN BEGIN
  SetError(ceENumStructAlreadyUsed);
  Get;
 END;
 IF NOT ferror THEN BEGIN
  IF tTok=_begin THEN BEGIN
   WertArray:=NIL;
   Wert:=0;
   LetzterWert:=-1;
   Get;
   WHILE NOT ((tTok=_end) OR feof OR ferror) DO BEGIN
    IF tTok=_ident THEN BEGIN
     S:=sTok;
     Get;
     IF tTok=_set THEN BEGIN
      Get;
      IF tTok=_integer THEN BEGIN
       Wert:=iTok;
       Get;
      END ELSE BEGIN
       SetError(ceZahlenWertErwartet);
      END;
     END ELSE BEGIN
      Wert:=LetzterWert;
      J:=0;
      WHILE J>=0 DO BEGIN
       INC(Wert);
       J:=-1;
       FOR I:=0 TO LENGTH(WertArray)-1 DO BEGIN
        IF WertArray[I]=Wert THEN BEGIN
         J:=I;
         BREAK;
        END;
       END;
      END;
     END;
     J:=-1;
     FOR I:=0 TO LENGTH(WertArray)-1 DO BEGIN
      IF WertArray[I]=Wert THEN BEGIN
       J:=I;
       BREAK;
      END;
     END;
     IF J<0 THEN BEGIN
      SETLENGTH(WertArray,LENGTH(WertArray)+1);
      WertArray[LENGTH(WertArray)-1]:=Wert;
     END;
     LetzterWert:=Wert;
     IF NOT LockVar(S,'',a,Adr,FALSE,-1) THEN BEGIN
      AddObjekt(S,'',_enumvalue,tInt,0,0,Art,FALSE,FALSE,-1,Wert);
     END ELSE BEGIN
      SetError(ceENumAlreadyDefined);
     END;
    END ELSE IF tTok=_enumvalue THEN BEGIN
     SetError(ceENumAlreadyDefined);
     Get;
    END ELSE BEGIN
     SetError(ceBezeichnerErwartet);
     Get;
    END;
    IF tTok=_comma THEN BEGIN
     Get;
    END;
   END;
   IF tTok=_end THEN BEGIN
    Get;
   END ELSE BEGIN
    SetError(ceEndErwartet);
   END;
   SETLENGTH(WertArray,0);
  END ELSE BEGIN
   SetError(ceBeginErwartet);
  END;
 END;
END;

PROCEDURE TBeRoScript.BreakPointStatement;
BEGIN
 Get;
 IF Debug THEN ByteHinzufuegen($CC);
END;

PROCEDURE TBeRoScript.OutputBlockStatement;
BEGIN
 Get;
 IF tTok=_lparent THEN BEGIN
  Get;
  IsTermSigned:=TRUE;
  DoExpression;
  OutOutputBlock;
  IF tTok=_rparent THEN BEGIN
   Get;
  END ELSE BEGIN
   SetError(ceRParenExp);
  END;
 END ELSE BEGIN
  SetError(ceLParenExp);
 END;
END;

PROCEDURE TBeRoScript.SizeOfStatement;
VAR A:STRING;
    Adr:TWert;
    I:INTEGER;
    Zeiger,HoleZeiger:BOOLEAN;
    AltAktSymPtr:INTEGER;
BEGIN
 Get;
 IF tTok=_lparent THEN BEGIN
  Get;
  Zeiger:=FALSE;
  HoleZeiger:=FALSE;
  WHILE NOT (feof OR ferror) DO BEGIN
   IF tTok=_mul THEN BEGIN
    Zeiger:=TRUE;
    HoleZeiger:=FALSE;
    Get;
   END ELSE IF tTok=_and THEN BEGIN
    Zeiger:=FALSE;
    HoleZeiger:=TRUE;
    Get;
   END ELSE BEGIN
    BREAK;
   END;
  END;
  IF HoleZeiger THEN BEGIN
   OutMovAxImmUnsigned(4);
  END ELSE IF tTok IN [_int,_stringtype,_float,_void] THEN BEGIN
   OutMovAxImmUnsigned(4);
  END ELSE IF tTok=_shortint THEN BEGIN
   OutMovAxImmUnsigned(2);
  END ELSE IF tTok IN [_byte,_char] THEN BEGIN
   OutMovAxImmUnsigned(1);
  END ELSE IF tTok=_ident THEN BEGIN
   I:=LookStruct(sTok);
   IF I>=0 THEN BEGIN
    OutMovAxImmUnsigned(TypTabelle[I].Size);
   END ELSE BEGIN
    IF LockVar(sTok,'',a,Adr,FALSE,-1) THEN BEGIN
     IF NameTabelle[AktSymPtr].Art=aGlobal THEN BEGIN
      AltAktSymPtr:=AktSymPtr;
      IF LookStructVar(sTok)<0 THEN BEGIN
       AktSymPtr:=AltAktSymPtr;
       StructAssignment(FALSE,FALSE,FALSE,TRUE);
      END ELSE BEGIN
       StructAssignment(FALSE,FALSE,TRUE,TRUE);
      END;
     END ELSE BEGIN
      StructAssignment(FALSE,FALSE,FALSE,TRUE);
     END;
    END ELSE BEGIN
     IF LookStructVar(sTok)<0 THEN BEGIN
      SetError(ceVarNotDef);
     END ELSE BEGIN
      StructAssignment(FALSE,FALSE,TRUE,TRUE);
     END;
    END;
    IF NOT fError THEN BEGIN
     IF NameTabelle[AktSymPtr].Zeiger AND NOT Zeiger THEN BEGIN
      OutMovAxImmUnsigned(4);
     END ELSE IF NameTabelle[AktSymPtr].EinTyp THEN BEGIN
      IF NameTabelle[AktSymPtr].IstArray THEN BEGIN
       OutMovAxImmUnsigned(TypTabelle[NameTabelle[AktSymPtr].TypLink].Size*NameTabelle[AktSymPtr].ArrayDim);
      END ELSE BEGIN
       OutMovAxImmUnsigned(TypTabelle[NameTabelle[AktSymPtr].TypLink].Size);
      END;
     END ELSE IF NameTabelle[AktSymPtr].IstArray THEN BEGIN
      OutMovAxImmUnsigned(NameTabelle[AktSymPtr].Size*NameTabelle[AktSymPtr].ArrayDim);
     END ELSE BEGIN
      OutMovAxImmUnsigned(NameTabelle[AktSymPtr].Size);
     END;
    END ELSE BEGIN
     SetError(ceVarNotDef);
    END;
   END;
  END ELSE BEGIN
   SetError(ceBezeichnerErwartet);
  END;
  IF tTok<>_rparent THEN Get;
  IF tTok=_rparent THEN BEGIN
   Get;
  END ELSE BEGIN
   SetError(ceRParenExp);
  END;
 END ELSE BEGIN
  SetError(ceLParenExp);
 END;
END;

PROCEDURE TBeRoScript.InheritedStatement;
VAR S,SO,SS,A,SA:STRING;
    I,J,K,L,M:INTEGER;
    Ident,Gefunden:BOOLEAN;
    Adr:TWert;
    AltAktSymPtr:INTEGER;
BEGIN
 Get;
 IF AktProc>=0 THEN BEGIN
  IF LENGTH(NameTabelle[AktProc].StructName)>0 THEN BEGIN
   S:=NameTabelle[AktProc].Name;
   SO:='';
   Ident:=TRUE;
   IF tTok=_ident THEN BEGIN
    SS:=sTok;
    Get;
    IF IsStruct(SS) THEN BEGIN
     SO:=SS;
     IF tTok=_dot THEN BEGIN
      Get;
      IF tTok=_ident THEN BEGIN
       Ident:=TRUE;
       S:=sTok;
       Get;
      END ELSE BEGIN
       SetError(ceBezeichnerErwartet);
      END;
     END;
    END ELSE BEGIN
     Ident:=TRUE;
     S:=SS;
    END;
   END;
   I:=LookStruct(NameTabelle[AktProc].StructName);
   IF I>=0 THEN BEGIN
    AltAktSymPtr:=0;
    K:=LENGTH(TypTabelle[I].Extends);
    Gefunden:=FALSE;
    IF K>0 THEN BEGIN
     M:=0;
     FOR J:=K-1 DOWNTO 0 DO BEGIN
      L:=TypTabelle[I].Extends[J];
      IF (SO=TypTabelle[L].Name) OR (SO='') THEN BEGIN
       IF LockVar(S,TypTabelle[L].Name,A,Adr,FALSE,-1) THEN BEGIN
        M:=J;
        AltAktSymPtr:=AktSymPtr;
        Gefunden:=TRUE;
        BREAK;
       END;
      END;
     END;
     IF Gefunden THEN BEGIN
      IF LockVar(tnFunctionObjectPointer,'',SA,Adr,FALSE,-1) THEN BEGIN
       OutMovCxVarEBP(NameTabelle[AktSymPtr].StackPtr,4);
      END;
      OutAddECX(TypTabelle[I].ExtendsOffsets[M]);
      OutMovBxImmLabel(a);
      AktSymPtr:=AltAktSymPtr;
      CallState(FALSE,TRUE,Ident);
     END ELSE BEGIN
      SetError(ceNoInheritedCallPossible);
     END;
    END ELSE BEGIN
     SetError(ceNoInheritedCallPossible);
    END;
   END ELSE BEGIN
    SetError(ceOnlyInMethodAllowed);
   END;
  END ELSE BEGIN
   SetError(ceOnlyInMethodAllowed);
  END;
 END ELSE BEGIN
  SetError(ceOnlyInMethodAllowed);
 END;
END;

PROCEDURE TBeRoScript.IdentStatement;
BEGIN
 IF NOT VarStruct(TRUE) THEN Statement(TRUE);
END;

PROCEDURE TBeRoScript.Statement(Semicolon:BOOLEAN);
VAR OldTok:INTEGER;
BEGIN
 OldTok:=tTok;
 CASE tTok OF
  _begin:BeginState;
  _while:WhileState;
  _do:DoWhileState;
  _for:ForState;
  _if:IfState;
  _switch:SwitchState;
  _printf,_print:PrntStatement;
  _asm:ASMStatement;
  _ident:AssignmentOrVarStruct;
  _mul:Assignment;
  _break:BEGIN
   OutJmp(BreakLabel[Level]);
   Get;
  END;
  _continue:BEGIN
   OutJmp(ContinueLabel[Level]);
   Get;
  END;
  _call:AssignmentOrVarStruct;
  _shortint,_void,_int,_byte,_char,_float,_stringtype,_unsigned,_signed,_static,_native,_import,_stdcall:VarDefStatement(FALSE,FALSE,FALSE,-1,FALSE);
  _return:ReturnStatement;
  _packed,_struct:StructStatement(FALSE,FALSE,FALSE);
  _union:StructStatement(FALSE,TRUE,FALSE);
  _object:StructStatement(FALSE,FALSE,TRUE);
  _label:LabelStatement;
  _goto:GotoStatement;
  _enum:enumStatement(aLokal);
  _breakpoint:BreakPointStatement;
  _outputblock:OutputBlockStatement;
  _sizeof:SizeOfStatement;
  _inherited:InheritedStatement;
  _semicolon:Get;
  ELSE BEGIN
   SetError(ceUndefErr);
  END;
 END;
 IF Semicolon AND NOT fError THEN BEGIN
  CASE OldTok OF
   _printf,_print,_ident,_mul,_call, _shortint,_void,_int,_byte,_char,_float,_stringtype,_unsigned,_signed,_static,_break,_continue,_return,_packed,_struct,_union,_native,_import,_stdcall,_goto,_breakpoint,_outputblock,_sizeof,_inherited:BEGIN
    IF tTok=_semicolon THEN BEGIN
     Get;
    END ELSE IF tTok=_end THEN BEGIN
    END ELSE BEGIN
     SetError(ceSemiColonErwartet);
    END;
   END;
   ELSE BEGIN
   END;
  END;
 END;
END;

PROCEDURE TBeRoScript.FirstStatement;
BEGIN
 WHILE NOT (feof OR ferror) DO BEGIN
  CASE tTok OF
   _shortint,_void,_int,_byte,_char,_float,_stringtype,_unsigned,_signed,_static,_native,_import,_stdcall:VarDefStatement(TRUE,FALSE,FALSE,-1,FALSE);
   _ident:IdentStatement;
   _packed,_struct:StructStatement(TRUE,FALSE,FALSE);
   _union:StructStatement(TRUE,TRUE,FALSE);
   _object:StructStatement(TRUE,FALSE,TRUE);
   _enum:enumStatement(aGlobal);
   _semicolon:Get;
   ELSE Statement(TRUE);
  END;
 END;
END;

PROCEDURE TBeRoScript.Init;
BEGIN
 IsCompiled:=FALSE;
 UseOutputBlock:=FALSE;
 UseWrtSTR:=FALSE;
 UseWrtAXSigned:=FALSE;
 UseWrtAXUnsigned:=FALSE;
 UseWrtChar:=FALSE;
 UseWrtPCharString:=FALSE;
 UseWrtFloat:=FALSE;
 UseStrNew:=FALSE;
 UseStrAssign:=FALSE;
 UseStrLength:=FALSE;
 UseStrSetLength:=FALSE;
 UseStrUnique:=FALSE;
 UseStrCharConvert:=FALSE;
 UseStrGet:=FALSE;
 UseStrConcat:=FALSE;
 UseStrSelfConcat:=FALSE;
 UseStrCompare:=FALSE;
 AktSymPtr:=-1;
 AktTypPtr:=-1;
 AktProc:=-1;
 AktProcName:='';
 QuelltextPos:=1;
 QuelltextZeile:=0;
 QuelltextSpalte:=0;
 feof:=FALSE;
 p:=0;
 Level:=0;
 SETLENGTH(BreakLabel,Level+1);
 SETLENGTH(ContinueLabel,Level+1);
 BreakLabel[Level]:='C_exit';
 ContinueLabel[Level]:='C_exit';
 DP:=0;
 tnZaehler:=0;
 ttZaehler:=0;
 tnSubZaehler:=0;
 ferror:=TRUE;
 frunning:=FALSE;
 inmain:=FALSE;
 SBuf:='';
 AddObjekt('{','',_keyword,tNichts,_begin,0,aGlobal,FALSE,FALSE,-1,0);
 AddObjekt('else','',_keyword,tNichts,_else,0,aGlobal,FALSE,FALSE,-1,0);
 AddObjekt('}','',_keyword,tNichts,_end,0,aGlobal,FALSE,FALSE,-1,0);
 AddObjekt('asm','',_keyword,tNichts,_asm,0,aGlobal,FALSE,FALSE,-1,0);
 AddObjekt('if','',_keyword,tNichts,_if,0,aGlobal,FALSE,FALSE,-1,0);
 AddObjekt('switch','',_keyword,tNichts,_switch,0,aGlobal,FALSE,FALSE,-1,0);
 AddObjekt('case','',_keyword,tNichts,_case,0,aGlobal,FALSE,FALSE,-1,0);
 AddObjekt('default','',_keyword,tNichts,_default,0,aGlobal,FALSE,FALSE,-1,0);
 AddObjekt('while','',_keyword,tNichts,_while,0,aGlobal,FALSE,FALSE,-1,0);
 AddObjekt('do','',_keyword,tNichts,_do,0,aGlobal,FALSE,FALSE,-1,0);
 AddObjekt('for','',_keyword,tNichts,_for,0,aGlobal,FALSE,FALSE,-1,0);
 AddObjekt('printf','',_keyword,tNichts,_printf,0,aGlobal,FALSE,FALSE,-1,0);
 AddObjekt('print','',_keyword,tNichts,_print,0,aGlobal,FALSE,FALSE,-1,0);
 AddObjekt('echo','',_keyword,tNichts,_print,0,aGlobal,FALSE,FALSE,-1,0);
 AddObjekt('shortint','',_keyword,tNichts,_shortint,0,aGlobal,FALSE,FALSE,-1,0);
 AddObjekt('void','',_keyword,tNichts,_void,0,aGlobal,FALSE,FALSE,-1,0);
 AddObjekt('file','',_keyword,tNichts,_void,0,aGlobal,FALSE,FALSE,-1,0);
 AddObjekt('int','',_keyword,tNichts,_int,0,aGlobal,FALSE,FALSE,-1,0);
 AddObjekt('long','',_keyword,tNichts,_int,0,aGlobal,FALSE,FALSE,-1,0);
 AddObjekt('byte','',_keyword,tNichts,_byte,0,aGlobal,FALSE,FALSE,-1,0);
 AddObjekt('char','',_keyword,tNichts,_char,0,aGlobal,FALSE,FALSE,-1,0);
 AddObjekt('float','',_keyword,tNichts,_float,0,aGlobal,FALSE,FALSE,-1,0);
 AddObjekt('string','',_keyword,tNichts,_stringtype,0,aGlobal,FALSE,FALSE,-1,0);
 AddObjekt('unsigned','',_keyword,tNichts,_unsigned,0,aGlobal,FALSE,FALSE,-1,0);
 AddObjekt('signed','',_keyword,tNichts,_signed,0,aGlobal,FALSE,FALSE,-1,0);
 AddObjekt('break','',_keyword,tNichts,_break,0,aGlobal,FALSE,FALSE,-1,0);
 AddObjekt('continue','',_keyword,tNichts,_continue,0,aGlobal,FALSE,FALSE,-1,0);
 AddObjekt('static','',_keyword,tNichts,_static,0,aGlobal,FALSE,FALSE,-1,0);
 AddObjekt('return','',_keyword,tNichts,_return,0,aGlobal,FALSE,FALSE,-1,0);
 AddObjekt('struct','',_keyword,tNichts,_struct,0,aGlobal,FALSE,FALSE,-1,0);
 AddObjekt('packed','',_keyword,tNichts,_packed,0,aGlobal,FALSE,FALSE,-1,0);
 AddObjekt('inherited','',_keyword,tNichts,_inherited,0,aGlobal,FALSE,FALSE,-1,0);
 AddObjekt('union','',_keyword,tNichts,_union,0,aGlobal,FALSE,FALSE,-1,0);
 AddObjekt('object','',_keyword,tNichts,_object,0,aGlobal,FALSE,FALSE,-1,0);
 AddObjekt('native','',_keyword,tNichts,_native,0,aGlobal,FALSE,FALSE,-1,0);
 AddObjekt('import','',_keyword,tNichts,_import,0,aGlobal,FALSE,FALSE,-1,0);
 AddObjekt('stdcall','',_keyword,tNichts,_stdcall,0,aGlobal,FALSE,FALSE,-1,0);
 AddObjekt('goto','',_keyword,tNichts,_goto,0,aGlobal,FALSE,FALSE,-1,0);
 AddObjekt('enum','',_keyword,tNichts,_enum,0,aGlobal,FALSE,FALSE,-1,0);
 AddObjekt('breakpoint','',_keyword,tNichts,_breakpoint,0,aGlobal,FALSE,FALSE,-1,0);
 AddObjekt('outputblock','',_keyword,tNichts,_outputblock,0,aGlobal,FALSE,FALSE,-1,0);
 AddObjekt('sizeof','',_keyword,tNichts,_sizeof,0,aGlobal,FALSE,FALSE,-1,0);
 AddObjekt('bool','',_keyword,tNichts,_int,0,aGlobal,FALSE,FALSE,-1,0);
 AddObjekt('BOOL','',_keyword,tNichts,_int,0,aGlobal,FALSE,FALSE,-1,0);
 AddObjekt('boolean','',_keyword,tNichts,_char,0,aGlobal,FALSE,FALSE,-1,0);
 AddObjekt('false','',_enumvalue,tNichts,_int,0,aGlobal,FALSE,FALSE,-1,0);
 AddObjekt('true','',_enumvalue,tNichts,_int,0,aGlobal,FALSE,FALSE,-1,1);
 AddObjekt('FALSE','',_enumvalue,tNichts,_int,0,aGlobal,FALSE,FALSE,-1,0);
 AddObjekt('TRUE','',_enumvalue,tNichts,_int,0,aGlobal,FALSE,FALSE,-1,1);
 AddObjekt('NULL','',_enumvalue,tNichts,_int,0,aGlobal,FALSE,FALSE,-1,0);
END;

PROCEDURE TBeRoScript.OutRTL;
BEGIN
 IF UseOutputBlock THEN BEGIN
  OutLabel('C_OutputBlock');
  OutPushClassPointer;
  OutPushAx;
  OutCallNative('RTL_OUTPUTBLOCK');
  OutRetEx;
 END;
 IF UseWrtSTR THEN BEGIN
  OutLabel('C_PrintString');
  OutPushClassPointer;
  OutPushAx;
  OutCallNative('RTL_PRINTF_STRING');
  OutRetEx;
 END;
 IF UseWrtAXSigned THEN BEGIN
  OutLabel('C_WRITENUMSIGNED');
  OutPushClassPointer;
  OutPushAx;
  OutCallNative('RTL_PRINTF_NUMBER_SIGNED');
  OutRetEx;
 END;
 IF UseWrtAXUnsigned THEN BEGIN
  OutLabel('C_WRITENUMUNSIGNED');
  OutPushClassPointer;
  OutPushAx;
  OutCallNative('RTL_PRINTF_NUMBER_UNSIGNED');
  OutRetEx;
 END;
 IF UseWrtChar THEN BEGIN
  OutLabel('C_PrintChar');
  OutPushClassPointer;
  OutPushAx;
  OutCallNative('RTL_PRINTF_CHAR');
  OutRetEx;
 END;
 IF UseWrtPCharString THEN BEGIN
  OutLabel('C_PrintPCharString');
  OutPushClassPointer;
  OutPushAx;
  OutCallNative('RTL_PRINTF_PCHAR');
  OutRetEx;
 END;
 IF UseWrtFloat THEN BEGIN
  OutLabel('C_PrintFloat');
  OutPushClassPointer;
  OutPushAx;
  OutCallNative('RTL_PRINTF_FLOAT');
  OutRetEx;
 END;
 IF UseStrNew THEN BEGIN
  OutLabel('C_StrNew');
  OutCallNative('RTL_STRING_NEW');
  OutRetEx;
 END;
 IF UseStrAssign THEN BEGIN
  OutLabel('C_StrAssign');
  OutPushAx;
  OutPushBx;
  OutCallNative('RTL_STRING_ASSIGN');
  OutRetEx;
 END;
 IF UseStrLength THEN BEGIN
  OutLabel('C_StrLength');
  OutPushAx;
  OutPushBx;
  OutCallNative('RTL_STRING_LENGTH');
  OutRetEx;
 END;
 IF UseStrSetLength THEN BEGIN
  OutLabel('C_StrSetLength');
  OutPushAx;
  OutPushBx;
  OutCallNative('RTL_STRING_SETLENGTH');
  OutRetEx;
 END;
 IF UseStrUnique THEN BEGIN
  OutLabel('C_StrUnique');
  OutPushAx;
  OutCallNative('RTL_STRING_UNIQUE');
  OutRetEx;
 END;
 IF UseStrCharConvert THEN BEGIN
  OutLabel('C_StrCharConvert');
  OutPushAx;
  OutCallNative('RTL_STRING_CHARCONVERT');
  OutRetEx;
 END;
 IF UseStrGet THEN BEGIN
  OutLabel('C_StrGet');
  OutPushAx;
  OutPushBx;
  OutCallNative('RTL_STRING_GET');
  OutRetEx;
 END;
 IF UseStrConcat THEN BEGIN
  OutLabel('C_StrConcat');
  OutPushBx;
  OutPushAx;
  OutPushCx;
  OutCallNative('RTL_STRING_CONCAT');
  OutRetEx;
 END;
 IF UseStrSelfConcat THEN BEGIN
  OutLabel('C_StrSelfConcat');
  OutPushAx;
  OutPushBx;
  OutCallNative('RTL_STRING_SELF_CONCAT');
  OutRetEx;
 END;
 IF UseStrCompare THEN BEGIN
  OutLabel('C_StrCompare');
  OutPushAx;
  OutPushBx;
  OutCallNative('RTL_STRING_COMPARE');
  OutRetEx;
 END;
END;

PROCEDURE TBeRoScript.DoCompile;
VAR I,J,K:INTEGER;
    Adr:TWert;
    a:STRING;
BEGIN
 AktSymPtr:=-1;
 AktTypPtr:=-1;
 AktProc:=-1;
 AktProcName:='';
 QuelltextPos:=1;
 QuelltextZeile:=0;
 QuelltextSpalte:=0;
 feof:=FALSE;
 ferror:=FALSE;
 ch:=LeseNaechstesZeichen;
 Get;               

 ProcHinzufuegen('$start','');
 ByteHinzufuegen($60); // PUSHAD
 OutPushBp;
 OutMovBpSp;
 FirstStatement;
 OutMovSpBp;
 OutPopBp;
 ByteHinzufuegen($61); // POPAD
 ByteHinzufuegen($C3); // RET

 ProcHinzufuegen('$main','');
 ByteHinzufuegen($60); // PUSHAD
 OutPushBp;
 OutMovBpSp;
 IF LockVar('main','',a,Adr,FALSE,-1) THEN CallLabel(a);
 OutMovSpBp;
 OutPopBp;
 ByteHinzufuegen($61); // POPAD
 ByteHinzufuegen($C3); // RET

 ProcHinzufuegen('$end','');
 ByteHinzufuegen($60); // PUSHAD
 OutPushBp;
 OutMovBpSp;
 tnSubZaehler:=0;
 FOR I:=1 TO tnZaehler DO IF NameTabelle[I].Obj=_ident THEN INC(tnSubZaehler);
 LabelHinzufuegen('C_Exit');
 FOR I:=1 TO tnZaehler DO BEGIN
  IF NameTabelle[I].Obj=_ident THEN BEGIN
   IF NameTabelle[I].Art IN [aGlobal,aStatic] THEN BEGIN
    IF AreInThatStrings(I) THEN BEGIN
     OutMovBxImmLabel(NameTabelle[I].AsmVarName);
     FunctionStringFree(I,NameTabelle[I].Art,0,0);
    END;
   END;
  END;
 END;
 OutMovSpBp;
 OutPopBp;
 ByteHinzufuegen($61); // POPAD
 ByteHinzufuegen($C3); // RET

 OutRTL;

 LabelHinzufuegen('CodeEnd');
 BSSGroesse:=0;
 IF tnSubZaehler>0 THEN BEGIN
  FOR I:=1 TO tnZaehler DO BEGIN
   IF NameTabelle[I].Obj=_ident THEN BEGIN
    IF NameTabelle[I].Art IN [aGlobal,aStatic] THEN BEGIN
     IF NameTabelle[I].Art=aGlobal THEN BEGIN
      VariableHinzufuegen(NameTabelle[I].Name,'');
     END ELSE IF NameTabelle[I].Art=aStatic THEN BEGIN
      VariableHinzufuegen(NameTabelle[I].Name,NameTabelle[I].Proc);
     END;
     IF NameTabelle[I].Zeiger THEN BEGIN
      LabelHinzufuegen(NameTabelle[I].AsmVarName);
      DWordHinzufuegen(0);
      INC(BSSGroesse,4);
     END ELSE IF NameTabelle[I].IstArray THEN BEGIN
      LabelHinzufuegen(NameTabelle[I].AsmVarName);
      INC(BSSGroesse,NameTabelle[I].Size*NameTabelle[I].ArrayDim);
      FOR J:=1 TO NameTabelle[I].ArrayDim DO BEGIN
       IF NameTabelle[I].Typ IN [tChar,tuChar,tByte,tuByte] THEN ByteHinzufuegen(0);
       IF NameTabelle[I].Typ IN [tShortInt,tuShortInt] THEN WordHinzufuegen(0);
       IF NameTabelle[I].Typ IN [tInt,tuInt,tFloat,tString,tVoid] THEN DWordHinzufuegen(0);
       IF NameTabelle[I].Typ=tType THEN BEGIN
        FOR K:=1 TO NameTabelle[I].Size DO ByteHinzufuegen(0);
       END;
      END;
     END ELSE BEGIN
      LabelHinzufuegen(NameTabelle[I].AsmVarName);
      INC(BSSGroesse,NameTabelle[I].Size);
      IF NameTabelle[I].Typ IN [tChar,tuChar,tByte,tuByte] THEN ByteHinzufuegen(0);
      IF NameTabelle[I].Typ IN [tShortInt,tuShortInt] THEN WordHinzufuegen(0);
      IF NameTabelle[I].Typ IN [tInt,tuInt,tFloat,tString,tVoid] THEN DWordHinzufuegen(0);
      IF NameTabelle[I].Typ=tType THEN BEGIN
       FOR K:=1 TO NameTabelle[I].Size DO ByteHinzufuegen(0);
      END;
     END;
    END;
   END;
  END;
 END;
 Errors:=TRIM(Errors);
 Fehler:=LENGTH(Errors)>0;
END;

PROCEDURE TBeRoScript.AddNativeProc(Name:STRING;Proc:POINTER);
BEGIN
 SETLENGTH(NativeTabelle,tnpZaehler+1);
 NativeTabelle[tnpZaehler].Name:=Name;
 NativeTabelle[tnpZaehler].Proc:=Proc;
 INC(tnpZaehler);
END;

PROCEDURE TBeRoScript.AddDefine(Name:STRING);
 FUNCTION ExistDefine(Name:STRING):BOOLEAN;
 VAR I:INTEGER;
 BEGIN
  RESULT:=FALSE;
  IF LENGTH(Name)>0 THEN BEGIN
   FOR I:=0 TO LENGTH(Defines)-1 DO BEGIN
    IF Defines[I].Name=Name THEN BEGIN
     RESULT:=TRUE;
     EXIT;
    END;
   END;
  END;
 END;
BEGIN
 IF NOT ExistDefine(Name) THEN BEGIN
  SETLENGTH(Defines,LENGTH(Defines)+1);
  Defines[LENGTH(Defines)-1].Name:=Name;
 END;
END;

PROCEDURE TBeRoScript.Preprocessor;
VAR OutStream:TBeRoMemoryStream;
    OutLineNumber:INTEGER;
    PreprocessorDefines:ARRAY OF TDefine;
    I,J:INTEGER;
  FUNCTION ExistDefine(Name:STRING):BOOLEAN;
  VAR I:INTEGER;
  BEGIN
  RESULT:=FALSE;
  IF LENGTH(Name)>0 THEN BEGIN
   FOR I:=0 TO LENGTH(PreprocessorDefines)-1 DO BEGIN
    IF PreprocessorDefines[I].Name=Name THEN BEGIN
     RESULT:=TRUE;
     EXIT;
    END;
   END;
  END;
 END;
 PROCEDURE AddPreprocessorDefine(Name:STRING);
 BEGIN
  IF NOT ExistDefine(Name) THEN BEGIN
   SETLENGTH(PreprocessorDefines,LENGTH(PreprocessorDefines)+1);
   PreprocessorDefines[LENGTH(PreprocessorDefines)-1].Name:=Name;
   PreprocessorDefines[LENGTH(PreprocessorDefines)-1].Parameter:=NIL;
  END;
 END;
 FUNCTION DeleteDefine(Name:STRING):BOOLEAN;
 VAR I:INTEGER;
 BEGIN
  RESULT:=FALSE;
  IF LENGTH(Name)>0 THEN BEGIN
   FOR I:=0 TO LENGTH(PreprocessorDefines)-1 DO BEGIN
    IF PreprocessorDefines[I].Name=Name THEN BEGIN
     PreprocessorDefines[I].Name:='';
     PreprocessorDefines[I].Lines:='';
     SETLENGTH(PreprocessorDefines[I].Parameter,0);;
     RESULT:=TRUE;
     EXIT;
    END;
   END;
  END;
 END;
 PROCEDURE AddLine(Line:STRING;LineNumber,FileIndex:INTEGER);
 BEGIN
  OutStream.WriteLine(Line);
  INC(OutLineNumber);
  IF OutLineNumber>0 THEN BEGIN
   SETLENGTH(LinesInfo.Lines,OutLineNumber);
   IF LineNumber<=LENGTH(LinesInfo.PreparsedLines) THEN BEGIN
    LinesInfo.Lines[OutLineNumber-1]:=LinesInfo.PreparsedLines[LineNumber-1];
   END ELSE BEGIN
    LinesInfo.Lines[OutLineNumber-1].LineNumber:=LineNumber;
    LinesInfo.Lines[OutLineNumber-1].FileIndex:=FileIndex;
   END;
  END;
 END;
 PROCEDURE ProcessFile(InputSource,FileName:STRING;LineSub:INTEGER);
 VAR Lines:TBeRoMemoryStream;
     Line:STRING;
     LineNumber:INTEGER;
     FileIndex:INTEGER;
  PROCEDURE NextLine;
  BEGIN
   Line:=Lines.ReadLine;
   INC(LineNumber);
  END;
  PROCEDURE RunLevel(Level,SkipLevel:INTEGER);
  VAR S,SA,Name,Parameter,MacroLine,TheFile:STRING;
      I,J,K,H:INTEGER;
      Schleife,IstOnce,IncludeInOrdnung:BOOLEAN;
      MacroParameter:ARRAY OF STRING;
   PROCEDURE GetName;
   BEGIN
    Name:='';
    WHILE LENGTH(S)>0 DO BEGIN
     IF S[1] IN ['a'..'z','A'..'Z','0'..'9','_'] THEN BEGIN
      Name:=Name+S[1];
      DELETE(S,1,1);
     END ELSE BEGIN
      BREAK;
     END;
    END;
   END;
   PROCEDURE GetParameter;
   BEGIN
    Parameter:='';
    WHILE LENGTH(S)>0 DO BEGIN
     IF S[1] IN ['a'..'z','A'..'Z','0'..'9','_'] THEN BEGIN
      Parameter:=Parameter+S[1];
      DELETE(S,1,1);
     END ELSE BEGIN
      BREAK;
     END;
    END;
   END;
  BEGIN
   MacroParameter:=NIL;
   WHILE Lines.Position<Lines.Size DO BEGIN
    NextLine;
    S:=TRIM(Line);
    IF (SkipLevel>=0) AND (Level>SkipLevel) THEN BEGIN
     IF POS('#ifdef',S)=1 THEN RunLevel(Level+1,SkipLevel);
     IF POS('#ifndef',S)=1 THEN RunLevel(Level+1,SkipLevel);
     IF POS('#else',S)=1 THEN BEGIN
      IF SkipLevel=(Level-1) THEN BEGIN
       SkipLevel:=-1;
      END;
     END;
     IF POS('#endif',S)=1 THEN BREAK;
    END ELSE BEGIN
     IF POS('#',S)=1 THEN BEGIN
      IF POS('#define',S)=1 THEN BEGIN
       DELETE(S,1,LENGTH('#define'));
       S:=TRIM(S);
       GetName;
       S:=TRIM(S);
       IF LENGTH(S)>0 THEN BEGIN
        IF NOT ExistDefine(Name) THEN BEGIN
         SETLENGTH(PreprocessorDefines,LENGTH(PreprocessorDefines)+1);
         PreprocessorDefines[LENGTH(PreprocessorDefines)-1].Name:=Name;
         PreprocessorDefines[LENGTH(PreprocessorDefines)-1].Parameter:=NIL;
         IF S[1]='(' THEN BEGIN
          DELETE(S,1,1);
          S:=TRIM(S);
          WHILE TRUE DO BEGIN
           IF LENGTH(S)>0 THEN BEGIN
            GetParameter;
            IF LENGTH(Parameter)>0 THEN BEGIN
             SETLENGTH(PreprocessorDefines[LENGTH(PreprocessorDefines)-1].Parameter,LENGTH(PreprocessorDefines[LENGTH(PreprocessorDefines)-1].Parameter)+1);
             PreprocessorDefines[LENGTH(PreprocessorDefines)-1].Parameter[LENGTH(PreprocessorDefines[LENGTH(PreprocessorDefines)-1].Parameter)-1]:=Parameter;
            END ELSE BEGIN
             BREAK;
            END;
            S:=TRIM(S);
            IF LENGTH(S)>0 THEN BEGIN
             IF S[1]=')' THEN BEGIN
              DELETE(S,1,1);
              S:=TRIM(S);
              BREAK;
             END ELSE IF S[1]=',' THEN BEGIN
              DELETE(S,1,1);
              S:=TRIM(S);
             END ELSE BEGIN
              SetError(cePreprocessorError);
              BREAK;
             END;
            END;
           END ELSE BEGIN
            SetError(cePreprocessorError);
            BREAK;
           END;
          END;
         END;
         IF S[LENGTH(S)]='\' THEN BEGIN
          S:=COPY(S,1,LENGTH(S)-1);
          PreprocessorDefines[LENGTH(PreprocessorDefines)-1].Lines:=S;
          WHILE TRUE DO BEGIN
           NextLine;
           S:=Line;
           IF LENGTH(S)>0 THEN BEGIN
            PreprocessorDefines[LENGTH(PreprocessorDefines)-1].Lines:=PreprocessorDefines[LENGTH(PreprocessorDefines)-1].Lines+S+#13#10;
            IF S[LENGTH(S)]<>'\' THEN EXIT;
           END ELSE BEGIN
            BREAK;
           END;
          END;
         END ELSE BEGIN
          PreprocessorDefines[LENGTH(PreprocessorDefines)-1].Lines:=S;
         END;
        END;
       END ELSE BEGIN
        AddPreprocessorDefine(Name);
       END;
      END;
      IF POS('#undef',S)=1 THEN BEGIN
       DELETE(S,1,LENGTH('#undef'));
       S:=TRIM(S);
       GetName;
       DeleteDefine(Name);
      END;
      IF POS('#ifdef',S)=1 THEN BEGIN
       DELETE(S,1,LENGTH('#ifdef'));
       S:=TRIM(S);
       GetName;
       IF ExistDefine(Name) THEN BEGIN
        RunLevel(Level+1,-1);
       END ELSE BEGIN
        RunLevel(Level+1,Level);
       END;
      END;
      IF POS('#ifndef',S)=1 THEN BEGIN
       DELETE(S,1,LENGTH('#ifndef'));
       S:=TRIM(S);
       GetName;
       IF NOT ExistDefine(Name) THEN BEGIN
        RunLevel(Level+1,-1);
       END ELSE BEGIN
        RunLevel(Level+1,Level);
       END;
      END;
      IF POS('#else',S)=1 THEN BEGIN
       SkipLevel:=Level-1;
      END;
      IF POS('#include',S)=1 THEN BEGIN
       IF POS('#includeonce',S)=1 THEN BEGIN
        DELETE(S,1,LENGTH('#includeonce'));
        IstOnce:=TRUE;
       END ELSE BEGIN
        DELETE(S,1,LENGTH('#include'));
        IstOnce:=FALSE;
       END;
       TheFile:=TRIM(S);
       IF LENGTH(TheFile)>0 THEN BEGIN
        IF TheFile[1]='<' THEN BEGIN
         DELETE(TheFile,1,1);
         IF LENGTH(TheFile)>0 THEN BEGIN
          IF TheFile[LENGTH(TheFile)]='>' THEN BEGIN
           DELETE(TheFile,LENGTH(TheFile),1);
          END;
         END;
        END;
       END;
       IF LENGTH(TheFile)>0 THEN BEGIN
        IF TheFile[1]='"' THEN BEGIN
         DELETE(TheFile,1,1);
         IF LENGTH(TheFile)>0 THEN BEGIN
          IF TheFile[LENGTH(TheFile)]='"' THEN BEGIN
           DELETE(TheFile,LENGTH(TheFile),1);
          END;
         END;
        END;
       END;
       IF LENGTH(TheFile)>0 THEN BEGIN
        AddLine('',LineNumber,FileIndex);
        IncludeInOrdnung:=TRUE;
        IF IstOnce THEN BEGIN
         FOR J:=0 TO LENGTH(LinesInfo.Files)-1 DO BEGIN
          IF LinesInfo.Files[J]=TheFile THEN BEGIN
           IncludeInOrdnung:=FALSE;
           BREAK;
          END;
         END;
        END;
        IF IncludeInOrdnung THEN BEGIN
         ProcessFile(ReadFileAsString(TheFile),TheFile,0);
        END;
       END;
      END;
     END ELSE BEGIN
      Schleife:=TRUE;
      WHILE Schleife DO BEGIN
       Schleife:=FALSE;
       FOR I:=0 TO LENGTH(PreprocessorDefines)-1 DO BEGIN
        IF LENGTH(PreprocessorDefines[I].Lines)>0 THEN BEGIN
         IF LENGTH(PreprocessorDefines[I].Parameter)>0 THEN BEGIN
          MacroLine:=PreprocessorDefines[I].Lines;
          S:=Line;
          J:=1;
          WHILE TRUE DO BEGIN
           K:=MeinePosition(Line,PreprocessorDefines[I].Name,J);
           IF K<=0 THEN BREAK;
           J:=K;
           DELETE(Line,K,LENGTH(PreprocessorDefines[I].Name));
           IF (LENGTH(Line)-K)>0 THEN BEGIN
            SETLENGTH(MacroParameter,0);
            IF Line[K]='(' THEN BEGIN
             S:=COPY(Line,K,LENGTH(Line)-K+1);
             SA:=S;
             IF S[1]='(' THEN BEGIN
              DELETE(S,1,1);
              S:=TRIM(S);
              WHILE TRUE DO BEGIN
               IF LENGTH(S)>0 THEN BEGIN
                Parameter:=S;
                FOR H:=1 TO LENGTH(Parameter) DO BEGIN
                 IF Parameter[H] IN [',',')'] THEN BEGIN
                  Parameter:=COPY(Parameter,1,H-1);
                  DELETE(S,1,H-1);
                  BREAK;
                 END;
                END;
                IF LENGTH(Parameter)>0 THEN BEGIN
                 SETLENGTH(MacroParameter,LENGTH(MacroParameter)+1);
                 MacroParameter[LENGTH(MacroParameter)-1]:=Parameter;
                END;
                S:=TRIM(S);
                IF LENGTH(S)>0 THEN BEGIN
                 IF S[1]=')' THEN BEGIN
                  DELETE(S,1,1);
                  S:=TRIM(S);
                  BREAK;
                 END ELSE IF S[1]=',' THEN BEGIN
                  DELETE(S,1,1);
                  S:=TRIM(S);
                 END ELSE BEGIN
                  SetError(cePreprocessorError);
                  BREAK;
                 END;
                END;
               END ELSE BEGIN
                SetError(cePreprocessorError);
                BREAK;
               END;
              END;
             END;
             IF LENGTH(MacroParameter)=LENGTH(PreprocessorDefines[I].Parameter) THEN BEGIN
              Schleife:=TRUE;
              FOR H:=0 TO LENGTH(PreprocessorDefines[I].Parameter)-1 DO BEGIN
               MacroLine:=StringErsetzen(MacroLine,PreprocessorDefines[I].Parameter[H],MacroParameter[H]);
              END;
              DELETE(Line,K,LENGTH(SA)-LENGTH(S));
              INSERT(MacroLine,Line,K);
             END ELSE BEGIN
              SetError(cePreprocessorError);
              BREAK;
             END;
            END ELSE BEGIN
             SetError(cePreprocessorError);
             BREAK;
            END;
           END ELSE BEGIN
            SetError(cePreprocessorError);
            BREAK;
           END;
          END;
         END ELSE BEGIN
          IF MeinePosition(Line,PreprocessorDefines[I].Name,0)>0 THEN BEGIN
           Line:=StringErsetzen(Line,PreprocessorDefines[I].Name,PreprocessorDefines[I].Lines);
           Schleife:=TRUE;
          END;
         END;
        END;
       END;
      END;
      AddLine(Line,LineNumber,FileIndex);
     END;
    END;
   END;
   SETLENGTH(MacroParameter,0);
  END;
 BEGIN
  FileIndex:=LENGTH(LinesInfo.Files);
  SETLENGTH(LinesInfo.Files,FileIndex+1);
  LinesInfo.Files[FileIndex]:=FileName;
  LineNumber:=-LineSub;
  Lines:=TBeRoMemoryStream.Create;
  Lines.Text:=InputSource;
  Lines.Seek(0);
  RunLevel(0,-1);
  Lines.Destroy;
 END;
BEGIN
 PreprocessorDefines:=NIL;
 FOR I:=0 TO LENGTH(Defines)-1 DO BEGIN
  IF NOT ExistDefine(Defines[I].Name) THEN BEGIN
   SETLENGTH(PreprocessorDefines,LENGTH(PreprocessorDefines)+1);
   PreprocessorDefines[LENGTH(PreprocessorDefines)-1]:=Defines[I];
  END;
 END;
 IF QuellStream.Size>0 THEN BEGIN
  OutLineNumber:=-LineDifference;
  OutStream:=TBeRoMemoryStream.Create;
  ProcessFile(QuellStream.Text,CodeFileName,LineDifference);
  QuellStream.Assign(OutStream);
  QuellStream.Seek(0);
  OutStream.Destroy;
 END;
 FOR I:=0 TO LENGTH(PreprocessorDefines)-1 DO BEGIN
  PreprocessorDefines[I].Name:='';
  PreprocessorDefines[I].Lines:='';
  FOR J:=0 TO LENGTH(PreprocessorDefines[I].Parameter)-1 DO PreprocessorDefines[I].Parameter[J]:='';
  SETLENGTH(PreprocessorDefines[I].Parameter,0);
 END;
 SETLENGTH(PreprocessorDefines,0);
 SETLENGTH(LinesInfo.PreparsedLines,0);
END;

procedure TBeRoScript.Print(s: string);
begin
  FPrint(self, S);
end;

PROCEDURE TBeRoScript.AddString(CONST S:STRING);
BEGIN
 IF LENGTH(S)>0 THEN QuellStream.Write(S[1],LENGTH(S));
END;

PROCEDURE TBeRoScript.AddNativePointers;
BEGIN
 // RTL Routinen definieren
 AddNativeProc('RTL_OUTPUTBLOCK',@RTL_OUTPUTBLOCK);
 AddNativeProc('RTL_PRINTF_STRING',@RTL_PRINTF_STRING);
 AddNativeProc('RTL_PRINTF_NUMBER_SIGNED',@RTL_PRINTF_NUMBER_SIGNED);
 AddNativeProc('RTL_PRINTF_NUMBER_UNSIGNED',@RTL_PRINTF_NUMBER_UNSIGNED);
 AddNativeProc('RTL_PRINTF_PCHAR',@RTL_PRINTF_PCHAR);
 AddNativeProc('RTL_PRINTF_CHAR',@RTL_PRINTF_CHAR);
// AddNativeProc('RTL_PRINTF_FLOAT',@RTL_PRINTF_FLOAT);
 AddNativeProc('RTL_STRING_NEW',@RTL_STRING_NEW);
 AddNativeProc('RTL_STRING_INCREASE',@RTL_STRING_INCREASE);
 AddNativeProc('RTL_STRING_DECREASE',@RTL_STRING_DECREASE);
 AddNativeProc('RTL_STRING_ASSIGN',@RTL_STRING_ASSIGN);
 AddNativeProc('RTL_STRING_LENGTH',@RTL_STRING_LENGTH);
 AddNativeProc('RTL_STRING_SETLENGTH',@RTL_STRING_SETLENGTH);
 AddNativeProc('RTL_STRING_UNIQUE',@RTL_STRING_UNIQUE);
 AddNativeProc('RTL_STRING_CHARCONVERT',@RTL_STRING_CHARCONVERT);
 AddNativeProc('RTL_STRING_GET',@RTL_STRING_GET);
 AddNativeProc('RTL_STRING_CONCAT',@RTL_STRING_CONCAT);
 AddNativeProc('RTL_STRING_SELF_CONCAT',@RTL_STRING_SELF_CONCAT);
 AddNativeProc('RTL_STRING_COMPARE',@RTL_STRING_COMPARE);
 AddNativeProc('round',@RTL_ROUND);
 AddNativeProc('trunc',@RTL_TRUNC);
 AddNativeProc('sin',@RTL_SIN);
 AddNativeProc('cos',@RTL_COS);
 AddNativeProc('abs',@RTL_ABS);
 AddNativeProc('frac',@RTL_FRAC);
 AddNativeProc('exp',@RTL_EXP);
 AddNativeProc('ln',@RTL_LN);
 AddNativeProc('sqr',@RTL_SQR);
 AddNativeProc('sqrt',@RTL_SQRT);
 AddNativeProc('random',@RTL_RANDOM);
 AddNativeProc('rand',@RTL_RANDOM);
 AddNativeProc('pi',@RTL_PI);
 AddNativeProc('readfloat',@RTL_READFLOAT);
 AddNativeProc('readint',@RTL_READINT);
 AddNativeProc('readuint',@RTL_READUINT);
 AddNativeProc('readstring',@RTL_READSTRING);
 AddNativeProc('readchar',@RTL_READCHAR);
 AddNativeProc('readln',@RTL_READSTRING);
 AddNativeProc('flushin',@RTL_FLUSHIN);
 AddNativeProc('flush',@RTL_FLUSH);
 AddNativeProc('flushout',@RTL_FLUSHOUT);
 AddNativeProc('trim',@RTL_TRIM);
 AddNativeProc('copy',@RTL_COPY);
 AddNativeProc('length',@RTL_LENGTH);
 AddNativeProc('charat',@RTL_CHARAT);
 AddNativeProc('charpointerat',@RTL_CHARPOINTERAT);
 AddNativeProc('delete',@RTL_DELETE);
 AddNativeProc('insert',@RTL_INSERT);
 AddNativeProc('setstring',@RTL_SETSTRING);
 AddNativeProc('lowercase',@RTL_LOWERCASE);
 AddNativeProc('uppercase',@RTL_UPPERCASE);
 AddNativeProc('locase',@RTL_LOCASE);
 AddNativeProc('upcase',@RTL_UPCASE);
 AddNativeProc('pos',@RTL_POS);
 AddNativeProc('posex',@RTL_POSEX);
 AddNativeProc('inttostr',@RTL_INTTOSTR);
 AddNativeProc('getmem',@RTL_GETMEM);
 AddNativeProc('freemem',@RTL_FREEMEM);
 AddNativeProc('malloc',@RTL_MALLOC);
 AddNativeProc('free',@RTL_FREE);
 AddNativeProc('fileopen',@RTL_FILEOPEN);
 AddNativeProc('filecreate',@RTL_FILECREATE);
 AddNativeProc('fileclose',@RTL_FILECLOSE);
 AddNativeProc('fileseek',@RTL_FILESEEK);
 AddNativeProc('fileposition',@RTL_FILEPOSITION);
 AddNativeProc('filesize',@RTL_FILESIZE);
 AddNativeProc('fileeof',@RTL_FILEEOF);
 AddNativeProc('fileread',@RTL_FILEREAD);
 AddNativeProc('filewrite',@RTL_FILEWRITE);
 AddNativeProc('filereadline',@RTL_FILEREADLINE);
 AddNativeProc('filewriteline',@RTL_FILEWRITELINE);
 AddNativeProc('gettickcount',@RTL_GETTICKCOUNT);
 AddNativeProc('exec',@RTL_EXEC);
 AddNativeProc('inttobase',@RTL_INTTOBASE);
 AddNativeProc('inttohex',@RTL_INTTOHEX);
 AddNativeProc('uinttobase',@RTL_UINTTOBASE);
 AddNativeProc('uinttohex',@RTL_UINTTOHEX);
 IF ASSIGNED(fOnOwnNativesPointers) THEN fOnOwnNativesPointers(SELF);
END;

PROCEDURE TBeRoScript.AddNativeDefinitions;
BEGIN
 AddString('native int round(float number);');
 AddString('native int trunc(float number);');
 AddString('native float sin(float number);');
 AddString('native float cos(float number);');
 AddString('native float abs(float number);');
 AddString('native float frac(float number);');
 AddString('native float exp(float number);');
 AddString('native float ln(float number);');
 AddString('native float sqr(float number);');
 AddString('native float sqrt(float number);');
 AddString('native float random();');
 AddString('native float rand();');
 AddString('native float pi();');
 AddString('native float readfloat();');
 AddString('native int readint();');
 AddString('native unsigned int readuint();');
 AddString('native string readstring();');
 AddString('native unsigned char readchar();');
 AddString('native string readln();');
 AddString('native void flushin();');
 AddString('native void flush();');
 AddString('native void flushout();');
 AddString('native string trim(string src);');
 AddString('native string copy(string src,int index,int count);');
 AddString('native int length(string src);');
 AddString('native unsigned char charat(string src,int index);');
 AddString('native unsigned int charpointerat(string src,int index);');
 AddString('native string delete(string src,int index,int count);');
 AddString('native string insert(string src,string dst,int index);');
 AddString('native string setstring(char *src,int srclength);');
 AddString('native string lowercase(string src);');
 AddString('native string uppercase(string src);');
 AddString('native unsigned char locase(unsigned int src);');
 AddString('native unsigned char upcase(unsigned int src);');
 AddString('native int pos(string substr,string str,int first);');
 AddString('native int posex(string substr,string str,int first);');
 AddString('native string inttostr(int number,int digits);');
 AddString('native unsigned int getmem(int size);');
 AddString('native void freemem(void *datapointer);');
 AddString('native unsigned int malloc(int size);');
 AddString('native void free(void *datapointer);');
 AddString('native unsigned int fileopen(string filename);');
 AddString('native unsigned int filecreate(string filename);');
 AddString('native void fileclose(void *filepointer);');
 AddString('native int fileseek(void *filepointer,int position);');
 AddString('native int fileposition(void *filepointer);');
 AddString('native int filesize(void *filepointer);');
 AddString('native int fileeof(void *filepointer);');
 AddString('native int fileread(void *filepointer,char *buffer,int counter);');
 AddString('native int filewrite(void *filepointer,char *buffer,int counter);');
 AddString('native string filereadline(void *filepointer);');
 AddString('native void filewriteline(void *filepointer,string str);');
 AddString('native unsigned int gettickcount();');
 AddString('native int exec(string filename,string parameter);');
 AddString('native string inttobase(int value,int base);');
 AddString('native string inttohex(int value);');
 AddString('native string uinttobase(unsigned int value,unsigned int base);');
 AddString('native string uinttohex(unsigned int value);');
 IF ASSIGNED(fOnOwnNativesDefinitions) THEN fOnOwnNativesDefinitions(SELF);
END;

FUNCTION TBeRoScript.LoadCode:BOOLEAN;
VAR Stream,OldStream:TBeRoStream;
    SD,DD:POINTER;
    SDS,DDS:LONGWORD;
    CheckSumme,Build,CodeGroesse,CountNatives:LONGWORD;
    I,J:INTEGER;
    Name,AsmVarName:STRING;
    P:POINTER;
    Gefunden,Fehler,Compressed:BOOLEAN;
    Sign:TBeRoScriptSign;
 FUNCTION LeseByte:BYTE;
 BEGIN
  Stream.Read(RESULT,SIZEOF(BYTE));
 END;
 FUNCTION LeseBoolean:BOOLEAN;
 BEGIN
  RESULT:=LeseByte<>0;
 END;
 FUNCTION LeseDWord:LONGWORD;
 BEGIN
  Stream.Read(RESULT,SIZEOF(LONGWORD));
 END;
 FUNCTION LeseDWordSigned:LONGINT;
 BEGIN
  Stream.Read(RESULT,SIZEOF(LONGINT));
 END;
 FUNCTION LeseString:STRING;
 VAR L:LONGWORD;
 BEGIN
  L:=LeseDWord;
  IF L>0 THEN BEGIN
   SETLENGTH(RESULT,L);
   Stream.Read(RESULT[1],L);
  END ELSE BEGIN
   RESULT:='';
  END;
 END;
 FUNCTION LeseSignatur:TBeRoScriptSign;
 BEGIN
  Stream.Read(RESULT,SIZEOF(TBeRoScriptSign));
 END;
BEGIN
 RESULT:=FALSE;
 IF (LENGTH(CacheDir)>0) AND (LENGTH(CodeName)>0) THEN BEGIN
  IF FILEEXISTS(CacheDir+CodeName) THEN BEGIN
   OldStream:=NIL;
   Stream:=TBeRoFileStream.Create(CacheDir+CodeName);
   Sign:=LeseSignatur;
   IF Sign=MyCacheSign THEN BEGIN
    Build:=LeseDWord;
    IF Build=BeRoScriptBuild THEN BEGIN
     CheckSumme:=LeseDWord;
     IF CheckSumme=SourceChecksumme THEN BEGIN
      Fehler:=FALSE;
      Compressed:=LeseBoolean;
      IF Compressed THEN BEGIN
       SDS:=LeseDWord;
       OldStream:=Stream;
       Stream:=TBeRoMemoryStream.Create;
       GETMEM(SD,SDS);
       OldStream.Read(SD^,SDS);
       DD:=NIL;
       DDS:=ProcessDecompress(SD,DD,SDS);
       Stream.Write(DD^,DDS);
       Stream.Seek(0);
       FREEMEM(DD);
       FREEMEM(SD);
      END;
      CodeGroesse:=LeseDWord;
      BSSGroesse:=LeseDWord;
      SETLENGTH(ProcTabelle,LeseDWord);
      SETLENGTH(VariableTabelle,LeseDWord);
      SETLENGTH(LabelFixUpTabelle,LeseDWord);
      SETLENGTH(UseFixUpTabelle,LeseDWord);
      CountNatives:=LeseDWord;
      IF LENGTH(NativeTabelle)<>LONGINT(CountNatives) THEN Fehler:=TRUE;
      SETLENGTH(ImportTabelle,LeseDWord);
      SETLENGTH(Blocks,LeseDWord);
      BeginBlock:=LeseDWordSigned;
      EndBlock:=LeseDWordSigned;
      CodeStream.Clear;
      CodeStream.AppendFrom(Stream,CodeGroesse);
      IF BSSGroesse>0 THEN BEGIN
       GETMEM(P,BSSGroesse);
       FILLCHAR(P^,BSSGroesse,0);
       CodeStream.Seek(CodeStream.Size);
       CodeStream.Write(P^,BSSGroesse);
       FREEMEM(P);
      END;
      FOR I:=0 TO LENGTH(ProcTabelle)-1 DO BEGIN
       ProcTabelle[I].Name:=LeseString;
       ProcTabelle[I].Offset:=LeseDWord;
      END;
      FOR I:=0 TO LENGTH(VariableTabelle)-1 DO BEGIN
       VariableTabelle[I].Name:=LeseString;
       VariableTabelle[I].Offset:=LeseDWord;
      END;
      FOR I:=0 TO LENGTH(LabelFixUpTabelle)-1 DO BEGIN
       LabelFixUpTabelle[I].Name:=LeseString;
       LabelFixUpTabelle[I].Offset:=LeseDWordSigned;
      END;
      FOR I:=0 TO LENGTH(UseFixUpTabelle)-1 DO BEGIN
       UseFixUpTabelle[I].Typ:=LeseByte;
       UseFixUpTabelle[I].Name:=LeseString;
       UseFixUpTabelle[I].Offset:=LeseDWordSigned;
       UseFixUpTabelle[I].AddOffset:=LeseDWordSigned;
      END;
      FOR I:=0 TO CountNatives-1 DO BEGIN
       Name:=LeseString;
       AsmVarName:=LeseString;
       Gefunden:=FALSE;
       FOR J:=0 TO LENGTH(NativeTabelle)-1 DO BEGIN
        IF NativeTabelle[J].Name=Name THEN BEGIN
         NativeTabelle[J].AsmVarName:=AsmVarName;
         Gefunden:=TRUE;
         BREAK;
        END;
       END;
       IF NOT Gefunden THEN BEGIN
        Fehler:=TRUE;
        BREAK;
       END;
      END;
      FOR I:=0 TO LENGTH(ImportTabelle)-1 DO BEGIN
       ImportTabelle[I].Name:=LeseString;
       ImportTabelle[I].AsmVarName:=LeseString;
       ImportTabelle[I].LibraryName:=LeseString;
       ImportTabelle[I].LibraryFunction:=LeseString;
      END;
      FOR I:=0 TO LENGTH(Blocks)-1 DO BEGIN
       Blocks[I]:=LeseString;
      END;
      IF Compressed THEN BEGIN
       Stream.Free;
       Stream:=OldStream;
      END;
      IF Fehler THEN BEGIN
       SETLENGTH(ProcTabelle,0);
       SETLENGTH(VariableTabelle,0);
       SETLENGTH(LabelFixUpTabelle,0);
       SETLENGTH(UseFixUpTabelle,0);
       SETLENGTH(ImportTabelle,0);
       SETLENGTH(Blocks,0);
      END;
      RESULT:=NOT Fehler;
     END;
    END;
   END;
   Stream.Free;
  END;
 END;
END;

PROCEDURE TBeRoScript.SaveCode;
VAR Stream,OldStream:TBeRoStream;
    SD,DD:POINTER;
    SDS,DDS:LONGWORD;
    I:INTEGER;
 PROCEDURE SchreibeByte(Wert:BYTE);
 BEGIN
  Stream.Write(Wert,SIZEOF(BYTE));
 END;
 PROCEDURE SchreibeBoolean(Wert:BOOLEAN);
 BEGIN
  IF Wert THEN BEGIN
   SchreibeByte(1);
  END ELSE BEGIN
   SchreibeByte(0);
  END;
 END;
 PROCEDURE SchreibeDWord(Wert:LONGWORD);
 BEGIN
  Stream.Write(Wert,SIZEOF(LONGWORD));
 END;
 PROCEDURE SchreibeDWordSigned(Wert:LONGINT);
 BEGIN
  Stream.Write(Wert,SIZEOF(LONGINT));
 END;
 PROCEDURE SchreibeString(S:STRING);
 BEGIN
  SchreibeDWord(LENGTH(S));
  IF LENGTH(S)>0 THEN Stream.Write(S[1],LENGTH(S));
 END;
 PROCEDURE SchreibeSignatur(Wert:TBeRoScriptSign);
 BEGIN
  Stream.Write(Wert,SIZEOF(TBeRoScriptSign));
 END;
BEGIN
 IF (LENGTH(CacheDir)>0) AND (LENGTH(CodeName)>0) THEN BEGIN
  OldStream:=NIL;
  Stream:=TBeRoFileStream.CreateNew(CacheDir+CodeName);
  SchreibeSignatur(MyCacheSign);
  SchreibeDWord(BeRoScriptBuild);
  SchreibeDWord(SourceChecksumme);
  SchreibeBoolean(CacheCompression);
  IF CacheCompression THEN BEGIN
   OldStream:=Stream;
   Stream:=TBeRoMemoryStream.Create;
  END;
  SchreibeDWord(CodeStream.Size-LONGINT(BSSGroesse));
  SchreibeDWord(BSSGroesse);
  SchreibeDWord(LENGTH(ProcTabelle));
  SchreibeDWord(LENGTH(VariableTabelle));
  SchreibeDWord(LENGTH(LabelFixUpTabelle));
  SchreibeDWord(LENGTH(UseFixUpTabelle));
  SchreibeDWord(LENGTH(NativeTabelle));
  SchreibeDWord(LENGTH(ImportTabelle));
  SchreibeDWord(LENGTH(Blocks));
  SchreibeDWordSigned(BeginBlock);
  SchreibeDWordSigned(EndBlock);
  CodeStream.Seek(0);
  Stream.AppendFrom(CodeStream,CodeStream.Size-LONGINT(BSSGroesse));
  FOR I:=0 TO LENGTH(ProcTabelle)-1 DO BEGIN
   SchreibeString(ProcTabelle[I].Name);
   SchreibeDWord(ProcTabelle[I].Offset);
  END;
  FOR I:=0 TO LENGTH(VariableTabelle)-1 DO BEGIN
   SchreibeString(VariableTabelle[I].Name);
   SchreibeDWord(VariableTabelle[I].Offset);
  END;
  FOR I:=0 TO LENGTH(LabelFixUpTabelle)-1 DO BEGIN
   SchreibeString(LabelFixUpTabelle[I].Name);
   SchreibeDWordSigned(LabelFixUpTabelle[I].Offset);
  END;
  FOR I:=0 TO LENGTH(UseFixUpTabelle)-1 DO BEGIN
   SchreibeByte(UseFixUpTabelle[I].Typ);
   SchreibeString(UseFixUpTabelle[I].Name);
   SchreibeDWordSigned(UseFixUpTabelle[I].Offset);
   SchreibeDWordSigned(UseFixUpTabelle[I].AddOffset);
  END;
  FOR I:=0 TO LENGTH(NativeTabelle)-1 DO BEGIN
   SchreibeString(NativeTabelle[I].Name);
   SchreibeString(NativeTabelle[I].AsmVarName);
  END;
  FOR I:=0 TO LENGTH(ImportTabelle)-1 DO BEGIN
   SchreibeString(ImportTabelle[I].Name);
   SchreibeString(ImportTabelle[I].AsmVarName);
   SchreibeString(ImportTabelle[I].LibraryName);
   SchreibeString(ImportTabelle[I].LibraryFunction);
  END;
  FOR I:=0 TO LENGTH(Blocks)-1 DO BEGIN
   SchreibeString(Blocks[I]);
  END;
  IF CacheCompression THEN BEGIN
   SDS:=Stream.Size;
   GETMEM(SD,SDS);
   Stream.Seek(0);
   Stream.Read(SD^,SDS);
   DD:=NIL;
   DDS:=ProcessCompress(SD,DD,SDS);
   Stream.Clear;
   SchreibeDWord(DDS);
   Stream.Write(DD^,DDS);
   OldStream.Append(Stream);
   FREEMEM(DD);
   FREEMEM(SD);
   Stream.Free;
   Stream:=OldStream;
  END;
  Stream.Free;
 END;
END;

PROCEDURE TBeRoScript.CopyCode;
BEGIN
 CodeLength:=CodeStream.Size;
 CodePointer:=VirtualAlloc(NIL,CodeLength,MEM_COMMIT,PAGE_EXECUTE_READWRITE);
 CodeFixen(LONGWORD(CodePointer));
 CodeStream.Seek(0);
 CodeStream.Read(CodePointer^,CodeStream.Size);
END;

FUNCTION TBeRoScript.Compile(Source:STRING;Name:STRING=''):BOOLEAN;
VAR CompileNew:BOOLEAN;
    Quelltext,OwnPreCode:STRING;
    Counter:INTEGER;
BEGIN
 // Alten Code freigeben
 IF CodePointer<>NIL THEN BEGIN
  VirtualFree(CodePointer,0,MEM_RELEASE);
  CodePointer:=NIL;
 END;

 // Name merken
 CodeFileName:=ExtractFileName(Name);
 IF LENGTH(Name)>0 THEN BEGIN
  CodeName:=ChangeFileExt(CodeFileName,'.bsc');
 END ELSE BEGIN
  CodeName:='';
 END;

 // Alte Fehler löschen
 Errors:='';

 // Quelltext vorbereiten
 LineDifference:=0;
 Quelltext:='';
 IF ASSIGNED(fOnOwnPreCode) THEN BEGIN
  OwnPreCode:=fOnOwnPreCode(SELF);
  Quelltext:=Quelltext+OwnPreCode;
  // Zeilen zusammmenzählen
  FOR Counter:=1 TO LENGTH(OwnPreCode) DO BEGIN
   IF OwnPreCode[Counter]=#10 THEN BEGIN
    INC(LineDifference);
   END;
  END;
 END;
 Quelltext:=Quelltext+Source;

 // RTL Routinen definieren
 AddNativePointers;

 // Standard Definitionen definieren
 AddDefine('BeRoScript');
 AddDefine('BeRoWebScript');
 AddDefine('BS');
 AddDefine('BWS');

 // Quelltext in den Quell Buffer kopieren
 QuellStream.Clear;
 AddNativeDefinitions;
 AddString(#13#10);
 INC(LineDifference);
 AddString(Quelltext);

 // Preprocessor ausführen
 Preprocessor;

 // Checksumme berechnen
 SourceChecksumme:=CRC32(QuellStream);

 CompileNew:=TRUE;
 IF NOT Debug THEN BEGIN
  IF LoadCode THEN BEGIN
   CompileNew:=FALSE;
   CopyCode;
  END;
 END;
 IF CompileNew THEN BEGIN
  // Compiler resetten
  CompilerCreate;
  Init;

  // Quelltext kompilieren
  IF LENGTH(Errors)=0 THEN BEGIN
   DoCompile;
  END;

  INC(LineDifference);

  IF LENGTH(Errors)=0 THEN BEGIN
   // Code sichern
   SaveCode;

   // Code kopieren
   CopyCode;
  END ELSE BEGIN
   CodePointer:=NIL;
   CodeLength:=0;
   BSSGroesse:=0;
  END;
 END;

 // Code Zeiger zum einem Procedure Zeiger umwandeln
 CodeProc:=CodePointer;

 // Code Grösse merken

 // Fehlerstatus zurückgeben
 RESULT:=LENGTH(Errors)=0;
 IsCompiled:=NOT RESULT;
 Output:='';
END;

FUNCTION TBeRoScript.CompileFile(SourceFile:STRING):BOOLEAN;
BEGIN
 RESULT:=Compile(ReadFileAsString(SourceFile),SourceFile);
END;

PROCEDURE TBeRoScript.RunProc(S:STRING);
VAR P:PROCEDURE(); PASCAL;
BEGIN
 IF ASSIGNED(CodeProc) AND NOT Fehler THEN BEGIN
  P:=GetProcPointer(S);
  IF ASSIGNED(P) THEN P();
 END;
END;

PROCEDURE TBeRoScript.RunStart;
BEGIN
 RunProc('$start');
END;

PROCEDURE TBeRoScript.RunMain;
BEGIN
 RunProc('$main');
END;

PROCEDURE TBeRoScript.RunEnd;
BEGIN
 RunProc('$end');
END;

PROCEDURE TBeRoScript.Run;
BEGIN
 Output:='';
 RunStart;
 RunMain;
 RunEnd;
END;

FUNCTION TBeRoScript.GetProcPointer(Name:STRING):POINTER;
VAR I:INTEGER;
BEGIN
 RESULT:=NIL;
 FOR I:=0 TO LENGTH(ProcTabelle)-1 DO BEGIN
  IF TRIM(ProcTabelle[I].Name)=TRIM(Name) THEN BEGIN
   RESULT:=POINTER(ProcTabelle[I].Offset);
   EXIT;
  END;
 END;
END;

FUNCTION TBeRoScript.GetVariablePointer(Name:STRING):POINTER;
VAR I:INTEGER;
BEGIN
 RESULT:=NIL;
 FOR I:=0 TO LENGTH(VariableTabelle)-1 DO BEGIN
  IF TRIM(VariableTabelle[I].Name)=TRIM(Name) THEN BEGIN
   RESULT:=POINTER(VariableTabelle[I].Offset);
   EXIT;
  END;
 END;
END;

PROCEDURE TBeRoScript.OutputBlock(BlockNummer:INTEGER);
BEGIN
 IF (BlockNummer>=0) AND (BlockNummer<LENGTH(Blocks)) THEN BEGIN
  IF OutDirect THEN BEGIN
   WRITE(Blocks[BlockNummer]);
  END ELSE BEGIN
   Output:=Output+Blocks[BlockNummer];
  END;
 END;
END;

FUNCTION TBeRoScript.ParseWebScript(FileName:STRING):STRING;
VAR Source:STRING;
    OutLineNumber:INTEGER;
    Files:ARRAY OF STRING;
    FirstBlock:BOOLEAN;
 PROCEDURE ClearFiles;
 VAR Counter:INTEGER;
 BEGIN
  FOR Counter:=0 TO LENGTH(Files)-1 DO Files[Counter]:='';
  SETLENGTH(Files,0);
 END;
 PROCEDURE AddFile(FileName:STRING);
 VAR MyFile:INTEGER;
 BEGIN
  MyFile:=LENGTH(Files);
  SETLENGTH(Files,MyFile+1);
  Files[MyFile]:=FileName;
 END;
 FUNCTION CheckFile(FileName:STRING):BOOLEAN;
 VAR Counter:INTEGER;
 BEGIN
  RESULT:=FALSE;
  FOR Counter:=0 TO LENGTH(Files)-1 DO BEGIN
   IF Files[Counter]=FileName THEN BEGIN
    RESULT:=TRUE;
    BREAK;
   END;
  END;
 END;
 FUNCTION AddBlock(DataBlock:STRING):INTEGER;
 BEGIN
  RESULT:=LENGTH(Blocks);
  SETLENGTH(Blocks,RESULT+1);
  Blocks[RESULT]:=DataBlock;
 END;            
 FUNCTION ParseFile(FileName:STRING):STRING;
 VAR Stream:TBeRoFileStream;
     C,LC,CM:CHAR;
     DataBlock:STRING;
     MyBlock:INTEGER;
     OldPos:INTEGER;
     Signature:STRING;
     TheFile:STRING;
     FileIndex:INTEGER;
     LineNumber:INTEGER;
  FUNCTION ReadString(LengthToRead:INTEGER):STRING;
  VAR Counter:INTEGER;
  BEGIN
   RESULT:='';
   FOR Counter:=1 TO LengthToRead DO RESULT:=RESULT+CHR(Stream.ReadByte);
  END;
  PROCEDURE AddLine;
  BEGIN
   INC(OutLineNumber);
   IF OutLineNumber>0 THEN BEGIN
    SETLENGTH(LinesInfo.PreparsedLines,OutLineNumber);
    LinesInfo.PreparsedLines[OutLineNumber-1].LineNumber:=LineNumber;
    LinesInfo.PreparsedLines[OutLineNumber-1].FileIndex:=FileIndex;
   END;
   INC(LineNumber);
  END;
 BEGIN
  FileIndex:=LENGTH(LinesInfo.Files);
  SETLENGTH(LinesInfo.Files,FileIndex+1);
  LinesInfo.Files[FileIndex]:=FileName;
  LineNumber:=1;
  Stream:=TBeRoFileStream.Create(FileName);
  DataBlock:='';
  LC:=#0;
  C:=#0;
  WHILE Stream.Position<Stream.Size DO BEGIN
   C:=CHR(Stream.ReadByte);
   IF C='<' THEN BEGIN
    C:=CHR(Stream.ReadByte);
    IF C='?' THEN BEGIN
     OldPos:=Stream.Position;
     Signature:=ReadString(3);
     IF Signature<>'bws' THEN Stream.Seek(OldPos);
     IF LENGTH(DataBlock)>0 THEN BEGIN
      IF FirstBlock THEN BEGIN
       BeginBlock:=AddBlock(DataBlock);
       FirstBlock:=FALSE;
      END ELSE BEGIN
       Source:=Source+'outputblock('+INTTOSTR(AddBlock(DataBlock))+');';
      END;
      DataBlock:='';
     END;
     C:=CHR(Stream.ReadByte);
     IF C='=' THEN BEGIN
      Source:=Source+'print(';
      WHILE Stream.Position<Stream.Size DO BEGIN
       C:=CHR(Stream.ReadByte);
       IF C='?' THEN BEGIN
        C:=CHR(Stream.ReadByte);
        IF C='>' THEN BEGIN
         BREAK;
        END ELSE BEGIN
         Source:=Source+C;
        END;
       END ELSE BEGIN
        Source:=Source+C;
       END;
      END;
      Source:=Source+');';
     END ELSE BEGIN
      LC:=#10;
      CM:=#0;
      WHILE Stream.Position<Stream.Size DO BEGIN
       IF CM=#0 THEN BEGIN
        IF C='?' THEN BEGIN
         OldPos:=Stream.Position;
         C:=CHR(Stream.ReadByte);
         IF C='>' THEN BEGIN
          BREAK;
         END ELSE BEGIN
          Stream.Seek(OldPos);
          Source:=Source+'?';
         END;
        END ELSE IF C='b' THEN BEGIN
         OldPos:=Stream.Position;
         Signature:=ReadString(4);
         IF Signature='ws?>' THEN BEGIN
          BREAK;
         END ELSE BEGIN
          Stream.Seek(OldPos);
          Source:=Source+'b';
         END;
        END ELSE IF (LC=#10) AND (C='#') THEN BEGIN
         OldPos:=Stream.Position;
         Signature:=ReadString(11);
         IF Signature='includeonce' THEN BEGIN
          C:=#0;
          TheFile:='';
          WHILE (Stream.Position<Stream.Size) AND NOT (C=#10) DO BEGIN
           TheFile:=TheFile+C;
           C:=CHR(Stream.ReadByte);
          END;
          TheFile:=TRIM(TheFile);
          IF LENGTH(TheFile)>0 THEN BEGIN
           IF TheFile[1]='<' THEN BEGIN
            DELETE(TheFile,1,1);
            IF LENGTH(TheFile)>0 THEN BEGIN
             IF TheFile[LENGTH(TheFile)]='>' THEN BEGIN
              DELETE(TheFile,LENGTH(TheFile),1);
             END;
            END;
           END;
          END;
          IF LENGTH(TheFile)>0 THEN BEGIN
           IF TheFile[1]='"' THEN BEGIN
            DELETE(TheFile,1,1);
            IF LENGTH(TheFile)>0 THEN BEGIN
             IF TheFile[LENGTH(TheFile)]='"' THEN BEGIN
              DELETE(TheFile,LENGTH(TheFile),1);
             END;
            END;
           END;
          END;
          IF NOT CheckFile(TheFile) THEN BEGIN
           AddFile(TheFile);
           DataBlock:=DataBlock+ParseFile(TheFile);
           IF LENGTH(DataBlock)>0 THEN BEGIN
            MyBlock:=LENGTH(Blocks);
            SETLENGTH(Blocks,MyBlock+1);
            Blocks[MyBlock]:=DataBlock;
            Source:=Source+'outputblock('+INTTOSTR(MyBlock)+');';
            DataBlock:='';
           END;
          END;
          Source:=Source+#10;
          AddLine;
         END ELSE BEGIN
          Stream.Seek(OldPos);
          Signature:=ReadString(7);
          IF Signature='include' THEN BEGIN
           C:=#0;
           TheFile:='';
           WHILE (Stream.Position<Stream.Size) AND NOT (C=#10) DO BEGIN
            TheFile:=TheFile+C;
            C:=CHR(Stream.ReadByte);
           END;
           TheFile:=TRIM(TheFile);
           IF LENGTH(TheFile)>0 THEN BEGIN
            IF TheFile[1]='<' THEN BEGIN
             DELETE(TheFile,1,1);
             IF LENGTH(TheFile)>0 THEN BEGIN
              IF TheFile[LENGTH(TheFile)]='>' THEN BEGIN
               DELETE(TheFile,LENGTH(TheFile),1);
              END;
             END;
            END;
           END;
           IF LENGTH(TheFile)>0 THEN BEGIN
            IF TheFile[1]='"' THEN BEGIN
             DELETE(TheFile,1,1);
             IF LENGTH(TheFile)>0 THEN BEGIN
              IF TheFile[LENGTH(TheFile)]='"' THEN BEGIN
               DELETE(TheFile,LENGTH(TheFile),1);
              END;
             END;
            END;
           END;
           DataBlock:=DataBlock+ParseFile(TheFile);
           IF LENGTH(DataBlock)>0 THEN BEGIN
            MyBlock:=LENGTH(Blocks);
            SETLENGTH(Blocks,MyBlock+1);
            Blocks[MyBlock]:=DataBlock;
            Source:=Source+'outputblock('+INTTOSTR(MyBlock)+');';
            DataBlock:='';
           END;
           Source:=Source+#10;
           AddLine;
          END ELSE BEGIN
           Stream.Seek(OldPos);
           Source:=Source+'#';
          END;
         END;
        END ELSE IF C='/' THEN BEGIN
         OldPos:=Stream.Position;
         C:=CHR(Stream.ReadByte);
         IF C='*' THEN BEGIN
          Source:=Source+'/*';
          LC:=#0;
          C:=#0;
          WHILE (Stream.Position<Stream.Size) AND NOT ((LC='*') AND (C='/')) DO BEGIN
           LC:=C;
           C:=CHR(Stream.ReadByte);
           Source:=Source+C;
           IF C=#10 THEN AddLine;
          END;
         END ELSE IF C='/' THEN BEGIN
          Source:=Source+'//';
          WHILE (Stream.Position<Stream.Size) AND NOT (C=#10) DO BEGIN
           C:=CHR(Stream.ReadByte);
           Source:=Source+C;
          END;
          AddLine;
         END ELSE BEGIN
          Stream.Seek(OldPos);
          Source:=Source+'/';
         END;
        END ELSE IF (C='''') AND (CM IN [#0,'''']) THEN BEGIN
         Source:=Source+C;
         IF CM=#0 THEN BEGIN
          CM:=C;
         END ELSE IF CM='''' THEN BEGIN
          CM:=#0;
         END;
        END ELSE IF (C='"') AND (CM IN [#0,'"']) THEN BEGIN
         Source:=Source+C;
         IF CM=#0 THEN BEGIN
          CM:=C;
         END ELSE IF CM='"' THEN BEGIN
          CM:=#0;
         END;
        END ELSE BEGIN
         Source:=Source+C;
         IF C=#10 THEN AddLine;
        END;
        LC:=C;
       END ELSE IF (C='''') AND (CM IN [#0,'''']) THEN BEGIN
        Source:=Source+C;
        IF CM=#0 THEN BEGIN
         CM:=C;
        END ELSE IF CM='''' THEN BEGIN
         CM:=#0;
        END;
       END ELSE IF (C='"') AND (CM IN [#0,'"']) THEN BEGIN
        Source:=Source+C;
        IF CM=#0 THEN BEGIN
         CM:=C;
        END ELSE IF CM='"' THEN BEGIN
         CM:=#0;
        END;
       END ELSE BEGIN
        Source:=Source+C;
        IF C=#10 THEN AddLine;
        LC:=#0;
       END;
       C:=CHR(Stream.ReadByte);
      END;
     END;
    END ELSE BEGIN
     IF C IN [#13,#10] THEN Source:=Source+C;
     IF C=#10 THEN AddLine;
     DataBlock:=DataBlock+'<'+C;
    END;
   END ELSE BEGIN
    IF C IN [#13,#10] THEN Source:=Source+C;
    IF C=#10 THEN AddLine;
    DataBlock:=DataBlock+C;
   END;
  END;
  IF C<>#10 THEN Source:=Source+#10;
  AddLine;
  Stream.Free;
  RESULT:=DataBlock;
 END;
VAR DataBlock:STRING;
BEGIN
 Files:=NIL;
 ClearBlocks;
 OutLineNumber:=0; 
 Source:='';
 FirstBlock:=TRUE;
 DataBlock:=ParseFile(FileName);
 IF LENGTH(DataBlock)>0 THEN BEGIN
  EndBlock:=AddBlock(DataBlock);
 END;
 ClearFiles;
 RESULT:=Source;
END;

FUNCTION TBeRoScript.RunWebScript(FileName:STRING):BOOLEAN;
VAR S:STRING;
BEGIN
 Clear;
 S:=ParseWebScript(FileName);
 IF Compile(S,FileName) THEN BEGIN
  Output:='';
  OutputBlock(BeginBlock);
  RunStart;
  RunEnd;
  OutputBlock(EndBlock);
  RESULT:=TRUE;
 END ELSE BEGIN
  RESULT:=FALSE;
 END;
END;

FUNCTION TBeRoScript.RunArchive(Stream:TBeRoStream;Name:STRING=''):BOOLEAN;
VAR ScriptStream:TBeRoMemoryStream;
    FileStream:TBeRoFileStream;
    AFile:TBeRoArchiveFileParam;
    Dir,OldDir:STRING;
    Files:ARRAY OF STRING;
    I:INTEGER;
    Fehler,OK,BWS:BOOLEAN;
BEGIN
 RESULT:=FALSE;
 Clear;
 ScriptStream:=TBeRoMemoryStream.Create;
 Archive:=TBeRoArchive.Create;
 IF Archive.IsArchive(Stream) AND NOT Archive.IsCrypted(Stream) THEN BEGIN
  Archive.OpenArchive(Stream);
  Fehler:=FALSE;
  OK:=FALSE;
  BWS:=FALSE;
  IF Archive.Extract('main.bs',ScriptStream) THEN OK:=TRUE;
  IF Archive.Extract('main.bws',ScriptStream) THEN BEGIN
   BWS:=TRUE;
   OK:=TRUE;
  END;
  IF OK THEN BEGIN     
   Dir:=GetTemp;
   Dir:=ExtractFilePath(Dir)+'BeRoScript%'+ExtractFileName(Dir);
   Dir:=ChangeFileExt(Dir,'')+'_tmp';
   {$I-}MKDIR(Dir);{$I+}IOResult;
   Dir:=Dir+'\';
   OldDir:=GetCurrentDir;
   Files:=NIL;
   Archive.InitSearch;
   WHILE NOT Archive.EndOfArchive DO BEGIN
    AFile:=Archive.FindNext;
    SETLENGTH(Files,LENGTH(Files)+1);
    Files[LENGTH(Files)-1]:=AFile.FileName;
    IF POS('\',AFile.FileName)>0 THEN BEGIN
     {$I-}MKDIR(Dir+ExtractFilePath(AFile.FileName));{$I+}IOResult;
    END;
   END;
   IF LENGTH(Files)>0 THEN BEGIN
    FOR I:=0 TO LENGTH(Files)-1 DO BEGIN
     FileStream:=TBeRoFileStream.CreateNew(Dir+Files[I]);
     IF NOT Archive.Extract(Files[I],FileStream) THEN BEGIN
      Fehler:=TRUE;
     END;
     FileStream.Free;
     Files[I]:='';
    END;
    {$I-}CHDIR(Dir);{$I+}IOResult;
   END;
   IF NOT Fehler THEN BEGIN
    IF BWS THEN BEGIN
     RESULT:=RunWebScript(Dir+'main.bws');
    END ELSE BEGIN
     IF Compile(ScriptStream.Text,Name) THEN BEGIN
      Run;
      RESULT:=TRUE;
     END;
    END;
   END;
   {$I-}CHDIR(OldDir);{$I+}IOResult;
   LoescheDateien(Dir,'*.*',TRUE);
   {$I-}RMDIR(Dir);{$I+}IOResult;
   SETLENGTH(Files,0);
  END;
  Archive.CloseArchive;
 END;
 Archive.Free;
 ScriptStream.Free;
END;

FUNCTION TBeRoScript.RunArchiveFile(FileName:STRING):BOOLEAN;
VAR FileStream:TBeRoFileStream;
BEGIN
 FileStream:=TBeRoFileStream.Create(FileName);
 RESULT:=RunArchive(FileStream,FileName);
 FileStream.Free;
END;

INITIALIZATION
 RandomSeed:=GetTickCount;
 RandomFactor:=$08088405;
 RandomIncrement:=1;
 ErzeugeTabelle;
END.
