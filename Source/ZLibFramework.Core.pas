{******************************************************************************}
{                                                                              }
{           ZLibFramework.Core                                                 }
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
unit ZLibFramework.Core;

interface

uses
  System.ZLib, System.Classes, System.SysUtils, ZLibFramework.Types;

function ZLibCompress(pInput: TStream;
  const pCompressionLevel: TZLibCompressionLevelType;
  const pAlgorithm: TZLibAlgorithmType): TBytes; overload;

function ZLibCompress(pInput: TBytes;
  const pCompressionLevel: TZLibCompressionLevelType;
  const pAlgorithm: TZLibAlgorithmType): TBytes; overload;

function ZLibDecompress(pInput: TStream;
  const pAlgorithm: TZLibAlgorithmType): TBytes; overload;

function ZLibDecompress(pInput: TBytes;
  const pAlgorithm: TZLibAlgorithmType): TBytes; overload;

function MD5Bytes(const pInput: TBytes): string;

implementation

uses
  System.Hash;

function MD5Bytes(const pInput: TBytes): string;
var
  lHashMD5: THashMD5;
begin
  lHashMD5 := THashMD5.Create;
  lHashMD5.Reset;
  lHashMD5.Update(pInput);

  Result := lHashMD5.HashAsString;
end;

function ZLibCompress(pInput: TStream;
  const pCompressionLevel: TZLibCompressionLevelType;
  const pAlgorithm: TZLibAlgorithmType): TBytes;
var
  lZCompressionStream: TZCompressionStream;
  lResultCompression: TBytesStream;
begin
  SetLength(Result, 0);

  lResultCompression := TBytesStream.Create;
  try
    lZCompressionStream := TZCompressionStream.Create(lResultCompression,
                                                      pCompressionLevel.ZCompressionLevel,
                                                      pAlgorithm.WindowBits);
    try
      pInput.Position := 0;
      lZCompressionStream.CopyFrom(pInput, pInput.Size);
    finally
      //COMPRESSION >> lRESULTCOMPRESS
      lZCompressionStream.Free;
    end;

    //SET RESULT
    lResultCompression.Position := 0;
    Result := Copy(lResultCompression.Bytes, 0, lResultCompression.Size);
  finally
    lResultCompression.Free;
  end;
end;

function ZLibCompress(pInput: TBytes;
  const pCompressionLevel: TZLibCompressionLevelType;
  const pAlgorithm: TZLibAlgorithmType): TBytes; overload;
var
  lInput: TBytesStream;
begin
  SetLength(Result, 0);

  lInput := TBytesStream.Create(pInput);
  try
    Result := ZLibCompress(lInput, pCompressionLevel, pAlgorithm);
  finally
    lInput.Free;
  end;
end;

function ZLibDecompress(pInput: TStream; const pAlgorithm: TZLibAlgorithmType): TBytes;
var
  lZDecompressionStream: TZDecompressionStream;
  lDecompressed: TBytesStream;
begin
  SetLength(Result, 0);

  lDecompressed := TBytesStream.Create;
  try
    pInput.Position := 0;
    lZDecompressionStream := TZDecompressionStream.Create(pInput,
                                                          pAlgorithm.WindowBits);
    try
      //DECOMPRESS >> lDECOMPRESSED
      lDecompressed.LoadFromStream(lZDecompressionStream);

      //SET RESULT
      lDecompressed.Position := 0;
      Result := Copy(lDecompressed.Bytes, 0, lDecompressed.Size);
    finally
      lZDecompressionStream.Free;
    end;

  finally
    lDecompressed.Free;
  end;
end;

function ZLibDecompress(pInput: TBytes; const pAlgorithm: TZLibAlgorithmType): TBytes;
var
  lInput: TBytesStream;
begin
  SetLength(Result, 0);

  lInput := TBytesStream.Create(pInput);
  try
    Result := ZLibDecompress(lInput, pAlgorithm);
  finally
    lInput.Free;
  end;
end;

end.
