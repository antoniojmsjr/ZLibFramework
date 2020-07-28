{******************************************************************************}
{                                                                              }
{           ZLibFramework.Interfaces                                           }
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
unit ZLibFramework.Interfaces;

interface

uses
  System.SysUtils, System.Classes, ZLibFramework.Types;

type

  IZLibAlgorithmCompression = interface;
  IZLibAlgorithmDecompression = interface;

  IZLibOperation = interface
    ['{050E6531-1417-4681-8007-E735CBE99EA3}']
    /// <summary>
    /// Processo de Compressão.
    /// <code>
    /// var
    ///   lResult: IZLibResult;
    /// begin
    ///   Exemplo: TZLib.Base64.Compress.Deflate.Text('Texto12345', lResult);
    /// end;
    /// </code>
    /// </summary>
    /// <returns>Retorna uma interface do tipo IZLibAlgorithmCompression que implementa o conceito de interface fluente para guiar no uso da biblioteca.</returns>
    function Compress: IZLibAlgorithmCompression;
    /// <summary>
    /// Processo de Descompressão.
    /// <code>
    /// var
    ///   lResult: IZLibResult;
    /// begin
    ///   Exemplo: TZLib.Base64.Decompress.Deflate.Text('eNozNDI2MQUAAvgBAA==', lResult);
    /// end;
    /// </code>
    /// </summary>
    /// <returns>Retorna uma interface do tipo IZLibAlgorithmDecompression que implementa o conceito de interface fluente para guiar no uso da biblioteca.</returns>
    function Decompress: IZLibAlgorithmDecompression;
  end;

  {$REGION 'COMPRESSION'}

  IZLibMethodsCompression = interface;

  IZLibAlgorithmCompression = interface
    ['{64C6AA18-01B6-44D8-8413-04DF96F9DDA8}']
    /// <summary>
    /// Processo de Compressão usando o algoritimo Deflate.
    /// <code>
    /// var
    ///   lResult: IZLibResult;
    /// begin
    ///   Exemplo: TZLib.Data.Compress.Deflate.Text('Texto12345', lResult);
    /// end;
    /// </code>
    /// </summary>
    /// <returns>Retorna uma interface do tipo IZLibMethodsCompression que implementa o conceito de interface fluente para guiar no uso da biblioteca.</returns>
    function Deflate: IZLibMethodsCompression;
    /// <summary>
    /// Processo de Compressão usando o algoritimo GZip.
    /// <code>
    /// var
    ///   lResult: IZLibResult;
    /// begin
    ///   Exemplo: TZLib.Data.Compress.GZip.Text('Texto12345', lResult);
    /// end;
    /// </code>
    /// </summary>
    /// <returns>Retorna uma interface do tipo IZLibMethodsCompression que implementa o conceito de interface fluente para guiar no uso da biblioteca.</returns>
    function GZip: IZLibMethodsCompression;
    function &End: IZLibOperation;
  end;

  IZLibMethodsCompression = interface
    ['{47AA25AE-CBD7-46CA-BF31-6CACF2A29F73}']
    /// <summary>
    /// Identifica o nível de compressão utilizada para compactação.
    /// <code>
    /// var
    ///   lResult: IZLibResult;
    /// begin
    ///   Exemplo: TZLib.Data.Compress.Deflate.Level(TZLibCompressionLevelType.Max).Text('Texto12345', lResult);
    /// end;
    /// </code>
    /// </summary>
    /// <remarks>
    /// <para>* Verificar na unit ZLibFramework.Types o tipo TZLibCompressionLevelType com as opções possíveis para ser utilizado.</para>
    /// <para>* O CompressionLevel utilizado quando não informado, é TZLibCompressionLevelType.Max.</para>
    /// </remarks>
    /// <param name="CompressionLevel">
    /// Identificação do nível de compressão.
    /// </param>
    /// <returns>Retorna uma interface do tipo IZLibMethodsCompression que implementa o conceito de interface fluente para guiar no uso da biblioteca.</returns>
    function Level(const CompressionLevel: TZLibCompressionLevelType): IZLibMethodsCompression;
    /// <summary>
    /// Compressão e codificação de uma string.
    /// <code>
    /// var
    ///   lResult: IZLibResult;
    /// begin
    ///   Exemplo: TZLib.Data.Compress.Deflate.Text('Texto12345', lResult);
    /// end;
    /// </code>
    /// </summary>
    /// <remarks>
    /// <para>* Para codificar o parâmetro de entrada em Base64, utilizar a property Base64 da classe TZLib.</para>
    /// <para>* O formato de compactação vai depender do algoritmo escolhido, Deflate ou GZip.</para>
    /// <para>* O Encoding utilizado quando não informado, é UTF8.</para>
    /// </remarks>
    /// <param name="Input">
    /// String na qual deseja-se compactar.
    /// </param>
    /// <param name="Result">
    /// Parâmetro de saída contendo o resultado da compactação e codificação do parâmetro de entrada.
    /// </param>
    /// <returns>Retorna uma interface do tipo IZLibAlgorithmCompression que implementa o conceito de interface fluente para guiar no uso da biblioteca.</returns>
    function Text(const Input: string; out Result: IZLibResult): IZLibAlgorithmCompression; overload;
    /// <summary>
    /// Compressão e codificação de uma string, com a opção de identificar um Encoding.
    /// <code>
    /// var
    ///   lResult: IZLibResult;
    /// begin
    ///   Exemplo: TZLib.Data.Compress.Deflate.Text('Texto12345', TEncoding.UTF8, lResult);
    /// end;
    /// </code>
    /// </summary>
    /// <remarks>
    /// <para>* Para codificar o parâmetro de entrada em Base64, utilizar a property Base64 da classe TZLib.</para>
    /// <para>* O formato de compactação vai depender do algoritmo escolhido, Deflate ou GZip.</para>
    /// <para>* O Encoding utilizado quando não informado, é UTF8.</para>
    /// </remarks>
    /// <param name="Input">
    /// String na qual deseja-se compactar.
    /// </param>
    /// <param name="Encoding">
    /// Identificação do Encoding.
    /// </param>
    /// <param name="Result">
    /// Parâmetro de saída contendo o resultado da compactação e codificação do parâmetro de entrada.
    /// </param>
    /// <returns>Retorna uma interface do tipo IZLibAlgorithmCompression que implementa o conceito de interface fluente para guiar no uso da biblioteca.</returns>
    function Text(const Input: string; const Encoding: TEncoding; out Result: IZLibResult): IZLibAlgorithmCompression; overload;
    /// <summary>
    /// Compressão e codificação de uma string, com a opção de salvar o resultado do processo de compactação.
    /// <code>
    /// var
    ///   lResult: IZLibResult;
    /// begin
    ///   Exemplo: TZLib.Data.Compress.Deflate.SaveToFile('Texto12345', 'C:\Teste.txt', lResult);
    /// end;
    /// </code>
    /// </summary>
    /// <remarks>
    /// <para>* Para codificar o parâmetro de entrada em Base64, utilizar a property Base64 da classe TZLib.</para>
    /// <para>* O formato de compactação vai depender do algoritmo escolhido, Deflate ou GZip.</para>
    /// <para>* O Encoding utilizado quando não informado, é UTF8.</para>
    /// </remarks>
    /// <param name="Input">
    /// String na qual deseja-se compactar.
    /// </param>
    /// <param name="FileName">
    /// Nome do arquivo que será utilizado para salvar o resultado do processo de compactação.
    /// </param>
    /// <param name="Result">
    /// Parâmetro de saída contendo o resultado da compactação e codificação do parâmetro de entrada.
    /// </param>
    /// <returns>Retorna uma interface do tipo IZLibAlgorithmCompression que implementa o conceito de interface fluente para guiar no uso da biblioteca.</returns>
    function SaveToFile(const Input: string; const FileName: TFileName; out Result: IZLibResult): IZLibAlgorithmCompression;
    /// <summary>
    /// Compressão e codificação de arquivo.
    /// <code>
    /// var
    ///   lResult: IZLibResult;
    /// begin
    ///   Exemplo: TZLib.Data.Compress.Deflate.LoadFromFile('C:\Teste.txt', lResult);
    /// end;
    /// </code>
    /// </summary>
    /// <remarks>
    /// <para>* Utilizado em imagens, pdf, executáveis entre outros.</para>
    /// <para>* Para codificar o parâmetro de entrada em Base64, utilizar a property Base64 da classe TZLib.</para>
    /// <para>* O formato de compactação vai depender do algoritmo escolhido, Deflate ou GZip.</para>
    /// </remarks>
    /// <param name="Input">
    /// Arquivo na qual deseja-se compactar.
    /// </param>
    /// <param name="Result">
    /// Parâmetro de saída contendo o resultado da compactação e codificação do parâmetro de entrada.
    /// </param>
    /// <returns>Retorna uma interface do tipo IZLibAlgorithmCompression que implementa o conceito de interface fluente para guiar no uso da biblioteca.</returns>
    function LoadFromFile(const Input: TFileName; out Result: IZLibResult): IZLibAlgorithmCompression;
    /// <summary>
    /// Compressão e codificação de uma variavél Stream.
    /// <code>
    /// var
    ///   lResult: IZLibResult;
    /// begin
    ///   Exemplo: TZLib.Data.Compress.Deflate.LoadFromStream(TStream, lResult);
    /// end;
    /// </code>
    /// </summary>
    /// <remarks>
    /// <para>* Para codificar o parâmetro de entrada em Base64, utilizar a property Base64 da classe TZLib.</para>
    /// <para>* O formato de compactação vai depender do algoritmo escolhido, Deflate ou GZip.</para>
    /// </remarks>
    /// <param name="Input">
    /// Stream na qual deseja-se compactar.
    /// </param>
    /// <param name="Result">
    /// Parâmetro de saída contendo o resultado da compactação e codificação do parâmetro de entrada.
    /// </param>
    /// <returns>Retorna uma interface do tipo IZLibAlgorithmCompression que implementa o conceito de interface fluente para guiar no uso da biblioteca.</returns>
    function LoadFromStream(Input: TStream; out Result: IZLibResult): IZLibAlgorithmCompression;
  end;

  {$ENDREGION}

  {$REGION 'DECOMPRESSION'}

  IZLibMethodsDecompression = interface;

  IZLibAlgorithmDecompression = interface
    ['{D70E18FA-7E27-4A53-A228-1A907F4E97DB}']
    /// <summary>
    /// Processo de descompressão usando o algoritimo Deflate.
    /// <code>
    /// var
    ///   lResult: IZLibResult;
    /// begin
    ///   Exemplo: TZLib.Base64.Decompress.Deflate.Text('eNozNDI2MQUAAvgBAA==', lResult);
    /// end;
    /// </code>
    /// </summary>
    /// <returns>Retorna uma interface do tipo IZLibMethodsDecompression que implementa o conceito de interface fluente para guiar no uso da biblioteca.</returns>
    function Deflate: IZLibMethodsDecompression;
    /// <summary>
    /// Processo de descompressão usando o algoritimo GZip.
    /// <code>
    /// var
    ///   lResult: IZLibResult;
    /// begin
    ///   Exemplo: TZLib.Base64.Decompress.GZip.Text('eNozNDI2MQUAAvgBAA==', lResult);
    /// end;
    /// </code>
    /// </summary>
    /// <returns>Retorna uma interface do tipo IZLibMethodsDecompression que implementa o conceito de interface fluente para guiar no uso da biblioteca.</returns>
    function GZip: IZLibMethodsDecompression;
    function &End: IZLibOperation;
  end;

  IZLibMethodsDecompression = interface
    ['{45E581C3-39F6-41E4-BC23-C0CC2C87A2C1}']
    /// <summary>
    /// Decodificação e Descompressão de uma string.
    /// <code>
    /// var
    ///   lResult: IZLibResult;
    /// begin
    ///   Exemplo: TZLib.Base64.Decompress.Deflate.Text('eNozNDI2MQUAAvgBAA==', lResult);
    /// end;
    /// </code>
    /// </summary>
    /// <remarks>
    /// <para>* Para decodificar o parâmetro de entrada em Base64, utilizar a property Base64 da classe TZLib.</para>
    /// <para>* O formato de descompactação vai depender do algoritmo escolhido, Deflate ou GZip.</para>
    /// </remarks>
    /// <param name="Input">
    /// String na qual deseja-se descompactar.
    /// </param>
    /// <param name="Result">
    /// Parâmetro de saída contendo o resultado da decodificação e descompactação do parâmetro de entrada.
    /// </param>
    /// <returns>Retorna uma interface do tipo IZLibAlgorithmDecompression que implementa o conceito de interface fluente para guiar no uso da biblioteca.</returns>
    function Text(const Input: string; out Result: IZLibResult): IZLibAlgorithmDecompression;
    /// <summary>
    /// Decodificação e Descompressão de uma string, com a opção de salvar o resultado do processo de descompactação.
    /// <code>
    /// var
    ///   lResult: IZLibResult;
    /// begin
    ///   Exemplo: TZLib.Data.Decompress.Deflate.SaveToFile('eNozNDI2MQUAAvgBAA==', 'C:\Teste.txt', lResult);
    /// end;
    /// </code>
    /// </summary>
    /// <remarks>
    /// <para>* Para decodificar o parâmetro de entrada em Base64, utilizar a property Base64 da classe TZLib.</para>
    /// <para>* O formato de descompactação vai depender do algoritmo escolhido, Deflate ou GZip.</para>
    /// <para>* O Encoding utilizado quando não informado, é UTF8.</para>
    /// </remarks>
    /// <param name="Input">
    /// String na qual deseja-se descompactar.
    /// </param>
    /// <param name="FileName">
    /// Nome do arquivo que será utilizado para salvar o resultado do processo de descompactação.
    /// </param>
    /// <param name="Result">
    /// Parâmetro de saída contendo o resultado da decodificação e descompactação do parâmetro de entrada.
    /// </param>
    /// <returns>Retorna uma interface do tipo IZLibAlgorithmDecompression que implementa o conceito de interface fluente para guiar no uso da biblioteca.</returns>
    function SaveToFile(const Input: string; const FileName: TFileName; out Result: IZLibResult): IZLibAlgorithmDecompression;
    /// <summary>
    /// Decodificação e Descompressão de arquivo.
    /// <code>
    /// var
    ///   lResult: IZLibResult;
    /// begin
    ///   Exemplo: TZLib.Data.Decompress.Deflate.LoadFromFile('C:\Teste.txt', lResult);
    /// end;
    /// </code>
    /// </summary>
    /// <remarks>
    /// <para>* Utilizado em imagens, pdf, executáveis entre outros.</para>
    /// <para>* Para decodificar o parâmetro de entrada em Base64, utilizar a property Base64 da classe TZLib.</para>
    /// <para>* O formato de descompactação vai depender do algoritmo escolhido, Deflate ou GZip.</para>
    /// </remarks>
    /// <param name="Input">
    /// Arquivo na qual deseja-se descompactar.
    /// <param name="Result">
    /// Parâmetro de saída contendo o resultado da decodificação e descompactação do parâmetro de entrada.
    /// </param>
    /// <returns>Retorna uma interface do tipo IZLibAlgorithmDecompression que implementa o conceito de interface fluente para guiar no uso da biblioteca.</returns>
    function LoadFromFile(const Input: TFileName; out Result: IZLibResult): IZLibAlgorithmDecompression;
    /// <summary>
    /// Decodificação e Descompressão de uma variavél Stream.
    /// <code>
    /// var
    ///   lResult: IZLibResult;
    /// begin
    ///   Exemplo: TZLib.Data.Decompress.Deflate.LoadFromStream(TStream, lResult);
    /// end;
    /// </code>
    /// </summary>
    /// <remarks>
    /// <para>* Para decodificar o parâmetro de entrada em Base64, utilizar a property Base64 da classe TZLib.</para>
    /// <para>* O formato de descompactação vai depender do algoritmo escolhido, Deflate ou GZip.</para>
    /// </remarks>
    /// <param name="Input">
    /// Stream na qual deseja-se descompactar.
    /// </param>
    /// <param name="Result">
    /// Parâmetro de saída contendo o resultado da decodificação e descompactação do parâmetro de entrada.
    /// </param>
    /// <returns>Retorna uma interface do tipo IZLibAlgorithmDecompression que implementa o conceito de interface fluente para guiar no uso da biblioteca.</returns>
    function LoadFromStream(Input: TStream; out Result: IZLibResult): IZLibAlgorithmDecompression; overload;
  end;

  {$ENDREGION}

implementation

end.

