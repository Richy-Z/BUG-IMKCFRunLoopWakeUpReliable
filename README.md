# BUG-IMKCFRunLoopWakeUpReliable
Character Palette logs IMKCFRunLoopWakeUpReliable Mach-port error during successful emoji insertion

Which area are you seeing an issue with?
Keyboard, Incorrect/Unexpected Behaviour, English (UK), Every app, this is system-wide, Text Input, It happens every time

## Description
When inserting an emoji from the character palette / emoji picker into a native AppKit NSTextField, HIToolbox logs the following error:
```
error messaging the mach port for IMKCFRunLoopWakeUpReliable
```

The emoji is inserted successfully, but the internal InputMethodKit or HIToolbox error keeps occurring and very much consistently during the character palette handoff.

For context, I was working on a 3D engine, ended up all the way from there to SDL, and eventually got to the bare OS with this issue. However, this reproduces very clearly in a native AppKit app using just a regular NSTextField and the standard [NSApp run] application loop.

OS info:
- macOS 26.5.2
- Build 25F84
- Intel-based Mac

I have attached a CMakeLists.txt and main.m file which are incredibly basic and easy to compile with CMake. The output should be something similar to this, once you open the emoji picker / character pallette and select an emoji:
```
2026-07-25 03:36:26.572 test[32296:2106550] Native control ready
2026-07-25 03:36:30.733 test[32296:2106550] native text: 🤣
2026-07-25 03:36:30.741 test[32296:2106550] error messaging the mach port for IMKCFRunLoopWakeUpReliable
```
