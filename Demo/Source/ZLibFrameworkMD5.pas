{******************************************************************************}
{                                                                              }
{           Demo.ZLibFrameworkMD5                                              }
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
unit ZLibFrameworkMD5;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FormBase,
  FMX.Layouts, FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo, FMX.Objects,
  FrameExecute, FrameBoxText, FrameBoxImage, FMX.StdCtrls, FMX.Edit,
  FrameBoxSaveFile, IPPeerCommon, IPPeerClient;

type
  TfrmZLibFrameworkMD5 = class(TfrmFormBase)
    lytAbout: TLayout;
    crtAbout: TCalloutRectangle;
    mmoAbout: TMemo;
    lytDemo: TLayout;
    vsbDemo: TVertScrollBox;
    gplDemoEncode: TGridPanelLayout;
    lytEncodeCell1: TLayout;
    lytEncodeCell2: TLayout;
    lytEncodeCell3: TLayout;
    lytEncodeRectangleTitle: TLayout;
    crtEncodeRectangleTitle: TCalloutRectangle;
    txtEncodeRectangleTitle: TText;
    lytEncodeTitle: TLayout;
    txtEncodeTitle: TText;
    lytEncodeCell4: TLayout;
    frmFrameBoxImageEncodeInput: TfrmFrameBoxImage;
    lytEncodeCell5: TLayout;
    frmFrameBoxTextEncodeResult: TfrmFrameBoxText;
    gplDemoDecode: TGridPanelLayout;
    lytDecodeCell1: TLayout;
    lytDecodeCell2: TLayout;
    lytDecodeCell3: TLayout;
    lytDecodeCell4: TLayout;
    lytDecodeCell5: TLayout;
    frmFrameBoxImageDecode: TfrmFrameBoxImage;
    frmFrameBoxTextDecode: TfrmFrameBoxText;
    lytDecodeRectangleTitle: TLayout;
    crtDecodeRectangleTitle: TCalloutRectangle;
    txtDecodeRectangleTitle: TText;
    lytDecodeTitle: TLayout;
    txtDecodeTitle: TText;
    frmFrameBoxSaveFileDecode: TfrmFrameBoxSaveFile;
    frmFrameExecuteDecode: TfrmFrameExecute;
    StyleBook1: TStyleBook;
    tmrAfterShow: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure tmrAfterShowTimer(Sender: TObject);
  private
    { Private declarations }
    FEncodeResult: string;
    procedure Encode(const pEncoding: TEncoding);
    procedure Decode(const pEncoding: TEncoding);
  public
    { Public declarations }
  end;

var
  frmZLibFrameworkMD5: TfrmZLibFrameworkMD5;

implementation

{$R *.fmx}

uses
  ZLibFramework, ZLibFramework.Types;

{ TfrmZLibFrameworkMD5 }

procedure TfrmZLibFrameworkMD5.FormCreate(Sender: TObject);
begin
  inherited;
  frmFrameExecuteDecode.Execute := Decode;
  frmFrameExecuteDecode.Encoding := TEncoding.ANSI;
  frmFrameExecuteDecode.ppmExecute.Clear;

  frmFrameBoxImageEncodeInput.LoadImageFromTImage;
  frmFrameBoxImageEncodeInput.LoadImage := False;
  frmFrameBoxImageDecode.LoadImage := False;

  frmFrameBoxSaveFileDecode.OnBeforeProcess :=
    procedure(var pInput: string;
              var pMode: TZLibModeType;
              var pOperation: TZLibOperationType;
              var pAlgorithm: TZLibAlgorithmType;
              var pEncoding: TEncoding;
              var pContentType: Integer)
    begin
      pInput := FEncodeResult;
      pMode := TZLibModeType.Base64;
      pOperation := TZLibOperationType.Decompress;
      pAlgorithm := TZLibAlgorithmType.Deflate;
      pEncoding  := TEncoding.ANSI;
      pContentType := 1; //TEXT;
    end;

  tmrAfterShow.Enabled := True;
end;

procedure TfrmZLibFrameworkMD5.tmrAfterShowTimer(Sender: TObject);
var
  lEncoding: TEncoding;
begin
  tmrAfterShow.Enabled := False;
  lEncoding := nil;
  Encode(lEncoding);
end;

procedure TfrmZLibFrameworkMD5.Encode(const pEncoding: TEncoding);
var
  lInput: TBytesStream;
  lResultCompress: IZLibResult;
begin
  lInput := TBytesStream.Create;
  try
    lInput.CopyFrom(frmFrameBoxImageEncodeInput.Image, frmFrameBoxImageEncodeInput.Image.Size);

    TZLib
      .Base64
        .Compress
          .Deflate
            .Level(TZLibCompressionLevelType.Max)
            .LoadFromStream(lInput, lResultCompress);

    frmFrameBoxImageEncodeInput.MD5 := lResultCompress.MD5Input;

    //RESULT
    FEncodeResult := lResultCompress.Text[TEncoding.UTF8];
    frmFrameBoxTextEncodeResult.Text := lResultCompress.Text[TEncoding.UTF8];
    frmFrameBoxTextEncodeResult.MD5 := lResultCompress.MD5Result;
  finally
    lInput.Free;
  end;
end;

procedure TfrmZLibFrameworkMD5.Decode(const pEncoding: TEncoding);
var
  lResultDecompressImage: IZLibResult;
  lResultDecompressText: IZLibResult;
begin

  //DECODE >> IMAGE
  TZLib
    .Base64
      .Decompress
        .Deflate
          .Text(FEncodeResult, lResultDecompressImage);

  //RESULT
  frmFrameBoxImageDecode.MD5 := lResultDecompressImage.MD5Result;
  frmFrameBoxImageDecode.Image := lResultDecompressImage.Stream;

  //DECODE >> TEXT
  TZLib
    .Base64
      .Decompress
        .Deflate
          .Text(FEncodeResult, lResultDecompressText);

  //RESULT
  frmFrameBoxTextDecode.Text := lResultDecompressText.Text[TEncoding.ANSI];
  frmFrameBoxTextDecode.MD5 := lResultDecompressText.MD5Result;

  //DECODE >> FILE
  ShowMessage('INFORME UM NOME DE ARQUIVO COM A EXTENSÃO .PNG PARA SALVAR A IMAGEM DEPOIS DA DECODIFICAÇÃO');
  frmFrameBoxSaveFileDecode.Execute;
end;

end.
