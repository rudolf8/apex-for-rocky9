# Oracle 23c AI Database Installation Script for Rocky Linux 9

This project provides a comprehensive bash script to streamline the installation of Oracle 23AI Free Database, Oracle APEX 24, and Oracle ORDS on Rocky Linux 9. The script automates the setup process, ensuring a smooth and efficient installation experience.

## Features
- **Oracle 23AI Free Database**: Installs the latest Oracle 23AI Free database, enabling advanced AI capabilities and vector search functionalities.
- **Oracle APEX 24**: Sets up Oracle Application Express (APEX) 24, a powerful, web-based development platform for building enterprise applications.
- **Oracle ORDS**: Configures Oracle REST Data Services (ORDS), facilitating the creation of RESTful web services for your Oracle Database.

## Requirements
- Rocky Linux 9
- Sufficient system resources (memory, CPU, and disk space) to support Oracle Database, APEX, and ORDS.

## Installation
1. **Clone the Repository**:
   ```bash
   git clone https://github.com/rudolf8/apex-for-rocky.git
   cd apex-for-rocky
   ```

2. **Run the Script**:
   ```bash
   chmod +x apex-for-rocky.sh
   sudo ./apex-for-rocky.sh
   ```

## Script Details
The script performs the following actions:
- Updates the system and installs necessary dependencies.
- Downloads and installs Oracle 23c AI Database RPM.
- Configures Oracle APEX 24 and ORDS.
- Sets up environment variables and aliases for easy database management.

## Usage
After installation, you can access Oracle APEX at `http://your-server-ip:8080/ords`. Use the configured administrative accounts to log in and start developing your applications.

## Contributing
Contributions are welcome! Please fork the repository and submit pull requests for any improvements or bug fixes.

## License
This project is licensed under the MIT License. See the LICENSE file for details.
