set JAVA_HOME=C:\Program Files\Java\jdk1.8.0_181
path %JAVA_HOME%\bin;%path%
cd D:\lamw\projects\databubble
jarsigner -verify -verbose -certs D:\lamw\projects\databubble\bin\databubble-release.apk
