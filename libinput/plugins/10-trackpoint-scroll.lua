-- TrackPoint を「スクロール専用」にする libinput プラグイン。
-- スティックの移動 (REL_X / REL_Y) をホイール (REL_WHEEL* / REL_HWHEEL*) に
-- 書き換えるので、ポインタは動かなくなる (ポインタはタッチパッドで動かす前提)。
-- ボタンはそのまま通す。
--
-- 配置: make libinput  (/etc/libinput/plugins/ に symlink。sudo が要る)
-- 反映: コンポジタ (KWin) が起動時に読むので、再ログインが要る。
-- 外す: sudo rm /etc/libinput/plugins/10-trackpoint-scroll.lua して再ログイン。
--
-- 動作確認 (KWin には影響しない。スティックを倒して POINTER_SCROLL_WHEEL が出れば OK):
--   sudo libinput debug-events --enable-plugins --device /dev/input/eventN
-- make libinput の後にやること。libinput 1.32.0 の --set-plugin-path は渡したパスを
-- 捨てて既定の /etc/libinput/plugins を読むので (tools/shared.c の add_path)、
-- 配置前の plugin はこのコマンドでは試せない。
--
-- API: https://wayland.freedesktop.org/libinput/doc/latest/lua-plugins.html

libinput:register({ 1 })

-- スティックの移動量 1 あたりのスクロール量 (1/120 ノッチ単位)。大きいほど速い。
local SPEED = 4
-- 横スクロールも出すか。false なら縦だけ。
local HORIZONTAL = true
-- これだけ間が空いたら端数を捨てる (µs)。
local IDLE_RESET = 500 * 1000

local states = {}

local function trunc(v)
    if v >= 0 then
        return math.floor(v)
    end
    return math.ceil(v)
end

local function new_axis()
    return { frac = 0, acc = 0 }
end

-- 高分解能 (1/120 ノッチ) を毎フレーム、従来のノッチは 120 溜まるごとに出す
-- (高分解能ホイールのマウスと同じ出し方)。
local function emit(axis, delta, hires, lores, out)
    local v = delta * SPEED + axis.frac
    local n = trunc(v)
    axis.frac = v - n
    if n == 0 then
        return
    end
    table.insert(out, { usage = hires, value = n })
    axis.acc = axis.acc + n
    local clicks = trunc(axis.acc / 120)
    if clicks ~= 0 then
        table.insert(out, { usage = lores, value = clicks })
        axis.acc = axis.acc - clicks * 120
    end
end

local function evdev_frame(device, frame, timestamp)
    local dx, dy = 0, 0
    local moved = false
    local out = {}

    for _, e in ipairs(frame) do
        if e.usage == evdev.REL_X then
            dx = dx + e.value
            moved = true
        elseif e.usage == evdev.REL_Y then
            dy = dy + e.value
            moved = true
        else
            table.insert(out, e)
        end
    end

    if not moved then
        return nil
    end

    local st = states[device]
    if timestamp - st.last > IDLE_RESET then
        st.v = new_axis()
        st.h = new_axis()
    end
    st.last = timestamp

    -- 斜めに流れないよう、フレームごとに大きい方の軸だけを使う (同じなら縦)。
    if HORIZONTAL and math.abs(dx) > math.abs(dy) then
        -- 右に倒す → 右へスクロール (REL_HWHEEL は正が右)
        emit(st.h, dx, evdev.REL_HWHEEL_HI_RES, evdev.REL_HWHEEL, out)
    else
        -- 手前に倒す (dy > 0) → 下へスクロール (REL_WHEEL は負が下)
        emit(st.v, -dy, evdev.REL_WHEEL_HI_RES, evdev.REL_WHEEL, out)
    end

    return out
end

libinput:connect("new-evdev-device", function(device)
    if not device:udev_properties()["ID_INPUT_POINTINGSTICK"] then
        return
    end

    -- TrackPoint は X/Y しか持たないので、ホイール軸を足す。
    -- libinput がデバイスを構成する前に呼ばれるので、ここで足せばホイール付きとして扱われる。
    device:enable_evdev_usage(evdev.REL_WHEEL)
    device:enable_evdev_usage(evdev.REL_WHEEL_HI_RES)
    device:enable_evdev_usage(evdev.REL_HWHEEL)
    device:enable_evdev_usage(evdev.REL_HWHEEL_HI_RES)

    states[device] = { v = new_axis(), h = new_axis(), last = 0 }
    device:connect("evdev-frame", evdev_frame)
    device:connect("device-removed", function(dev)
        states[dev] = nil
    end)

    libinput:log_info("trackpoint-scroll: " .. device:name())
end)
