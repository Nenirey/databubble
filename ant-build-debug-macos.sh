export PATH=/lamw/apache-ant-1.10.5/bin:$PATH
export JAVA_HOME=${/usr/libexec/java_home}
export PATH=${JAVA_HOME}/bin:$PATH
cd /lamw/projects/databubble-appcompact/
ant -Dtouchtest.enabled=true debug
