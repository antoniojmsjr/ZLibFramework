{******************************************************************************}
{                                                                              }
{           BaseForm.Utils                                                     }
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
unit Utils;

interface

uses
  {$IFDEF ANDROID}
  FMX.Helpers.Android, Androidapi.JNI.GraphicsContentViewText,
  Androidapi.JNI.Net, Androidapi.JNI.JavaTypes, Androidapi.Helpers,
  FMX.Platform.Android, Androidapi.JNI.App,
  {$ENDIF ANDROID}
  {$IFDEF MSWINDOWS}
  Winapi.ShellAPI, Winapi.Windows,
  {$ENDIF MSWINDOWS}
  IdURI, FMX.Platform;

  procedure OpenURL(const pURL: string);
  procedure ClipboardText(const pText: string);
  function ConvertBytes(const pBytes: Int64): string;

implementation

uses
  System.SysUtils, System.Math;

{$IFDEF ANDROID}
procedure OpenURLAndroid(const pURL: string);
var
  lIntent: JIntent;
begin
  lIntent := TJIntent.Create;
  lIntent.setType(StringToJString('text/pas'));
  lIntent.setAction(TJIntent.JavaClass.ACTION_VIEW);
  lIntent.setData(TJnet_Uri.JavaClass.parse(StringToJString(TIdURI.URLEncode(pURL))));
  SharedActivity.startActivity(lIntent);
end;
{$ENDIF ANDROID}

{$IFDEF MSWINDOWS}
procedure OpenURLWindows(const pURL: string);
begin
  ShellExecute(0, 'OPEN', PChar(pURL), '', '', SW_SHOWNORMAL);
end;
{$ENDIF MSWINDOWS}

procedure OpenURL(const pURL: string);
begin
  {$IFDEF ANDROID}
  OpenURLAndroid(pURL);
  {$ENDIF ANDROID}
  {$IFDEF MSWINDOWS}
  OpenURLWindows(pURL);
  {$ENDIF MSWINDOWS}
end;

procedure ClipboardText(const pText: string);
var
  lClipboardService: IFMXClipboardService;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXClipboardService, lClipboardService) then
      lClipboardService.SetClipboard(pText);
end;

function ConvertBytes(const pBytes: Int64): string;
const
  cDisplay: Array [0 .. 8] of string = ('Bytes', 'Kb', 'Mb', 'Gb', 'Tb', 'Pb', 'Eb', 'Zb', 'Yb');
var
  I: Integer;
begin
  I := 0;

  while (pBytes > Power(1024, I + 1)) do
    Inc(I);

  Result := FormatFloat('###0.##', pBytes / IntPower(1024, I)) + ' ' + cDisplay[I];
end;


end.
