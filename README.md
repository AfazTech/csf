
# ConfigServer Security & Firewall (CSF) - AfazTech Fork

[![License: GPLv3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
[![GitHub stars](https://img.shields.io/github/stars/AfazTech/csf?style=social)](https://github.com/AfazTech/csf)

**ConfigServer Security & Firewall (CSF)** is a Stateful Packet Inspection (SPI) firewall, Login Failure Daemon (LFD) and security suite for Linux servers.

This is a maintained fork of the original CSF after ConfigServer (Way to the Web Ltd) shut down in August 2025 and released the code under the **GPLv3** license.

---

## Features

- Stateful Packet Inspection (SPI) firewall
- Login Failure Daemon (LFD) – brute-force protection
- Extensive control panel support (cPanel, DirectAdmin, CyberPanel, CWP, Vesta, InterWorx, Webmin...)
- IP blocklists, port flood protection, connection tracking
- Process tracking, directory watching, and security checks
- Easy web UI + powerful CLI

---

## Quick Install (One-Liner)

```bash
bash <(curl -s https://raw.githubusercontent.com/AfazTech/csf/main/install.sh)
```

---

## Manual Installation

```bash
cd /usr/src
rm -rf csf* AfazTech-csf*
wget https://github.com/AfazTech/csf/archive/refs/heads/main.tar.gz -O csf.tar.gz
tar -xzf csf.tar.gz
cd AfazTech-csf-main
sh install.sh
```

---

## After Installation

1. Check version:
```bash
csf -v
```

2. Test required modules:
```bash
perl /usr/local/csf/bin/csftest.pl
```

3. **Important:** Disable auto-updates (recommended)
```bash
sed -i 's/AUTO_UPDATES = "1"/AUTO_UPDATES = "0"/' /etc/csf/csf.conf
csf -r
```

4. Open CSF configuration:
```bash
nano /etc/csf/csf.conf
```
- Set `TESTING = "0"` when you are ready
- Adjust allowed ports (`TCP_IN`, `TCP_OUT`, etc.)

---

## Uninstall

```bash
cd /etc/csf
sh uninstall.sh
```

---

## Supported Control Panels

| Panel          | Status     |
|----------------|------------|
| cPanel / WHM   | Supported  |
| DirectAdmin    | Supported  |
| CyberPanel     | Supported  |
| CentOS Web Panel (CWP) | Supported |
| VestaCP        | Supported  |
| InterWorx      | Supported  |
| Webmin         | Supported  |
| Generic Linux  | Supported  |

---

## Notes

- Original project by Way to the Web Ltd (ConfigServer)
- Released under **GNU General Public License v3 (GPLv3)**
- This fork is community-maintained and focused on keeping CSF usable after the original project ended.

---

## License

This project is licensed under the **GNU General Public License v3.0**.  
See the [LICENSE](LICENSE) file for details.

---

**Maintained by:** [AfazTech](https://github.com/AfazTech)