![Maintained YES](https://img.shields.io/badge/Maintained%3F-yes-green.svg)
![Delphi Supported Versions](https://img.shields.io/badge/Delphi%20Supported%20Versions-Tokyo%2010.2.3%20and%20ever-blue.svg)
![Platforms](https://img.shields.io/badge/Platforms-Win32%20and%20Win64-red.svg)
![Compatibility](https://img.shields.io/badge/Compatibility-VCL,%20Firemonkey,%20DataSnap%20-brightgreen.svg)
![](https://img.shields.io/github/stars/antoniojmsjr/ZLibFramework.svg) ![](https://img.shields.io/github/forks/antoniojmsjr/ZLibFramework.svg) ![](https://img.shields.io/github/issues/antoniojmsjr/ZLibFramework.svg)
<p align="center">
  <a href="https://github.com/antoniojmsjr/ZLibFramework/blob/master/Image/Logo.png">
    <img alt="ZLibFramework" height="150" src="https://github.com/antoniojmsjr/ZLibFramework/blob/master/Image/Logo.png">
  </a>
</p>

# ZLibFramework

Biblioteca de compressão, descompressão e codificação em Base64.

Implementado na linguagem Delphi, e utiliza o conceito de [interface fluente](https://en.wikipedia.org/wiki/Fluent_interface) para guiar no uso da biblioteca.</br>
A biblioteca desenvolvida utilizando as classes nativas do Delphi.

* `Base64`: Classe de compressão e codificação para Base64 e decodificação e descompressão da Base64.

* `Data`: Classe somente de compressão e descompressão de dados.

Algoritmo de compressão implementado:

* `Deflate`
* `GZip`

NOTA: As funções sempre retornam um MD5 antes da codificação e o MD5 depois da codificação, que podem ser usados para garantir que um determinado texto foi decodificado corretamente e validando com o MD5 gerado antes da codificação.

## Para que?

Framework de compressão e descompressão com a opção de codificação em Base64.

* Compressão de textos:

	* No aplicativo de demonstração, tem um exemplo de compressão de uma NF-e com 100 itens vendidos, no total de 94.543 caracteres:
		#### Resultado
		* Compressão e codificação em Base64: Uma **redução** de 91.167 caracteres ou **96,42%** no seu tamanho.
		* Compressão: Uma **redução** de 92.012 caracteres ou **97,32%** no seu tamanho.
	* Algoritmo de compressão: Deflate

* Compressão de imagens

	* Bitmap
		* No aplicativo de demonstração, tem um exemplo de compressão de uma imagem no format bitmap, no total de 2.391.674 bytes:
			#### Resultado
			* Compressão e codificação em Base64: Uma **redução** de 645.774 bytes ou **27%** no seu tamanho.
			* Compressão: Uma **redução** de 1.082.249 bytes ou **45,25%** no seu tamanho.
		* Algoritmo de compressão: Deflate

	* PNG, JPG
		* Esses tipos de arquivo já sofreram um processo de compressão na sua criação, o resultado de uma nova compressão não é tão significativa.

		* No aplicativo de demonstração, tem um exemplo de compressão de imagem no format png, no total de 42.436 bytes:
			#### Resultado
			* Compressão e codificação em Base64: Um **aumento** de 13.808 bytes ou **32,53%** no seu tamanho.
			* Compressão: Uma **redução** de 255 bytes ou **0,60%** no seu tamanho.
		* Algoritmo de compressão: Deflate

## Instalação Manual:

Project > Options > Delphi Compiler > Target > All Configurations > Search path

```
..\ZLibFramework\Source
```

## Uso:

```delphi
uses ZLibFramework, ZLibFramework.Types;
```

```delphi
var
  lResultCompress: IZLibResult;
  lMsgError: string;
begin
  try
    TZLib
      .Base64
        .Compress
          .Deflate
            .Level(TZLibCompressionLevelType.Max)
            .Text('12345', lResultCompress);

    Application.MessageBox(PWideChar(lResultCompress.TextUTF8), 'C O M P R E S S Ã O', MB_OK + MB_ICONINFORMATION);
  except
    on E: EZLibException do
    begin
      lMsgError := Concat(lMsgError, Format('Mode: %s', [E.Mode.AsString]), sLineBreak);
      lMsgError := Concat(lMsgError, Format('Operation: %s', [E.Operation.AsString]), sLineBreak);
      lMsgError := Concat(lMsgError, Format('Algorithm: %s', [E.Algorithm.AsString]), sLineBreak);
      lMsgError := Concat(lMsgError, Format('Encoding Fail: %s', [BoolToStr(E.EncodingFail, True)]), sLineBreak);
      lMsgError := Concat(lMsgError, Format('Message: %d', [E.Message]), sLineBreak);
      lMsgError := Concat(lMsgError, Format('Hint: %s', [E.Hint]));

      Application.MessageBox(PWideChar(lMsgError), 'A T E N Ç Ã O', MB_OK + MB_ICONERROR);
    end;
    on E: Exception do
    begin
      Application.MessageBox(PWideChar(E.Message), 'A T E N Ç Ã O', MB_OK + MB_ICONERROR);
    end;
  end;
end;
```

## Demo
[![Download](https://img.shields.io/badge/Download-Demo.zip-orange.svg)](https://github.com/antoniojmsjr/ZLibFramework/files/4998500/Demo.zip)
![ZLibFramework](https://user-images.githubusercontent.com/20980984/88880108-4b1a3e00-d202-11ea-9d45-26a7f7ed19b5.png)

## Licença
`ZLibFramework` is free and open-source software licensed under the [![License](https://img.shields.io/badge/license-Apache%202-blue.svg)](https://github.com/antoniojmsjr/ZLibFramework/blob/master/LICENSE)