# Cat Cafe Database Project

This repository contains a comprehensive database system for managing a cat cafe business, including customer interactions, cat care, adoption processes, and sales management.

## Database Schema

The database schema (`cat_cafe_schema_file.sql`) implements a sophisticated entity-relationship model with the following key components:

### Core Entities
- **Person Management**: A supertype-subtype hierarchy for managing different types of people (customers, employees, care specialists)
- **Cat Management**: Complete tracking of cats, including their medical records and visits
- **Adoption System**: Comprehensive adoption request and interaction tracking
- **Event Management**: System for managing cafe events and attendance
- **Sales System**: Product management with subtypes for retail and consumable items

### Key Features
- Weak entity relationships for medical records and visits
- Comprehensive transaction tracking
- Event organization and attendance management
- Product inventory with ingredient tracking
- Adoption process management with interaction history

## Synthetic Data Generation

The synthetic data generation system (`cat_cafe_data_generator.py`) uses a sophisticated approach to create realistic test data:

### Methodology
1. **Faker Integration**: Uses the Faker library to generate realistic personal information
2. **Controlled Randomness**: Implements seeded random number generation for reproducibility
3. **Relationship Management**: Maintains referential integrity across all generated data
4. **Data Distribution**: Creates realistic distributions of data across different entity types

### Key Components
- **Person Generation**: Creates a diverse set of customers, employees, and specialists
- **Cat Profiles**: Generates realistic cat profiles with medical histories
- **Transaction Simulation**: Creates realistic sales patterns and customer interactions
- **Event Management**: Generates event schedules and attendance records
- **Adoption Process**: Simulates adoption requests and interactions

## Setup Instructions

1. Create the database using the schema file:
```sql
mysql -u your_username -p < cat_cafe_schema_file.sql
```

2. Generate synthetic data:
```bash
python cat_cafe_data_generator.py
```

3. Import the generated data:
```sql
mysql -u your_username -p catcafe < cat_cafe_data.sql
```

## Project Structure

- `cat_cafe_schema_file.sql`: Complete database schema
- `cat_cafe_data_generator.py`: Synthetic data generation script
- `cat_cafe_data.sql`: Generated synthetic data (created by the generator)
- `catcafe_workbench_exports/`: MySQL Workbench exports and queries
- `mysql_workbench_queries/`: Additional SQL queries and utilities

## Data Generation Details

The synthetic data generator creates realistic data with the following characteristics:

- 50 persons (30 customers, 20 employees)
- 30 cats with medical records and visit histories
- 15 events with attendance records
- 40 products (retail and consumable)
- 80 transactions with associated orders
- 20 adoption requests with interaction histories

The generator ensures:
- Referential integrity across all tables
- Realistic date ranges and time sequences
- Proper handling of weak entities
- Consistent data distributions
- Realistic business patterns

## Contributing

Feel free to submit issues and enhancement requests!