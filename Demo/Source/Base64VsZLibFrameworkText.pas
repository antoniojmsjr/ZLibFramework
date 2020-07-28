{******************************************************************************}
{                                                                              }
{           Demo.Base64VsZLibFrameworkText                                     }
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
unit Base64VsZLibFrameworkText;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FormBase,
  FMX.Layouts, FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo, FMX.Objects,
  FrameExecute, FMX.Edit, FrameBoxText;

type
  TfrmBase64VsZLibFrameworkText = class(TfrmFormBase)
    lytAbout: TLayout;
    crtAbout: TCalloutRectangle;
    mmoAbout: TMemo;
    lytDemo: TLayout;
    vsbDemo: TVertScrollBox;
    gplDemoBase64: TGridPanelLayout;
    lytBase64Cell1: TLayout;
    lytBase64Cell2: TLayout;
    lytBase64Cell3: TLayout;
    lytBase64RectangleTitle: TLayout;
    crtBase64RectangleTitle: TCalloutRectangle;
    txtBase64RectangleTitle: TText;
    lytBase64Title: TLayout;
    txtBase64Title: TText;
    lytBase64Cell4: TLayout;
    lytBase64Cell5: TLayout;
    lytBase64Cell6: TLayout;
    frmFrameBoxTextBase64Input: TfrmFrameBoxText;
    frmFrameBoxTextBase64Result: TfrmFrameBoxText;
    frmFrameExecuteEncodeBase64: TfrmFrameExecute;
    lytZLibFrameworkRectangleTitle: TLayout;
    rctZLibFrameworkRectangleTitle: TCalloutRectangle;
    txtZLibFrameworkRectangleTitle: TText;
    lytZLibFrameworkTitle: TLayout;
    txtZLibFrameworkTitle: TText;
    frmFrameBoxTextZLibFrameworkInput: TfrmFrameBoxText;
    frmFrameBoxTextZLibFrameworkResult: TfrmFrameBoxText;
    frmFrameExecuteEncodeZLibFramework: TfrmFrameExecute;
    StyleBook1: TStyleBook;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure EncodeBase64(const pEncoding: TEncoding);
    procedure EncodeZLibFramework(const pEncoding: TEncoding);
  public
    { Public declarations }
  end;

var
  frmBase64VsZLibFrameworkText: TfrmBase64VsZLibFrameworkText;

implementation

{$R *.fmx}

uses
  Base64VsZLibFrameworkTextNFe, System.NetEncoding, System.Hash, ZLibFramework,
  ZLibFramework.Types;

procedure TfrmBase64VsZLibFrameworkText.FormCreate(Sender: TObject);
var
  lTextoNFe: TStrings;
begin
  inherited;
  lTextoNFe := GetTextoNFe;
  try
    frmFrameBoxTextBase64Input.mmoBoxText.Lines.AddStrings(lTextoNFe);
    frmFrameBoxTextZLibFrameworkInput.mmoBoxText.Lines.AddStrings(lTextoNFe);
  finally
    lTextoNFe.Free;
  end;

  frmFrameExecuteEncodeBase64.Execute := EncodeBase64;
  frmFrameExecuteEncodeZLibFramework.Execute := EncodeZLibFramework;
end;

procedure TfrmBase64VsZLibFrameworkText.EncodeBase64(const pEncoding: TEncoding);
var
  lInput: string;
  lResult: string;
  lMD5Input: string;
  lMD5Result: string;
  lBase64Encoding: TBase64Encoding;
begin
  lInput := frmFrameBoxTextBase64Input.Text;

  lBase64Encoding := TBase64Encoding.Create(0);
  try
    lResult := lBase64Encoding.Encode (lInput);
  finally
    lBase64Encoding.Free;
  end;

  lMD5Input := THashMD5.GetHashString(lInput);
  frmFrameBoxTextBase64Input.MD5 := lMD5Input;

  //RESULT
  lMD5Result := THashMD5.GetHashString(lResult);
  frmFrameBoxTextBase64Result.Text := lResult;
  frmFrameBoxTextBase64Result.MD5 := lMD5Result;
end;

procedure TfrmBase64VsZLibFrameworkText.EncodeZLibFramework(const pEncoding: TEncoding);
var
  lInput: string;
  lResultCompress: IZLibResult;
begin
  lInput := frmFrameBoxTextZLibFrameworkInput.Text;

  TZLib
    .Base64
      .Compress
        .Deflate
          .Level(TZLibCompressionLevelType.Max)
          .Text(lInput, lResultCompress);

  frmFrameBoxTextZLibFrameworkInput.MD5 := lResultCompress.MD5Input;

  //RESULT
  frmFrameBoxTextZLibFrameworkResult.Text := lResultCompress.Text[TEncoding.UTF8];
  frmFrameBoxTextZLibFrameworkResult.MD5 := lResultCompress.MD5Result;
end;

end.
