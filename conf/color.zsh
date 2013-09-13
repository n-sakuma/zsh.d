# vim: ft=zsh
# -*- mode: shell-script -*-

# フォーマット
zstyle ':completion:*' list-colors 'di=36' 'ln=35'
zstyle ':completion:*:default' menu select=1

export LSCOLORS=gxfxcbdxbxegedabagacad
    # position: 1234567890123456789012

    # * 01: ディレクトリ前景色
    # * 02: ディレクトリ背景色
    # * 03: シンボリックリンク前景色
    # * 04: シンボリックリンク背景色
    # * 05: ソケットファイル前景色
    # * 06: ソケットファイル背景色
    # * 07: FIFOファイル前景色
    # * 08: FIFOファイル背景色
    # * 09: 実行ファイル前景色
    # * 10: 実行ファイル背景色
    # * 11: ブロックスペシャルファイル前景色
    # * 12: ブロックスペシャルファイル背景色
    # * 13: キャラクタスペシャルファイル前景色
    # * 14: キャラクタスペシャルファイル背景色
    # * 15: setuidつき実行ファイル前景色
    # * 16: setuidつき実行ファイル背景色
    # * 17: setgidつき実行ファイル前景色
    # * 18: setgidつき実行ファイル背景色
    # * 19: スティッキビットありother書き込み権限つきディレクトリ前景色
    # * 20: スティッキビットありother書き込み権限つきディレクトリ背景色
    # * 21: スティッキビットなしother書き込み権限つきディレクトリ前景色
    # * 22: スティッキビットなしother書き込み権限つきディレクトリ背景色

    # * a: 黒
    # * b: 赤
    # * c: 緑
    # * d: 茶
    # * e: 青
    # * f: マゼンタ
    # * g: シアン
    # * h: 白
    # * A: 黒(太字)
    # * B: 赤(太字)
    # * C: 緑(太字)
    # * D: 茶(太字)
    # * E: 青(太字)
    # * F: マゼンタ(太字)
    # * G: シアン(太字)
    # * H: 白(太字)
    # * x: デフォルト色


# set prompt
#

autoload colors
colors

# color

# red
# blue
# green
# cyan
# yellow
# white
# black



##
# grep config
export GREP_COLOR='1;37' # 白
export GREP_OPTIONS='--color=auto'
# パイプでも表示するが Git表示でおかしくなる
# export GREP_OPTIONS='--color=always'

# alias grep='grep --colour'
# 環境変数 GREP_COLORに ANSIエスケープシーケンスで定義される色指定を
# 置くことにより、任意の色でカラー出力できます。

# 色指定の例:
#     Black       0;30     Dark Gray     1;30
#     Blue        0;34     Light Blue    1;34
#     Green       0;32     Light Green   1;32
#     Cyan        0;36     Light Cyan    1;36
#     Red         0;31     Light Red     1;31
#     Purple      0;35     Light Purple  1;35
#     Brown       0;33     Yellow        1;33
#     Light Gray  0;37     White         1;37

# セミコロンの前の0は通常輝度を指示し、1は高輝度を指示します。
# 3xの代わりに4xと指定すると反転表示の指示です。たとえば
#   set GREP_COLOR=1;41;37
# のようにすると、マッチした部分を赤い背景に白い文字で表示します。
