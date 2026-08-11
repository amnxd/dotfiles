# Hypr Dotfiles — Hyprland Setup

This repository contains my Hyprland dotfiles, organized for readability, reuse, and easy GitHub publishing.

## Overview

The config is split into two parallel systems:

- `hyprland.conf` — the main Hyprland config loader
- `config/` — modular Hyprland config sections loaded by `hyprland.conf`
- `hyprland.lua` — the main Lua config entrypoint for `hyprland-lua`
- `lua/` — modular Lua configuration sections loaded by `hyprland.lua`

This gives me a clear separation between static Hyprland settings and Lua-powered automation.

## What is included

### Root files

- `hyprland.conf`
  - Loads the main Hyprland configuration and includes files from `config/`
- `hyprland.lua`
  - Loads the Lua-based Hyprland config and includes files from `lua/`
- `hypridle.conf`
  - Idle and power-saving behavior for Hyprland sessions
- `hyprlock.conf`
  - Lock screen appearance and behavior
- `wallpaper.png`
  - Current wallpaper image file

### Config directory

- `config/animations.conf`
  - Window and UI animation settings
- `config/autostart.conf`
  - Programs and services launched when Hyprland starts
- `config/bindings.conf`
  - Keyboard and mouse bindings
- `config/decoration.conf`
  - Window decoration and titlebar settings
- `config/general.conf`
  - Global Hyprland options and behavior
- `config/gesture.conf`
  - Touch gesture mappings and per-device pointer sensitivity
- `config/input.conf`
  - Mouse/touchpad input settings, acceleration, and scrolling
- `config/layer-rules.conf`
  - Layer surface rules such as panels and overlays
- `config/monitor.conf`
  - Monitor layout and output configuration
- `config/permission.conf`
  - Workspace and application permission rules
- `config/window-rules.conf`
  - App-specific window rules and placement
- `config/xwayland.conf`
  - XWayland behavior and fallback settings

### Lua directory

- `lua/01-xwayland.lua`
  - XWayland-specific Lua helpers and configuration
- `lua/02-monitor.lua`
  - Monitor layout setup and dynamic display handling
- `lua/03-autostart.lua`
  - Lua-driven autostart utilities
- `lua/04-env.lua`
  - Environment variables and runtime settings
- `lua/05-general.lua`
  - General Hyprland behavior and shared Lua helpers
- `lua/06-layer-rules.lua`
  - Layer rule management in Lua
- `lua/07-animation.lua`
  - Animation configuration via Lua
- `lua/08-gesture.lua`
  - Gesture setup and pointer device tuning
- `lua/09-bindings.lua`
  - Keyboard/mouse binding helpers
- `lua/10-window-rules.lua`
  - Window rule helpers and workspace rules

## Important settings to know

### Mouse / pointer sensitivity

Current active Hyprland input settings are stored in:

- `config/input.conf`
  - `sensitivity` — mouse movement sensitivity
  - `accel_profile` — acceleration profile (`flat` / `adaptive` / etc.)
  - `follow_mouse` — whether focus follows the pointer
  - `touchpad.scroll_factor` — touchpad scroll sensitivity

- `config/gesture.conf`
  - Device-specific pointer tuning for `epic-mouse-v1`

Example values:

```ini
input {
    accel_profile = flat
    follow_mouse = 1
    sensitivity = 7.0
    touchpad {
        natural_scroll = true
        scroll_factor = 10.0
    }
}

device {
    name = epic-mouse-v1
    sensitivity = 3.0
}
```

If the cursor feels slow, increase `sensitivity` in `config/input.conf`.

## How to use these dotfiles

1. Copy the full `hypr/` folder into `~/.config/hypr/`
2. Make sure `hyprland` and `hyprland-lua` are installed
3. Start Hyprland normally from your Wayland login manager or TTY

## GitHub publishing tips

To push this dotfiles folder to GitHub:

```bash
cd ~/.config/hypr
git init
git add .
git commit -m "Add Hyprland dotfiles"
git branch -M main
git remote add origin git@github.com:amnxd/hypr-dotfiles.git
git push -u origin main
```

If you prefer HTTPS:

```bash
git remote add origin https://github.com/amnxd/hypr-dotfiles.git
```

## Notes

- The `config/` directory is the active Hyprland configuration path.
- The `lua/` folder is optional and only used if `hyprland.lua` is loaded.
- Keep `hyprland.conf` and `hyprland.lua` only as loaders; most editing belongs in the modular files.

## Customization

- Change display settings in `config/monitor.conf`
- Change key bindings in `config/bindings.conf`
- Change animations in `config/animations.conf`
- Change startup apps in `config/autostart.conf`

---

This README is written to document the structure and make your dotfiles GitHub-ready.
