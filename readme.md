# 🚲 Divvy Bike-Share Data Analysis

![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)
![SQL](https://img.shields.io/badge/SQL-4479A1?style=flat&logo=mysql&logoColor=white)

## 📋 About The Project

Comprehensive analysis of Divvy bike-sharing system data for 2023, exploring ride patterns, user behavior, and system usage through SQL queries.

### 🛠️ Built With

* MySQL/MariaDB
* SQL
* Divvy Public Dataset

## 🚀 Getting Started

### Prerequisites

* MySQL or MariaDB database
* Sufficient storage for 12 months of trip data
* SQL execution privileges

### Installation

1. Clone the repository
   ```sh
   git clone https://github.com/yourusername/divvy-analysis.git
   ```
2. Import monthly Divvy datasets into your database
3. Run the table combination query
4. Execute the analysis query

## 💻 Usage

### Step 1: Combine Monthly Data

```sql
CREATE table `combined_table_2023`
SELECT *
FROM `202301_divvy_tripdata`
UNION ALL
SELECT *
FROM `202302_divvy_tripdata`
-- ... continues for all months
```

### Step 2: Run Analysis

```sql
SELECT
    member_casual,
    rideable_type,
    cast(str_to_date(substring_index(started_at, ' ', 1),'%Y-%m-%d') as date) as date,
    -- ... continues with all transformations
```

## 📊 Data Structure

### Input Tables
- 12 monthly tables (January through December 2023)
- Consistent schema across all tables

### Output Columns
| Column | Description |
|--------|-------------|
| member_casual | User type (member/casual) |
| rideable_type | Type of bicycle |
| date | Ride date |
| start_time | Ride start time |
| end_time | Ride end time |
| duration | Calculated ride duration |
| time_bucket | Duration category |
| weekday | Day of the week |

### Time Buckets
- 0-5 minutes
- 5-10 minutes
- 10-30 minutes
- 30-60 minutes
- 60+ minutes

## 🤝 Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 License

Distributed under the MIT License. See `LICENSE` for more information.
