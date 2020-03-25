if [[ $@ == "http" ]]; then
    curl -sf localhost:10080
    if [[ $? -ne 0 ]]; then
        return 1
    fi
elif [[ $@ == "stream" ]]; then
    curl -sf localhost:10081
    if [[ $? -ne 52 ]]; then
        return 1
    fi
fi
