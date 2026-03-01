# OmnEmoji Addon

This is the **distributable addon folder**. Copy this entire folder to your Godot project's `addons/` directory.

## Quick Start

1. Copy `omnemoji/` to `your_project/addons/`
2. Enable "OmnEmoji" in **Project Settings → Plugins**
3. Done! Emojis now work everywhere 🎉

**Default fonts are bundled** — no downloads required for basic use.

## Bundled Fonts

| Font | Type | Size | License |
|------|------|------|---------||
| Noto Color Emoji | Emoji | ~10 MB | SIL OFL 1.1 |
| Noto Sans | Text | ~0.6 MB | SIL OFL 1.1 |

**Total bundle size: ~11 MB**

Additional providers (OpenMoji, Twemoji, Fluent, EmojiOne) are downloaded on-demand when selected.

## Contents

- `plugin.cfg` — Addon metadata  
- `gd_omnemojis_plugin.gd` — Main plugin (auto font injection)
- `font_providers.gd` — Font provider registry (loads from JSON)
- `font_downloader.gd` — Async font downloader with ZIP support
- `providers/` — JSON provider definitions
  - `emoji_providers.json` — Emoji font providers
  - `text_providers.json` — Text font providers
- `exporter/` — Export plugin for bundling fonts
- `resources/` — Font resources (text + emoji fonts with fallback chain)
- `third_party/` — Bundled and downloaded fonts

## How It Works

When enabled, the plugin:
1. Loads bundled fonts (or downloads selected provider)
2. Creates a font chain: text font → emoji font (fallback)
3. Sets this as the project's default font (`gui/theme/custom_font`)
4. Registers an export plugin to ensure fonts are bundled in exports

## Customization

Edit the JSON files in `providers/` to add custom font sources:
- No code changes required
- Add mirrors for reliability
- Support for direct downloads and ZIP archives

See `emoji_providers.json` for format examples.

## License

- **Code**: MIT License
- **Fonts**: Various open licenses (SIL OFL, CC BY-SA, MIT)

See `THIRD_PARTY.md` for full attribution.
