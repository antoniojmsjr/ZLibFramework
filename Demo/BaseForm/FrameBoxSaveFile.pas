{******************************************************************************}
{                                                                              }
{           BaseForm.FrameBoxSaveFile                                          }
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
unit FrameBoxSaveFile;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.Objects, FMX.Controls.Presentation, FMX.Edit, FMX.Effects,
  FMX.Filter.Effects, FMX.ListBox, ZLibFramework.Types;

type
  TOnBeforeProcess = reference to procedure(var pInput: string;
                                            var pMode: TZLibModeType;
                                            var pOperation: TZLibOperationType;
                                            var pAlgorithm: TZLibAlgorithmType;
                                            var pEncoding: TEncoding;
                                            var pContentType: Integer);
  TOnAfterProcess = reference to procedure(const pMD5Result: string);

  TfrmFrameBoxSaveFile = class(TFrame)
    lytSaveFile: TLayout;
    lytMD5: TLayout;
    edtBoxSaveFileMD5Value: TEdit;
    txtBoxSaveFileMD5Title: TText;
    rctSaveFile: TRectangle;
    sdFile: TSaveDialog;
    lbFile: TListBox;
    lbiHeader: TListBoxItem;
    lbiFilePath: TListBoxItem;
    lytHeader: TLayout;
    rctHeader: TRectangle;
    gplHeader: TGridPanelLayout;
    lytHeaderCell1: TLayout;
    lytHeaderCell2: TLayout;
    lytButtonSaveFile: TLayout;
    imgButtonSaveFile: TImage;
    FillRGBEffect1: TFillRGBEffect;
    sbButtonSaveFile: TSpeedButton;
    txtHeaderCell1: TText;
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
    lbiDivision: TListBoxItem;
    BoxSaveFileMD5Copy: TPath;
    freBoxSaveFileMD5Copy: TFillRGBEffect;
    BoxSaveFileMD5Check: TPath;
    freBoxBoxSaveFileMD5Check: TFillRGBEffect;
    procedure sbButtonSaveFileClick(Sender: TObject);
    procedure BoxSaveFileMD5CopyClick(Sender: TObject);
    procedure BoxSaveFileMD5CheckClick(Sender: TObject);
  private
    { Private declarations }
    FOnBeforeProcess: TOnBeforeProcess;
    FOnAfterProcess: TOnAfterProcess;
    function FileSize(const pFile: string): Int64;
    procedure GetInfoFile(const pFile: string);
    procedure Decompress(const pInput: string;
                         const pFile: string;
                         const pMode: TZLibModeType;
                         const pAlgorithm: TZLibAlgorithmType;
                         const pEncoding: TEncoding;
                         out pResultDecompress: IZLibResult);
    procedure Compress(const pInput: string;
                       const pMode: TZLibModeType;
                       const pAlgorithm: TZLibAlgorithmType;
                       const pEncoding: TEncoding;
                       const pContentType: Integer;
                       out pResultDecompress: IZLibResult); overload;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    procedure Execute;
    property OnBeforeProcess: TOnBeforeProcess read FOnBeforeProcess write FOnBeforeProcess;
    property OnAfterProcess: TOnAfterProcess read FOnAfterProcess write FOnAfterProcess;
  end;

implementation

{$R *.fmx}

uses
  System.IOUtils, Utils, ZLibFramework;

constructor TfrmFrameBoxSaveFile.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

procedure TfrmFrameBoxSaveFile.BoxSaveFileMD5CheckClick(Sender: TObject);
begin
  OpenURL('https://emn178.github.io/online-tools/md5_checksum.html');
end;

procedure TfrmFrameBoxSaveFile.BoxSaveFileMD5CopyClick(Sender: TObject);
begin
  ClipboardText(edtBoxSaveFileMD5Value.Text);
end;

procedure TfrmFrameBoxSaveFile.Compress(const pInput: string;
  const pMode: TZLibModeType;
  const pAlgorithm: TZLibAlgorithmType;
  const pEncoding: TEncoding;
  const pContentType: Integer;
  out pResultDecompress: IZLibResult);
begin
  case pMode of
    TZLibModeType.Base64: //BASE64
    begin
      case pAlgorithm of
        TZLibAlgorithmType.Deflate:
        begin
          TZLib
            .Base64
              .Compress
                .Deflate
                  .Level(TZLibCompressionLevelType.Max)
                  .Text(pInput, pResultDecompress);
        end;
        TZLibAlgorithmType.GZip:
        begin
          TZLib
            .Base64
              .Compress
                .GZip
                  .Level(TZLibCompressionLevelType.Max)
                  .Text(pInput, pResultDecompress);
        end;
      end;
    end;
    TZLibModeType.Data: //DATA
    begin
      case pAlgorithm of
        TZLibAlgorithmType.Deflate:
        begin
          case pContentType of
            1: //TEXT
            begin
              TZLib
                .Data
                  .Compress
                    .Deflate
                      .Level(TZLibCompressionLevelType.Max)
                      .Text(pInput, pResultDecompress);
            end;
            2: //FILE
            begin
              TZLib
                .Data
                  .Compress
                    .Deflate
                      .Level(TZLibCompressionLevelType.Max)
                      .LoadFromFile(pInput, pResultDecompress);
            end;
          end;
        end;
        TZLibAlgorithmType.GZip:
        begin
          case pContentType of
            1: //TEXT
            begin
              TZLib
                .Data
                  .Compress
                    .GZip
                      .Level(TZLibCompressionLevelType.Max)
                      .Text(pInput, pResultDecompress);
            end;
            2: //FILE
            begin
              TZLib
                .Data
                  .Compress
                    .GZip
                      .Level(TZLibCompressionLevelType.Max)
                      .LoadFromFile(pInput, pResultDecompress);
            end;
          end;
        end;
      end;

    end;
  end;
end;

procedure TfrmFrameBoxSaveFile.Decompress(const pInput: string;
                         const pFile: string;
                         const pMode: TZLibModeType;
                         const pAlgorithm: TZLibAlgorithmType;
                         const pEncoding: TEncoding;
                         out pResultDecompress: IZLibResult);
begin
  case pMode of
    TZLibModeType.Base64: //BASE64
    begin
      case pAlgorithm of
        TZLibAlgorithmType.Deflate:
        begin
          TZLib
            .Base64
              .Decompress
                .Deflate
                  .SaveToFile(pInput, pFile, pResultDecompress);
        end;
        TZLibAlgorithmType.GZip:
        begin
          TZLib
            .Base64
              .Decompress
                .GZip
                  .SaveToFile(pInput, pFile, pResultDecompress);
        end;
      end;
    end;
    TZLibModeType.Data: //DATA
    begin
      case pAlgorithm of
        TZLibAlgorithmType.Deflate:
        begin
          TZLib
            .Data
              .Decompress
                .Deflate
                  .LoadFromFile(pInput, pResultDecompress);
        end;
        TZLibAlgorithmType.GZip:
        begin
          TZLib
            .Data
              .Decompress
                .GZip
                  .LoadFromFile(pInput, pResultDecompress);
        end;
      end;
    end;
  end;
end;

procedure TfrmFrameBoxSaveFile.Execute;
var
  lInput: string;
  lFile: string;
  lEncoding: TEncoding;
  lMode: TZLibModeType;
  lOperation: TZLibOperationType;
  lAlgorithm: TZLibAlgorithmType;
  lContentType: Integer;
  lResultDecompress: IZLibResult;
begin
  lFile := EmptyStr;
  if sdFile.Execute then
    lFile := sdFile.FileName;

  if lFile.Trim.IsEmpty then
    Exit;

  lEncoding := nil;
  if Assigned(FOnBeforeProcess) then
    FOnBeforeProcess(lInput, lMode, lOperation, lAlgorithm, lEncoding, lContentType);

  edtBoxSaveFileMD5Value.Text := EmptyStr;

  case lOperation of
    TZLibOperationType.Compress:   Compress(lInput, lMode, lAlgorithm, lEncoding, lContentType, lResultDecompress);
    TZLibOperationType.Decompress: Decompress(lInput, lFile, lMode, lAlgorithm, lEncoding, lResultDecompress);
  end;

  //SAVE TO FILE
  lResultDecompress.SaveToFile(lFile);

  //INFORMAÇÕES DO ARQUIVO
  GetInfoFile(lFile);

  if Assigned(FOnAfterProcess) then
    FOnAfterProcess(lResultDecompress.MD5Input);

  //RESULT
  edtBoxSaveFileMD5Value.Text := lResultDecompress.MD5Result;
end;

function TfrmFrameBoxSaveFile.FileSize(const pFile: string): Int64;
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

procedure TfrmFrameBoxSaveFile.GetInfoFile(const pFile: string);
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

procedure TfrmFrameBoxSaveFile.sbButtonSaveFileClick(Sender: TObject);
begin
  Execute;
end;

end.
