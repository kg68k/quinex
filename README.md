# QuineX
アセンブリ言語で書かれたX680x0/Human68k向けの
[クワイン](https://ja.wikipedia.org/wiki/%E3%82%AF%E3%83%AF%E3%82%A4%E3%83%B3_(%E3%83%97%E3%83%AD%E3%82%B0%E3%83%A9%E3%83%9F%E3%83%B3%E3%82%B0))
です。  
無保証につき各自の責任で使用して下さい。


## Description

### quine1
HAS060.Xの`.insert`疑似命令を使用します。  
ただし、クワインの定義にもよりますがこの手法は正統派からはクワインとは見なされないようです。

### quine2
quine2gen.rによって出力されるquine2.sがクワインとなります。

### quine3
quine3gen.rによって出力されるquine3.sがクワインとなります。

### quine4
標準Cライブラリの`printf()`を使用します。  
gccから呼び出されるアセンブラが、256バイト以上の長い文字列リテラルに対応している必要があります。


## Build
PCやネット上での取り扱いを用意にするために、src/内のファイルはUTF-8で記述されています。
X68000上でビルドする際には、UTF-8からShift_JISへの変換が必要です。

### u8tosjを使用する方法
あらかじめ、[u8tosj](https://github.com/kg68k/u8tosj)をビルドしてインストールしておいてください。

トップディレクトリで`make`を実行してください。以下の処理が行われます。
1. build/ディレクトリの作成。
2. src/内の各ファイルをShift_JISに変換してbuild/へ保存。

次に、カレントディレクトリをbuild/に変更し、`make`を実行してください。
実行ファイルが作成されます。

### u8tosjを使用しない方法
ファイルを適当なツールで適宜Shift_JISに変換してから`make`を実行してください。
UTF-8のままでは正しくビルドできませんので注意してください。


## License
GNU GENERAL PUBLIC LICENSE Version 3 or later.

## Author
TcbnErik / https://github.com/kg68k/quinex

