set JAVA_HOME=C:\Program Files\Java\jdk1.8.0_181
set PATH=%JAVA_HOME%\bin;%PATH%
set JAVA_TOOL_OPTIONS=-Duser.language=en
cd D:\lamw\projects\databubble
keytool -genkey -v -keystore databubble-release.keystore -alias databubble.keyalias -keyalg RSA -keysize 2048 -validity 10000 < D:\lamw\projects\databubble\keytool_input.txt
