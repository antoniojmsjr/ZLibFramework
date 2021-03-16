{******************************************************************************}
{                                                                              }
{           ZLibFramework.Types                                                }
{                                                                              }
{           Copyright (C) Antônio José Medeiros Schneider Júnior               }
{                                                                              }
{           https://github.com/antoniojmsjr/ZLibFramework                      }
{                                                                              }
{                                                                              }
{******************************************************************************}
{                                                                              }
{  Licensed under the Apache License, Version 2.0 (the "License");             }
{  you may not use this file except in compliance with the License.            }
{  You may obtain a copy of the License at                                     }
{                                                                              }
{      http://www.apache.org/licenses/LICENSE-2.0                              }
{                                                                              }
{  Unless required by applicable law or agreed to in writing, software         }
{  distributed under the License is distributed on an "AS IS" BASIS,           }
{  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.    }
{  See the License for the specific language governing permissions and         }
{  limitations under the License.                                              }
{                                                                              }
{******************************************************************************}
unit ZLibFramework.Types;

interface

uses
  System.ZLib, System.SysUtils, System.Classes;

type
  TZLibCompressionLevelType = (None, Fastest, Default, Max);
  TZLibModeType = (Base64, Data);
  TZLibOperationType = (Compress, Decompress);
  TZLibAlgorithmType = (Deflate, GZip);

  {$REGION 'IZLibResult'}

  IZLibResult = interface
    ['{067C347C-1F21-421F-9507-8E358E23B4D3}']
    function GetMode: TZLibModeType;
    function GetOperation: TZLibOperationType;
    function GetAlgorithm: TZLibAlgorithmType;
    function GetMD5Input: string;
    function GetMD5Result: string;
    function GetText(const Value: TEncoding): string;
    function GetTextUTF8: string;
    function GetStream: TStream;

    /// <summary>
    /// Salva o resultado do processo de compressão e descompressão em arquivo.
    /// <code>
    /// var
    ///   lResult: IZLibResult;
    /// begin
    ///   Exemplo: TZLib.Base64.Compress.Deflate.Text('Texto12345', lResult);
    ///   lResult.SaveToFile('C:\Result.txt');
    /// end;
    /// </code>
    /// </summary>
    procedure SaveToFile(const FileName: TFileName);
    /// <summary>
    /// Identificação do tipo de formato utilizado no processo de compressão e descompressão.
    /// </summary>
    /// <remarks>
    /// <para>* Verificar na unit ZLibFramework.Types o tipo TZLibModeType os valores disponíveis.</para>
    /// </remarks>
    property Mode: TZLibModeType read GetMode;
    /// <summary>
    /// Identificação da operação utilizada no processo de compressão e descompressão.
    /// </summary>
    /// <remarks>
    /// <para>* Verificar na unit ZLibFramework.Types o tipo TZLibOperationType os valores disponíveis.</para>
    /// </remarks>
    property Operation: TZLibOperationType read GetOperation;
    /// <summary>
    /// Identificação do algoritmo utilizado no processo de compressão e descompressão.
    /// </summary>
    /// <remarks>
    /// <para>* Verificar na unit ZLibFramework.Types o tipo TZLibAlgorithmType os valores disponíveis.</para>
    /// </remarks>
    property Algorithm: TZLibAlgorithmType read GetAlgorithm;
    /// <summary>
    /// Texto contendo o resultado do processo de compressão e descompressão.
    /// <code>
    /// var
    ///   lResult: IZLibResult;
    /// begin
    ///   Exemplo: TZLib.Base64.Compress.Deflate.Text('Texto12345', lResult);
    ///   lblResult.Text := lResult.Text[TEncoding.UTF8];
    /// end;
    /// </code>
    /// </summary>
    /// <remarks>
    /// <para>* O conteúdo do texto pode ser codificado usando um determinado Encoding.</para>
    /// <para>* O Encoding utilizado quando não informado, é UTF8.</para>
    /// </remarks>
    property Text[const Encoding: TEncoding]: string read GetText;
    /// <summary>
    /// Texto contendo o resultado do processo de compressão e descompressão.
    /// <code>
    /// var
    ///   lResult: IZLibResult;
    /// begin
    ///   Exemplo: TZLib.Base64.Compress.Deflate.Text('Texto12345', lResult);
    ///   lblResult.Text := lResult.TextUTF8;
    /// end;
    /// </code>
    /// </summary>
    /// <remarks>
    /// <para>* Conteúdo do texto codificado usando o Encoding UTF8.</para>
    /// </remarks>
    property TextUTF8: string read GetTextUTF8;
    /// <summary>
    /// Stream contendo o resultado do processo de compressão e descompressão.
    /// </summary>
    property Stream: TStream read GetStream;
    /// <summary>
    /// MD5 do parâmetro de entrada utilizado no processo de compressão e descompressão.
    /// </summary>
    property MD5Input: string read GetMD5Input;
    /// <summary>
    /// MD5 do resultado do processo de compressão e descompressão.
    /// </summary>
    property MD5Result: string read GetMD5Result;
  end;

  {$ENDREGION}

  {$REGION 'EZLibException'}

  EZLibException = class(Exception)
  strict private
  private
    { private declarations }
    FMode: TZLibModeType;
    FOperation: TZLibOperationType;
    FAlgorithm: TZLibAlgorithmType;
    FHint: string;
    FEncodingFail: Boolean;
  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create(const pMode: TZLibModeType;
                       const pOperation: TZLibOperationType;
                       const pAlgorithm: TZLibAlgorithmType;
                       const pMessage: string;
                       const pHint: string;
                       const pEncodingFail: Boolean = false);
    function ToString: string; override;
    property Mode: TZLibModeType read FMode;
    property Operation: TZLibOperationType read FOperation;
    property Algorithm: TZLibAlgorithmType read FAlgorithm;
    property Hint: string read FHint;
    property EncodingFail: Boolean read FEncodingFail;
  end;

  {$ENDREGION}

  {$REGION 'TZLibResult}

  TZLibResult = class(TInterfacedObject, IZLibResult)
  strict private
    { private declarations }
    FOperation: TZLibOperationType;
    FMode: TZLibModeType;
    FAlgorithm: TZLibAlgorithmType;
    FStream: TBytesStream;
    FMD5Input: string;
    FMD5Result: string;
    function GetMode: TZLibModeType;
    function GetOperation: TZLibOperationType;
    function GetAlgorithm: TZLibAlgorithmType;
    function GetMD5Input: string;
    function GetMD5Result: string;
    function GetText(const pValue: TEncoding): string;
    function GetTextUTF8: string;
    function GetStream: TStream;
    procedure SaveToFile(const pFileName: TFileName);
  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create(const pOperation: TZLibOperationType;
                       const pMode: TZLibModeType;
                       const pAlgorithm: TZLibAlgorithmType;
                       const pBytes: TBytes;
                       const pMD5Input: string; const pMD5Result: string); overload;
    destructor Destroy; override;
  end;

  {$ENDREGION}

  {$REGION 'TZLibCompressionLevelTypeHelper'}

  TZLibCompressionLevelTypeHelper = record helper for TZLibCompressionLevelType
  strict private
    { private declarations }
    function GetAsString: string;
    function GetZCompressionLevel: TZCompressionLevel;
  protected
    { protected declarations }
  public
    { public declarations }
    property ZCompressionLevel: TZCompressionLevel read GetZCompressionLevel;
    property AsString: string read GetAsString;
  end;

  {$ENDREGION}

  {$REGION 'TZLibAlgorithmTypeHelper'}

  TZLibAlgorithmTypeHelper = record helper for TZLibAlgorithmType
  strict private
    { private declarations }
    function GetWindowBits: Integer;
    function GetAsString: string;
  protected
    { protected declarations }
  public
    { public declarations }
    property WindowBits: Integer read GetWindowBits;
    property AsString: string read GetAsString;
  end;

  {$ENDREGION}

  {$REGION 'TZLibOperationTypeHelper'}

  TZLibOperationTypeHelper = record helper for TZLibOperationType
  strict private
    { private declarations }
    function GetAsString: string;
  protected
    { protected declarations }
  public
    { public declarations }
    property AsString: string read GetAsString;
  end;

  {$ENDREGION}

  {$REGION 'TZLibModeTypeHelper'}

  TZLibModeTypeHelper = record helper for TZLibModeType
  strict private
    { private declarations }
    function GetAsString: string;
  protected
    { protected declarations }
  public
    { public declarations }
    property AsString: string read GetAsString;
  end;

  {$ENDREGION}

ResourceString
  sEZDecompressionErrorHint = 'Verificar se o valor passado no parâmetro para ser descompactado foi compactado utilizando o algoritimo "%s".';

implementation

{$REGION 'TZLibCompressionLevelTypeHelper'}

function TZLibCompressionLevelTypeHelper.GetAsString: string;
begin
  case Self of
    None: Result := 'None';
    Fastest: Result := 'Fastest';
    Default: Result := 'Default';
    Max: Result := 'Max';
  end;
end;

function TZLibCompressionLevelTypeHelper.GetZCompressionLevel: TZCompressionLevel;
begin
  Result := TZCompressionLevel.zcNone;
  case Self of
    Fastest: Result := TZCompressionLevel.zcFastest;
    Default: Result := TZCompressionLevel.zcDefault;
    Max: Result := TZCompressionLevel.zcMax;
  end;
end;

{$ENDREGION}

{$REGION 'TZLibModeTypeHelper'}

function TZLibModeTypeHelper.GetAsString: string;
begin
  case Self of
    Base64: Result := 'Base64';
    Data: Result := 'Data';
  end;
end;

{$ENDREGION}

{$REGION 'TZLibOperationTypeHelper'}

function TZLibOperationTypeHelper.GetAsString: string;
begin
  case Self of
    Compress: Result := 'Compress';
    Decompress: Result := 'Decompress';
  end;
end;

{$ENDREGION}

{$REGION 'TZLibAlgorithmTypeHelper'}

function TZLibAlgorithmTypeHelper.GetAsString: string;
begin
  case Self of
    Deflate:  Result := 'Deflate';
    GZip:     Result := 'GZip';
  end;
end;

function TZLibAlgorithmTypeHelper.GetWindowBits: Integer;
begin
  Result := 0;
  case Self of
    Deflate: Result := 15;
    GZip:    Result := 31;
  end;
end;

{$ENDREGION}

{$REGION 'TZLibResult'}

constructor TZLibResult.Create(const pOperation: TZLibOperationType;
  const pMode: TZLibModeType; const pAlgorithm: TZLibAlgorithmType;
  const pBytes: TBytes;
  const pMD5Input: string; const pMD5Result: string);
begin
  FMode := pMode;
  FOperation := pOperation;
  FAlgorithm := pAlgorithm;
  FMD5Input := pMD5Input;
  FMD5Result := pMD5Result;
  FStream := TBytesStream.Create(pBytes);
end;

destructor TZLibResult.Destroy;
begin
  if Assigned(FStream) then
    FStream.Free;
  inherited Destroy;
end;

function TZLibResult.GetAlgorithm: TZLibAlgorithmType;
begin
  Result := FAlgorithm;
end;

function TZLibResult.GetMD5Input: string;
begin
  Result := FMD5Input;
end;

function TZLibResult.GetMD5Result: string;
begin
  Result := FMD5Result;
end;

function TZLibResult.GetMode: TZLibModeType;
begin
  Result := FMode;
end;

function TZLibResult.GetOperation: TZLibOperationType;
begin
  Result := FOperation;
end;

function TZLibResult.GetText(const pValue: TEncoding): string;
var
  lEncoding: TEncoding;
begin
  lEncoding := nil;

  try
    if Assigned(pValue) then
      lEncoding := pValue
    else
      lEncoding := TEncoding.UTF8;

    Result := lEncoding.GetString(FStream.Bytes);
  except
    on E: Exception do
      raise EZLibException.Create(FMode,
                                  FOperation,
                                  FAlgorithm,
                                  E.Message,
                                  Format('%s[%s]', ['Verificar o Encoding.', lEncoding.ToString]),
                                  True);

  end;
end;

function TZLibResult.GetTextUTF8: string;
var
  lEncoding: TEncoding;
begin
  lEncoding := nil;

  try
    lEncoding := TEncoding.UTF8;

    Result := lEncoding.GetString(FStream.Bytes);
  except
    on E: Exception do
      raise EZLibException.Create(FMode,
                                  FOperation,
                                  FAlgorithm,
                                  E.Message,
                                  Format('%s[%s]', ['Verificar o Encoding.', lEncoding.ToString]),
                                  True);

  end;
end;

procedure TZLibResult.SaveToFile(const pFileName: TFileName);
begin
  if not Assigned(FStream) then
    Exit;

  FStream.SaveToFile(pFileName);
end;

function TZLibResult.GetStream: TStream;
begin
  Result := FStream;
end;

{$ENDREGION}

{$REGION 'EZLibException'}

constructor EZLibException.Create(const pMode: TZLibModeType;
  const pOperation: TZLibOperationType;
  const pAlgorithm: TZLibAlgorithmType;
  const pMessage: string;
  const pHint: string;
  const pEncodingFail: Boolean = false);
begin
  inherited Create(pMessage);
  FMode := pMode;
  FOperation := pOperation;
  FAlgorithm := pAlgorithm;
  FHint := pHint;
  FEncodingFail := pEncodingFail;
end;

function EZLibException.ToString: string;
begin
  Result := EmptyStr;
  Result := Concat(Result, Format('Mode: %s',           [Self.Mode.AsString]), sLineBreak);
  Result := Concat(Result, Format('Operation: %s',      [Self.Operation.AsString]), sLineBreak);
  Result := Concat(Result, Format('Algorithm: %s',      [Self.Algorithm.AsString]), sLineBreak);
  Result := Concat(Result, Format('Encoding Fail: %s',  [BoolToStr(FEncodingFail, True)]), sLineBreak);
  Result := Concat(Result, Format('Message: %s',        [inherited]), sLineBreak);
  Result := Concat(Result, Format('Hint: %s',           [Self.Hint]));
end;

{$ENDREGION}

end.
