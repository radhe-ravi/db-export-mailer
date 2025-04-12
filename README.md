# sql-exporter

A simple and configurable shell-based tool that:
- Runs SQL queries against a PostgreSQL database
- Exports results as CSV files
- Packages them into a ZIP archive
- Uploads the archive to AWS S3
- Sends a pre-signed download link via email

---

## 📁 Project Structure


---

## ⚙️ Configuration

Update the following values in `config/config.env`:

```env
# Database
DB_HOST=your-db-host
DB_PORT=5432
DB_NAME=your-db-name
DB_USER=your-db-user
DB_PASSWORD=your-password

# AWS S3
BUCKET_NAME=your-bucket
FOLDER=exports
S3_REGION=ap-south-1

# Email
TO_EMAIL=recipient@example.com
FROM_EMAIL=sender@example.com
API_URL=https://your-email-api

🧪 Usage
Run the full export flow:

make run

Or manually:

bash bin/run.sh

📥 Add Queries

Place your SQL files inside the queries/ folder.
Each .sql file will be executed and exported to its own CSV file.

Example:

queries/
├── products.sql
├── customers.sql

Each file should contain a valid SELECT query.

✅ Output

    ZIP archive with CSV exports

    Uploaded to S3

    Pre-signed download link sent via email


🧹 Clean Up

To delete ZIPs and temporary CSV files:

make clean