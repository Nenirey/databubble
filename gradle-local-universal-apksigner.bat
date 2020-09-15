set Path=%PATH%;D:\lamw\SDK\platform-tools;D:\lamw\SDK\build-tools\29.0.0
set GRADLE_HOME=D:\lamw\gradle-4.4.1
set PATH=%PATH%;%GRADLE_HOME%\bin
zipalign -v -p 4 D:\lamw\projects\databubble\build\outputs\apk\release\databubble-universal-release-unsigned.apk D:\lamw\projects\databubble\build\outputs\apk\release\databubble-universal-release-unsigned-aligned.apk
apksigner sign --ks databubble-release.keystore --out D:\lamw\projects\databubble\build\outputs\apk\release\databubble-release.apk D:\lamw\projects\databubble\build\outputs\apk\release\databubble-universal-release-unsigned-aligned.apk
