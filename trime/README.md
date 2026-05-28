# Install

version: 3.3.8

- 如果安裝後第一次啟動無法開啟，就先強制關閉再打開一次
- 安裝後先部屬預設方案，確定可以正常使用
- 複製設定檔到rime資料夾後要強制關閉trime，重開之後重新build trime.yaml

```bash
adb push ../rime/* /sdcard/rime
adb push . /sdcard/rime
adb shell am force-stop com.osfans.trime
```

- Schemata: 注音-臺灣整體
- General:
    - Preferred: Whisper Voice Input
        - 設定voice Keyboard
- Virtual Keyboard:
    - Vibrate on key press
- Keyboard Style
    - Themes: 預設
    - Colors: One Dark
