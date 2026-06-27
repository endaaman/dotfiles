# Troubleshooting

## Code - OSS が Claude/Copilot の認証時にクラッシュする (2026-06)

### 症状
VSCode (Arch の `code` = **Code - OSS**) で Claude Code や GitHub Copilot にサインインしようとすると、
`/usr/lib/electron42/electron (part of Code - OSS) has encountered a fatal error and was closed.`
と出てクラッシュ(electron が SIGSEGV)。

### 原因
KDE Plasma 6 + 新しい `ksecretd`(`kwallet` 6.27 同梱)の構成で、Electron/Chromium の
**KWallet 専用 D-Bus コードパス**が segfault する既知の不具合。
`XDG_CURRENT_DESKTOP=KDE` を見て Electron が KWallet 経路を選ぶのが引き金。
認証トークンを OS キーリングへ保存しようとした瞬間にメインプロセスが落ちる。

### 対処
パスワードストアを KWallet 経路ではなく **libsecret 経路**(`org.freedesktop.secrets`、
ksecretd が提供)に強制する。`~/.config/code-flags.conf` を作成:

```
--password-store=gnome-libsecret
```

Code-OSS のラッパー (`/usr/bin/code-oss`) が起動毎に読み、`code --password-store=gnome-libsecret`
と等価になる。Code-OSS を完全に終了して再起動すれば反映。

- 確認: `secret-tool store/lookup/clear` で libsecret→ksecretd の保存/読出/削除が通ること
- 効かない / それでも落ちる場合の最終手段: `--password-store=basic`
  (外部キーリングを一切使わない=絶対に落ちないが、トークンは弱い暗号化で保存)

### メモ
- crashpad が SIGSEGV を自前処理するため coredump は truncated + strip でバックトレース不可。
  カーネルにも segfault 行が出ない。原因特定は「起動して落ちないこと + キーリング経路の直接テスト」で確認した。
- 参考: microsoft/vscode #189672, #187338, #185212(KDE6 は VSCode 未サポート)
