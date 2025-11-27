# SysGuardian

SysGuardian is a modular, command-line based system auditing toolkit written in Bash.  
It provides essential system monitoring functions such as CPU usage, memory status, disk usage, network information, and firewall status.  
The project is structured to allow gradual expansion as additional modules or features are developed.

This repository is intended for learning, portfolio building, and practical system administration practice.

---

## Purpose of This Project

SysGuardian was created to serve as a foundational Linux toolkit that can be improved over time.  
It demonstrates:

- Bash scripting skills  
- Modular tool design  
- System auditing fundamentals  
- Practical use of Linux utilities  
- Clean project organization  
- Documentation and maintainability best practices  

SysGuardian is intentionally simple in Version 1.0, making it easy to understand while leaving room for continuous improvement.

---

## Current Features (Version 1.0)

SysGuardian currently supports the following system checks:

1. CPU usage  
2. Memory usage  
3. Disk space summary  
4. Network interface and IP information  
5. Firewall status check  

Each feature is contained within a module located in the `modules/` directory.

---

## Project Structure

SysGuardian/
├── sysguardian.sh Main menu script
├── modules/
│ ├── cpu.sh CPU usage check
│ ├── memory.sh Memory status check
│ ├── disk.sh Disk usage summary
│ ├── network.sh Network and IP information
│ └── firewall.sh Firewall status check
├── logs/
│ └── sysguardian.log Log file (auto-created)
├── .gitignore
├── LICENSE
└── README.md
