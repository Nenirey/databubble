set Path=%PATH%;D:\lamw\apache-ant-1.10.5\bin
set JAVA_HOME=C:\Program Files\Java\jdk1.8.0_181
cd D:\lamw\projects\databubble-appcompact\
call ant clean release
if errorlevel 1 pause
