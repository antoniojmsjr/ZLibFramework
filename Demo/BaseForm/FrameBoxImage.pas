{******************************************************************************}
{                                                                              }
{           BaseForm.FrameBoxImage                                             }
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
unit FrameBoxImage;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Filter.Effects, FMX.Effects, FMX.Objects, FMX.Controls.Presentation,
  FMX.Edit, FMX.Layouts;

type
  TfrmFrameBoxImage = class(TFrame)
    rctBoxImage: TRectangle;
    lytBoxImage: TLayout;
    edtBoxImageMD5Value: TEdit;
    txtBoxImageMD5Title: TText;
    lytFooterBoxImage: TLayout;
    rctFooterBoxImage: TRectangle;
    seFooterBoxImage: TShadowEffect;
    txtFooterBoxImageBytes: TText;
    imgBox: TImage;
    odFile: TOpenDialog;
    BoxImageLoadImage: TPath;
    freBoxImageLoadImage: TFillRGBEffect;
    BoxImageMD5ValueCopy: TPath;
    freBoxImageMD5ValueCopy: TFillRGBEffect;
    BoxImageMD5Check: TPath;
    freBoxImageMD5Check: TFillRGBEffect;
    procedure BoxImageLoadImageClick(Sender: TObject);
    procedure BoxImageMD5ValueCopyClick(Sender: TObject);
    procedure BoxImageMD5CheckClick(Sender: TObject);
  private
    { Private declarations }
    FImage: TStream;
    FOnChangeImage: TNotifyEvent;
    FLoadImage: Boolean;
    FFileName: string;
    function GetSizeImage: Int64;
    procedure StreamToBitmap;
    procedure SetImage(const Value: TStream);
    function GetMD5: string;
    procedure SetMD5(const Value: string);
    procedure SetOnChangeImage(const Value: TNotifyEvent);
    procedure SetLoadImage(const Value: Boolean);
    procedure GetInfoImage;
    function GetFile: TFilename;
  public
    { Public declarations }
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    procedure LoadImageFromTImage;
    property LoadImage: Boolean read FLoadImage write SetLoadImage;
    property Image: TStream read FImage write SetImage;
    property &File: TFilename read GetFile;
    property MD5: string read GetMD5 write SetMD5;
    property OnChangeImage: TNotifyEvent read FOnChangeImage write SetOnChangeImage;
  end;

implementation

{$R *.fmx}

uses
  Utils, FMX.MultiResBitmap;

{ TfrmFrameBoxImage }

procedure TfrmFrameBoxImage.AfterConstruction;
begin
  inherited;
  FImage := TMemoryStream.Create;
  LoadImage := True;
end;

procedure TfrmFrameBoxImage.BeforeDestruction;
begin
  if Assigned(FImage) then
    FImage.Free;
  inherited;
end;

procedure TfrmFrameBoxImage.BoxImageLoadImageClick(Sender: TObject);
begin
  FFileName := EmptyStr;
  if not odFile.Execute then
    Exit;

  FFileName := odFile.FileName;

  TMemoryStream(FImage).Clear;
  TMemoryStream(FImage).LoadFromFile(FFileName);

  StreamToBitmap;

  if Assigned(FOnChangeImage) then
    FOnChangeImage(Self);

  GetInfoImage;
end;

procedure TfrmFrameBoxImage.BoxImageMD5ValueCopyClick(Sender: TObject);
begin
  ClipboardText(edtBoxImageMD5Value.Text);
end;

procedure TfrmFrameBoxImage.BoxImageMD5CheckClick(Sender: TObject);
begin
  OpenURL('https://emn178.github.io/online-tools/md5_checksum.html');
end;

function TfrmFrameBoxImage.GetFile: TFilename;
begin
  Result := FFileName
end;

procedure TfrmFrameBoxImage.GetInfoImage;
var
  lSizeImage: Int64;
begin
  lSizeImage := GetSizeImage;
  txtFooterBoxImageBytes.Text := Format('%.3d :: %s', [lSizeImage, ConvertBytes(lSizeImage)]);
end;

function TfrmFrameBoxImage.GetMD5: string;
begin
  Result := edtBoxImageMD5Value.Text;
end;

function TfrmFrameBoxImage.GetSizeImage: Int64;
begin
  FImage.Seek(0, TSeekOrigin.soBeginning);
  Result := FImage.Size;
end;

procedure TfrmFrameBoxImage.LoadImageFromTImage;
begin
  TMemoryStream(FImage).Clear;
  imgBox.Bitmap.SaveToStream(FImage);

  if Assigned(FOnChangeImage) then
    FOnChangeImage(Self);

  GetInfoImage;
end;

procedure TfrmFrameBoxImage.SetImage(const Value: TStream);
begin
  TMemoryStream(FImage).Clear;
  TMemoryStream(FImage).LoadFromStream(Value);
  StreamToBitmap;
  GetInfoImage;
end;

procedure TfrmFrameBoxImage.SetLoadImage(const Value: Boolean);
begin
  FLoadImage := Value;
  BoxImageLoadImage.Visible := FLoadImage;
end;

procedure TfrmFrameBoxImage.SetMD5(const Value: string);
begin
  edtBoxImageMD5Value.Text := EmptyStr;
  edtBoxImageMD5Value.Text := Value;
end;

procedure TfrmFrameBoxImage.SetOnChangeImage(const Value: TNotifyEvent);
begin
  FOnChangeImage := Value;
end;

procedure TfrmFrameBoxImage.StreamToBitmap;
var
  lItem: TCustomBitmapItem;
begin
  if (FImage.Size = 0) then
    Exit;

  imgBox.MultiResBitmap.Clear;
  lItem := imgBox.MultiResBitmap.ItemByScale(1, False, True);
  lItem.Bitmap.LoadFromStream(FImage);

  if Assigned(FOnChangeImage) then
    FOnChangeImage(Self);
end;

end.
