should_install_clt() {
    ! [[ -e "/Library/Developer/CommandLineTools/usr/bin/git" ]]
}

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

    # retries=2
    # sleepInterval=3
    
    clt_label=$(eval $clt_label_command)
    if [[ -n "$clt_label" ]]; then
        echo "Installing $clt_label"
        sudo "/usr/sbin/softwareupdate" "-i" "$clt_label"
    fi
    sudo "/bin/rm" "-f" "$clt_placeholder"

    # until [[ $retries -le 0 ]]; do
    #     clt_label=$(eval $clt_label_command)
    #     if [[ -z "$clt_label" ]]; then
    #         ((retries--))
    #     else
    #         echo "$clt_label found"
    #         break
    #     fi
    #     if [[ $retries -eq 0 ]]; then
    #         echo "Unable to find command line tools, all the attempts exhausted"
    #         return 1
    #     fi
    #     echo "Unable to find command line tools, wait for $sleepInterval seconds, $retries attempts left"
    #     sleep $sleepInterval
    # done

    # echo "Installing $clt_label"
    # sudo "/usr/sbin/softwareupdate" "-i" "$clt_label"
    # sudo "/bin/rm" "-f" "$clt_placeholder"
}

retries=2
sleepInterval=30

until [ $retries -ge 0 ]; do
    if should_install_clt; then
        install_clt
        ((retries--))
    else
        echo "Xcode command line tools are installed"
        sudo "/usr/bin/xcode-select" "--switch" "/Library/Developer/CommandLineTools"
        exit 0   
    fi
    sleep $sleepInterval
done