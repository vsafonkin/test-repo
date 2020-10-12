install_clt() {
    echo "Searching online for the Command Line Tools"
    # This temporary file prompts the 'softwareupdate' utility to list the Command Line Tools
    clt_placeholder="/tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress"
    sudo touch $clt_placeholder
    clt_label_command="/usr/sbin/softwareupdate -l |
                        grep -B 1 -E 'Command Line Tools' |
                        awk -F'*' '/^ *\\*/ {print \$2}' |
                        sed -e 's/^ *Label: //' -e 's/^ *//' |
                        sort -V |
                        tail -n1"
    retries=30
    sleepInterval=60
    until [[ $retries -le 0 ]]; do
        clt_label=$clt_label_command
        if [[ -z "$clt_label" ]]; then
            ((retries--))
        else
            echo "$clt_label_command found"
            break
        fi
        if [[ $retries -eq 0 ]]; then
            echo "Unable to find command line tools, all the attempts exhausted"
            exit 1
        fi
        echo "Unable to find command line tools, wait for $sleepInterval seconds, $retries attempts left"
        sleep $sleepInterval
    done
    # if [[ -n "$clt_label" ]]; then
    # echo "Installing $clt_label"
    # sudo "/usr/sbin/softwareupdate" "-i" "$clt_label"
    # sudo "/bin/rm" "-f" "$clt_placeholder"
    # sudo "/usr/bin/xcode-select" "--switch" "/Library/Developer/CommandLineTools"
    # fi
}

install_clt