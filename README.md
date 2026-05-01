# Langdale Zoo API — AWS EC2 & RDS Deployment

A RESTful Flask API for managing zoo animal data, deployed on AWS infrastructure. The application runs on an EC2 instance and connects to a PostgreSQL database hosted on AWS RDS.

## Tech Stack

- **Backend:** Python, Flask
- **Database:** PostgreSQL (AWS RDS)
- **Deployment:** AWS EC2
- **Testing:** pytest
- **Other:** Shell scripting, psycopg2, pylint, ESLint, Prettier

## Project Structure

```
aws-ec2-rds-zoo-project/
├── langdale_zoo_api/     # Flask app — routes, models, DB connection
├── cookie_clicker/       # Additional mini-project
├── coding_problems/      # Practice problems completed during the programme
├── requirements.txt
└── .pylintrc / .eslintrc.json / .prettierrc
```

## Features

- REST API endpoints for zoo animal records (GET, POST)
- PostgreSQL database schema designed and hosted on AWS RDS
- Application deployed and served from an AWS EC2 instance
- Error handling with appropriate HTTP status codes
- Code quality enforced via pylint and prettier configs

## Setup (local)

```bash
git clone https://github.com/Webbie-AAA/aws-ec2-rds-zoo-project
cd aws-ec2-rds-zoo-project
pip install -r requirements.txt
```

Set the following environment variables to connect to your database:

```
DB_HOST=<your-rds-endpoint>
DB_NAME=<your-db-name>
DB_USER=<your-db-user>
DB_PASSWORD=<your-db-password>
```

Then run:

```bash
python langdale_zoo_api/app.py
```

## Tests

```bash
pytest
```

## Context

Built as part of the Sigma Labs Data Engineering Training Programme (Dec 2025 – Feb 2026), a 10-week intensive focused on data engineering, cloud deployment, REST APIs, and TDD.
