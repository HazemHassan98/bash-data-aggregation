
# 🚀 run_aggregations.sh  

### 🖥️ Bash Script for Running ClickHouse Aggregation Queries  

![Bash](https://img.shields.io/badge/Bash-4EAA25?style=for-the-badge&logo=gnu-bash&logoColor=white)  
![ClickHouse](https://img.shields.io/badge/ClickHouse-FDEE21?style=for-the-badge&logo=clickhouse&logoColor=black)  

## 📌 Overview  

`run_aggregations.sh` is a Bash script that automates the execution of multiple SQL aggregation queries against a ClickHouse database. It loads queries from a specified directory and sequentially executes them to populate aggregate tables.  

## 📑 Table of Contents  

- [📌 Overview](#-overview)  
- [⚙️ How It Works](#️-how-it-works)  
- [📦 Installation & Setup](#-installation--setup)  
- [🚀 Usage](#-usage)  
- [🛠️ Configuration](#-configuration)  
- [📂 Query Directory Structure](#-query-directory-structure)  
- [🐞 Troubleshooting](#-troubleshooting)  
- [👨‍💻 Author](#-author)  

## ⚙️ How It Works  

1. Loads environment variables from a `config.env` file.  
2. Validates required variables such as `CLICKHOUSE_HOST`, `CLICKHOUSE_PORT`, and `DATABASE_NAME`.  
3. Searches for `.sql` files in the `queries/` directory.  
4. Iterates through each SQL file and executes it using the ClickHouse client.  
5. Logs execution details to a log file specified in the configuration.  

If an error occurs while executing a query, the script stops execution immediately.  

## 📦 Installation & Setup  

### 1️⃣ Prerequisites  

- Bash shell (Linux/macOS)  
- ClickHouse installed and accessible via `clickhouse-client`  
- A configured ClickHouse database  

### 2️⃣ Clone the Repository  

```bash
git clone https://github.com/your-repo/run_aggregations.git
cd run_aggregations
```

### 3️⃣ Create a Configuration File  

Copy the sample configuration file and modify it accordingly:  

```bash
cp config.env.example config.env
```

Edit `config.env` with your ClickHouse connection details:  

```
CLICKHOUSE_HOST=your-clickhouse-host
CLICKHOUSE_PORT=9000
DATABASE_NAME=your_database
LOG_FILE=aggregation.log
```

### 4️⃣ Ensure the Script is Executable  

```bash
chmod +x run_aggregations.sh
```

## 🚀 Usage  

Run the script with:  

```bash
./run_aggregations.sh
```

## 🛠️ Configuration  

| Variable          | Description                          |
|------------------|----------------------------------|
| `CLICKHOUSE_HOST` | The hostname of the ClickHouse server |
| `CLICKHOUSE_PORT` | The port used by ClickHouse       |
| `DATABASE_NAME`  | The database where queries will be executed |
| `LOG_FILE`       | Path to the log file for script execution |

## 📂 Query Directory Structure  

Ensure your SQL queries are stored in the `queries/` directory:  

```
/queries
  ├── aggregation_1.sql
  ├── aggregation_2.sql
  ├── ...
```

Each file should contain a valid ClickHouse SQL query.  

## 🐞 Troubleshooting  

- **Error: Configuration file not found**  
  - Ensure `config.env` exists and is correctly set up.  

- **Error: No SQL files found**  
  - Ensure `.sql` files are placed inside the `queries/` directory.  

- **Error: Failed to execute query**  
  - Check the `LOG_FILE` for detailed error messages.  

## 👨‍💻 Author  

**Hazem Hassan**  

---

This README is clear, structured, and visually appealing with relevant badges and sections. Let me know if you’d like any modifications! 🚀 
