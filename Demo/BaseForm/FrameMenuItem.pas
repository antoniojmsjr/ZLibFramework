{******************************************************************************}
{                                                                              }
{           BaseForm.FrameMenuItem                                             }
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
unit FrameMenuItem;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Layouts, FMX.Effects, FMX.Filter.Effects;

type
  TfrmFrameMenuItem = class(TFrame)
    lytMain: TLayout;
    lytImage: TLayout;
    lytDescription: TLayout;
    txtTitle: TText;
    imgMain: TImage;
    txtDetail: TText;
    FillRGBEffect1: TFillRGBEffect;
    lnDivision: TLine;
    FillRGBEffect2: TFillRGBEffect;
  private
    { Private declarations }
    procedure SetTitle(const Value: string);
    function GetTitle: string;
    function GetDetail: string;
    procedure SetDetail(const Value: string);
  public
    { Public declarations }
    property Title: string read GetTitle write SetTitle;
    property Detail: string read GetDetail write SetDetail;
  end;

implementation

{$R *.fmx}

{ TfrmFrameMenuItem }

function TfrmFrameMenuItem.GetDetail: string;
begin
  Result := txtDetail.Text;
end;

function TfrmFrameMenuItem.GetTitle: string;
begin
  Result := txtTitle.Text;
end;

procedure TfrmFrameMenuItem.SetDetail(const Value: string);
begin
  txtDetail.Text := Value.Trim;
end;

procedure TfrmFrameMenuItem.SetTitle(const Value: string);
begin
  txtTitle.Text := Value.Trim;
end;

end.
