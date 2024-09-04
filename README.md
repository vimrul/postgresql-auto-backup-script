# PostgreSQL Backup Script

This repository contains a bash script to automate the process of taking individual backups for each PostgreSQL database, transferring the backups to a remote server, and managing the retention of old backups. The script is designed to make database backups easy and reliable, especially for environments that need remote storage.

## Features

- **Automated Backups**: The script connects to a PostgreSQL server, takes individual backups for each database, and stores them with timestamps.
- **Remote Transfer**: Backups are securely transferred to a remote server using `sshpass` and `scp`.
- **Backup Retention**: The script automatically deletes local backups older than the configured retention period.

## When to Use This Script

This script is useful when you need to:
- Automate regular backups of multiple PostgreSQL databases.
- Store database backups on a remote server for redundancy.
- Maintain backup retention to prevent storage overload.

For example:
- Daily or periodic backups of production databases.
- Backing up PostgreSQL databases in a development or staging environment and transferring them to a remote location for safekeeping.

## Requirements

- `psql` and `pg_dump` installed and configured on the server where the script runs.
- `sshpass` installed for automating the remote transfer using password-based authentication.
- Passwordless `psql` access or the use of environment variables for PostgreSQL password authentication.

## Usage

Clone the Repository
git clone https://github.com/yourusername/postgresql-backup-script.git cd postgresql-backup-script

Configure the Script
Edit the script and replace the placeholders with your actual details:

REMOTE_USER: Username for the remote server. REMOTE_HOST: IP or hostname of the remote server. REMOTE_PASSWORD: Password for the remote server. REMOTE_FOLDER: Folder on the remote server where backups will be stored. PG_HOST: Hostname or IP of the PostgreSQL server. PG_PORT: PostgreSQL server port. PG_USER: PostgreSQL username. BACKUP_RETENTION_DAYS: The number of days to keep local backups.

Run the Script
You can run the script manually by executing:

./backup_postgresql.sh

This will:

Take a backup of each PostgreSQL database. Store the backups in the local directory /tmp/pg_backups (configurable). Transfer the backups to the remote server. Delete local backups older than the specified retention period.

Automating the Script with Cron
To automate the backup process, you can set up a cron job to run the script at regular intervals.

Example Cron Setup:

Open the crontab editor:

crontab -e

Add the following line to run the backup script every day at 2 AM:

0 2 * * * /path/to/backup_postgresql.sh

This will:

Run the script daily at 2:00 AM. Perform the backup process without manual intervention.


## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Contributions

Contributions are welcome! Feel free to open an issue or submit a pull request.

## Author

[Imrul](https://imrul.net)

## Contact

For any inquiries, please contact me at [hello@imrul.net](mailto:hello@imrul.net).
