{******************************************************************************}
{                                                                              }
{           BaseForm.FrameBoxOpenFile                                          }
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
unit FrameBoxOpenFile;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.Objects, FMX.Controls.Presentation, FMX.Edit, FMX.Effects,
  FMX.Filter.Effects, FMX.ListBox;

type
  TfrmFrameBoxOpenFile = class(TFrame)
    lytOpenFile: TLayout;
    odFile: TOpenDialog;
    lytMD5: TLayout;
    edtBoxOpenFileMD5Value: TEdit;
    txtBoxOpenFileMD5Title: TText;
    rctOpenFile: TRectangle;
    lbFile: TListBox;
    lbiHeader: TListBoxItem;
    lytHeader: TLayout;
    rctHeader: TRectangle;
    gplHeader: TGridPanelLayout;
    lytHeaderCell1: TLayout;
    txtHeaderCell1: TText;
    lytHeaderCell2: TLayout;
    lytButtonOpenFile: TLayout;
    imgButtonOpenFile: TImage;
    feButtonOpenFile: TFillRGBEffect;
    sbButtonOpenFile: TSpeedButton;
    lbiDivision: TListBoxItem;
    lbiFilePath: TListBoxItem;
    lytFilePath: TLayout;
    txtFilePathTitle: TText;
    txtFilePathValue: TText;
    lbiFileName: TListBoxItem;
    lytFileName: TLayout;
    txtFileNameTitle: TText;
    txtFileNameValue: TText;
    lbiFileExtension: TListBoxItem;
    lytFileExtension: TLayout;
    txtFileExtensionTitle: TText;
    txtFileExtensionValue: TText;
    lbiFileDateTime: TListBoxItem;
    lytFileDateTime: TLayout;
    txtFileDateTimeTitle: TText;
    txtFileDateTimeValue: TText;
    lbiFileSize: TListBoxItem;
    lytFileSize: TLayout;
    txtFileSizeTitle: TText;
    txtFileSizeValue: TText;
    BoxOpenFileMD5Copy: TPath;
    freBoxOpenFileMD5Copy: TFillRGBEffect;
    BoxOpenFileMD5Check: TPath;
    freBoxOpenFileMD5Check: TFillRGBEffect;
    procedure sbButtonOpenFileClick(Sender: TObject);
    procedure BoxOpenFileMD5CheckClick(Sender: TObject);
    procedure BoxOpenFileMD5CopyClick(Sender: TObject);
  private
    { Private declarations }
    FFile: TFileName;
    function FileSize(const pFile: string): Int64;
    procedure GetInfoFile(const pFile: string);
    function GetMD5: string;
    procedure SetMD5(const Value: string);
  public
    { Public declarations }
    property &File: TFileName read FFile;
    property MD5: string read GetMD5 write SetMD5;
  end;

implementation

{$R *.fmx}

uses
  System.IOUtils, Utils;

procedure TfrmFrameBoxOpenFile.BoxOpenFileMD5CheckClick(Sender: TObject);
begin
  OpenURL('https://emn178.github.io/online-tools/md5_checksum.html');
end;

procedure TfrmFrameBoxOpenFile.BoxOpenFileMD5CopyClick(Sender: TObject);
begin
  ClipboardText(edtBoxOpenFileMD5Value.Text);
end;

function TfrmFrameBoxOpenFile.FileSize(const pFile: string): Int64;
var
  lFileStream: TFileStream;
begin
  lFileStream := TFileStream.Create(pFile, fmOpenRead or fmShareDenyWrite);
  try
    Result := lFileStream.Size;
  finally
    lFileStream.Free;
  end;
end;

procedure TfrmFrameBoxOpenFile.GetInfoFile(const pFile: string);
var
  lFileSize: Int64;
begin
  txtFilePathValue.Text := TPath.GetDirectoryName(pFile);
  txtFileNameValue.Text := TPath.GetFileNameWithoutExtension(pFile);
  txtFileExtensionValue.Text := TPath.GetExtension(pFile);
  txtFileDateTimeValue.Text := FormatDateTime('dd/mm/yyyy hh:mm:ss', TFile.GetCreationTime(pFile));
  lFileSize := FileSize(pFile);
  txtFileSizeValue.Text := Format('%s (%d)', [ConvertBytes(lFileSize), lFileSize]);
end;

procedure TfrmFrameBoxOpenFile.sbButtonOpenFileClick(Sender: TObject);
var
  lFile: string;
begin
  lFile := EmptyStr;
  if odFile.Execute then
    lFile := odFile.FileName;

  if lFile.Trim.IsEmpty then
    Exit;

  FFile := lFile.Trim;
  GetInfoFile(lFile);

  edtBoxOpenFileMD5Value.Text := EmptyStr;
end;

function TfrmFrameBoxOpenFile.GetMD5: string;
begin
  Result := edtBoxOpenFileMD5Value.Text;
end;


procedure TfrmFrameBoxOpenFile.SetMD5(const Value: string);
begin
  edtBoxOpenFileMD5Value.Text := EmptyStr;
  edtBoxOpenFileMD5Value.Text := Value;
end;


end.
