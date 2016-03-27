# Programming language T

Programming language T is functional programming language.

T言語は関数型プログラミング言語です。

T言語はTIPERとCoPL、TAPLに強く影響を受けています。

構文解析はPrologの標準的な機能を用いています。Prologはユーザー定義の様々な演算子を用いる事が出来るので、LispのS式の代わりにより複雑な式を用いる事が出来ます。

T言語の実装は大ステップ評価器の評価規則と、型付け規則から構成されています。

## install on Mac OSX

	brew install swi-prolog

## run

	swipl t.pl

## TODO

- [x] 型エラー。
- [ ] 仕様を書く。
- [x] ファイルを読み込んで実行する。
- [ ] コマンド tを作って、t aaa.t 等として実行出来るようにする。
- [ ] 標準入力に対応する
- [ ] 構文解析する
- [ ] 解説を書く
- [ ] リストを一般的な物にする
- [ ] 文字列をリストとして扱えるようにする
- [ ] 文字列出力関数を用意する
