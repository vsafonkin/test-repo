download_with_retries() {
# Due to restrictions of bash functions, positional arguments are used here.
# In case if you using latest argument NAME, you should also set value to all previous parameters.
# Example: download_with_retries $ANDROID_SDK_URL "." "android_sdk.zip"
    local URL="$1"
    local DEST="${2:-.}"
    local NAME="${3:-${URL##*/}}"
    local COMPRESSED="$4"

    if [[ $COMPRESSED == "compressed" ]]; then
        COMMAND="sudo curl $URL -4 -sL --no-buffer --compressed -o '$DEST/$NAME'"
    else
        COMMAND="sudo curl $URL -4 -sL --no-buffer -o '$DEST/$NAME'"
    fi

    echo "Downloading $URL..."
    retries=20
    interval=30
    while [ $retries -gt 0 ]; do
        ((retries--))
        eval $COMMAND
        if [ $? != 0 ]; then
            echo "Unable to download $URL, next attempt in $interval sec, $retries attempts left"
            sleep $interval
        else
            echo "$URL was downloaded successfully to $DEST/$NAME"
            return 0
        fi
    done

    echo "Could not download $URL"
    return 1
}

NUGET_URL="https://dist.nuget.org/win-x86-commandline/v5.3.1/nuget.exe"
echo "Installing nuget v5.3.1 for Mono"
sudo bash -c "$(declare -f download_with_retries); download_with_retries $NUGET_URL '.' 'nuget.exe'"
# download_with_retries $NUGET_URL "." "nuget.exe"
