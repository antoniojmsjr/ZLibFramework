{******************************************************************************}
{                                                                              }
{           Demo.ProcessImage                                                  }
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
unit ProcessImage;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, ChildBase,
  FMX.Layouts, FrameBoxImage, FrameExecute, FrameBoxText, FMX.Objects,
  FMX.Effects, FrameBoxSaveFile, FMX.TabControl, ZLibFramework.Types,
  FrameBoxOpenFile;

type
  TfrmProcessImage = class(TfrmChildBase)
    rtToolBarEncode: TRectangle;
    seToolBarEncode: TShadowEffect;
    txtToolBarEncode: TText;
    rtToolBarDecode: TRectangle;
    seToolBarDecode: TShadowEffect;
    txtToolBarDecode: TText;
    frmFrameBoxImageDecodeResult: TfrmFrameBoxImage;
    frmFrameExecuteDecode: TfrmFrameExecute;
    frmFrameExecuteEncode: TfrmFrameExecute;
    frmFrameBoxImageEncodeInput: TfrmFrameBoxImage;
    tbcEncodeResult: TTabControl;
    tbiEncodeResultText: TTabItem;
    frmFrameBoxTextEncodeResult: TfrmFrameBoxText;
    tbiEncodeResultSaveToFile: TTabItem;
    frmFrameBoxSaveFileEncodeResult: TfrmFrameBoxSaveFile;
    tbcDecodeInput: TTabControl;
    tbiDecodeInputText: TTabItem;
    frmFrameBoxTextDecodeInput: TfrmFrameBoxText;
    tbiDecodeInputOpenFile: TTabItem;
    frmFrameBoxOpenFileDecodeInput: TfrmFrameBoxOpenFile;
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
  System.NetEncoding, ZLibFramework;

{ TfrmSamples003 }

procedure TfrmProcessImage.FormCreate(Sender: TObject);
begin
  inherited;
  frmFrameExecuteEncode.Execute := Encode;
  frmFrameExecuteEncode.ppmExecute.Clear;

  frmFrameExecuteDecode.Execute := Decode;
  frmFrameExecuteDecode.Encoding := TEncoding.ANSI;
  frmFrameExecuteDecode.ppmExecute.Clear;

  frmFrameBoxImageDecodeResult.LoadImage := False;

  tbcEncodeResult.TabPosition := TTabPosition.None;
  tbcDecodeInput.TabPosition := TTabPosition.None;

  //ENCODE: DATA
  frmFrameBoxSaveFileEncodeResult.OnBeforeProcess :=
    procedure(var pInput: string;
              var pMode: TZLibModeType;
              var pOperation: TZLibOperationType;
              var pAlgorithm: TZLibAlgorithmType;
              var pEncoding: TEncoding;
              var pContentType: Integer)
    begin
      pInput := frmFrameBoxImageEncodeInput.&File;
      pMode := TZLibModeType.Data;
      pOperation := Operation;
      pAlgorithm := Algorithm;
      pEncoding  := TEncoding.ANSI;
      pContentType := 2; //FILE
    end;
  frmFrameBoxSaveFileEncodeResult.OnAfterProcess :=
    procedure(const pMD5Result: string)
    begin
      frmFrameBoxImageEncodeInput.MD5 := pMD5Result;
    end;
end;

procedure TfrmProcessImage.SetMode(const Value: TZLibModeType);
begin
  inherited;
  FMode := Value;
  case Value of
    TZLibModeType.Base64:
    begin
      frmFrameExecuteEncode.OptionExecute := 1;
      frmFrameExecuteDecode.OptionExecute := 1;
      tbcEncodeResult.ActiveTab := tbiEncodeResultText;
      tbcDecodeInput.ActiveTab := tbiDecodeInputText;
    end;
    TZLibModeType.Data:
    begin
//      frmFrameBoxOpenFileInput.txtHeaderCell1.Text := 'Selecione um arquivo para ser compactado';
//      frmFrameBoxOpenFileDecodeInput.txtHeaderCell1.Text := 'Selecione um arquivo para ser descompactado';
//      frmFrameBoxSaveFileDecodeResult.txtHeaderCell1.Text := 'Selecione um arquivo para ser salvo depois da descompactação';

      frmFrameExecuteEncode.OptionExecute := 2;
      frmFrameExecuteDecode.OptionExecute := 1;
      tbcEncodeResult.ActiveTab := tbiEncodeResultSaveToFile;
      tbcDecodeInput.ActiveTab := tbiDecodeInputOpenFile;
    end;
  end;
end;

procedure TfrmProcessImage.Encode(const pEncoding: TEncoding);
var
  lInputFile: string;
  lInputStrem: TBytesStream;
  lResultCompress: IZLibResult;
begin

  case Mode of
    TZLibModeType.Base64: //BASE64
    begin
      lInputStrem := TBytesStream.Create;
      try
        frmFrameBoxImageEncodeInput.Image.Position := 0;
        lInputStrem.LoadFromStream(frmFrameBoxImageEncodeInput.Image);

        case Algorithm of
          TZLibAlgorithmType.Deflate: //DEFLATE
          begin
            TZLib
              .Base64
                .Compress
                  .Deflate
                    .Level(TZLibCompressionLevelType.Max)
                    .LoadFromStream(lInputStrem, lResultCompress);
          end;
          TZLibAlgorithmType.GZip: //GZIP
          begin
            TZLib
              .Base64
                .Compress
                  .GZip
                    .Level(TZLibCompressionLevelType.Max)
                    .LoadFromStream(lInputStrem, lResultCompress);
          end;
        end;
      finally
        lInputStrem.Free;
      end;

      frmFrameBoxTextEncodeResult.Text := lResultCompress.Text[TEncoding.UTF8];
    end;
    TZLibModeType.Data: //DATA
    begin
      lInputFile := frmFrameBoxImageEncodeInput.&File;

      case Algorithm of
        TZLibAlgorithmType.Deflate: //DEFLATE
        begin
          TZLib
            .Data
              .Compress
                .Deflate
                  .Level(TZLibCompressionLevelType.Max)
                  .LoadFromFile(lInputFile, lResultCompress);
        end;
        TZLibAlgorithmType.GZip: //GZIP
        begin
          TZLib
            .Data
              .Compress
                .GZip
                  .Level(TZLibCompressionLevelType.Max)
                  .LoadFromFile(lInputFile, lResultCompress);
        end;
      end;

      frmFrameBoxTextEncodeResult.Text := lResultCompress.Text[TEncoding.ANSI];
    end;
  end;

  frmFrameBoxImageEncodeInput.MD5 := lResultCompress.MD5Input;

  //RESULT
  frmFrameBoxTextEncodeResult.MD5 := lResultCompress.MD5Result;
end;

procedure TfrmProcessImage.Decode(const pEncoding: TEncoding);
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
          TZLib
            .Base64
              .Decompress
                .Deflate
                  .Text(lInput, lResultDecompress);
        end;
        TZLibAlgorithmType.GZip:
        begin
          TZLib
            .Base64
              .Decompress
                .GZip
                  .Text(lInput, lResultDecompress);
        end;
      end;

    end;
    TZLibMOdeType.Data: //DATA
    begin
      lInput := frmFrameBoxOpenFileDecodeInput.&File;

      case Algorithm of
        TZLibAlgorithmType.Deflate:
        begin
          TZLib
            .Data
              .Decompress
                .Deflate
                  .LoadFromFile(lInput, lResultDecompress);
        end;
        TZLibAlgorithmType.GZip:
        begin
          TZLib
            .Data
              .Decompress
                .GZip
                  .LoadFromFile(lInput, lResultDecompress);
        end;
      end;

    end;
  end;

  frmFrameBoxOpenFileDecodeInput.MD5 := lResultDecompress.MD5Input;
  frmFrameBoxTextDecodeInput.MD5 := lResultDecompress.MD5Input;
  frmFrameBoxImageDecodeResult.MD5 := lResultDecompress.MD5Result;
  frmFrameBoxImageDecodeResult.Image := lResultDecompress.Stream;
end;

end.
