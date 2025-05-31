"MacSecureCheck"

![License](https://img.shields.io/badge/License-MIT-blue)
![Repo Size](https://img.shields.io/github/repo-size/2002TAS/MacSecureCheck?color=gray)
![Last Commit](https://img.shields.io/github/last-commit/2002TAS/MacSecureCheck?color=black)

"MacSecureCheck" is a macOS system protection status checker script. It provides a snapshot of important security features and system information, making it easy to audit your system’s protection status.

## Features

- System Integrity Protection (SIP) status  
- Gatekeeper status  
- XProtect version  
- Firewall status  
- FileVault status  
- Secure Boot and Apple Silicon Secure Enclave detection  
- macOS version  
- System uptime  
- Battery health (cycle count and condition)  
- Disk space usage  
- Recent security updates  
- macOS software update status

## How to Use

Clone the repository:

"git clone https://github.com/2002TAS/MacSecureCheck.git"  
"cd MacSecureCheck"

Or download the script directly:

"curl -O https://raw.githubusercontent.com/2002TAS/MacSecureCheck/main/CheckProtection.command"  
"chmod +x CheckProtection.command"

Run the script:

"./CheckProtection.command"

## Example Output

Below are examples of the script’s output:

![MacSecureCheck Example 1](MacSecureCheck%20Image%201.png)  
![MacSecureCheck Example 2](MacSecureCheck%20Image%202.png)

## License

This project is licensed under the MIT License. See the LICENSE file for details.