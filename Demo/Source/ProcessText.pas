{******************************************************************************}
{                                                                              }
{           Demo.ProcessText                                                   }
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
unit ProcessText;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, ChildBase,
  FrameExecute, FrameBoxText, FMX.Objects, FMX.Effects, FMX.Layouts, FMX.Menus,
  FMX.TabControl, ZLibFramework.Types, FrameBoxSaveFile, FrameBoxOpenFile;

type
  TfrmProcessText = class(TfrmChildBase)
    rtToolBarEncode: TRectangle;
    seToolBarEncode: TShadowEffect;
    txtToolBarEncode: TText;
    rtToolBarDecode: TRectangle;
    seToolBarDecode: TShadowEffect;
    txtToolBarDecode: TText;
    frmFrameBoxTextEncodeInput: TfrmFrameBoxText;
    frmFrameExecuteEncode: TfrmFrameExecute;
    frmFrameBoxTextEncodeResult: TfrmFrameBoxText;
    frmFrameBoxTextDecodeResult: TfrmFrameBoxText;
    tbcEncodeResult: TTabControl;
    tbiEncodeResultText: TTabItem;
    tbiEncodeResultSaveToFile: TTabItem;
    frmFrameBoxSaveFileEncodeResult: TfrmFrameBoxSaveFile;
    tbcDecodeInput: TTabControl;
    tbiDecodeInputText: TTabItem;
    tbiDecodeInputOpenFile: TTabItem;
    frmFrameBoxOpenFileDecodeInput: TfrmFrameBoxOpenFile;
    frmFrameExecuteDecode: TfrmFrameExecute;
    frmFrameBoxTextDecodeInput: TfrmFrameBoxText;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FMode: TZLibModeType;
    procedure Encode(const pEncoding: TEncoding);
    procedure Decode(const pEncoding: TEncoding);
  protected
    { Private declarations }
    procedure SetMode(const Value: TZLibModeType); override;
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

uses
  ZLibFramework;

{ TForm2 }

procedure TfrmProcessText.FormCreate(Sender: TObject);
begin
  inherited;
  frmFrameExecuteEncode.Execute := Encode;
  frmFrameExecuteDecode.Execute := Decode;

  tbcEncodeResult.TabPosition := TTabPosition.None;
  tbcDecodeInput.TabPosition := TTabPosition.None;

  //ENCODE
  frmFrameBoxSaveFileEncodeResult.OnBeforeProcess :=
    procedure(var pInput: string;
              var pMode: TZLibModeType;
              var pOperation: TZLibOperationType;
              var pAlgorithm: TZLibAlgorithmType;
              var pEncoding: TEncoding;
              var pContentType: Integer)
    begin
      pInput := frmFrameBoxTextEncodeInput.Text;
      pMode := FMode;
      pOperation := Operation;
      pAlgorithm := Algorithm;
      pEncoding  := TEncoding.ANSI;
      pContentType := 1; //TEXT
    end;
  frmFrameBoxSaveFileEncodeResult.OnAfterProcess :=
    procedure(const pMD5Result: string)
    begin
      frmFrameBoxTextEncodeInput.MD5 := pMD5Result;
    end;
end;

procedure TfrmProcessText.SetMode(const Value: TZLibModeType);
begin
  inherited;
  FMode := Value;
  case Value of
    TZLibModeType.Base64:
    begin
      frmFrameExecuteEncode.OptionExecute := 1;
      tbcEncodeResult.ActiveTab := tbiEncodeResultText;
      tbcDecodeInput.ActiveTab := tbiDecodeInputText;
    end;
    TZLibModeType.Data:
    begin
      frmFrameExecuteEncode.OptionExecute := 2;
      frmFrameExecuteDecode.OptionExecute := 1;
      tbcEncodeResult.ActiveTab := tbiEncodeResultSaveToFile;
      tbcDecodeInput.ActiveTab := tbiDecodeInputOpenFile;
    end;
  end;
end;

procedure TfrmProcessText.Encode(const pEncoding: TEncoding);
var
  lInput: string;
  lResultCompress: IZLibResult;
begin
  lInput := frmFrameBoxTextEncodeInput.Text;

  case Mode of
    TZLibModeType.Base64: //BASE64
    begin

      case Algorithm of
        TZLibAlgorithmType.Deflate:
        begin
          lResultCompress := TZLib
            .Base64
              .Compress
                .Deflate
                  .Level(TZLibCompressionLevelType.Max)
                  .Text(lInput, pEncoding);
        end;
        TZLibAlgorithmType.GZip:
        begin
          lResultCompress := TZLib
            .Base64
              .Compress
                .GZip
                  .Level(TZLibCompressionLevelType.Max)
                  .Text(lInput, pEncoding);
        end;
      end;

      frmFrameBoxTextEncodeResult.Text := lResultCompress.Text[nil]; //DEFAULT UTF8
    end;
    TZLibModeType.Data: //DATA
    begin

      case Algorithm of
        TZLibAlgorithmType.Deflate:
        begin
          lResultCompress := TZLib
            .Data
              .Compress
                .Deflate
                  .Level(TZLibCompressionLevelType.Max)
                  .Text(lInput, pEncoding);
        end;
        TZLibAlgorithmType.GZip:
        begin
          lResultCompress := TZLib
            .Data
              .Compress
                .GZip
                  .Level(TZLibCompressionLevelType.Max)
                  .Text(lInput, pEncoding);
        end;
      end;

      frmFrameBoxTextEncodeResult.Text := lResultCompress.Text[TEncoding.ANSI];
    end;
  end;

  frmFrameBoxTextEncodeInput.MD5 := lResultCompress.MD5Input;
  frmFrameBoxTextEncodeResult.MD5 := lResultCompress.MD5Result;
end;

procedure TfrmProcessText.Decode(const pEncoding: TEncoding);
var
  lInput: string;
  lResultDecompress: IZLibResult;
begin

  case Mode of
    TZLibModeType.Base64: //BASE64
    begin
      lInput := frmFrameBoxTextDecodeInput.Text;

      case Algorithm of
        TZLibAlgorithmType.Deflate:
        begin
          lResultDecompress := TZLib
            .Base64
              .Decompress
                .Deflate
                  .Text(lInput);
        end;
        TZLibAlgorithmType.GZip:
        begin
          lResultDecompress := TZLib
            .Base64
              .Decompress
                .GZip
                  .Text(lInput);
        end;
      end;

      frmFrameBoxTextDecodeResult.Text := lResultDecompress.Text[pEncoding];
    end;
    TZLibModeType.Data: //DATA
    begin
      lInput := frmFrameBoxOpenFileDecodeInput.&File;

      case Algorithm of
        TZLibAlgorithmType.Deflate:
        begin
          lResultDecompress := TZLib
            .Data
              .Decompress
                .Deflate
                  .LoadFromFile(lInput);
        end;
        TZLibAlgorithmType.GZip:
        begin
          lResultDecompress := TZLib
            .Data
              .Decompress
                .GZip
                  .LoadFromFile(lInput);
        end;
      end;

      frmFrameBoxTextDecodeResult.Text := lResultDecompress.Text[pEncoding];
    end;
  end;

  frmFrameBoxOpenFileDecodeInput.MD5 := lResultDecompress.MD5Input;
  frmFrameBoxTextDecodeInput.MD5 := lResultDecompress.MD5Input;
  frmFrameBoxTextDecodeResult.MD5 := lResultDecompress.MD5Result;
end;

end.
