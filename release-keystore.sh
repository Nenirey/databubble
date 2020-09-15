export JAVA_HOME=/Program Files/Java/jdk1.8.0_181
cd /lamw/projects/databubble
keytool -genkey -v -keystore databubble-release.keystore -alias databubble.keyalias -keyalg RSA -keysize 2048 -validity 10000 < /lamw/projects/databubble/keytool_input.txt
