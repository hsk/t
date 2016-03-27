# Programming language T

Programming language T is functional programming language.

T言語は関数型プログラミング言語です。

T言語はTIPERとCoPL、TAPLに強く影響を受けています。

構文解析はPrologの標準的な機能を用いています。Prologはユーザー定義の様々な演算子を用いる事が出来るので、LispのS式の代わりにより複雑な式を用いる事が出来ます。

T言語の実装は大ステップ評価器の評価規則と、型付け規則から構成されています。

## install on Mac OSX

	brew install swi-prolog

## run

	./t example/sum.t

## TODO

- [x] 型エラー。
- [x] ファイルを読み込んで実行する。
- [x] コマンド tを作って、t aaa.t 等として実行出来るようにする。
- [x] 文字列をリストとして扱えるようにする
- [x] リストを文字列に変換するstring関数を作る
- [ ] 標準入力に対応する
- [ ] 仕様を書く。
- [ ] 構文解析する
- [ ] 解説を書く
- [ ] リストを一般的な物にする
