export JAVA_HOME=${/usr/libexec/java_home}
export PATH=${JAVA_HOME}/bin:$PATH
cd /lamw/projects/databubble
keytool -genkey -v -keystore databubble-release.keystore -alias databubble.keyalias -keyalg RSA -keysize 2048 -validity 10000 < /lamw/projects/databubble/keytool_input.txt
