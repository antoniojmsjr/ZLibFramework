{******************************************************************************}
{                                                                              }
{           ZLibFramework.Compression                                          }
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
unit ZLibFramework.Compression;

interface

uses
  System.Classes, System.SysUtils, ZLibFramework.Types, ZLibFramework.Interfaces;

type

  {$REGION 'TZLibAlgorithmCompressionCustom'}

  TZLibAlgorithmCompressionCustom = class(TInterfacedObject, IZLibAlgorithmCompression)
  strict private
    { private declarations }
    [weak]
    FParent: IZLibOperation;
  protected
    { protected declarations }
    FDeflate: IZLibMethodsCompression;
    FGzip: IZLibMethodsCompression;
  public
    { public declarations }
    constructor Create(const pParent: IZLibOperation); virtual;
    function Deflate: IZLibMethodsCompression;
    function GZip: IZLibMethodsCompression;
    function &End: IZLibOperation;
  end;

  {$ENDREGION}

  {$REGION 'TZLibAlgorithmCompressionBase64'}

  TZLibAlgorithmCompressionBase64 = class(TZLibAlgorithmCompressionCustom)
  strict private
    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create(const pParent: IZLibOperation); override;
  end;

  {$ENDREGION}

  {$REGION 'TZLibAlgorithmCompressionData'}

  TZLibAlgorithmCompressionData = class(TZLibAlgorithmCompressionCustom)
  strict private
    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create(const pParent: IZLibOperation); override;
  end;

  {$ENDREGION}


  {$REGION 'TZLibMethodsCompressionCustom'}

  TZLibMethodsCompressionCustom = class(TInterfacedObject)
  strict private
    { private declarations }
  protected
    { protected declarations }
    [weak]
    FParent: IZLibAlgorithmCompression;
    FZLibModeType: TZLibModeType;
    FZLibOperationType: TZLibOperationType;
    FZLibAlgorithmType: TZLibAlgorithmType;

    function Encode(const pInput: TBytes): TBytes; virtual; abstract;
    function CompressionFromText(const pValue: string;
                                 const pCompressionLevel: TZLibCompressionLevelType;
                                 const pEncoding: TEncoding;
                                 out pMD5Text: string): TBytes;
    function CompressionFromFile(const pValue: TFileName;
                                 const pCompressionLevel: TZLibCompressionLevelType;
                                 out pMD5File: string): TBytes;
    function CompressionFromStream(pValue: TStream;
                                   const pCompressionLevel: TZLibCompressionLevelType;
                                   out pMD5Stream: string): TBytes;
  public
    { public declarations }
    constructor Create(const pParent: IZLibAlgorithmCompression); virtual;
  end;

  {$ENDREGION}

  {$REGION 'TZLibMethodsCompression'}

  TZLibMethodsCompression = class(TZLibMethodsCompressionCustom, IZLibMethodsCompression)
  strict private
    { private declarations }
    FCompressionLevel: TZLibCompressionLevelType;
  protected
    { protected declarations }
  public
    { public declarations }
    function Level(const pCompressionLevel: TZLibCompressionLevelType): IZLibMethodsCompression;
    function Text(const pInput: string; out pResult: IZLibResult): IZLibAlgorithmCompression; overload;
    function Text(const pInput: string; const pEncoding: TEncoding; out pResult: IZLibResult): IZLibAlgorithmCompression; overload;
    function SaveToFile(const pInput: string; const pFileName: TFileName; out pResult: IZLibResult): IZLibAlgorithmCompression;
    function LoadFromFile(const pInput: TFileName; out pResult: IZLibResult): IZLibAlgorithmCompression;
    function LoadFromStream(pInput: TStream; out pResult: IZLibResult): IZLibAlgorithmCompression;
    constructor Create(const pParent: IZLibAlgorithmCompression); override;
  end;

  {$ENDREGION}


  {$REGION 'TZLibMethodsCompressionBase64'}

  TZLibMethodsCompressionBase64 = class(TZLibMethodsCompression)
  strict private
    { private declarations }
    function EncodeBase64(const pInput: TBytes): TBytes;
  protected
    { protected declarations }
    function Encode(const pInput: TBytes): TBytes; override;
  public
    { public declarations }
    constructor Create(const pParent: IZLibAlgorithmCompression); override;
  end;

  {$ENDREGION}

  {$REGION 'TZLibMethodsCompressionBase64Deflate'}
  
  TZLibMethodsCompressionBase64Deflate = class(TZLibMethodsCompressionBase64)
  strict private
    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create(const pParent: IZLibAlgorithmCompression); override;
  end;
  
  {$ENDREGION}

  {$REGION 'TZLibMethodsCompressionBase64GZip'}

  TZLibMethodsCompressionBase64GZip = class(TZLibMethodsCompressionBase64)
  strict private
    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create(const pParent: IZLibAlgorithmCompression); override;
  end;

  {$ENDREGION}


  {$REGION 'TZLibMethodsCompressionData'}

  TZLibMethodsCompressionData = class(TZLibMethodsCompression)
  strict private
    { private declarations }
  protected
    { protected declarations }
    function Encode(const pInput: TBytes): TBytes; override;
  public
    { public declarations }
    constructor Create(const pParent: IZLibAlgorithmCompression); override;
  end;

  {$ENDREGION}

  {$REGION 'TZLibMethodsCompressionDataDeflate'}

  TZLibMethodsCompressionDataDeflate = class(TZLibMethodsCompressionData)
  strict private
    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create(const pParent: IZLibAlgorithmCompression); override;
  end;

  {$ENDREGION}

  {$REGION 'TZLibMethodsCompressionDataGZip'}

  TZLibMethodsCompressionDataGZip = class(TZLibMethodsCompressionData)
  strict private
    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create(const pParent: IZLibAlgorithmCompression); override;
  end;

  {$ENDREGION}


implementation

uses
  System.NetEncoding, System.Hash, System.ZLib, ZLibFramework.Core;

{$REGION 'TZLibAlgorithmCompressionCustom'}

constructor TZLibAlgorithmCompressionCustom.Create(
  const pParent: IZLibOperation);
begin
  FParent := pParent;
end;

function TZLibAlgorithmCompressionCustom.&End: IZLibOperation;
begin
  Result := FParent;
end;

function TZLibAlgorithmCompressionCustom.Deflate: IZLibMethodsCompression;
begin
  Result := FDeflate;
end;

function TZLibAlgorithmCompressionCustom.GZip: IZLibMethodsCompression;
begin
  Result := FGZip;
end;

{$ENDREGION}

{$REGION 'TZLibAlgorithmCompressionBase64'}

constructor TZLibAlgorithmCompressionBase64.Create(
  const pParent: IZLibOperation);
begin
  inherited Create(pParent);
  FDeflate := TZLibMethodsCompressionBase64Deflate.Create(Self);
  FGzip := TZLibMethodsCompressionBase64GZip.Create(Self);
end;

{$ENDREGION}

{$REGION 'TZLibAlgorithmCompressionData'}

constructor TZLibAlgorithmCompressionData.Create(
  const pParent: IZLibOperation);
begin
  inherited Create(pParent);
  FDeflate := TZLibMethodsCompressionDataDeflate.Create(Self);
  FGzip := TZLibMethodsCompressionDataGZip.Create(Self);
end;

{$ENDREGION}


{$REGION 'TZLibMethodsCompressionCustom'}

constructor TZLibMethodsCompressionCustom.Create(
  const pParent: IZLibAlgorithmCompression);
begin
  FParent := pParent;
  FZLibOperationType := TZLibOperationType.Compress;
end;

function TZLibMethodsCompressionCustom.CompressionFromText(
  const pValue: string;
  const pCompressionLevel: TZLibCompressionLevelType;
  const pEncoding: TEncoding;
  out pMD5Text: string): TBytes;
var
  lText: TBytes;
  lEncodingText: TEncoding;
  lResultCompression: TBytes;
  lHint: string;
begin
  pMD5Text := EmptyStr;

  //ENCODING
  if not Assigned(pEncoding) then
    lEncodingText := TEncoding.UTF8 //DEFAULT
  else
    lEncodingText := pEncoding;

  try
    lText := lEncodingText.GetBytes(pValue);
  except
    on E: Exception do
      raise EZLibException.Create(FZLibModeType,
                                  FZLibOperationType,
                                  FZLibAlgorithmType,
                                  E.Message,
                                  'Verificar se o valor passado no parâmetro pode ser condificado.',
                                  True);

  end;

  //MD5 INPUT
  pMD5Text := MD5Bytes(lText);

  try
    //COMPRESSION
    lResultCompression := ZLibCompress(lText,
                                       pCompressionLevel,
                                       FZLibAlgorithmType);

  except
    on E: Exception do
    begin
      lHint := 'Erro geral.';
      if (E is EZDecompressionError) then
        lHint := 'Falha na compactação.';
      raise EZLibException.Create(FZLibModeType,
                                  FZLibOperationType,
                                  FZLibAlgorithmType,
                                  E.Message,
                                  lHint);
    end;
  end;


  //ENCODE RESULT
  try
    Result := Encode(lResultCompression);
  except
    on E: Exception do
      raise EZLibException.Create(FZLibModeType,
                                  FZLibOperationType,
                                  FZLibAlgorithmType,
                                  E.Message,
                                  'Falha na codificação!',
                                  True);

  end;
end;

function TZLibMethodsCompressionCustom.CompressionFromFile(
  const pValue: TFileName;
  const pCompressionLevel: TZLibCompressionLevelType;
  out pMD5File: string): TBytes;
var
  lFile: TBytesStream;
  lContentFile: TBytes;
  lResultCompression: TBytes;
  lHint: string;
begin

  //READ FILE
  lFile := TBytesStream.Create;
  try
    //LOAD FILE
    lFile.LoadFromFile(pValue);

    SetLength(lContentFile, lFile.Size);
    lFile.Seek(0, TSeekOrigin.soBeginning);
    lContentFile := Copy(lFile.Bytes, 0, lFile.Size);
  finally
    lFile.Free;
  end;

  //MD5 INPUT
  pMD5File := MD5Bytes(lContentFile);

  //COMPRESSION
  try
    lResultCompression := ZLibCompress(lContentFile,
                                       pCompressionLevel,
                                       FZLibAlgorithmType);
  except
    on E: Exception do
    begin
      lHint := 'Erro geral.';
      if (E is EZDecompressionError) then
        lHint := 'Falha na compactação.';
      raise EZLibException.Create(FZLibModeType,
                                  FZLibOperationType,
                                  FZLibAlgorithmType,
                                  E.Message,
                                  lHint);
    end;
  end;

  //ENCODE RESULT
  try
    Result := Encode(lResultCompression);
  except
    on E: Exception do
      raise EZLibException.Create(FZLibModeType,
                                  FZLibOperationType,
                                  FZLibAlgorithmType,
                                  E.Message,
                                  'Falha na codificação!',
                                  True);

  end;
end;

function TZLibMethodsCompressionCustom.CompressionFromStream(
  pValue: TStream;
  const pCompressionLevel: TZLibCompressionLevelType;
  out pMD5Stream: string): TBytes;
var
  lStream: TBytesStream;
  lContentStream: TBytes;
  lResultCompression: TBytes;
  lHint: string;
begin

  //READ STREAM
  lStream := TBytesStream.Create;
  try
    //LOAD STREAM
    pValue.Seek(0, TSeekOrigin.soBeginning);
    lStream.LoadFromStream(pValue);

    SetLength(lContentStream, lStream.Size);
    lStream.Seek(0, TSeekOrigin.soBeginning);
    lContentStream := Copy(lStream.Bytes, 0, lStream.Size);
  finally
    lStream.Free;
  end;

  //MD5 INPUT
  pMD5Stream := MD5Bytes(lContentStream);

  //COMPRESSION
  try
    lResultCompression := ZLibCompress(lContentStream,
                                       pCompressionLevel,
                                       FZLibAlgorithmType);
  except
    on E: Exception do
    begin
      lHint := 'Erro geral.';
      if (E is EZDecompressionError) then
        lHint := 'Falha na compactação.';
      raise EZLibException.Create(FZLibModeType,
                                  FZLibOperationType,
                                  FZLibAlgorithmType,
                                  E.Message,
                                  lHint);
    end;
  end;

  //ENCODE RESULT
  try
    Result := Encode(lResultCompression);
  except
    on E: Exception do
      raise EZLibException.Create(FZLibModeType,
                                  FZLibOperationType,
                                  FZLibAlgorithmType,
                                  E.Message,
                                  'Falha na codificação!',
                                  True);

  end;
end;

{$ENDREGION}

{$REGION 'TZLibMethodsCompression'}

constructor TZLibMethodsCompression.Create(
  const pParent: IZLibAlgorithmCompression);
begin
  inherited Create(pParent);
  FCompressionLevel := TZLibCompressionLevelType.Max;
end;

function TZLibMethodsCompression.Level(
  const pCompressionLevel: TZLibCompressionLevelType): IZLibMethodsCompression;
begin
  Result := Self;
  FCompressionLevel := pCompressionLevel;
end;

function TZLibMethodsCompression.Text(const pInput: string;
  out pResult: IZLibResult): IZLibAlgorithmCompression;
var
  lResultCompression: TBytes;
  lMD5Input: string;
  lMD5Result: string;
begin
  Result := FParent;

  //COMPRESSION
  lResultCompression := CompressionFromText(pInput,
                                            FCompressionLevel,
                                            nil,
                                            lMD5Input);

  //MD5: RESULT
  lMD5Result := MD5Bytes(lResultCompression);

  //RESULT
  pResult := TZLibResult.Create(FZLibOperationType,
                                FZLibModeType,
                                FZLibAlgorithmType,
                                lResultCompression,
                                lMD5Input,
                                lMD5Result);
end;

function TZLibMethodsCompression.Text(const pInput: string;
  const pEncoding: TEncoding;
  out pResult: IZLibResult): IZLibAlgorithmCompression;
var
  lResultCompression: TBytes;
  lMD5Input: string;
  lMD5Result: string;
begin
  Result := FParent;

  //COMPRESSION
  lResultCompression := CompressionFromText(pInput,
                                            FCompressionLevel,
                                            pEncoding,
                                            lMD5Input);

  //MD5: RESULT
  lMD5Result := MD5Bytes(lResultCompression);

  //RESULT
  pResult := TZLibResult.Create(FZLibOperationType,
                                FZLibModeType,
                                FZLibAlgorithmType,
                                lResultCompression,
                                lMD5Input,
                                lMD5Result);
end;

function TZLibMethodsCompression.LoadFromFile(const pInput: TFileName;
  out pResult: IZLibResult): IZLibAlgorithmCompression;
var
  lResultCompression: TBytes;
  lMD5Input: string;
  lMD5Result: string;
begin
  Result := FParent;

  //COMPRESSION
  lResultCompression := CompressionFromFile(pInput,
                                            FCompressionLevel,
                                            lMD5Input);

  //MD5: RESULT
  lMD5Result := MD5Bytes(lResultCompression);

  //RESULT
  pResult := TZLibResult.Create(FZLibOperationType,
                                FZLibModeType,
                                FZLibAlgorithmType,
                                lResultCompression,
                                lMD5Input,
                                lMD5Result);
end;

function TZLibMethodsCompression.LoadFromStream(pInput: TStream;
  out pResult: IZLibResult): IZLibAlgorithmCompression;
var
  lResultCompression: TBytes;
  lMD5Input: string;
  lMD5Result: string;
begin
  Result := FParent;

  //COMPRESSION
  lResultCompression := CompressionFromStream(pInput,
                                              FCompressionLevel,
                                              lMD5Input);

  //MD5: RESULT
  lMD5Result := MD5Bytes(lResultCompression);

  //RESULT
  pResult := TZLibResult.Create(FZLibOperationType,
                                FZLibModeType,
                                FZLibAlgorithmType,
                                lResultCompression,
                                lMD5Input,
                                lMD5Result);
end;

function TZLibMethodsCompression.SaveToFile(const pInput: string;
  const pFileName: TFileName;
  out pResult: IZLibResult): IZLibAlgorithmCompression;
var
  lResultCompression: TBytes;
  lFile: TBytesStream;
  lMD5Input: string;
  lMD5Result: string;
begin
  Result := FParent;

  //COMPRESSION
  lResultCompression := CompressionFromText(pInput,
                                            FCompressionLevel,
                                            nil,
                                            lMD5Input);

  //MD5: RESULT
  lMD5Result := MD5Bytes(lResultCompression);

  //SAVE RESULT TO FILE
  lFile := TBytesStream.Create(lResultCompression);
  try
    lFile.SaveToFile(pFileName);
  finally
    lFile.Free;
  end;

  //RESULT
  pResult := TZLibResult.Create(FZLibOperationType,
                                FZLibModeType,
                                FZLibAlgorithmType,
                                lResultCompression,
                                lMD5Input,
                                lMD5Result);
end;

{$ENDREGION}


{$REGION 'TZLibMethodsCompressionBase64'}

constructor TZLibMethodsCompressionBase64.Create(
  const pParent: IZLibAlgorithmCompression);
begin
  inherited Create(pParent);
  FZLibModeType := TZLibModeType.Base64;
end;

function TZLibMethodsCompressionBase64.EncodeBase64(const pInput: TBytes): TBytes;
var
  lBase64Encoding: TBase64Encoding;
begin
  lBase64Encoding := TBase64Encoding.Create(0);
  try
    Result := lBase64Encoding.Encode(pInput);
  finally
    lBase64Encoding.Free;
  end;
end;

function TZLibMethodsCompressionBase64.Encode(
  const pInput: TBytes): TBytes;
begin
  Result := EncodeBase64(pInput);
end;

{$ENDREGION}

{$REGION 'TZLibMethodsCompressionBase64Deflate'}

constructor TZLibMethodsCompressionBase64Deflate.Create(
  const pParent: IZLibAlgorithmCompression);
begin
  inherited Create(pParent);
  FZLibAlgorithmType := TZLibAlgorithmType.Deflate;
end;

{$ENDREGION}

{$REGION 'TZLibMethodsCompressionBase64GZip'}

constructor TZLibMethodsCompressionBase64GZip.Create(
  const pParent: IZLibAlgorithmCompression);
begin
  inherited Create(pParent);
  FZLibAlgorithmType := TZLibAlgorithmType.GZip;
end;

{$ENDREGION}


{$REGION 'TZLibMethodsCompressionData'}

constructor TZLibMethodsCompressionData.Create(
  const pParent: IZLibAlgorithmCompression);
begin
  inherited Create(FParent);
  FZLibModeType := TZLibModeType.Data;
end;

function TZLibMethodsCompressionData.Encode(
  const pInput: TBytes): TBytes;
begin
  Result := pInput;
end;

{$ENDREGION}

{$REGION 'TZLibMethodsCompressionDataDeflate'}

constructor TZLibMethodsCompressionDataDeflate.Create(
  const pParent: IZLibAlgorithmCompression);
begin
  inherited Create(pParent);
  FZLibAlgorithmType := TZLibAlgorithmType.Deflate;
end;

{$ENDREGION}

{$REGION 'TZLibMethodsCompressionDataGZip'}

constructor TZLibMethodsCompressionDataGZip.Create(
  const pParent: IZLibAlgorithmCompression);
begin
  inherited Create(pParent);
  FZLibAlgorithmType := TZLibAlgorithmType.GZip;
end;

{$ENDREGION}

end.
