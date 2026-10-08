# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

HarmonyOS (鸿蒙) music player app built with ArkTS, targeting HarmonyOS NEXT (API 6.0.1). Bundle name: `com.roy.music`. Currently in early scaffold stage — the default template with a "Hello World" page. The full feature spec is in `需求文档.txt` (Chinese).

## Build & Development

- **IDE**: DevEco Studio (required for building, signing, and device deployment)
- **Build system**: Hvigor (HarmonyOS build tool)
- **Build command**: Use DevEco Studio's Build menu; CLI build via `hvigorw assembleHap` from the project root
- **Run on device/emulator**: Use DevEco Studio's Run button. The app loads `pages/Index` via `EntryAbility.onWindowStageCreate()`
- **SDK**: `targetSdkVersion` 6.0.1(21), `compatibleSdkVersion` 6.0.1(21), `runtimeOS: HarmonyOS`

## Testing

Test framework: `@ohos/hypium` (HarmonyOS testing library).

- **Local unit tests** (`entry/src/test/`): Run in DevEco Studio via right-click → Run on the test file or directory. Test entry: `List.test.ets` → `LocalUnit.test.ets`
- **Device/integration tests** (`entry/src/ohosTest/`): Deploy to device/emulator. Test entry: `List.test.ets` → `Ability.test.ets`
- Tests use standard `describe`/`it`/`expect` API from `@ohos/hypium`

## Linting

Config in `code-linter.json5`:
- Lints `**/*.ets` files (ArkTS source)
- Rules: `@performance/recommended`, `@typescript-eslint/recommended`
- Strong crypto security rules enforced (no unsafe AES/RSA/DH/DSA/ECDSA/SHA hashes)

## Architecture

### Stage Model (HarmonyOS app model)

```
entry/
├── src/main/
│   ├── ets/
│   │   ├── entryability/EntryAbility.ets    ← Main UIAbility lifecycle
│   │   ├── entrybackupability/EntryBackupAbility.ets  ← Backup/Restore extension
│   │   └── pages/Index.ets                  ← Initial page (placeholder)
│   ├── module.json5                          ← Module config (abilities, pages)
│   └── resources/                            ← String/color/float resources, icons, page routing
├── src/ohosTest/                             ← Device tests (hypium)
├── src/test/                                 ← Local unit tests (hypium)
└── build-profile.json5                       ← Module-level build options
```

### Key files

- **`entry/src/main/module.json5`**: Declares `EntryAbility` (main), `EntryBackupAbility` (backup extension), routes pages via `$profile:main_pages`
- **`entry/src/main/resources/base/profile/main_pages.json`**: Page route table — add new pages here for the router to find them
- **`AppScope/app.json5`**: App-level config (bundle name, version, icon, label)
- **`build-profile.json5`** (root): Products, signing configs, modules list
- **`hvigorfile.ts`** (root & entry): Hvigor build entry — root uses `appTasks`, entry uses `hapTasks`, both from `@ohos/hvigor-ohos-plugin`

### Page routing

New pages must be declared in `main_pages.json` under `"src"` array. The main ability loads the first page via `windowStage.loadContent('pages/Index', ...)`. Use ArkUI's built-in router (`@ohos.router`) for navigation between pages.

### Color mode

`EntryAbility.onCreate` sets color mode to `COLOR_MODE_NOT_SET` (follow system). Dark mode color overrides live in `entry/src/main/resources/dark/element/color.json`.

## Feature spec (需求文档.txt)

The music app targets 5 main tabs: Home (discover), Search, Library/My Music, Player (core), Profile. Details are in `需求文档.txt`. The `ui/` directory at root is currently empty — intended for UI design assets or documentation.
