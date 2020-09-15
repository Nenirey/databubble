export PATH=/lamw/SDK/platform-tools:$PATH
export GRADLE_HOME=/lamw/gradle-4.4.1/
export PATH=$PATH:$GRADLE_HOME/bin
source ~/.bashrc
gradle clean build --info
