{******************************************************************************}
{                                                                              }
{           ZLibFramework                                                      }
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
unit ZLibFramework;

interface

uses
  ZLibFramework.Interfaces, ZLibFramework.Compression, ZLibFramework.Decompress;

type

  {$REGION 'TZLib'}

  TZLib = class sealed
  strict private
    { private declarations }
    class function GetZLibBase64: IZLibOperation; static;
    class function GetZLibData: IZLibOperation; static;
  protected
    { protected declarations }
  public
    { public declarations }
    class property Base64: IZLibOperation read GetZLibBase64;
    class property Data: IZLibOperation read GetZLibData;
  end;

  {$ENDREGION}

  {$REGION 'TZLibOperationCustom'}

  TZLibOperationCustom = class(TInterfacedObject, IZLibOperation)
  strict private
    { private declarations }
  protected
    { protected declarations }
    FCompress: IZLibAlgorithmCompression;
    FDecompress: IZLibAlgorithmDecompression;
  public
    { public declarations }
    constructor Create; virtual;
    function Compress: IZLibAlgorithmCompression;
    function Decompress: IZLibAlgorithmDecompression;
  end;

  {$ENDREGION}

  {$REGION 'TZLibBase64'}

  TZLibBase64 = class(TZLibOperationCustom)
  strict private
    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create; override;
  end;

  {$ENDREGION}

  {$REGION 'TZLibData'}

  TZLibData = class(TZLibOperationCustom)
  strict private
    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create; override;
  end;

  {$ENDREGION}

implementation

uses System.SysUtils;

{$REGION 'TZLib'}

class function TZLib.GetZLibBase64: IZLibOperation;
begin
  Result := TZLibBase64.Create;
end;

class function TZLib.GetZLibData: IZLibOperation;
begin
  Result := TZLibData.Create;
end;

{$ENDREGION}

{$REGION 'TZLibOperationCustom'}

constructor TZLibOperationCustom.Create;
begin
  FCompress := nil;
  FDecompress := nil;
end;

function TZLibOperationCustom.Compress: IZLibAlgorithmCompression;
begin
  Result := FCompress;
end;

function TZLibOperationCustom.Decompress: IZLibAlgorithmDecompression;
begin
  Result := FDecompress;
end;

{$ENDREGION}

{$REGION 'TZLibBase64'}

constructor TZLibBase64.Create;
begin
  FCompress   := TZLibAlgorithmCompressionBase64.Create(Self);
  FDecompress := TZLibAlgorithmDecompressionBase64.Create(Self);
end;

{$ENDREGION}

{$REGION 'TZLibData'}

constructor TZLibData.Create;
begin
  FCompress   := TZLibAlgorithmCompressionData.Create(Self);
  FDecompress := TZLibAlgorithmDecompressionData.Create(Self);
end;

{$ENDREGION}

end.
