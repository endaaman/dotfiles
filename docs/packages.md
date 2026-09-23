# パッケージをどの経路で入れるか (2026-09-23)

Arch と Ubuntu の両方で使うので、経路を 3 つに絞る。迷ったら上から順に当てる。

| 経路 | 入れるもの | やらないこと |
|---|---|---|
| **ディストリ (pacman / apt)** | 第一候補。CLI ツール全般、Python 製ツールも `python-*` / LSP (`jedi-language-server`, `typescript-language-server`) があればこちら | — |
| **mise** | ランタイム (node)。既定は `mise/config.toml`、プロジェクトは `.node-version` | Python を持たせない (uv と二重になる)。ツール類も入れない (pipx/npm バックエンドは使わない) |
| **uv** | Python。プロジェクトは `uv` + `.python-version`、名前付きグローバル環境は `uvenv activate <name>`。**ディストリに無い Python 製 CLI は `uv tool install`** (`uvtools.txt` → `make tools`) | — |

## 理由

- **ディストリ優先**: Arch は Python が上がると `python-*` を全部リビルドする。apt も同様に
  一括で整合を取る。ユーザーが自前で venv を持つと、そこだけ取り残される。
- **pipx は使わない (廃止)**: venv の interpreter が `/usr/bin/python3.X` を直接指すので、
  ディストリの Python がメジャー更新されると全 venv が `bad interpreter` で死ぬ
  (2026-09-23、3.13→3.14 で jedi-language-server と jupytext が両方死んで nvim の LSP が
  落ちた)。`uv tool` は uv 管理の Python を使うので巻き込まれない。用途は pipx と同じ。
  `uvx` は `uv tool` の使い捨て実行で、別経路ではない。
- **mise はランタイムだけ**: mise にも `pipx:` `npm:` バックエンドがあるが、使うと 4 つ目の
  経路が増える。node が要る CLI (typescript-language-server 等) はディストリ、無ければ
  mise の node で `npm i -g` (mise の node 配下に入り、node を消せば一緒に消える)。
- **pyenv / nodebrew / nvm は廃止済み**。

## 廃止したものの残骸 (このマシン、2026-09-23 時点で未処理)

- `pyenv` (pacman、`pyenv-virtualenv` が依存) と `~/.pyenv` (8.5G、3.12.8 と `ml` env)。
  `ml` は `~/.uvenvs/ml` に移行済みなので消してよい。
- `python-poetry` / `python-virtualenvwrapper` (pacman、uv 移行前のもの)。
- zshrc の pipenv / poetry / virtualenvwrapper の分岐 (存在チェックなので害は無い)。
