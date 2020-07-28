{******************************************************************************}
{                                                                              }
{           Demo                                                               }
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
program Demo;

uses
  System.StartUpCopy,
  FMX.Forms,
  About in 'Source\About.pas' {frmAbout},
  Base64VsZLibFrameworkStreamingImage in 'Source\Base64VsZLibFrameworkStreamingImage.pas' {frmBase64VsZLibFrameworkStreamingImage},
  Base64VsZLibFrameworkTextNFe in 'Source\Base64VsZLibFrameworkTextNFe.pas',
  Main in 'Source\Main.pas' {frmMain},
  ProcessText in 'Source\ProcessText.pas' {frmProcessText},
  ProcessFile in 'Source\ProcessFile.pas' {frmProcessFile},
  Base64VsZLibFrameworkText in 'Source\Base64VsZLibFrameworkText.pas' {frmBase64VsZLibFrameworkText},
  ZLibFrameworkMD5 in 'Source\ZLibFrameworkMD5.pas' {frmZLibFrameworkMD5},
  ProcessImage in 'Source\ProcessImage.pas' {frmProcessImage};

{$R *.res}

begin
  //Verificação Memory Leak
  {$IFDEF MSWINDOWS}
  ReportMemoryLeaksOnShutdown := (DebugHook <> 0);
  {$ENDIF}

  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
