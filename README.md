# LÖVE Game Template for Zed

Turn your [LÖVE](https://love2d.org/) game ideas into polished multi-platform releases with this template! A [Zed](https://zed.dev/)-native fork of [Oval-Tutu/bootstrap-love2d-project](https://github.com/Oval-Tutu/bootstrap-love2d-project) — same automated build system, with the editor integration rebuilt for Zed and a linting/testing layer added. Built for LÖVE 💕

- 🛑 **Don't fork this repository directly!**
- 🟢 [**Create a new repository from this template**](https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-repository-from-a-template) for your game.

## Features

- ⚡ [Zed](https://zed.dev/)-native project configuration (`.zed/`)
  - 🌕 Rich Lua language features via the [Lua extension](https://zed.dev/extensions?query=lua) ([LuaLS](https://luals.github.io/))
    - <small>`.luarc.json` configures LuaJIT, the `love` global, and LuaLS's bundled LÖVE API definitions — autocomplete and hover docs for every `love.*` function out of the box.</small>
  - 🎑 Deterministic Lua code formatting with [StyLua](https://github.com/JohnnyMorganz/StyLua), on save
  - 🚨 Linting with [luacheck](https://github.com/lunarmodules/luacheck) (`std = "luajit+love"`)
  - 🧪 BDD-style testing with [busted](https://lunarmodules.github.io/busted/)
  - 👨‍💻 Consistent coding styles with [Editorconfig](https://editorconfig.org/)
  - 🤖 [`AGENTS.md`](AGENTS.md) instructions for the Zed Agent and other AI coding tools
  - ️👷 Run, debug-run, build, lint, and test as Zed tasks
- 🧹 Quality workflow on every push: StyLua check, luacheck, and busted specs
- 📦 GitHub Actions for automated builds - compatible with [act](https://nektosact.com/)
  - 🤖 Android (.aab and .apk)
  - 📱 iOS (.ipa)
  - 🌐 HTML5
  - 🐧 Linux (.AppImage and tarball)
  - 🍏 macOS (App bundle and .dmg Disk Image)
  - 🪟 Windows (Installer, SFX .exe and .zip)
  - 🔐 [lua-https](https://github.com/love2d/lua-https) built-in to LÖVE 11.5
  - ⤴️ Automatic publishing to [itch.io](https://itch.io/)
- ️⚙️ [Shared product configuration](game/product.env) between the game and the GitHub Actions
- 🎮 [SteamOS DevKit](https://gitlab.steamos.cloud/devkit/steamos-devkit) integration
- 📊 Integrated performance metrics overlay
- ️❄️ Nix flake to provision a dev shell

### Prerequisites

- [Zed](https://zed.dev/) with the [Lua extension](https://zed.dev/extensions?query=lua)
- [LÖVE 11.5](https://love2d.org/) (*currently only 11.5 is supported*)
  - **`love` should be in your `PATH`**
- [StyLua](https://github.com/JohnnyMorganz/StyLua) (`cargo install stylua`, or a [release binary](https://github.com/JohnnyMorganz/StyLua/releases))
- `bash`
- `7z`
- [`luacheck`](https://github.com/lunarmodules/luacheck) and [`busted`](https://lunarmodules.github.io/busted/) (*optional locally — CI runs them regardless*)
  - `luarocks install --local luacheck busted` (needs `lua`, headers, and a C compiler; on Fedora: `sudo dnf install lua lua-devel gcc luarocks`)
- [`miniserve`](https://github.com/svenstaro/miniserve) (*optional ️for local testing of HTML builds*)

## Platform Support

| Platform | Artifact Type | Extension        | Store      | lua-https |
|----------|---------------|------------------|------------|-----------|
| Android  | App Bundle    | `.aab`           | Play Store | ✅        |
| Android  | Package       | `.apk`           | Itch.io    | ✅        |
| iOS      | App Archive   | `.ipa`           | App Store  | ️🚧        |
| Linux    | AppImage      | `.AppImage`      | Itch.io    | ✅        |
| Linux    | Tarball       | `.tar.gz`        | Steam      | ✅        |
| macOS    | App Bundle    | `.app.zip`       | Steam      | ✅        |
| macOS    | Disk Image    | `.dmg`           | Itch.io    | ✅        |
| Web      | HTML5         | `-html.zip`      | Itch.io    | ❌        |
| Windows  | Install       | `-installer.exe` | Itch.io    | ✅        |
| Windows  | SFX           | `.exe`           | Itch.io    | ✅        |
| Windows  | ZIP           | `.zip`           | Steam      | ✅        |
| LÖVE     | Game          | `.love`          | -          | ️️✔️        |

- The Store column indicates which store front the artifact is best suited for.
- The lua-https column indicates if supplemental HTTPS support is included with LÖVE 11.5 builds
  - The `.love` file includes https native libraries for supported platforms, see [**USAGE.md**](USAGE.md) for more details.

## Quick Start

- **Don't fork this repository directly!**
- [**Create a new repository from this template**](https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-repository-from-a-template) for your game, then clone that repository.
- Open the project folder in [Zed](https://zed.dev/) (`zed .`)
  - Install the **Lua** extension if you haven't already (`zed: extensions` from the command palette).
- Remove our example *"game"* by:
  - Rename `game/main.template.lua` to `game/main.lua`.
  - Delete `game/eyes` directory.
- Configure [`game/product.env`](game/product.env) and [`game/conf.lua`](game/conf.lua) with the settings specific to your game.
  - Disable any platforms you do not want to target.
  - Full details on configuration can be found in the [**USAGE.md**](USAGE.md) file.
- Replace `resources/icon.png` with your game's high-resolution icon.
- If you are targeting Android, you need to create a keystore for signing your game; full details are in the [**USAGE.md**](USAGE.md) file.
- If you want to publish your game to [itch.io](https://itch.io/), you need to add [`BUTLER_API_KEY`](https://itch.io/user/settings/api-keys) to your GitHub repository; full details are in the [**USAGE.md**](USAGE.md) file.

### Running

All project tasks live in [`.zed/tasks.json`](.zed/tasks.json). Open the task picker with `task: spawn` from the command palette (or bind a key — see the comment in that file):

- **Run game** — `love game/`
- **Run game (debug)** — `love game/ debug`; errors crash with a full traceback instead of LÖVE's error screen
- **Lint (luacheck)** and **Test (busted)** — the same checks CI runs

Re-run the last task any time with `task: rerun`.

### Building

Builds a date stamped `.love` file and puts it in the `builds` folder.

- Spawn the **Build .love package** task.

### Performance Metrics

When the game is running you can access the performance metrics overlay by pressing <kbd>F3</kbd>.

#### Keyboard Controls

- <kbd>F3</kbd>: Toggle Overlay
- <kbd>F5</kbd>: Toggle VSync (only when benchmark is active)

#### Controller Controls

- Select + A: Toggle Overlay
- Select + B: Toggle VSync

#### Touch Controls

- Double Tap top right corner: Toggle Overlay
- Double Tap the overlay itself: Toggle VSync

### How to Register/Unregister Particle Systems for performance metrics

#### Basic Usage

```lua
-- When creating a particle system
local particleSystem = love.graphics.newParticleSystem(imageData)
overlayStats.registerParticleSystem(particleSystem)

-- Later, when you no longer need the particle system
overlayStats.unregisterParticleSystem(particleSystem)
```

#### Implementation Details

- **Where to register**: After creating any particle system you want tracked in your stats overlay
- **When to register**: Immediately after creating the particle system, typically in your load/initialization code
- **When to unregister**: When destroying the particle system or when it's no longer relevant to track
- **Implementation note**: Only active particle systems (`particleSystem:isActive()`) are counted

## Detailed Documentation

- [**USAGE.md**](USAGE.md)

For more detailed technical information about development workflows, build configurations, and deployment processes, please see [**USAGE.md**](USAGE.md). This companion document covers:

- Complete project structure and file organization
- Project configuration and settings
- Local development and GitHub Actions workflow details
- Platform-specific build configurations
- Release management and publishing workflows
- Web deployment configurations
- Android signing setup
- Local testing procedures

## References

A fork of [Oval-Tutu/bootstrap-love2d-project](https://github.com/Oval-Tutu/bootstrap-love2d-project), which was itself inspired by and adapted from [LOVE VSCode Game Template](https://github.com/Keyslam/LOVE-VSCode-Game-Template), [LÖVE Actions](https://github.com/love-actions) and [love.js player](https://github.com/2dengine/love.js) from [2dengine](https://2dengine.com/).


### Credits

The sample "game" included in this template uses the following assets:
- [Aargh! (male screams)](https://opengameart.org/content/aargh-male-screams)
- [Eyeballs](https://opengameart.org/content/eyeballs)
- [Fireplace Sound Loop](https://opengameart.org/content/fireplace-sound-loop)
- [Parallax Backgrounds](https://opengameart.org/content/3-parallax-backgrounds)
