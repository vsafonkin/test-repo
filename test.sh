mkdir -p "$HOME/.gradle/init.d"

if [ -d "$HOME/.gradle/init.d" ]; then
   rm -rf "$HOME/.gradle/init.d"
fi

ls $HOME/.gradle
