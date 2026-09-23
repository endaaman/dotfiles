# install の入口だけ。ロジックは install が持つ。
# 任意の組み合わせは make run ARGS="gui tools" で渡せる。
# どのパッケージをどの経路で入れるかは docs/packages.md。

ARGS ?=

.DEFAULT_GOAL := install
.PHONY: install gui mise tools zinit all run check diff help

install:
	@./install $(ARGS)

gui:
	@./install gui $(ARGS)

mise:
	@./install mise $(ARGS)

tools:
	@./install tools $(ARGS)

zinit:
	@./install zinit $(ARGS)

all:
	@./install gui mise tools zinit

run:
	@./install $(ARGS)

# 変更せず確認するもの
check:
	@./install --dry-run $(ARGS)

diff:
	@./install --dry-run $(ARGS) | awk -F'\t' '$$1!="ok"'

help:
	@echo 'make            基本セットアップ (= ./install)'
	@echo 'make gui        + フォント / tym / VSCode / Syncthing'
	@echo 'make mise       + mise (インストール/自己更新) と node'
	@echo 'make tools      + uvtools.txt の Python CLI (uv tool install)'
	@echo 'make zinit      + zinit'
	@echo 'make all        gui mise tools zinit (未導入なら入れる / 導入済みなら更新する)'
	@echo ''
	@echo 'make check      変更せず全状態を出す (--dry-run)'
	@echo 'make diff       ok 以外だけ (new/relink/conflict/missing)'
	@echo ''
	@echo 'make run ARGS="gui mise"    任意の組み合わせ'
	@echo 'make check ARGS=gui         gui 込みで確認'
