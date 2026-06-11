# Task reminder

A simple, local-first todo app with optional reminders. Built with Flutter.

**Made by [RBD Apps](https://www.rbdapps.com/)**

## What it does

Task reminder helps you manage everyday tasks without accounts, subscriptions, or cloud sync. Everything stays on your device.

- **Tasks** — Add, edit, delete, and mark tasks complete
- **Reminders** — Set a reminder with a quick “tomorrow at …” option or a custom date and time
- **Notifications** — Get notified when a reminder is due, with options to mark done, postpone, or dismiss
- **Postpone presets** — Configurable shortcuts (e.g. 15 min, 1 hour, tomorrow morning) when snoozing a reminder
- **Languages** — English, Spanish, German, Dutch, French, Italian, Russian, Ukrainian, and Portuguese
- **Appearance** — Light, dark, or system theme
- **Privacy** — No sign-in, no network required for core features; data stored locally with Hive

## Screens

| Screen | Purpose |
|--------|---------|
| Home | Task list (active and completed), progress summary |
| Add / Edit task | Title, notes, and reminder options |
| Settings | Language, theme, tomorrow reminder time, postpone presets, notifications |
| Reminder sheet | Actions when a notification fires |

## Requirements

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (stable channel)
- Android Studio / Xcode for emulators or device builds

## Run locally

```bash
flutter pub get
flutter run
```

Release build (Android):

```bash
flutter build appbundle --release
```

## App icon

The launcher icon is generated from:

`assets/task-reminder-logo-1024x1024.png`

Regenerate platform icons after changing the source image:

```bash
dart run flutter_launcher_icons
```

## Project info

| | |
|---|---|
| **App name** | Task reminder |
| **Package** | `com.taskreminder.task_reminder` (Android) |
| **Author** | [RBD Apps](https://www.rbdapps.com/) |

## License

Private project — not published to pub.dev.
