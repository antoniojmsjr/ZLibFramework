{******************************************************************************}
{                                                                              }
{           Demo.About                                                         }
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
unit About;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FormBase,
  FMX.Layouts, FMX.Objects, FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo,
  FMX.Effects, FMX.Edit, FMX.StdCtrls, FMX.Filter.Effects, FrameExecute;

type
  TfrmAbout = class(TfrmFormBase)
    lytAbout: TLayout;
    lytDemo: TLayout;
    crtAbout: TCalloutRectangle;
    mmoAbout: TMemo;
    StyleBook1: TStyleBook;
    gplDemoBase64: TGridPanelLayout;
    vsbDemo: TVertScrollBox;
    lytBase64Cell1: TLayout;
    lytBase64Cell2: TLayout;
    lytBase64Cell3: TLayout;
    lytBase64RectangleTitle: TLayout;
    crtBase64RectangleTitle: TCalloutRectangle;
    txtBase64RectangleTitle: TText;
    lytBase64Title: TLayout;
    txtBase64Title: TText;
    lytBase64Cell4: TLayout;
    rctDemoBase64Encode: TRectangle;
    lytDemoBase64Encode: TLayout;
    txtDemoBase64EncodeValue: TText;
    edtDemoBase64EncodeValue: TEdit;
    txtDemoBase64EncodeMD5Value: TText;
    edtDemoBase64EncodeMD5Value: TEdit;
    lytBase64Cell5: TLayout;
    lytBase64Cell8: TLayout;
    rctDemoBase64EncodeResult: TRectangle;
    lytDemoBase64EncodeResult: TLayout;
    txtDemoBase64EncodeResultValue: TText;
    edtDemoBase64EncodeResultValue: TEdit;
    txtDemoBase64EncodeResultMD5Value: TText;
    edtDemoBase64EncodeResultMD5Value: TEdit;
    lytBase64Cell9: TLayout;
    lytBase64Cell7: TLayout;
    frmFrameExecuteDecodeBase64: TfrmFrameExecute;
    rctDemoBase64Decode: TRectangle;
    lytDemoBase64Decode: TLayout;
    txtDemoBase64DecodeValue: TText;
    edtDemoBase64DecodeValue: TEdit;
    txtDemoBase64DecodeMD5Value: TText;
    edtDemoBase64DecodeMD5Value: TEdit;
    rctDemoBase64DecodeResult: TRectangle;
    lytDemoBase64DecodeResult: TLayout;
    txtDemoBase64DecodeResultValue: TText;
    edtDemoBase64DecodeResultValue: TEdit;
    txtDemoBase64DecodeResultMD5Value: TText;
    edtDemoBase64DecodeResultMD5Value: TEdit;
    lytBase64Cell6: TLayout;
    frmFrameExecuteEncodeBase64: TfrmFrameExecute;
    gplDemoData: TGridPanelLayout;
    lytDataCell1: TLayout;
    lytDataCell2: TLayout;
    lytDataCell3: TLayout;
    lytDataRectangle: TLayout;
    crtDataRectangle: TCalloutRectangle;
    txtDataRectangle: TText;
    lytDemoDataTitle: TLayout;
    txtDemoDataTitle: TText;
    lytDataCell4: TLayout;
    rctDemoDataEncode: TRectangle;
    lytDemoDataEncode: TLayout;
    txtDemoDataEncodeValue: TText;
    edtDemoDataEncodeValue: TEdit;
    txtDemoDataEncodeMD5Value: TText;
    edtDemoDataEncodeMD5Value: TEdit;
    lytDataCell5: TLayout;
    rctDemoDataDecode: TRectangle;
    lytDemoDataDecode: TLayout;
    txtDemoDataDecodeValue: TText;
    edtDemoDataDecodeValue: TEdit;
    txtDemoDataDecodeMD5Value: TText;
    edtDemoDataDecodeMD5Value: TEdit;
    lytDataCell9: TLayout;
    rctDemoDataEncodeResult: TRectangle;
    lytDemoDataEncodeResult: TLayout;
    txtDemoDataEncodeResultValue: TText;
    edtDemoDataEncodeResultValue: TEdit;
    txtDemoDataEncodeResultMD5Value: TText;
    edtDemoDataEncodeResultMD5Value: TEdit;
    lytDataCell10: TLayout;
    rctDemoDataDecodeResult: TRectangle;
    lytDemoDataDecodeResult: TLayout;
    txtDemoDataDecodeResultValue: TText;
    edtDemoDataDecodeResultValue: TEdit;
    txtDemoDataDecodeResultMD5Value: TText;
    edtDemoDataDecodeResultMD5Value: TEdit;
    lytDataCell7: TLayout;
    frmFrameExecuteDecodeData: TfrmFrameExecute;
    lytDataCell6: TLayout;
    frmFrameExecuteEncodeData: TfrmFrameExecute;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure EncodeBase64(const pEncoding: TEncoding);
    procedure DecodeBase64(const pEncoding: TEncoding);
    procedure EncodeData(const pEncoding: TEncoding);
    procedure DecodeData(const pEncoding: TEncoding);
  public
    { Public declarations }
  end;

var
  frmAbout: TfrmAbout;

implementation

{$R *.fmx}

uses
  ZLibFramework, ZLibFramework.Types;

{ TfrmAbout }

procedure TfrmAbout.FormCreate(Sender: TObject);
begin
  inherited;
  frmFrameExecuteEncodeBase64.Execute := EncodeBase64;
  frmFrameExecuteDecodeBase64.Execute := DecodeBase64;

  frmFrameExecuteEncodeData.Execute := EncodeData;
  frmFrameExecuteDecodeData.Execute := DecodeData;
end;

procedure TfrmAbout.EncodeBase64(const pEncoding: TEncoding);
var
  lInput: string;
  lResultCompress: IZLibResult;
begin
  lInput := edtDemoBase64EncodeValue.Text;

  lResultCompress := TZLib
    .Base64
      .Compress
        .Deflate
          .Level(TZLibCompressionLevelType.Max)
            .Text(lInput);

  edtDemoBase64EncodeMD5Value.Text := lResultCompress.MD5Input;

  //RESULT
  edtDemoBase64EncodeResultValue.Text := lResultCompress.Text[TEncoding.UTF8];
  edtDemoBase64EncodeResultMD5Value.Text := lResultCompress.MD5Result;

  edtDemoBase64DecodeValue.Text := lResultCompress.Text[TEncoding.UTF8];;
end;

procedure TfrmAbout.DecodeBase64(const pEncoding: TEncoding);
var
  lInput: string;
  lResultDecompress: IZLibResult;
begin
  if edtDemoBase64DecodeValue.Text.Trim.IsEmpty then
    Exit;

  lInput := edtDemoBase64DecodeValue.Text;

  lResultDecompress := TZLib
    .Base64
      .Decompress
        .Deflate
          .Text(lInput);

  edtDemoBase64DecodeMD5Value.Text := lResultDecompress.MD5Input;

  //RESULT
  edtDemoBase64DecodeResultValue.Text := lResultDecompress.Text[TEncoding.UTF8];
  edtDemoBase64DecodeResultMD5Value.Text := lResultDecompress.MD5Result;
end;

procedure TfrmAbout.EncodeData(const pEncoding: TEncoding);
var
  lInput: string;
  lResultCompress: IZLibResult;
begin
  lInput := edtDemoDataEncodeValue.Text;

  lResultCompress := TZLib
    .Data
      .Compress
        .Deflate
          .Level(TZLibCompressionLevelType.Max)
            .Text(lInput);

  edtDemoDataEncodeMD5Value.Text := lResultCompress.MD5Input;

  //RESULT
  edtDemoDataEncodeResultValue.Text := lResultCompress.Text[TEncoding.ANSI];
  edtDemoDataEncodeResultMD5Value.Text := lResultCompress.MD5Result;

  edtDemoDataDecodeValue.Text := lResultCompress.Text[TEncoding.ANSI];
end;

procedure TfrmAbout.DecodeData(const pEncoding: TEncoding);
var
  lInput: string;
  lResultDecompress: IZLibResult;
begin
  if edtDemoDataDecodeValue.Text.Trim.IsEmpty then
    Exit;

  lInput := edtDemoDataDecodeValue.Text;

  lResultDecompress := TZLib
    .Data
      .Decompress
        .Deflate
          .Text(lInput);

  edtDemoDataDecodeMD5Value.Text := lResultDecompress.MD5Input;

  //RESULT
  edtDemoDataDecodeResultValue.Text := lResultDecompress.Text[TEncoding.ANSI];
  edtDemoDataDecodeResultMD5Value.Text := lResultDecompress.MD5Result;
end;

end.
