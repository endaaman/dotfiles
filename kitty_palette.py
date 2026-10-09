# 自作コマンド（kitty.conf の action_alias my_*）だけを並べるパレット。kitty の custom kitten。
#
# kitty.conf から `map ctrl+shift+p kitten ~/dotfiles/kitty_palette.py` で呼ぶ。
# 一覧は kitty.conf から作る: `action_alias my_xxx ...` の直前の 1 行コメントを説明として出す。
# 選択は fzf（PATH に無ければ zinit の置き場所も見る）。キー操作などは zsh と同じ ~/dotfiles/fzfrc を使う。
# 選んだ action は overlay を閉じてから元のウィンドウに対して実行する（組み込みの command_palette と同じやり方）

import os
import re
import shutil
import subprocess
import sys
from functools import partial

from kitty.boss import Boss
from kitty.constants import config_dir
from kitty.fast_data_types import add_timer, get_boss

FZF_FALLBACKS = ['~/.local/share/zinit/plugins/junegunn---fzf/fzf']
# KDE から起動した kitty には zshrc の環境変数が無いので、ここで指す
FZF_OPTS_FILE = '~/dotfiles/fzfrc'


def collect() -> list[tuple[str, str]]:
    path = os.path.join(config_dir, 'kitty.conf')
    items = []
    prev = ''
    with open(path) as f:
        for line in f:
            line = line.strip()
            m = re.match(r'action_alias\s+(my_\S+)', line)
            if m:
                items.append((m.group(1), prev))
            prev = line[1:].strip() if line.startswith('#') else ''
    return items


def find_fzf() -> str | None:
    found = shutil.which('fzf')
    if found:
        return found
    for p in FZF_FALLBACKS:
        p = os.path.expanduser(p)
        if os.access(p, os.X_OK):
            return p
    return None


def main(args: list[str]) -> str:
    items = collect()
    if not items:
        input('kitty.conf に action_alias my_* がありません。Enter で閉じる')
        return ''
    width = max(len(name) for name, _ in items)
    lines = [f'{name.ljust(width)}  {desc}' for name, desc in items]

    fzf = find_fzf()
    if fzf:
        env = dict(os.environ)
        env.setdefault('FZF_DEFAULT_OPTS_FILE', os.path.expanduser(FZF_OPTS_FILE))
        r = subprocess.run(
            [fzf, '--no-multi', '--prompt=my> '],
            input='\n'.join(lines), stdout=subprocess.PIPE, text=True, env=env)
        chosen = r.stdout.strip()
    else:
        for i, line in enumerate(lines, 1):
            print(f'{i:2}  {line}')
        try:
            chosen = lines[int(input('番号: ')) - 1]
        except (ValueError, IndexError, EOFError):
            chosen = ''
    return chosen.split()[0] if chosen else ''


def run_action(target_window_id: int, action: str, timer_id: int | None) -> None:
    boss = get_boss()
    w = boss.window_id_map.get(target_window_id)
    boss.combine(action, w)


def handle_result(args: list[str], answer: str, target_window_id: int, boss: Boss) -> None:
    if answer:
        # overlay が閉じてから実行する（hints などが palette の画面を拾わないように）
        add_timer(partial(run_action, target_window_id, answer), 0, False)


if __name__ == '__main__':
    print(main(sys.argv))
