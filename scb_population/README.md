# SCB ETL Pipeline — dbt Star Schema

A data transformation project using dbt (Data Build Tool) to model Swedish population data into a star schema for analytical use. Built on top of the PostgreSQL pipeline from [scb-etl-postgres-docker](https://github.com/serhatdogan-tech/scb-etl-postgres-docker).

## Project Overview

This project takes raw population data already loaded into PostgreSQL and transforms it into a dimensional star schema using dbt. The resulting model enables efficient analytical queries and serves as the data foundation for Power BI dashboards.

## Tech Stack

- **dbt Core** — data transformation and modelling
- **dbt-postgres** — PostgreSQL adapter for dbt
- **PostgreSQL** — target database (running in Docker)
- **SQL** — transformation logic
- **YAML** — schema definitions, tests and documentation

## Star Schema Design

```
             dim_region
             (region_id PK,
              region_code,
              region_name)
                  ↑
fact_population ──┤
(region_id FK,    │
 time_id FK,      ↓
 population,  dim_time
 growth)      (time_id PK,
               year)
```

## Project Structure

```
scb-etl-dbt-starschema/
├── scb_population/
│   ├── models/
│   │   ├── staging/
│   │   │   ├── sources.yml
│   │   │   └── stg_population.sql
│   │   └── marts/
│   │       ├── schema.yml
│   │       ├── dim_region.sql
│   │       ├── dim_time.sql
│   │       └── fact_population.sql
│   └── dbt_project.yml
└── README.md
```

## Setup Instructions

### Prerequisites
- Python 3.10+
- Docker Desktop
- PostgreSQL container from scb-etl-postgres-docker running with population data loaded

### 1. Clone the repository

```bash
git clone https://github.com/serhatdogan-tech/scb-etl-dbt-starschema.git
cd scb-etl-dbt-starschema
```

### 2. Create and activate virtual environment

```bash
python -m venv venv
source venv/Scripts/Activate
```

### 3. Install dependencies

```bash
pip install dbt-core dbt-postgres
```

### 4. Configure dbt profile

```bash
dbt init scb_population
```

### 5. Verify connection

```bash
cd scb_population
dbt debug
```

### 6. Run the models

```bash
dbt run
```

### 7. Run tests

```bash
dbt test
```

### 8. Generate and view documentation

```bash
dbt docs generate
dbt docs serve
```

## Models

| Model | Type | Description |
|---|---|---|
| stg_population | View | Staging layer — renames columns from raw source |
| dim_region | Table | 22 Swedish counties + national aggregate with surrogate keys |
| dim_time | Table | 57 years (1968–2024) with surrogate keys |
| fact_population | Table | 1254 rows of population and growth metrics |

## Data Tests

12 automated data tests defined in schema.yml:
- **unique** — no duplicate values in ID columns
- **not_null** — no missing values in key columns

## Future Improvements

- Add column-level descriptions to schema.yml for richer documentation
- Add accepted_values tests for region codes
- Extend star schema with additional dimension tables
- Connect to Apache Airflow for automated pipeline orchestration (Project 4)