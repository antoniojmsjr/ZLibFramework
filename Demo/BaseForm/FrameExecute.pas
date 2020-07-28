{******************************************************************************}
{                                                                              }
{           BaseForm.FrameExecute                                              }
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
unit FrameExecute;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.Controls.Presentation, FMX.Objects, FMX.Effects,
  FMX.Filter.Effects, FMX.Menus, FMX.TabControl;

type
  TOnExecute = reference to procedure(const pEncoding: TEncoding);

  TfrmFrameExecute = class(TFrame)
    lytMain: TLayout;
    lytButton: TLayout;
    imgExecute: TImage;
    sbExecute: TSpeedButton;
    feExecute: TFillRGBEffect;
    ppmExecute: TPopupMenu;
    mniEncodingUTF8: TMenuItem;
    mniEncodingANSI: TMenuItem;
    mniEncodingASCII: TMenuItem;
    mniEncodingUTF7: TMenuItem;
    mniEncodingUnicode: TMenuItem;
    mniEncodingBigEndianUnicode: TMenuItem;
    tbcOptionExecute: TTabControl;
    tbiOption1: TTabItem;
    tbiOption2: TTabItem;
    gplOption2: TGridPanelLayout;
    lytCell1: TLayout;
    lytCell2: TLayout;
    lytCell3: TLayout;
    Text1: TText;
    FillRGBEffect1: TFillRGBEffect;
    Path4: TPath;
    FillRGBEffect2: TFillRGBEffect;
    Path5: TPath;
    Path6: TPath;
    Path1: TPath;
    Path2: TPath;
    Path3: TPath;
    procedure sbExecuteClick(Sender: TObject);
    procedure mniEncodingUTF8Click(Sender: TObject);
    procedure mniEncodingANSIClick(Sender: TObject);
    procedure mniEncodingASCIIClick(Sender: TObject);
    procedure mniEncodingUTF7Click(Sender: TObject);
    procedure mniEncodingUnicodeClick(Sender: TObject);
    procedure mniEncodingBigEndianUnicodeClick(Sender: TObject);
  private
    { Private declarations }
    FExecute: TOnExecute;
    FEncoding: TEncoding;
    FOptionExecute: Integer;
    procedure SetOptionExecute(const Value: Integer);
  public
    { Public declarations }
    procedure AfterConstruction; override;
     property Execute: TOnExecute read FExecute write FExecute;
     property Encoding: TEncoding read FEncoding write FEncoding;
     property OptionExecute: Integer read FOptionExecute write SetOptionExecute;
  end;

implementation

{$R *.fmx}

{ TfrmFrameExecute }

procedure TfrmFrameExecute.AfterConstruction;
begin
  inherited;
  FEncoding := TEncoding.UTF8;
  tbcOptionExecute.TabPosition := TTabPosition.None;
  tbcOptionExecute.ActiveTab := tbiOption1;
end;

procedure TfrmFrameExecute.mniEncodingANSIClick(Sender: TObject);
begin
  if Assigned(FExecute) then
    FExecute(TEncoding.ANSI);
end;

procedure TfrmFrameExecute.mniEncodingASCIIClick(Sender: TObject);
begin
  if Assigned(FExecute) then
    FExecute(TEncoding.ASCII);
end;

procedure TfrmFrameExecute.mniEncodingBigEndianUnicodeClick(Sender: TObject);
begin
  if Assigned(FExecute) then
    FExecute(TEncoding.BigEndianUnicode);
end;

procedure TfrmFrameExecute.mniEncodingUnicodeClick(Sender: TObject);
begin
  if Assigned(FExecute) then
    FExecute(TEncoding.Unicode);
end;

procedure TfrmFrameExecute.mniEncodingUTF7Click(Sender: TObject);
begin
    if Assigned(FExecute) then
    FExecute(TEncoding.UTF7);
end;

procedure TfrmFrameExecute.mniEncodingUTF8Click(Sender: TObject);
begin
  if Assigned(FExecute) then
    FExecute(TEncoding.UTF8);
end;

procedure TfrmFrameExecute.sbExecuteClick(Sender: TObject);
begin
  if Assigned(FExecute) then
    FExecute(FEncoding);
end;

procedure TfrmFrameExecute.SetOptionExecute(const Value: Integer);
begin
  FOptionExecute := Value;
  case FOptionExecute of
    1: tbcOptionExecute.ActiveTab := tbiOption1;
    2: tbcOptionExecute.ActiveTab := tbiOption2;
  else
    tbcOptionExecute.ActiveTab := tbiOption1;
  end;
end;

end.
