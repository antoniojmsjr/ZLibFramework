{******************************************************************************}
{                                                                              }
{           Demo.Base64VsZLibFrameworkStreamingImage                           }
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
unit Base64VsZLibFrameworkStreamingImage;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FormBase,
  FMX.Layouts, FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo, FMX.Objects,
  FrameExecute, FMX.Edit, FMX.StdCtrls, FrameBoxImage, FrameBoxText;

type
  TfrmBase64VsZLibFrameworkStreamingImage = class(TfrmFormBase)
    lytAbout: TLayout;
    crtAbout: TCalloutRectangle;
    mmoAbout: TMemo;
    lytDemo: TLayout;
    vsbDemo: TVertScrollBox;
    lytStreamingDownload: TLayout;
    txtStreamingURL: TText;
    edtStreamingURL: TEdit;
    sbStreamingDownload: TSpeedButton;
    lnStreamingLineBottom: TLine;
    lnStreamingLineTop: TLine;
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
    frmFrameExecuteEncodeBase64: TfrmFrameExecute;
    frmFrameBoxImageBase64Input: TfrmFrameBoxImage;
    frmFrameBoxTextBase64Result: TfrmFrameBoxText;
    StyleBook1: TStyleBook;
    gplDemoZLibCompress: TGridPanelLayout;
    lyZLibFrameworkCell1: TLayout;
    lyZLibFrameworkCell2: TLayout;
    lyZLibFrameworkCell3: TLayout;
    lytZLibFrameworkRectangleTitle: TLayout;
    crtZLibFrameworkRectangleTitle: TCalloutRectangle;
    txtZLibFrameworkRectangleTitle: TText;
    ZLibFrameworkTitle: TLayout;
    txtZLibFrameworkTitle: TText;
    lyZLibFrameworkCell4: TLayout;
    frmFrameBoxImageZLibFrameworkInput: TfrmFrameBoxImage;
    lyZLibFrameworkCell5: TLayout;
    frmFrameBoxTextZLibFrameworkResult: TfrmFrameBoxText;
    lyZLibFrameworkCell6: TLayout;
    frmFrameExecuteEncodeZLibFramework: TfrmFrameExecute;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure sbStreamingDownloadClick(Sender: TObject);
  private
    { Private declarations }
    FImageDownload: TBytesStream;
    procedure Download;
    procedure OnChangeImageBase64(Sender: TObject);
    procedure OnChangeImageZLibCompress(Sender: TObject);
    procedure EncodeBase64(const pEncoding: TEncoding);
    procedure EncodeZLibCompress(const pEncoding: TEncoding);
  public
    { Public declarations }
  end;

var
  frmBase64VsZLibFrameworkStreamingImage: TfrmBase64VsZLibFrameworkStreamingImage;

implementation

uses
  REST.Client, System.NetEncoding, System.Hash, ZLibFramework,
  ZLibFramework.Types;

{$R *.fmx}

{ TfrmBase64VsZLibCompressStreamingImage }

procedure TfrmBase64VsZLibFrameworkStreamingImage.FormCreate(Sender: TObject);
begin
  inherited;
  FImageDownload := TBytesStream.Create;

  frmFrameExecuteEncodeBase64.Execute := EncodeBase64;
  frmFrameExecuteEncodeZLibFramework.Execute := EncodeZLibCompress;

  frmFrameBoxImageBase64Input.LoadImage := False;
  frmFrameBoxImageZLibFrameworkInput.LoadImage := False;
  frmFrameBoxImageBase64Input.OnChangeImage := OnChangeImageBase64;
  frmFrameBoxImageZLibFrameworkInput.OnChangeImage := OnChangeImageZLibCompress;

  Download;
end;

procedure TfrmBase64VsZLibFrameworkStreamingImage.FormDestroy(Sender: TObject);
begin
  FImageDownload.Free;
  inherited;
end;

procedure TfrmBase64VsZLibFrameworkStreamingImage.Download;
begin
  FImageDownload.Clear;
  TDownloadURL.DownloadRawBytes(edtStreamingURL.Text.Trim, FImageDownload);

  frmFrameBoxImageBase64Input.Image := FImageDownload;
  frmFrameBoxImageZLibFrameworkInput.Image := FImageDownload;
end;

procedure TfrmBase64VsZLibFrameworkStreamingImage.EncodeBase64(const pEncoding: TEncoding);
var
  lInput: TBytesStream;
  lResult: string;
  lMD5Result: string;
  lBase64Encoding: TBase64Encoding;
  lImageBytes: TBytes;
begin
  lInput := TBytesStream.Create;
  try
    lInput.LoadFromStream(frmFrameBoxImageBase64Input.Image);

    lBase64Encoding := TBase64Encoding.Create(0);
    try
      lInput.Position := 0;
      lImageBytes := Copy(lInput.Bytes, 0, lInput.Size);
      lResult := lBase64Encoding.EncodeBytesToString(lImageBytes);
    finally
      lBase64Encoding.Free;
    end;

    frmFrameBoxImageBase64Input.MD5 := THashMD5.GetHashString(lResult);

    //RESULT
    lMD5Result := THashMD5.GetHashString(lResult);
    frmFrameBoxTextBase64Result.Text := lResult;
    frmFrameBoxTextBase64Result.MD5 := lMD5Result;

  finally
    lInput.Free;
  end;
end;

procedure TfrmBase64VsZLibFrameworkStreamingImage.EncodeZLibCompress(
  const pEncoding: TEncoding);
var
  lImage: TMemoryStream;
  lResultCompress: IZLibResult;
begin
  lImage := TMemoryStream.Create;
  try
    lImage.Size := frmFrameBoxImageZLibFrameworkInput.Image.Size;
    lImage.LoadFromStream(frmFrameBoxImageZLibFrameworkInput.Image);

    TZLib
      .Base64
        .Compress
          .Deflate
            .Level(TZLibCompressionLevelType.Max)
              .LoadFromStream(lImage, lResultCompress);

    frmFrameBoxImageZLibFrameworkInput.MD5 := lResultCompress.MD5Input;

    //RESULT
    frmFrameBoxTextZLibFrameworkResult.Text := lResultCompress.Text[TEncoding.UTF8];
    frmFrameBoxTextZLibFrameworkResult.MD5 := lResultCompress.MD5Result;
  finally
    lImage.Free;
  end;
end;

procedure TfrmBase64VsZLibFrameworkStreamingImage.OnChangeImageBase64(
  Sender: TObject);
begin
  frmFrameBoxTextBase64Result.Clear;
end;

procedure TfrmBase64VsZLibFrameworkStreamingImage.OnChangeImageZLibCompress(
  Sender: TObject);
begin
  frmFrameBoxTextZLibFrameworkResult.Clear;
end;

procedure TfrmBase64VsZLibFrameworkStreamingImage.sbStreamingDownloadClick(
  Sender: TObject);
begin
  Download;
end;

end.
