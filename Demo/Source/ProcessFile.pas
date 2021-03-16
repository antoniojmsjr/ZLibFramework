{******************************************************************************}
{                                                                              }
{           Demo.ProcessFile                                                   }
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
unit ProcessFile;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, ChildBase,
  FMX.Layouts, FrameExecute, FrameBoxText, FrameBoxOpenFile, FrameBoxSaveFile,
  FMX.Objects, FMX.Effects, ZLibFramework.Types, FMX.TabControl;

type
  TfrmProcessFile = class(TfrmChildBase)
    rtToolBarEncode: TRectangle;
    seToolBarEncode: TShadowEffect;
    txtToolBarEncode: TText;
    rtToolBarDecode: TRectangle;
    seToolBarDecode: TShadowEffect;
    txtToolBarDecode: TText;
    frmFrameBoxSaveFileDecodeResult: TfrmFrameBoxSaveFile;
    frmFrameExecuteEncode: TfrmFrameExecute;
    frmFrameBoxOpenFileInput: TfrmFrameBoxOpenFile;
    frmFrameExecuteDecode: TfrmFrameExecute;
    tbcEncodeResult: TTabControl;
    tbiEncodeResultText: TTabItem;
    frmFrameBoxTextEncodeResult: TfrmFrameBoxText;
    tbiEncodeResultSaveToFile: TTabItem;
    frmFrameBoxSaveFileEncodeResult: TfrmFrameBoxSaveFile;
    tbcDecodeInput: TTabControl;
    tbiDecodeInputText: TTabItem;
    tbiDecodeInputOpenFile: TTabItem;
    frmFrameBoxOpenFileDecodeInput: TfrmFrameBoxOpenFile;
    frmFrameBoxTextDecodeInput: TfrmFrameBoxText;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FMode: TZLibModeType;
    procedure Encode(const pEncoding: TEncoding);
  protected
    { Private declarations }
    procedure SetMode(const Value: TZLibModeType); override;
  public
    { Public declarations }
  end;

implementation

uses
  ZLibFramework;

{$R *.fmx}

{ TfrmSamples002 }

procedure TfrmProcessFile.FormCreate(Sender: TObject);
begin
  inherited;
  frmFrameExecuteEncode.Execute := Encode;
  frmFrameExecuteEncode.ppmExecute.Clear;

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
      pInput := frmFrameBoxOpenFileInput.&File;
      pMode := FMode;
      pOperation := Operation;
      pAlgorithm := Algorithm;
      pEncoding  := TEncoding.ANSI;
      pContentType := 2; //FILE
    end;
  frmFrameBoxSaveFileEncodeResult.OnAfterProcess :=
    procedure(const pMD5Result: string)
    begin
      frmFrameBoxOpenFileInput.MD5 := pMD5Result;
    end;

end;

procedure TfrmProcessFile.SetMode(const Value: TZLibModeType);
begin
  inherited;
  FMode := Value;
  case Value of
    TZLibModeType.Base64:
    begin
      frmFrameExecuteEncode.OptionExecute := 1;
      frmFrameExecuteDecode.OptionExecute := 2;
      tbcEncodeResult.ActiveTab := tbiEncodeResultText;
      tbcDecodeInput.ActiveTab := tbiDecodeInputText;

      //DECODE
      frmFrameBoxSaveFileDecodeResult.OnBeforeProcess :=
        procedure(var pInput: string;
                  var pMode: TZLibModeType;
                  var pOperation: TZLibOperationType;
                  var pAlgorithm: TZLibAlgorithmType;
                  var pEncoding: TEncoding;
                  var pContentType: Integer)
        begin
          pInput := frmFrameBoxTextDecodeInput.Text;
          pMode := Mode;
          pOperation := TZLibOperationType.Decompress;
          pAlgorithm := Algorithm;
          pEncoding  := TEncoding.ANSI;
          pContentType := 2; //FILE
        end;
      frmFrameBoxSaveFileDecodeResult.OnAfterProcess :=
        procedure(const pMD5Result: string)
        begin
          frmFrameBoxTextDecodeInput.MD5 := pMD5Result;
        end;
    end;
    TZLibModeType.Data:
    begin
      frmFrameBoxOpenFileInput.txtHeaderCell1.Text := 'Selecione um arquivo para ser compactado';
      frmFrameBoxOpenFileDecodeInput.txtHeaderCell1.Text := 'Selecione um arquivo para ser descompactado';
      frmFrameBoxSaveFileDecodeResult.txtHeaderCell1.Text := 'Selecione um arquivo para ser salvo depois da descompactação';

      frmFrameExecuteEncode.OptionExecute := 2;
      frmFrameExecuteDecode.OptionExecute := 2;
      tbcEncodeResult.ActiveTab := tbiEncodeResultSaveToFile;
      tbcDecodeInput.ActiveTab := tbiDecodeInputOpenFile;

      //DECODE
      frmFrameBoxSaveFileDecodeResult.OnBeforeProcess :=
        procedure(var pInput: string;
                  var pMode: TZLibModeType;
                  var pOperation: TZLibOperationType;
                  var pAlgorithm: TZLibAlgorithmType;
                  var pEncoding: TEncoding;
                  var pContentType: Integer)
        begin
          pInput := frmFrameBoxOpenFileDecodeInput.&File;
          pMode := Mode;
          pOperation := TZLibOperationType.Decompress;
          pAlgorithm := Algorithm;
          pEncoding  := TEncoding.ANSI;
          pContentType := 2; //FILE
        end;
      frmFrameBoxSaveFileDecodeResult.OnAfterProcess :=
        procedure(const pMD5Result: string)
        begin
          frmFrameBoxOpenFileDecodeInput.MD5 := pMD5Result;
        end;
    end;
  end;
end;

procedure TfrmProcessFile.Encode(const pEncoding: TEncoding);
var
  lInput: TFileName;
  lResultCompress: IZLibResult;
begin
  lInput := frmFrameBoxOpenFileInput.&File;

  case Mode of
    TZLibModeType.Base64: //BASE64
    begin

      case Algorithm of
        TZLibAlgorithmType.Deflate: //DEFLATE
        begin
          lResultCompress := TZLib
            .Base64
              .Compress
                .Deflate
                  .Level(TZLibCompressionLevelType.Max)
                  .LoadFromFile(lInput);
        end;
        TZLibAlgorithmType.GZip: //GZIP
        begin
          lResultCompress := TZLib
            .Base64
              .Compress
                .GZip
                  .Level(TZLibCompressionLevelType.Max)
                  .LoadFromFile(lInput);
        end;
      end;

      frmFrameBoxTextEncodeResult.Text := lResultCompress.Text[TEncoding.UTF8];
    end;
    TZLibModeType.Data: //DATA
    begin

      case Algorithm of
        TZLibAlgorithmType.Deflate: //DEFLATE
        begin
          lResultCompress := TZLib
            .Data
              .Compress
                .Deflate
                  .Level(TZLibCompressionLevelType.Max)
                  .LoadFromFile(lInput);
        end;
        TZLibAlgorithmType.GZip: //GZIP
        begin
          lResultCompress := TZLib
            .Data
              .Compress
                .GZip
                  .Level(TZLibCompressionLevelType.Max)
                  .LoadFromFile(lInput);
        end;
      end;

      frmFrameBoxTextEncodeResult.Text := lResultCompress.Text[TEncoding.ANSI];
    end;
  end;

  frmFrameBoxOpenFileInput.MD5 := lResultCompress.MD5Input;
  frmFrameBoxTextEncodeResult.MD5 := lResultCompress.MD5Result;
end;

end.
