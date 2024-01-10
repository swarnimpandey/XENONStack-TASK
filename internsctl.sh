#!/bin/bash

VERSION="v0.1.0"

show_help() {
    echo "Usage: internsctl [OPTIONS] COMMAND [ARGS]"
    echo "Custom Linux command for operations."
    echo ""
    echo "Options:"
    echo "  --help     Show this help message"
    echo "  --version  Show version information"
    echo ""
    echo "Commands:"
    echo "  cpu        Get CPU information"
    echo "  memory     Get memory information"
    echo "  user       Manage users"
    echo "  file       Get file information"
}

show_version() {
    echo "internsctl $VERSION"
}

# Function to get CPU information
get_cpu_info() {
    lscpu
}

# Function to get memory information
get_memory_info() {
    free
}

# Function to create a new user
create_user() {
    if [ -z "$1" ]; then
        echo "Error: Please provide a username."
        exit 1
    fi

    sudo useradd -m "$1"
    sudo passwd "$1"
}

# Function to list users
list_users() {
    if [ "$1" = "--sudo-only" ]; then
        getent passwd | cut -d: -f1,3,4 | awk -F: '$2 >= 1000 {print $1}' | xargs groups | grep -w sudo | cut -d: -f1
    else
        getent passwd | cut -d: -f1
    fi
}

# Function to get file information
get_file_info() {
    if [ -z "$1" ]; then
        echo "Error: Please provide a file name."
        exit 1
    fi

    file="$1"
    size=$(stat --printf="%s" "$file")
    permissions=$(stat --printf="%A" "$file")
    owner=$(stat --printf="%U" "$file")
    last_modified=$(stat --printf="%y" "$file")

    echo "File: $file"
    echo "Access: $permissions"
    echo "Size(B): $size"
    echo "Owner: $owner"
    echo "Modify: $last_modified"
}

# Parse command line options
while [[ "$#" -gt 0 ]]; do
    case $1 in
        --help)
            show_help
            exit 0
            ;;
        --version)
            show_version
            exit 0
            ;;
        *)
            break
            ;;
    esac
    shift
done

# Parse commands
case "$1" in
    cpu)
        get_cpu_info
        ;;
    memory)
        get_memory_info
        ;;
    user)
        shift
        case "$1" in
            create)
                shift
                create_user "$1"
                ;;
            list)
                shift
                list_users "$1"
                ;;
            *)
                echo "Error: Unknown user command."
                show_help
                exit 1
                ;;
        esac
        ;;
    file)
        shift
        case "$1" in
            getinfo)
                shift
                get_file_info "$1"
                ;;
            *)
                echo "Error: Unknown file command."
                show_help
                exit 1
                ;;
        esac
        ;;
    *)
        echo "Error: Unknown command."
        show_help
        exit 1
        ;;
esac
