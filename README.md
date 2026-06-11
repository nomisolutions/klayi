# Klayi - Keyboard Layout Indicator

<img width="265" height="246" alt="klayi" src="https://github.com/user-attachments/assets/0a973cc9-a446-4eb7-adc0-595e00dd01b9" />

This repo is for the app users community.

Please use the Issues or Discussions sections for questions, feature requests, bug reports, and sharing feedback or ideas with other users.

**Download** the app from the app store [MacOS App Store](https://apps.apple.com/us/app/klayi/id6743553507)

[Privacy Policy](https://github.com/nomisolutions/klayi-privacy)

# Supported Keyboards Firmware

## Svalboard
Keyboard official website [Svalboard](https://svalboard.com/)

- Klayi version 1.1.1 or higher [QMK Firmware Release v0.0.2](https://github.com/nomisolutions/vial-qmk/tree/v0.0.2klayi)
- Klayi version 1.0.0 or higher [QMK Firmware Release v0.0.1](https://github.com/nomisolutions/vial-qmk/releases/tag/v0.0.1klayi)

## ZSA Moonlander
Keyboard official website [Moonlander](https://www.zsa.io/moonlander)

- Klayi version 1.2.0 or higher [QMK/ZSA Firmware Release v0.1.2](https://github.com/nomisolutions/qmk_firmware)
- Klayi version 1.3.0 or higher supports the Moonlander Oryx protocol.

### Moonlander protocol options

- **Moonlander (Oryx)** uses the ZSA Oryx raw HID protocol over USB usage page `0xFF60` and usage ID `0x61`. This is the recommended option for firmware that includes the Oryx QMK module.
- **Moonlander (A)** uses the older Klayi active-layer raw HID protocol.

For implementation details, see the [ZSA Oryx QMK module](https://github.com/zsa/qmk_modules/tree/main/oryx).

## Contributions

Contributions are welcomed. If you'd like to add support for your keyboard feel free to submit a PR. If landed succesfully you will get access to TestFlight builds for the next planned or current release.

## Demo

Watch on Youtube [Layout Indicator on ZSA Moonlander](https://www.youtube.com/watch?v=tv10-MyxraA)
