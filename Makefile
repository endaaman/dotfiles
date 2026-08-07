# install の入口だけ。ロジックは install が持つ。
# 任意の組み合わせは make run ARGS="gui node" で渡せる。

ARGS ?=

.DEFAULT_GOAL := install
.PHONY: install gui mise zinit node all run check diff help

install:
	@./install $(ARGS)

gui:
	@./install gui $(ARGS)

mise:
	@./install mise $(ARGS)

zinit:
	@./install zinit $(ARGS)

# 非推奨 (mise へ移行中)
node:
	@./install node $(ARGS)

all:
	@./install gui mise zinit

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
	@echo 'make mise       + mise (インストール/自己更新)'
	@echo 'make zinit      + zinit'
	@echo 'make all        gui mise zinit'
	@echo ''
	@echo 'make check      変更せず全状態を出す (--dry-run)'
	@echo 'make diff       ok 以外だけ (new/relink/conflict/missing)'
	@echo ''
	@echo 'make run ARGS="gui mise"    任意の組み合わせ'
	@echo 'make check ARGS=gui         gui 込みで確認'
	@echo ''
	@echo 'make node       nodebrew (非推奨 — mise へ移行中)'
