# Third-Party Components

gd-OmnEmoji supports multiple font providers. This document lists all available options.

---

## Emoji Font Providers

### Noto Color Emoji ★ (Recommended)

| Property | Value |
|----------|-------|
| **Name** | Noto Color Emoji |
| **Format** | CBDT/CBLC |
| **Upstream** | https://github.com/googlefonts/noto-emoji |
| **License** | SIL Open Font License 1.1 (OFL) |
| **Copyright** | © Google Inc. |

### OpenMoji

| Property | Value |
|----------|-------|
| **Name** | OpenMoji |
| **Format** | CBDT/CBLC |
| **Upstream** | https://github.com/hfg-gmuend/openmoji |
| **License** | CC BY-SA 4.0 |
| **Copyright** | © OpenMoji |

### Twemoji

| Property | Value |
|----------|-------|
| **Name** | Twemoji (Mozilla Build) |
| **Format** | COLR/CPAL |
| **Upstream** | https://github.com/mozilla/twemoji-colr |
| **License** | CC BY 4.0 / MIT |
| **Copyright** | © Twitter, Inc. |

### EmojiOne Color

| Property | Value |
|----------|-------|
| **Name** | EmojiOne Color |
| **Format** | SVGinOT |
| **Upstream** | https://github.com/adobe-fonts/emojione-color |
| **License** | SIL OFL 1.1 / CC BY 4.0 |
| **Copyright** | © Adobe / EmojiOne |

### Fluent Emoji

| Property | Value |
|----------|-------|
| **Name** | Fluent Emoji (Color) |
| **Format** | CBDT/CBLC |
| **Upstream** | https://github.com/microsoft/fluentui-emoji |
| **Webfont Build** | https://github.com/tetunori/fluent-emoji-webfont |
| **License** | MIT |
| **Copyright** | © Microsoft Corporation |

---

## Text Font Providers

### Noto Sans

| Property | Value |
|----------|-------|
| **Name** | Noto Sans |
| **Upstream** | https://github.com/notofonts/latin-greek-cyrillic |
| **License** | SIL Open Font License 1.1 (OFL) |
| **Copyright** | © Google Inc. |

### Roboto

| Property | Value |
|----------|-------|
| **Name** | Roboto |
| **Upstream** | https://github.com/googlefonts/roboto |
| **License** | Apache 2.0 |
| **Copyright** | © Google Inc. |

### Inter

| Property | Value |
|----------|-------|
| **Name** | Inter |
| **Upstream** | https://github.com/rsms/inter |
| **License** | SIL Open Font License 1.1 (OFL) |
| **Copyright** | © Rasmus Andersson |

### Open Sans

| Property | Value |
|----------|-------|
| **Name** | Open Sans |
| **Upstream** | https://github.com/googlefonts/opensans |
| **License** | SIL Open Font License 1.1 (OFL) |
| **Copyright** | © Google Inc. |

### Source Sans 3

| Property | Value |
|----------|-------|
| **Name** | Source Sans 3 |
| **Upstream** | https://github.com/adobe-fonts/source-sans |
| **License** | SIL Open Font License 1.1 (OFL) |
| **Copyright** | © Adobe Inc. |

### Lato

| Property | Value |
|----------|-------|
| **Name** | Lato |
| **Upstream** | https://github.com/latofonts/lato-source |
| **License** | SIL Open Font License 1.1 (OFL) |
| **Copyright** | © Łukasz Dziedzic |

### Ubuntu

| Property | Value |
|----------|-------|
| **Name** | Ubuntu |
| **Upstream** | https://github.com/canonical/UbuntuMono-fonts |
| **License** | Ubuntu Font License |
| **Copyright** | © Canonical Ltd. |

### Fira Sans

| Property | Value |
|----------|-------|
| **Name** | Fira Sans |
| **Upstream** | https://github.com/mozilla/Fira |
| **License** | SIL Open Font License 1.1 (OFL) |
| **Copyright** | © Mozilla Foundation |

---

## Font File Locations

Bundled fonts (included with addon, ~11 MB total):
```
addons/omnemoji/third_party/
├── noto-emoji/
│   └── NotoColorEmoji.ttf      ★ Default emoji font
└── noto-sans/
    └── NotoSans-Regular.ttf    ★ Default text font
```

Downloaded on-demand (when selected):
```
├── openmoji/
│   └── OpenMoji-color-cbdt.ttf
├── twemoji/
│   └── Twemoji.Mozilla.ttf
├── emojione/
│   └── EmojiOneColor.otf
├── fluent-emoji/
│   └── FluentEmojiColor.ttf
└── ... (text font providers)
```

---

## License Notes

All fonts are used **unmodified**, as permitted by their respective licenses.

### SIL Open Font License (OFL)
- ✅ Use freely in any project
- ✅ Bundle with software
- ✅ Embed in applications
- ✅ Redistribute with attribution

### Creative Commons (CC BY / CC BY-SA)
- ✅ Use freely with attribution
- ✅ Modify and redistribute
- CC BY-SA requires derivatives to use same license

### Apache 2.0 / MIT
- ✅ Use freely
- ✅ Include license notice

---

## Format Compatibility

Godot 4.x supports:
- **CBDT/CBLC** (bitmap color emoji) ✅ Best compatibility
- **SVG-in-OpenType** ✅ Good support
- **COLR/CPAL** ✅ Supported in Godot 4.x

Not supported:
- Apple Color Emoji (EMJC)
- Windows Segoe UI Emoji (older COLR)
