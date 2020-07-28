{******************************************************************************}
{                                                                              }
{           ZLibFramework.Decompress                                           }
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
unit ZLibFramework.Decompress;

interface

uses
  System.Classes, System.SysUtils,
  ZLibFramework.Types, ZLibFramework.Interfaces;

type

  {$REGION 'TZLibAlgorithmDecompressionCustom'}

  TZLibAlgorithmDecompressionCustom = class(TInterfacedObject, IZLibAlgorithmDecompression)
  strict private
    { private declarations }
  protected
    { protected declarations }
    [weak]
    FParent: IZLibOperation;
    FDeflate: IZLibMethodsDecompression;
    FGzip: IZLibMethodsDecompression;
  public
    { public declarations }
    constructor Create(const pParent: IZLibOperation); virtual;
    function Deflate: IZLibMethodsDecompression;
    function GZip: IZLibMethodsDecompression;
    function &End: IZLibOperation;
  end;

  {$ENDREGION}

  {$REGION 'TZLibAlgorithmDecompressionBase64'}

  TZLibAlgorithmDecompressionBase64 = class(TZLibAlgorithmDecompressionCustom)
  strict private
    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create(const pParent: IZLibOperation); override;
  end;

  {$ENDREGION}

  {$REGION 'TZLibAlgorithmDecompressionData'}

  TZLibAlgorithmDecompressionData = class(TZLibAlgorithmDecompressionCustom)
  strict private
    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create(const pParent: IZLibOperation); override;
  end;

  {$ENDREGION}


  {$REGION 'TZLibMethodsDecompressionCustom'}

  TZLibMethodsDecompressionCustom = class(TInterfacedObject)
  strict private
    { private declarations }
  protected
    { protected declarations }
    [weak]
    FParent: IZLibAlgorithmDecompression;
    FZLibOperationType: TZLibOperationType;
    FZLibModeType: TZLibModeType;
    FZLibAlgorithmType: TZLibAlgorithmType;

    function Decode(const pInput: string): TBytes; virtual; abstract;
    function DecompressionFromText(const pValue: string;
                                   out pMD5Result: string): TBytes; overload;
    function DecompressionFromFile(const pValue: TFileName;
                                   out pMD5Result: string): TBytes; overload;
    function DecompressionFromStream(pValue: TStream;
                                     out pMD5Result: string): TBytes; overload;
  public
    { public declarations }
    constructor Create(const pParent: IZLibAlgorithmDecompression); virtual;
  end;

  {$ENDREGION}

  {$REGION 'TZLibMethodsDecompression'}

  TZLibMethodsDecompression = class(TZLibMethodsDecompressionCustom, IZLibMethodsDecompression)
  strict private
    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }
    function Text(const pInput: string; out pResult: IZLibResult): IZLibAlgorithmDecompression;
    function SaveToFile(const pInput: string; const pFileName: TFileName; out pResult: IZLibResult): IZLibAlgorithmDecompression;
    function LoadFromFile(const pInput: TFileName; out pResult: IZLibResult): IZLibAlgorithmDecompression;
    function LoadFromStream(pInput: TStream; out pResult: IZLibResult): IZLibAlgorithmDecompression; overload;
  end;

  {$ENDREGION}


  {$REGION 'TZLibMethodsDecompressionBase64'}

  TZLibMethodsDecompressionBase64 = class(TZLibMethodsDecompression)
  strict private
    { private declarations }
    function DecodeBase64(const pInput: string): TBytes;
  protected
    { protected declarations }
    function Decode(const pInput: string): TBytes; override;
  public
    { public declarations }
    constructor Create(const pParent: IZLibAlgorithmDecompression); override;
  end;

  {$ENDREGION}

  {$REGION 'TZLibMethodsDecompressionBase64Deflate'}

  TZLibMethodsDecompressionBase64Deflate = class(TZLibMethodsDecompressionBase64)
  strict private
    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create(const pParent: IZLibAlgorithmDecompression); override;
  end;

  {$ENDREGION}

  {$REGION 'TZLibMethodsDecompressionBase64GZip'}

  TZLibMethodsDecompressionBase64GZip = class(TZLibMethodsDecompressionBase64)
  strict private
    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create(const pParent: IZLibAlgorithmDecompression); override;
  end;

  {$ENDREGION}


  {$REGION 'TZLibMethodsDecompressionData'}

  TZLibMethodsDecompressionData = class(TZLibMethodsDecompression)
  strict private
    { private declarations }
    function DecodeString(const pInput: string): TBytes;
  protected
    { protected declarations }
    function Decode(const pInput: string): TBytes; override;
  public
    { public declarations }
    constructor Create(const pParent: IZLibAlgorithmDecompression); override;
  end;

  {$ENDREGION}

  {$REGION 'TZLibMethodsDecompressionDataDeflate'}

  TZLibMethodsDecompressionDataDeflate = class(TZLibMethodsDecompressionData)
  strict private
    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create(const pParent: IZLibAlgorithmDecompression); override;
  end;

  {$ENDREGION}

  {$REGION 'TZLibMethodsDecompressionDataGZip'}

  TZLibMethodsDecompressionDataGZip = class(TZLibMethodsDecompressionData)
  strict private
    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create(const pParent: IZLibAlgorithmDecompression); override;
  end;

  {$ENDREGION}

implementation

uses
  System.NetEncoding, System.Hash, System.ZLib, ZLibFramework.Core;

{$REGION 'TZLibAlgorithmDecompressionCustom'}

constructor TZLibAlgorithmDecompressionCustom.Create(const pParent: IZLibOperation);
begin
  FParent := pParent;
end;

function TZLibAlgorithmDecompressionCustom.&End: IZLibOperation;
begin
  Result := FParent;
end;

function TZLibAlgorithmDecompressionCustom.Deflate: IZLibMethodsDecompression;
begin
  Result := FDeflate;
end;

function TZLibAlgorithmDecompressionCustom.GZip: IZLibMethodsDecompression;
begin
  Result := FGZip;
end;

{$ENDREGION}

{$REGION 'TZLibAlgorithmDecompressionBase64'}

constructor TZLibAlgorithmDecompressionBase64.Create(
  const pParent: IZLibOperation);
begin
  inherited Create(pParent);
  FDeflate := TZLibMethodsDecompressionBase64Deflate.Create(Self);
  FGzip := TZLibMethodsDecompressionBase64GZip.Create(Self);
end;

{$ENDREGION}

{$REGION 'TZLibAlgorithmDecompressionData'}

constructor TZLibAlgorithmDecompressionData.Create(const pParent: IZLibOperation);
begin
  inherited Create(pParent);
  FDeflate := TZLibMethodsDecompressionDataDeflate.Create(Self);
  FGzip := TZLibMethodsDecompressionDataGZip.Create(Self);
end;

{$ENDREGION}


{$REGION 'TZLibMethodsDecompressionCustom'}

constructor TZLibMethodsDecompressionCustom.Create(
  const pParent: IZLibAlgorithmDecompression);
begin
  FParent := pParent;
  FZLibOperationType := TZLibOperationType.Decompress;
end;

function TZLibMethodsDecompressionCustom.DecompressionFromText(
  const pValue: string; out pMD5Result: string): TBytes;
var
  lResultDecode: TBytes;
  lHint: string;
begin
  SetLength(Result, 0);

  //DECODE
  try
    lResultDecode := Decode(pValue);
  except
    on E: Exception do
      raise EZLibException.Create(FZLibModeType,
                                  FZLibOperationType,
                                  FZLibAlgorithmType,
                                  E.Message,
                                  'Verificar se o valor passado no parâmetro está codificado para ser decoficado.',
                                  True);

  end;

  //DECOMPRESSION
  try
    Result := ZLibDecompress(lResultDecode, FZLibAlgorithmType);
  except
    on E: Exception do
    begin
      lHint := 'Erro geral.';
      if (E is EZDecompressionError) then
        lHint := Format(sEZDecompressionErrorHint, [FZLibAlgorithmType.AsString]);
      raise EZLibException.Create(FZLibModeType,
                                  FZLibOperationType,
                                  FZLibAlgorithmType,
                                  E.Message,
                                  lHint);
    end;
  end;

  //MD5 RESULT
  pMD5Result := MD5Bytes(Result);
end;

function TZLibMethodsDecompressionCustom.DecompressionFromFile(
  const pValue: TFileName; out pMD5Result: string): TBytes;
var
  lFile: TFileStream;
  lHint: string;
begin
  SetLength(Result, 0);

  //LOAD FILE
  lFile := TFileStream.Create(pValue, fmOpenRead or fmShareDenyWrite);

  try

    //DECOMPRESSION
    try
      Result := ZLibDecompress(lFile, FZLibAlgorithmType);
    except
      on E: Exception do
      begin
        lHint := 'Erro geral.';
        if (E is EZDecompressionError) then
          lHint := Format(sEZDecompressionErrorHint, [FZLibAlgorithmType.AsString]);
        raise EZLibException.Create(FZLibModeType,
                                    FZLibOperationType,
                                    FZLibAlgorithmType,
                                    E.Message,
                                    lHint);
      end;
    end;

  finally
    lFile.Free;
  end;

  //MD5 RESULT
  pMD5Result := MD5Bytes(Result);
end;

function TZLibMethodsDecompressionCustom.DecompressionFromStream(
  pValue: TStream; out pMD5Result: string): TBytes;
var
  lHint: string;
begin
  SetLength(Result, 0);

  //DECOMPRESSION
  try
    Result := ZLibDecompress(pValue, FZLibAlgorithmType);
  except
    on E: Exception do
    begin
      lHint := 'Erro geral.';
      if (E is EZDecompressionError) then
        lHint := Format(sEZDecompressionErrorHint, [FZLibAlgorithmType.AsString]);
      raise EZLibException.Create(FZLibModeType,
                                  FZLibOperationType,
                                  FZLibAlgorithmType,
                                  E.Message,
                                  lHint);
    end;
  end;

  //MD5 RESULT
  pMD5Result := MD5Bytes(Result);
end;

{$ENDREGION}

{$REGION 'TZLibMethodsDecompression'}

function TZLibMethodsDecompression.Text(const pInput: string;
  out pResult: IZLibResult): IZLibAlgorithmDecompression;
var
  lResultDecompression: TBytes;
  lMD5Input: string;
  lMD5Result: string;
begin
  Result := FParent;

  //DECOMPRESSION
  lResultDecompression := DecompressionFromText(pInput, lMD5Result);

  //MD5: INPUT
  lMD5Input := THashMD5.GetHashString(pInput);

  //RESULT
  pResult := TZLibResult.Create(FZLibOperationType,
                                FZLibModeType,
                                FZLibAlgorithmType,
                                lResultDecompression,
                                lMD5Input,
                                lMD5Result);
end;

function TZLibMethodsDecompression.SaveToFile(const pInput: string;
  const pFileName: TFileName;
  out pResult: IZLibResult): IZLibAlgorithmDecompression;
var
  lFile: TBytesStream;
  lResultDecompression: TBytes;
  lMD5Input: string;
  lMD5Result: string;
begin
  Result := FParent;

  //DECOMPRESSION
  lResultDecompression := DecompressionFromText(pInput, lMD5Result);

  //MD5: INPUT
  lMD5Input := THashMD5.GetHashString(pInput);

  //SAVE RESULT TO FILE
  lFile := TBytesStream.Create(lResultDecompression);
  try
    lFile.SaveToFile(pFileName);
  finally
    lFile.Free;
  end;

  //RESULT
  pResult := TZLibResult.Create(FZLibOperationType,
                                FZLibModeType,
                                FZLibAlgorithmType,
                                lResultDecompression,
                                lMD5Input,
                                lMD5Result);
end;

function TZLibMethodsDecompression.LoadFromFile(const pInput: TFileName;
  out pResult: IZLibResult): IZLibAlgorithmDecompression;
var
  lResultDecompression: TBytes;
  lMD5Input: string;
  lMD5Result: string;
begin
  Result := FParent;

  //DECOMPRESSION
  lResultDecompression := DecompressionFromFile(pInput, lMD5Result);

  //MD5: INPUT
  lMD5Input := THashMD5.GetHashStringFromFile(pInput);

  //RESULT
  pResult := TZLibResult.Create(FZLibOperationType,
                                FZLibModeType,
                                FZLibAlgorithmType,
                                lResultDecompression,
                                lMD5Input,
                                lMD5Result);

end;

function TZLibMethodsDecompression.LoadFromStream(pInput: TStream;
  out pResult: IZLibResult): IZLibAlgorithmDecompression;
var
  lResultDecompression: TBytes;
  lMD5Input: string;
  lMD5Result: string;
begin
  Result := FParent;

  //DECOMPRESSION
  lResultDecompression := DecompressionFromStream(pInput, lMD5Result);

  //MD5: INPUT
  lMD5Input := THashMD5.GetHashString(pInput);

  //RESULT
  pResult := TZLibResult.Create(FZLibOperationType,
                                FZLibModeType,
                                FZLibAlgorithmType,
                                lResultDecompression,
                                lMD5Input,
                                lMD5Result);
end;

{$ENDREGION}


{$REGION 'TZLibMethodsDecompressionBase64'}

constructor TZLibMethodsDecompressionBase64.Create(
  const pParent: IZLibAlgorithmDecompression);
begin
  inherited Create(pParent);
  FZLibModeType := TZLibModeType.Base64;
end;

//System.NetEncoding.TBase64Encoding
//Input Strings for Decode and DecodeStringToBytes should be UTF8 encoded.
function TZLibMethodsDecompressionBase64.DecodeBase64(
  const pInput: string): TBytes;
begin
  SetLength(Result, 0);
  Result := TBase64Encoding.Base64.DecodeStringToBytes(pInput);
end;

function TZLibMethodsDecompressionBase64.Decode(
  const pInput: string): TBytes;
begin
  SetLength(Result, 0);
  Result := DecodeBase64(pInput)
end;

{$ENDREGION}

{$REGION 'TZLibMethodsDecompressionBase64Deflate'}

constructor TZLibMethodsDecompressionBase64Deflate.Create(
  const pParent: IZLibAlgorithmDecompression);
begin
  inherited Create(pParent);
  FZLibAlgorithmType := TZLibAlgorithmType.Deflate;
end;

{$ENDREGION}

{$REGION 'TZLibMethodsDecompressionBase64GZip'}

constructor TZLibMethodsDecompressionBase64GZip.Create(
  const pParent: IZLibAlgorithmDecompression);
begin
  inherited Create(pParent);
  FZLibAlgorithmType := TZLibAlgorithmType.GZip;
end;

{$ENDREGION}


{$REGION 'TZLibMethodsDecompressionData'}

constructor TZLibMethodsDecompressionData.Create(
  const pParent: IZLibAlgorithmDecompression);
begin
  inherited Create(FParent);
  FZLibModeType := TZLibModeType.Data;
end;

function TZLibMethodsDecompressionData.Decode(
  const pInput: string): TBytes;
begin
  SetLength(Result, 0);
  Result := DecodeString(pInput);
end;

function TZLibMethodsDecompressionData.DecodeString(
  const pInput: string): TBytes;
var
  lResultEncoding: TBytes;
  lInput: TBytesStream;
begin
  SetLength(Result, 0);

  lResultEncoding := TEncoding.Default.GetBytes(pInput);

  lInput := TBytesStream.Create(lResultEncoding);
  try
    lInput.Seek(0, TSeekOrigin.soBeginning);
    Result := Copy(lInput.Bytes, 0, lInput.Size);
  finally
    lInput.Free;
  end;
end;

{$ENDREGION}

{$REGION 'TZLibMethodsDecompressionDataDeflate'}

constructor TZLibMethodsDecompressionDataDeflate.Create(
  const pParent: IZLibAlgorithmDecompression);
begin
  inherited Create(pParent);
  FZLibAlgorithmType := TZLibAlgorithmType.Deflate;
end;

{$ENDREGION}

{$REGION 'TZLibMethodsDecompressionDataGZip'}

constructor TZLibMethodsDecompressionDataGZip.Create(
  const pParent: IZLibAlgorithmDecompression);
begin
  inherited Create(pParent);
  FZLibAlgorithmType := TZLibAlgorithmType.GZip;
end;

{$ENDREGION}

end.
