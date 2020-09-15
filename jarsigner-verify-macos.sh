export JAVA_HOME=${/usr/libexec/java_home}
export PATH=${JAVA_HOME}/bin:$PATH
cd /lamw/projects/databubble
jarsigner -verify -verbose -certs /lamw/projects/databubble/bin/databubble-release.apk
