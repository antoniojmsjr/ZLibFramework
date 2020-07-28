{******************************************************************************}
{                                                                              }
{           BaseForm.FrameBoxText                                              }
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
unit FrameBoxText;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.ScrollBox, FMX.Memo, FMX.Effects, FMX.Objects, FMX.Controls.Presentation,
  FMX.Edit, FMX.Layouts, FMX.Filter.Effects;

type
  TfrmFrameBoxText = class(TFrame)
    rctBoxText: TRectangle;
    lytBoxText: TLayout;
    edtBoxTextMD5Value: TEdit;
    txtBoxTextMD5Title: TText;
    lytFooterBoxText: TLayout;
    rctFooterBoxText: TRectangle;
    seFooterBoxText: TShadowEffect;
    txtFooterBoxTextBytes: TText;
    mmoBoxText: TMemo;
    FooterBoxTextCopy: TPath;
    freFooterBoxTextCopy: TFillRGBEffect;
    FooterBoxTextTrash: TPath;
    freFooterBoxTextTrash: TFillRGBEffect;
    FooterBoxTextProcessOnlie: TPath;
    freFooterBoxTextProcessOnlie: TFillRGBEffect;
    BoxTextMD5ValueCopy: TPath;
    freBoxTextMD5ValueCopy: TFillRGBEffect;
    BoxTextMD5ValueMD5Check: TPath;
    freBoxTextMD5ValueMD5Check: TFillRGBEffect;
    procedure mmoBoxTextChangeTracking(Sender: TObject);
    procedure mmoBoxTextChange(Sender: TObject);
    procedure FooterBoxTextTrashClick(Sender: TObject);
    procedure FooterBoxTextCopyClick(Sender: TObject);
    procedure FooterBoxTextProcessOnlieClick(Sender: TObject);
    procedure BoxTextMD5ValueMD5CheckClick(Sender: TObject);
    procedure BoxTextMD5ValueCopyClick(Sender: TObject);
  private
    { Private declarations }
    procedure SetText(const Value: string);
    function GetText: string;
    procedure SetMD5(const Value: string);
    function GetMD5: string;
  public
    { Public declarations }
    procedure Clear;
    property Text: string read GetText write SetText;
    property MD5: string read GetMD5 write SetMD5;
  end;

implementation

{$R *.fmx}

uses
  Utils;

procedure TfrmFrameBoxText.mmoBoxTextChange(Sender: TObject);
begin
  if (TMemo(Sender).Text.Length = 0) then
    edtBoxTextMD5Value.Text := EmptyStr;
end;

procedure TfrmFrameBoxText.mmoBoxTextChangeTracking(Sender: TObject);
var
  lLengthText: Int64;
begin
  lLengthText := TMemo(Sender).Text.Length;
  txtFooterBoxTextBytes.Text := Format('%.3d :: %s', [lLengthText, ConvertBytes(lLengthText)]);
  edtBoxTextMD5Value.Text := EmptyStr;
end;

procedure TfrmFrameBoxText.SetText(const Value: string);
begin
  mmoBoxText.BeginUpdate;
  try
    mmoBoxText.Lines.Clear;
    mmoBoxText.Text := Format('%s', [Value]);
  finally
    mmoBoxText.EndUpdate;
  end;
end;

function TfrmFrameBoxText.GetText: string;
begin
  Result := Format('%s', [mmoBoxText.Text]);
end;

procedure TfrmFrameBoxText.BoxTextMD5ValueCopyClick(Sender: TObject);
begin
  ClipboardText(edtBoxTextMD5Value.Text);
end;

procedure TfrmFrameBoxText.BoxTextMD5ValueMD5CheckClick(Sender: TObject);
begin
  OpenURL('https://www.md5hashgenerator.com');
end;

procedure TfrmFrameBoxText.Clear;
begin
  edtBoxTextMD5Value.Text := EmptyStr;
  mmoBoxText.BeginUpdate;
  try
    mmoBoxText.Lines.Clear;
  finally
    mmoBoxText.EndUpdate;
  end;
end;

procedure TfrmFrameBoxText.FooterBoxTextCopyClick(Sender: TObject);
begin
  ClipboardText(Format('%s', [mmoBoxText.Text]));
end;

procedure TfrmFrameBoxText.FooterBoxTextProcessOnlieClick(Sender: TObject);
begin
  OpenURL('http://www.txtwizard.net/compression');
end;

procedure TfrmFrameBoxText.FooterBoxTextTrashClick(Sender: TObject);
begin
  mmoBoxText.Lines.Clear;
end;

function TfrmFrameBoxText.GetMD5: string;
begin
  Result := edtBoxTextMD5Value.Text;
end;

procedure TfrmFrameBoxText.SetMD5(const Value: string);
begin
  edtBoxTextMD5Value.Text := EmptyStr;
  edtBoxTextMD5Value.Text := Value;
end;

end.
