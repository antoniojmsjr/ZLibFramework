{******************************************************************************}
{                                                                              }
{           Demo.Main                                                          }
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
unit Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.Controls.Presentation, FMX.MultiView, FMX.Objects,
  FMX.ListBox, FMX.Effects, FMX.Filter.Effects, FMX.ScrollBox,
  FMX.Memo, FrameMenuItem, ProcessText, ProcessFile, ProcessImage, FrameExecute;

const
  cURLGitHub = 'https://github.com/antoniojmsjr/zlibframework';

type
  TfrmMain = class(TForm)
    mvMenu: TMultiView;
    lytMain: TLayout;
    tbMain: TToolBar;
    lytMenu: TLayout;
    sbMenu: TSpeedButton;
    rtgMenuBackground: TRectangle;
    lblMenuTitulo: TLabel;
    rtgToolbar: TRectangle;
    seToolBar: TShadowEffect;
    sbInfo: TSpeedButton;
    FillRGBEffect3: TFillRGBEffect;
    FillRGBEffect4: TFillRGBEffect;
    lytLogoMain: TLayout;
    lytLogoMainContainer: TLayout;
    lytLogoMainContainerInternal: TLayout;
    txtLogoMainTitle: TText;
    txtLogoMainLink: TText;
    imgLogoMain: TImage;
    lytLogo: TLayout;
    rctLogoBackgrounbd: TRectangle;
    txtLogoTitle: TText;
    lnLogo: TLine;
    txtLogoLink: TText;
    imgLogo: TImage;
    lbMenu: TListBox;
    lbiAbout: TListBoxItem;
    frmFrameMenuItemAbout: TfrmFrameMenuItem;
    lbiBase64VsZLibFrameworkText: TListBoxItem;
    frmFrameMenuItemBase64VsZLibFrameworkText: TfrmFrameMenuItem;
    lbiBase64VsZLibFrameworkStreamingImage: TListBoxItem;
    frmFrameMenuItemBase64VsZLibFrameworkStreamingImage: TfrmFrameMenuItem;
    erMenuCompressionBase64: TExpander;
    erMenuCompressionBase64Deflate: TExpander;
    lbMenuCompressionBase64DeflateMenu: TListBox;
    lbiMenuBase64DeflateText: TListBoxItem;
    lbiMenuBase64DeflateFile: TListBoxItem;
    lbiMenuBase64DeflateImage: TListBoxItem;
    StyleBook1: TStyleBook;
    frmFrameMenuItemBase64DeflateText: TfrmFrameMenuItem;
    frmFrameMenuItemBase64DeflateFile: TfrmFrameMenuItem;
    frmFrameMenuItemBase64DeflateImage: TfrmFrameMenuItem;
    lbiZlibFrameworkMD5: TListBoxItem;
    frmFrameMenuItemZLibFrameworkMD5: TfrmFrameMenuItem;
    erMenuCompressionBase64GZip: TExpander;
    lbMenuCompressionBase64GZipMenu: TListBox;
    lbiMenuBase64GZipText: TListBoxItem;
    frmFrameMenuItemBase64GZipText: TfrmFrameMenuItem;
    lbiMenuBase64GZipFile: TListBoxItem;
    frmFrameMenuItemBase64GZipFile: TfrmFrameMenuItem;
    lbiMenuBase64GZipImage: TListBoxItem;
    frmFrameMenuItemBase64GZipImage: TfrmFrameMenuItem;
    erMenuCompressionData: TExpander;
    erMenuCompressionDataDeflate: TExpander;
    lbMenuCompressionDataDeflateMenu: TListBox;
    lbiMenuDataDeflateText: TListBoxItem;
    frmFrameMenuItemDataDeflateText: TfrmFrameMenuItem;
    lbiMenuDataDeflateFile: TListBoxItem;
    frmFrameMenuItemDataDeflateFile: TfrmFrameMenuItem;
    lbiMenuDataDeflateImage: TListBoxItem;
    frmFrameMenuItemDataDeflateImage: TfrmFrameMenuItem;
    erMenuCompressionDataGZip: TExpander;
    lbMenuCompressionDataGZipMenu: TListBox;
    lbiMenuDataGZipText: TListBoxItem;
    frmFrameMenuItemDataGZipText: TfrmFrameMenuItem;
    lbiMenuDataGZipFile: TListBoxItem;
    frmFrameMenuItemDataGZipFile: TfrmFrameMenuItem;
    lbiMenuDataGZipImage: TListBoxItem;
    frmFrameMenuItemDataGZipImage: TfrmFrameMenuItem;
    procedure lbMenuItemClick(const Sender: TCustomListBox;
      const Item: TListBoxItem);
    procedure Text2Click(Sender: TObject);
    procedure Text4Click(Sender: TObject);
    procedure sbInfoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure lbiAboutClick(Sender: TObject);
    procedure lbiBase64VsZLibFrameworkTextClick(Sender: TObject);
    procedure lbiBase64VsZLibFrameworkStreamingImageClick(Sender: TObject);
    procedure lbMenuCompressionBase64DeflateMenuItemClick(
      const Sender: TCustomListBox; const Item: TListBoxItem);
    procedure lbiMenuBase64DeflateTextClick(Sender: TObject);
    procedure lbiMenuBase64DeflateFileClick(Sender: TObject);
    procedure lbiMenuBase64DeflateImageClick(Sender: TObject);
    procedure lbiZlibFrameworkMD5Click(Sender: TObject);
    procedure lbiMenuBase64GZipTextClick(Sender: TObject);
    procedure lbMenuCompressionBase64GZipMenuItemClick(
      const Sender: TCustomListBox; const Item: TListBoxItem);
    procedure lbiMenuBase64GZipFileClick(Sender: TObject);
    procedure lbiMenuBase64GZipImageClick(Sender: TObject);
    procedure lb(const Sender: TCustomListBox;
      const Item: TListBoxItem);
    procedure lbiMenuDataDeflateTextClick(Sender: TObject);
    procedure erMenuCompressionBase64DeflateExpandedChanging(Sender: TObject);
    procedure erMenuCompressionBase64GZipExpandedChanging(Sender: TObject);
    procedure lbiMenuDataDeflateFileClick(Sender: TObject);
    procedure lbiMenuDataDeflateImageClick(Sender: TObject);
    procedure lbMenuCompressionDataGZipMenuItemClick(
      const Sender: TCustomListBox; const Item: TListBoxItem);
    procedure lbMenuCompressionDataDeflateMenuItemClick(
      const Sender: TCustomListBox; const Item: TListBoxItem);
    procedure lbiMenuDataGZipTextClick(Sender: TObject);
    procedure lbiMenuDataGZipFileClick(Sender: TObject);
    procedure lbiMenuDataGZipImageClick(Sender: TObject);
    procedure txtLogoMainLinkClick(Sender: TObject);
    procedure txtLogoLinkClick(Sender: TObject);
  private
    { Private declarations }
    FURLInfo: string;
    FProcessTextBase64Deflate: TfrmProcessText;
    FProcessTextBase64GZip: TfrmProcessText;
    FProcessFileBase64Deflate: TfrmProcessFile;
    FProcessFileBase64GZip: TfrmProcessFile;
    FProcessImageBase64Deflate: TfrmProcessImage;
    FProcessImageBase64GZip: TfrmProcessImage;

    FProcessTextDataDeflate: TfrmProcessText;
    FProcessTextDataGZip: TfrmProcessText;
    FProcessFileDataDeflate: TfrmProcessFile;
    FProcessFileDataGZip: TfrmProcessFile;
    FProcessImageDataDeflate: TfrmProcessImage;
    FProcessImageDataGZip: TfrmProcessImage;
    procedure InfoSamples(const pTitle: string; const pURL: string);
    procedure LayoutAddObject(const pObject: TFmxObject);
    procedure OnException(Sender: TObject; E: Exception);
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses
  Utils, ZLibFramework.Types, About, ZLibFrameworkMD5, Base64VsZLibFrameworkText,
  Base64VsZLibFrameworkStreamingImage;

{$R *.fmx}

procedure TfrmMain.erMenuCompressionBase64GZipExpandedChanging(Sender: TObject);
begin
  erMenuCompressionBase64.BeginUpdate;
  try
    if erMenuCompressionBase64GZip.IsExpanded then
      erMenuCompressionBase64.Height := (erMenuCompressionBase64.Height - 150)
    else
      erMenuCompressionBase64.Height := (erMenuCompressionBase64.Height + 150);
  finally
    erMenuCompressionBase64.EndUpdate;
  end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
{$IFDEF MSWINDOWS}
var
  lRect: TRectF;
{$ENDIF}
begin
  FURLInfo := cURLGitHub;

  {$IFDEF MSWINDOWS}
  lRect := TRectF.Create(Screen.WorkAreaRect.TopLeft, Screen.WorkAreaRect.Width,
                         Screen.WorkAreaRect.Height);
  SetBounds(Round(lRect.Left + (lRect.Width - Width) / 2),
            0,
            Width,
            Screen.WorkAreaRect.Height);
  {$ENDIF}
  Application.OnException := OnException;
end;

procedure TfrmMain.FormResize(Sender: TObject);
begin
  {$IFDEF MSWINDOWS}
  if (Self.Width < 1015) then
  begin
    Self.Width := 1015;
    Abort;
  end;
  {$ENDIF}
end;

procedure TfrmMain.InfoSamples(const pTitle, pURL: string);
begin
  FURLInfo := pURL;
  lblMenuTitulo.Text := pTitle;
end;

procedure TfrmMain.LayoutAddObject(const pObject: TFmxObject);
var
  lFmxObject: TFmxObject;
begin
  for lFmxObject in Self.lytMain.Children do
  begin
    if (lFmxObject is TLayout) then
      TLayout(lFmxObject).Visible := False;
  end;

  if not Self.lytMain.ContainsObject(pObject) then
    Self.lytMain.AddObject(pObject);

  TLayout(pObject).Visible := True;
  Self.lytMain.BringChildToFront(pObject);
end;

procedure TfrmMain.erMenuCompressionBase64DeflateExpandedChanging(
  Sender: TObject);
begin
  erMenuCompressionBase64.BeginUpdate;
  try
    if erMenuCompressionBase64Deflate.IsExpanded then
      erMenuCompressionBase64.Height := (erMenuCompressionBase64.Height - 150)
    else
      erMenuCompressionBase64.Height := (erMenuCompressionBase64.Height + 150);
  finally
    erMenuCompressionBase64.EndUpdate;
  end;
end;

procedure TfrmMain.lbMenuCompressionBase64DeflateMenuItemClick(
  const Sender: TCustomListBox; const Item: TListBoxItem);
begin
  Item.IsSelected := False;
  mvMenu.HideMaster;
end;

procedure TfrmMain.lbMenuCompressionBase64GZipMenuItemClick(
  const Sender: TCustomListBox; const Item: TListBoxItem);
begin
  Item.IsSelected := False;
  mvMenu.HideMaster;
end;

procedure TfrmMain.lbMenuCompressionDataDeflateMenuItemClick(
  const Sender: TCustomListBox; const Item: TListBoxItem);
begin
  Item.IsSelected := False;
  mvMenu.HideMaster;
end;

procedure TfrmMain.lbMenuCompressionDataGZipMenuItemClick(
  const Sender: TCustomListBox; const Item: TListBoxItem);
begin
  Item.IsSelected := False;
  mvMenu.HideMaster;
end;

procedure TfrmMain.lbMenuItemClick(const Sender: TCustomListBox;
  const Item: TListBoxItem);
begin
  Item.IsSelected := False;
  mvMenu.HideMaster;
end;

procedure TfrmMain.lb(const Sender: TCustomListBox;
  const Item: TListBoxItem);
begin
  Item.IsSelected := False;
  mvMenu.HideMaster;
end;

procedure TfrmMain.OnException(Sender: TObject; E: Exception);
begin
  ShowMessage(E.ToString);
end;

procedure TfrmMain.lbiAboutClick(Sender: TObject);
begin
  InfoSamples('Sobre', FURLInfo);
  if not Assigned(frmAbout) then
    frmAbout := TfrmAbout.Create(Self);

  LayoutAddObject(frmAbout.lytContainer);
end;

procedure TfrmMain.lbiBase64VsZLibFrameworkStreamingImageClick(Sender: TObject);
begin
  InfoSamples('Base64(Standard) Vs ZLibFramework :: Streaming Imagem', FURLInfo);
  if not Assigned(frmBase64VsZLibFrameworkStreamingImage) then
    frmBase64VsZLibFrameworkStreamingImage := TfrmBase64VsZLibFrameworkStreamingImage.Create(Self);

  LayoutAddObject(frmBase64VsZLibFrameworkStreamingImage.lytContainer);
end;

procedure TfrmMain.lbiBase64VsZLibFrameworkTextClick(Sender: TObject);
begin
  InfoSamples('Base64(Standard) Vs ZLibFramework :: Texto', FURLInfo);
  if not Assigned(frmBase64VsZLibFrameworkText) then
    frmBase64VsZLibFrameworkText := TfrmBase64VsZLibFrameworkText.Create(Self);

  LayoutAddObject(frmBase64VsZLibFrameworkText.lytContainer);
end;

procedure TfrmMain.lbiZlibFrameworkMD5Click(Sender: TObject);
begin
  InfoSamples('ZLibFramework :: MD5', FURLInfo);
  if not Assigned(frmZLibFrameworkMD5) then
    frmZLibFrameworkMD5 := TfrmZLibFrameworkMD5.Create(Self);

  LayoutAddObject(frmZLibFrameworkMD5.lytContainer);
end;

procedure TfrmMain.lbiMenuBase64DeflateTextClick(Sender: TObject);
begin
  InfoSamples(Format('Base64 Deflate - %s', [frmFrameMenuItemBase64DeflateText.Title]), FURLInfo);
  if not Assigned(FProcessTextBase64Deflate) then
    FProcessTextBase64Deflate := TfrmProcessText.Create(Self);

  FProcessTextBase64Deflate.Mode := TZLibModeType.Base64;
  FProcessTextBase64Deflate.Algorithm := TZLibAlgorithmType.Deflate;
  LayoutAddObject(FProcessTextBase64Deflate.lytContainer);
end;

procedure TfrmMain.lbiMenuBase64DeflateFileClick(Sender: TObject);
begin
  InfoSamples(Format('Base64 Deflate - %s', [frmFrameMenuItemBase64DeflateFile.Title]), FURLInfo);
  if not Assigned(FProcessFileBase64Deflate) then
    FProcessFileBase64Deflate := TfrmProcessFile.Create(Self);

  FProcessFileBase64Deflate.Mode := TZLibModeType.Base64;
  FProcessFileBase64Deflate.Algorithm := TZLibAlgorithmType.Deflate;
  LayoutAddObject(FProcessFileBase64Deflate.lytContainer);
end;

procedure TfrmMain.lbiMenuBase64DeflateImageClick(Sender: TObject);
begin
  InfoSamples(Format('Base64 Deflate - %s', [frmFrameMenuItemBase64DeflateImage.Title]), FURLInfo);
  if not Assigned(FProcessImageBase64Deflate) then
    FProcessImageBase64Deflate := TfrmProcessImage.Create(Self);

  FProcessImageBase64Deflate.Mode := TZLibModeType.Base64;
  FProcessImageBase64Deflate.Algorithm := TZLibAlgorithmType.Deflate;
  LayoutAddObject(FProcessImageBase64Deflate.lytContainer);
end;

procedure TfrmMain.lbiMenuBase64GZipFileClick(Sender: TObject);
begin
  InfoSamples(Format('Base64 GZip - %s', [frmFrameMenuItemBase64GZipFile.Title]), FURLInfo);
  if not Assigned(FProcessFileBase64GZip) then
    FProcessFileBase64GZip := TfrmProcessFile.Create(Self);

  FProcessFileBase64GZip.Mode := TZLibModeType.Base64;
  FProcessFileBase64GZip.Algorithm := TZLibAlgorithmType.GZip;
  LayoutAddObject(FProcessFileBase64GZip.lytContainer);
end;

procedure TfrmMain.lbiMenuBase64GZipImageClick(Sender: TObject);
begin
  InfoSamples(Format('Base64 GZip - %s', [frmFrameMenuItemBase64GZipImage.Title]), FURLInfo);
  if not Assigned(FProcessImageBase64GZip) then
    FProcessImageBase64GZip := TfrmProcessImage.Create(Self);

  FProcessImageBase64GZip.Mode := TZLibModeType.Base64;
  FProcessImageBase64GZip.Algorithm := TZLibAlgorithmType.GZip;
  LayoutAddObject(FProcessImageBase64GZip.lytContainer);
end;

procedure TfrmMain.lbiMenuBase64GZipTextClick(Sender: TObject);
begin
  InfoSamples(Format('Base64 GZip - %s', [frmFrameMenuItemBase64GZipText.Title]), FURLInfo);
  if not Assigned(FProcessTextBase64GZip) then
    FProcessTextBase64GZip := TfrmProcessText.Create(Self);

  FProcessTextBase64GZip.Mode := TZLibModeType.Base64;
  FProcessTextBase64GZip.Algorithm := TZLibAlgorithmType.GZip;
  LayoutAddObject(FProcessTextBase64GZip.lytContainer);
end;

procedure TfrmMain.lbiMenuDataDeflateFileClick(Sender: TObject);
begin
  InfoSamples(Format('Data Deflate - %s', [frmFrameMenuItemDataDeflateFile.Title]), FURLInfo);
  if not Assigned(FProcessFileDataDeflate) then
    FProcessFileDataDeflate := TfrmProcessFile.Create(Self);

  FProcessFileDataDeflate.Mode := TZLibModeType.Data;
  FProcessFileDataDeflate.Algorithm := TZLibAlgorithmType.Deflate;
  LayoutAddObject(FProcessFileDataDeflate.lytContainer);
end;

procedure TfrmMain.lbiMenuDataDeflateImageClick(Sender: TObject);
begin
  InfoSamples(Format('Data Deflate - %s', [frmFrameMenuItemDataDeflateImage.Title]), FURLInfo);
  if not Assigned(FProcessImageDataDeflate) then
    FProcessImageDataDeflate := TfrmProcessImage.Create(Self);

  FProcessImageDataDeflate.Mode := TZLibModeType.Data;
  FProcessImageDataDeflate.Algorithm := TZLibAlgorithmType.Deflate;
  LayoutAddObject(FProcessImageDataDeflate.lytContainer);
end;

procedure TfrmMain.lbiMenuDataDeflateTextClick(Sender: TObject);
begin
  InfoSamples(Format('Data Deflate - %s', [frmFrameMenuItemDataDeflateText.Title]), FURLInfo);
  if not Assigned(FProcessTextDataDeflate) then
    FProcessTextDataDeflate := TfrmProcessText.Create(Self);

  FProcessTextDataDeflate.Mode := TZLibModeType.Data;
  FProcessTextDataDeflate.Algorithm := TZLibAlgorithmType.Deflate;
  LayoutAddObject(FProcessTextDataDeflate.lytContainer);
end;

procedure TfrmMain.lbiMenuDataGZipFileClick(Sender: TObject);
begin
  InfoSamples(Format('Data GZIP - %s', [frmFrameMenuItemDataGZipFile.Title]), FURLInfo);
  if not Assigned(FProcessFileDataGZip) then
    FProcessFileDataGZip := TfrmProcessFile.Create(Self);

  FProcessFileDataGZip.Mode := TZLibModeType.Data;
  FProcessFileDataGZip.Algorithm := TZLibAlgorithmType.GZip;
  LayoutAddObject(FProcessFileDataGZip.lytContainer);
end;

procedure TfrmMain.lbiMenuDataGZipImageClick(Sender: TObject);
begin
  InfoSamples(Format('Data GZIP - %s', [frmFrameMenuItemDataGZipImage.Title]), FURLInfo);
  if not Assigned(FProcessImageDataGZip) then
    FProcessImageDataGZip := TfrmProcessImage.Create(Self);

  FProcessImageDataGZip.Mode := TZLibModeType.Data;
  FProcessImageDataGZip.Algorithm := TZLibAlgorithmType.GZip;
  LayoutAddObject(FProcessImageDataGZip.lytContainer);
end;

procedure TfrmMain.lbiMenuDataGZipTextClick(Sender: TObject);
begin
  InfoSamples(Format('Data GZIP - %s', [frmFrameMenuItemDataGZipText.Title]), FURLInfo);
  if not Assigned(FProcessTextDataGZip) then
    FProcessTextDataGZip := TfrmProcessText.Create(Self);

  FProcessTextDataGZip.Mode := TZLibModeType.Data;
  FProcessTextDataGZip.Algorithm := TZLibAlgorithmType.GZip;
  LayoutAddObject(FProcessTextDataGZip.lytContainer);
end;

procedure TfrmMain.sbInfoClick(Sender: TObject);
begin
  OpenURL(FURLInfo);
end;

procedure TfrmMain.Text2Click(Sender: TObject);
begin
  OpenURL(cURLGitHub);
end;

procedure TfrmMain.Text4Click(Sender: TObject);
begin
  OpenURL(cURLGitHub);
end;

procedure TfrmMain.txtLogoLinkClick(Sender: TObject);
begin
  OpenURL(FURLInfo);
end;

procedure TfrmMain.txtLogoMainLinkClick(Sender: TObject);
begin
  OpenURL(FURLInfo);
end;

end.
