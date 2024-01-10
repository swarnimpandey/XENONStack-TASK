Important: You need to have linux environment.
Create file with name: internsctl.sh

#internsctl.sh - Custom Linux Command

##Description
`internsctl.sh` is a custom Linux command designed to perform various system-related operations. It provides functionalities for getting CPU and memory information, managing users, and retrieving file information.

To make the script executable, you can run the following commands:
chmod +x internsctl
#Version
Current Version: v0.1.0

#Commands
To display help information:

```bash
./internsctl --help

#To check the version:
./internsctl --version

#To get CPU information:
./internsctl cpu

#To get memory information:
./internsctl memory

#Create a new user:
./internsctl user create swarnim

#To list all regular users:
./internsctl user list

#To list users with sudo permissions:
./internsctl user list --sudo-only

#To get information about a file:
./internsctl file getinfo <file-name>

Author
Swarnim Aditya Pandey
```
