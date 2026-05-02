# Pong

A classic two-player Pong clone built with [LÖVE](https://love2d.org/), a 2D game framework for Lua.

## What it does

Two players control paddles on opposite sides of the screen and try to keep the ball in play. The game displays both players' scores and runs at a fixed virtual resolution scaled up to the window size.

## Technologies

- **[LÖVE](https://love2d.org/)** — 2D game framework (Lua)
- **[Lua](https://www.lua.org/)** — scripting language LÖVE uses for game logic
- **[push](https://github.com/Ulydev/push)** — virtual resolution library (`push.lua`) for pixel-perfect scaling

## Controls

| Action | Player 1 | Player 2 |
|--------|----------|----------|
| Move up | `W` | `↑` |
| Move down | `S` | `↓` |
| Quit | `Escape` | — |

## How to run

1. Install LÖVE (see below).
2. Clone or download this repository.
3. Run the game from the project directory:

```bash
love .
```

Or pass the folder path explicitly:

```bash
love /path/to/love-2d-game
```

## Installing LÖVE

### Linux

**Debian / Ubuntu:**
```bash
sudo apt install love
```

**Fedora:**
```bash
sudo dnf install love
```

**Arch:**
```bash
sudo pacman -S love
```

Or download an AppImage from the [LÖVE downloads page](https://love2d.org/#download).

### macOS

Using Homebrew:
```bash
brew install love
```

Or download the `.dmg` from [love2d.org](https://love2d.org/#download), open it, and drag LÖVE to `/Applications`.

To use `love` from the terminal after installing the app:
```bash
echo 'alias love="/Applications/love.app/Contents/MacOS/love"' >> ~/.zshrc
source ~/.zshrc
```

### Windows

1. Download the installer or zip from [love2d.org](https://love2d.org/#download).
2. Run the installer (or extract the zip).
3. Add the LÖVE folder to your `PATH`, then run:

```cmd
love C:\path\to\love-2d-game
```

Alternatively, drag the game folder onto `love.exe`.

## Links

- LÖVE website: https://love2d.org/
- LÖVE documentation: https://love2d.org/wiki/Main_Page
- LÖVE GitHub: https://github.com/love2d/love
- push library: https://github.com/Ulydev/push
