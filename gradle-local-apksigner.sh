export PATH=/lamw/SDK/platform-tools:$PATH
export PATH=/lamw/SDK/build-tools/29.0.0:$PATH
export GRADLE_HOME=/lamw/gradle-4.4.1
export PATH=$PATH:$GRADLE_HOME/bin
zipalign -v -p 4 /lamw/projects/databubble/build/outputs/apk/release/databubble-release-unsigned.apk D:\lamw\projects\databubble/build/outputs/apk/release/databubble-release-unsigned-aligned.apk
apksigner sign --ks databubble-release.keystore --out /lamw/projects/databubble/build/outputs/apk/release/databubble-release.apk D:\lamw\projects\databubble/build/outputs/apk/release/databubble-release-unsigned-aligned.apk
