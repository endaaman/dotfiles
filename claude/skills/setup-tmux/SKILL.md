---
name: setup-tmux
description: repo の開発環境（tmux session・DB・dev サーバー）を `dev-tmux` で立ち上げて疎通まで確認する。環境を移動してきたとき・サーバーが落ちているとき・セッション開始時に実行する。
---

# setup-tmux — 開発環境の立ち上げ

中身は `dev-tmux`（repo 横断のツール群にあるスクリプト）。冪等で、既に上がっているものには触らない。
この skill は **打って、WARN を読んで、直す**だけ。規約は `~/.claude/CLAUDE.md` の「tmux 規約」。

## 手順

1. **repo root に `.dev-tmux` があるか見る。** 無ければこの repo は対象外 —— 止めて ken に聞く。推測で作らない。
2. **`dev-tmux` を打つ**（再起動なら `dev-tmux --restart <window>…` / `--restart-be` / `--restart`。
   何をするか先に見たいなら `--dry`）。`dev-tmux` が無ければ、ツール群の clone を `make install`
   （clone 先と手順は repo の CLAUDE.md にある）。
3. **出力の WARN を読んで直す。**
   - 雛形からコピーした config → 鍵は入れない。ken に埋めてもらう
   - ポートが開かない → `tmux capture-pane -p -t <session>:<window>` でログを読み、原因を直してから
     `dev-tmux --restart <window>`
   - 「プロセスが居るがポートが開いていない」→ サーバーやエラーで止まったプロセスが前面に居る。
     **キーを送らない。** ログを読んで直す（kill しない）
   - session の改名・新設をしたと出たら ken に一言
4. **[6] の他の claude window を報告する。** 居れば同一ファイル競合の注意。相手への疎通
   （`tmux send-keys` 等）は ken に確認してから。
5. **報告**: 何を起動した / 何が上がっていた / WARN / 他の claude の有無。

## やらないこと

- 内部 shell（foreground / background とも）で dev サーバーを起動しない —— ken がログを見られない
- サーバーが前面に居る window へキーを送らない
- session / window を手で新設しない（`dev-tmux` が今居る session を使う）
