{******************************************************************************}
{                                                                              }
{           BaseForm.ChildBase                                                 }
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
unit ChildBase;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FormBase, ZLibFramework.Types;

type
  TfrmChildBase = class(TfrmFormBase)
    gplContainer: TGridPanelLayout;
    lytCell1: TLayout;
    lytCell2: TLayout;
    lytCell3: TLayout;
    lytCell4: TLayout;
    lytCell5: TLayout;
    lytCell6: TLayout;
    lytCell7: TLayout;
    lytCell8: TLayout;
    StyleBookMain: TStyleBook;
  private
    { Private declarations }
    FMode: TZLibModeType;
    FAlgorithm: TZLibAlgorithmType;
    FOperation: TZLibOperationType;
    procedure SetAlgorithm(const Value: TZLibAlgorithmType);
    procedure SetOperation(const Value: TZLibOperationType);
  protected
    { Private declarations }
    procedure SetMode(const Value: TZLibModeType); virtual;
  public
    { Public declarations }
    property Mode: TZLibModeType read FMode write SetMode;
    property Operation: TZLibOperationType read FOperation write SetOperation;
    property Algorithm: TZLibAlgorithmType read FAlgorithm write SetAlgorithm;
  end;

implementation

{$R *.fmx}

{ TfrmChildBase }

procedure TfrmChildBase.SetAlgorithm(const Value: TZLibAlgorithmType);
begin
  FAlgorithm := Value;
end;

procedure TfrmChildBase.SetMode(const Value: TZLibModeType);
begin
  FMode := Value;
end;

procedure TfrmChildBase.SetOperation(const Value: TZLibOperationType);
begin
  FOperation := Value;
end;

end.
