"""
Cat Cafe Database - Synthetic Data Generator
===========================================
This script generates synthetic data for the Cat Cafe database.
The output is a SQL script containing INSERT statements.
"""

import random
import datetime
from faker import Faker
import numpy as np
from pathlib import Path

# Initialize Faker
fake = Faker()
random.seed(42)  # For reproducibility
Faker.seed(42)

# Define output file
OUTPUT_FILE = "cat_cafe_data.sql"


def generate_insert(table_name, columns, values_list):
    """Generate INSERT statements for a table"""
    insert_stmt = f"INSERT INTO {table_name} ({', '.join(columns)})\nVALUES\n"

    values_strings = []
    for values in values_list:
        # Format each value correctly based on its type
        formatted_values = []
        for val in values:
            if val is None:
                formatted_values.append("NULL")
            elif isinstance(val, (int, float)) and not isinstance(val, bool):
                formatted_values.append(str(val))
            elif isinstance(val, bool):
                formatted_values.append(str(int(val)))
            else:
                formatted_values.append("'" + str(val).replace("'", "''") + "'")

        values_strings.append(f"({', '.join(formatted_values)})")

    insert_stmt += ",\n".join(values_strings) + ";\n\n"
    return insert_stmt


# Main Data Generator Class
class CatCafeDataGenerator:
    def __init__(self):
        self.sql_content = []
        self.person_data = []
        self.person_ids = []
        self.customer_ids = []
        self.employee_ids = []
        self.care_specialist_ids = []
        self.behaviorist_ids = []
        self.groomer_ids = []
        self.veterinarian_ids = []
        self.shelter_ids = []
        self.cat_ids = []
        self.event_ids = []
        self.product_ids = []
        self.retail_product_ids = []
        self.consumable_product_ids = []
        self.ingredient_ids = []
        self.transaction_ids = []
        self.order_ids = []
        self.refund_ids = []
        self.reservation_ids = []

        # Tracking for weak entities
        self.medical_records = {}  # cat_id -> list of record_ids
        self.visits = {}  # cat_id -> list of visit_ids
        self.interactions = {}  # adoption_id -> list of interaction_ids

    def generate_phone_number(self):
        """Generate a phone number in (XXX) XXX-XXXX format"""
        area = random.randint(100, 999)
        prefix = random.randint(100, 999)
        line = random.randint(1000, 9999)
        return f"({area}) {prefix}-{line}"

    def generate_all_data(self):
        """Generate all data for the Cat Cafe database"""
        self.sql_content.append("-- Cat Cafe Synthetic Data\n")
        self.sql_content.append(
            "-- Generated on "
            + datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
            + "\n\n"
        )
        self.sql_content.append("USE catcafe;\n\n")

        # Generate data for each table
        self.generate_persons()
        self.generate_customers()
        self.generate_employees()
        self.generate_shelters()
        self.generate_care_specialists()
        self.generate_specialist_subtypes()
        self.generate_cats()
        self.generate_medical_records()
        self.generate_visits()
        self.generate_adoption_requests()
        self.generate_interactions()
        self.generate_events()
        self.generate_event_attendances()
        self.generate_event_cats()
        self.generate_visit_registrations()
        self.generate_products()
        self.generate_product_subtypes()
        self.generate_ingredients()
        self.generate_consumable_ingredients()
        self.generate_transactions()
        self.generate_transaction_subtypes()
        self.generate_order_items()
        self.generate_event_organisation()
        self.generate_transaction_visits()

        # Write to file
        with open(OUTPUT_FILE, "w", encoding="utf-8") as f:
            f.write("\n".join(self.sql_content))

        print(f"Data generated and saved to {OUTPUT_FILE}")

    def generate_persons(self, count=50):
        """Generate data for the person table"""
        columns = [
            "person_id",
            "first_name",
            "last_name",
            "phone_number",
            "email",
            "address",
        ]
        values_list = []

        for i in range(1, count + 1):
            first_name = fake.first_name()
            last_name = fake.last_name()
            phone = self.generate_phone_number()
            email = fake.email()
            address = fake.address().replace("\n", ", ").replace("'", "''")

            self.person_data.append(
                {
                    "id": i,
                    "first_name": first_name,
                    "last_name": last_name,
                    "full_name": f"{first_name} {last_name}",
                }
            )
            self.person_ids.append(i)
            values_list.append((i, first_name, last_name, phone, email, address))

        self.sql_content.append("-- Person data")
        self.sql_content.append(generate_insert("person", columns, values_list))

    def generate_customers(self, count=30):
        """Generate data for the customer table"""
        # Select random persons to be customers
        self.customer_ids = random.sample(self.person_ids, count)
        columns = ["person_id"]
        values_list = [
            (id,) for id in sorted(self.customer_ids)
        ]  # Sort IDs for consistency

        self.sql_content.append("-- Customer data")
        self.sql_content.append(generate_insert("customer", columns, values_list))

    def generate_employees(self, count=20):
        """Generate data for the employee table"""
        columns = [
            "person_id",
            "ssn",
            "position_title",
            "full_time_flag",
            "work_hours",
            "start_date",
            "supervisor_id",
        ]

        # Get available persons who are not customers
        available_persons = [p for p in self.person_ids if p not in self.customer_ids]
        self.employee_ids = random.sample(
            available_persons, min(count, len(available_persons))
        )

        # Sort employee IDs to make sure supervisors have lower IDs
        self.employee_ids.sort()

        values_list = []
        positions = [
            "Barista",
            "Manager",
            "Assistant Manager",
            "Cat Attendant",
            "Receptionist",
            "Cleaner",
        ]

        for i, emp_id in enumerate(self.employee_ids):
            ssn = f"{random.randint(100, 999)}-{random.randint(10, 99)}-{random.randint(1000, 9999)}"
            position = random.choice(positions)
            full_time = random.choice([0, 1])
            work_hours = 40.0 if full_time else round(random.uniform(10.0, 30.0), 2)

            # Random start date in the past 5 years
            start_date = fake.date_between(start_date="-5y", end_date="today")

            # Set supervisor (if not the first few employees)
            if i < 3:  # First few employees don't have supervisors
                supervisor_id = None
            else:
                supervisor_id = random.choice(
                    self.employee_ids[:i]
                )  # Choose from employees with lower IDs

            values_list.append(
                (
                    emp_id,
                    ssn,
                    position,
                    full_time,
                    work_hours,
                    start_date,
                    supervisor_id,
                )
            )

        self.sql_content.append("-- Employee data")
        self.sql_content.append(generate_insert("employee", columns, values_list))

    def generate_shelters(self, count=5):
        """Generate data for the shelter table"""
        columns = ["name", "address"]
        values_list = []

        shelter_names = [
            "Whisker Haven",
            "Paws & Claws Sanctuary",
            "Furry Friends Rescue",
            "Meow Manor",
            "Cat's Cradle Shelter",
            "Second Chance Cat Rescue",
            "Purr-fect Home",
        ]

        for i in range(1, count + 1):
            name = (
                shelter_names[i - 1] if i <= len(shelter_names) else f"Cat Shelter {i}"
            )
            address = fake.address().replace("\n", ", ").replace("'", "''")

            values_list.append((name, address))
            self.shelter_ids.append(i)

        self.sql_content.append("-- Shelter data")
        self.sql_content.append(generate_insert("shelter", columns, values_list))

    def generate_care_specialists(self, count=10):
        """Generate data for the care_specialist table"""
        columns = ["person_id", "shelter_id"]

        # Choose a subset of employees to be care specialists
        available_employees = self.employee_ids.copy()
        count = min(count, len(available_employees))
        self.care_specialist_ids = random.sample(available_employees, count)

        values_list = []
        for specialist_id in self.care_specialist_ids:
            shelter_id = random.choice(self.shelter_ids)
            values_list.append((specialist_id, shelter_id))

        self.sql_content.append("-- Care Specialist data")
        self.sql_content.append(
            generate_insert("care_specialist", columns, values_list)
        )

    def generate_specialist_subtypes(self):
        """Generate data for behaviorist, groomer, veterinarian tables"""
        # Distribute care specialists among the subtypes
        # Some specialists might belong to multiple subtypes

        # Shuffle the specialists for random assignment
        specialists = self.care_specialist_ids.copy()
        random.shuffle(specialists)

        # Distribute to subtypes with some overlap
        third = max(1, len(specialists) // 3)
        self.behaviorist_ids = specialists[
            : third + 2
        ]  # First third plus a couple more
        self.groomer_ids = specialists[
            third - 1 : 2 * third + 1
        ]  # Middle third with slight overlap
        self.veterinarian_ids = specialists[
            2 * third - 1 :
        ]  # Last third with slight overlap

        # Generate INSERT statements for each subtype
        self.sql_content.append("-- Behaviorist data")
        self.sql_content.append(
            generate_insert(
                "behaviorist", ["person_id"], [([id]) for id in self.behaviorist_ids]
            )
        )

        self.sql_content.append("-- Groomer data")
        self.sql_content.append(
            generate_insert(
                "groomer", ["person_id"], [([id]) for id in self.groomer_ids]
            )
        )

        self.sql_content.append("-- Veterinarian data")
        self.sql_content.append(
            generate_insert(
                "veterinarian", ["person_id"], [([id]) for id in self.veterinarian_ids]
            )
        )

    def generate_cats(self, count=30):
        """Generate data for the cat table"""
        columns = [
            "shelter_id",
            "name",
            "gender",
            "breed",
            "description",
            "energy_level",
            "first_day_in_cafe",
            "last_day_in_cafe",
        ]

        values_list = []
        cat_names = [
            "Luna",
            "Oliver",
            "Leo",
            "Bella",
            "Charlie",
            "Lucy",
            "Max",
            "Lily",
            "Simon",
            "Sophie",
            "Jack",
            "Chloe",
            "Milo",
            "Zoe",
            "Oscar",
            "Cleo",
            "Felix",
            "Stella",
            "Simba",
            "Ruby",
            "Sam",
            "Molly",
            "Jasper",
            "Daisy",
            "Loki",
            "Willow",
            "Tigger",
            "Pepper",
            "Gizmo",
            "Shadow",
            "Smokey",
            "Pumpkin",
            "Mittens",
            "Oreo",
            "Gracie",
            "Romeo",
            "Coco",
            "Lucky",
            "Misty",
            "Ginger",
        ]

        cat_breeds = [
            "Domestic Shorthair",
            "Maine Coon",
            "Persian",
            "Siamese",
            "Ragdoll",
            "Bengal",
            "Sphynx",
            "British Shorthair",
            "Scottish Fold",
            "Abyssinian",
            "Norwegian Forest Cat",
            "Russian Blue",
            "Burmese",
            "Siberian",
            "Devon Rex",
        ]

        energy_levels = ["Low", "Medium", "High", "Very High", "Variable"]

        for i in range(1, count + 1):
            name = cat_names[i - 1] if i <= len(cat_names) else f"Cat {i}"
            gender = random.choice(["M", "F"])
            breed = random.choice(cat_breeds)
            description = f"A {random.choice(['sweet', 'playful', 'calm', 'energetic', 'shy', 'friendly'])} {breed} with {random.choice(['beautiful', 'striking', 'soft', 'sleek'])} {random.choice(['black', 'white', 'gray', 'orange', 'tabby', 'calico', 'tuxedo'])} fur."
            energy = random.choice(energy_levels)

            # Some cats might be from shelters, others might not
            shelter_id = (
                random.choice(self.shelter_ids) if random.random() > 0.3 else None
            )

            # First day in cafe within the last 2 years
            first_day = fake.date_between(start_date="-2y", end_date="-1w")

            # Some cats might have left the cafe
            if random.random() < 0.2:
                last_day = fake.date_between(start_date=first_day, end_date="today")
            else:
                last_day = None

            values_list.append(
                (
                    shelter_id,
                    name,
                    gender,
                    breed,
                    description,
                    energy,
                    first_day,
                    last_day,
                )
            )
            self.cat_ids.append(i)

        self.sql_content.append("-- Cat data")
        self.sql_content.append(generate_insert("cat", columns, values_list))

    def generate_medical_records(self, avg_records_per_cat=3):
        """Generate data for the medical_record table (weak entity)"""
        columns = [
            "cat_id",
            "record_id",
            "recorded_at",
            "weight_kg",
            "vaccinations",
            "allergies",
            "notes",
        ]
        values_list = []

        # Keep track of unique cat_id, record_id combinations for the reference table
        self.medical_record_references = set()

        for cat_id in self.cat_ids:
            # Each cat gets a varying number of medical records
            num_records = random.randint(1, avg_records_per_cat * 2)
            record_ids = []

            for record_num in range(1, num_records + 1):
                # Record partial key IDs should repeat across cats
                record_id = random.randint(
                    1, 5
                )  # Deliberately limited range to ensure repetition
                record_ids.append(record_id)

                # Add to reference set
                self.medical_record_references.add((cat_id, record_id))

                recorded_at = fake.date_time_between(start_date="-2y", end_date="now")
                weight = round(random.uniform(3.0, 8.0), 2)

                vaccinations = random.choice(
                    [
                        "FVRCP, Rabies",
                        "FVRCP, Rabies, FeLV",
                        "FVRCP",
                        "Rabies booster",
                        None,
                    ]
                )

                allergies = random.choice(
                    ["None known", "Chicken", "Fish", "Dairy", None]
                )

                notes = random.choice(
                    [
                        "Healthy checkup, no concerns",
                        "Minor dental issues noted",
                        "Slightly overweight, diet recommended",
                        "Regular grooming needed",
                        "Recovering well from procedure",
                        None,
                    ]
                )

                values_list.append(
                    (
                        cat_id,
                        record_id,
                        recorded_at,
                        weight,
                        vaccinations,
                        allergies,
                        notes,
                    )
                )

            # Store the record_ids for this cat
            self.medical_records[cat_id] = record_ids

        self.sql_content.append("-- Medical Record data (weak entity)")
        self.sql_content.append(generate_insert("medical_record", columns, values_list))

        # Generate medical record reference data
        self.generate_medical_record_references()

    def generate_medical_record_references(self):
        """Generate data for the medical_record_reference table"""
        columns = ["cat_id", "record_id"]
        values_list = []

        # Each unique combination gets one entry
        for cat_id, record_id in self.medical_record_references:
            values_list.append((cat_id, record_id))

        self.sql_content.append("-- Medical Record Reference data")
        self.sql_content.append(
            generate_insert("medical_record_reference", columns, values_list)
        )

    def generate_visits(self, avg_visits_per_cat=5):
        """Generate data for the visit table (weak entity)"""
        columns = [
            "cat_id",
            "visit_id",
            "customer_id",
            "visit_datetime",
            "duration_minutes",
        ]
        values_list = []

        # Keep track of unique cat_id, visit_id combinations for the reference table
        self.visit_references = set()

        for cat_id in self.cat_ids:
            # Each cat gets multiple visits with varying visit_ids (partial key)
            num_visits = random.randint(1, avg_visits_per_cat * 2)
            visit_ids = []

            for _ in range(num_visits):
                # Visit IDs should repeat across cats
                visit_id = random.randint(1, 10)  # Limited range to ensure repetition
                visit_ids.append(visit_id)

                # Add to reference set
                self.visit_references.add((cat_id, visit_id))

                # Random customer for the visit
                customer_id = random.choice(self.customer_ids)

                # Visit datetime within the last year
                visit_datetime = fake.date_time_between(
                    start_date="-1y", end_date="now"
                )

                # Duration in minutes
                duration_minutes = random.choice([15, 30, 45, 60, 90, 120])

                values_list.append(
                    (cat_id, visit_id, customer_id, visit_datetime, duration_minutes)
                )

            # Store visit_ids for this cat
            self.visits[cat_id] = visit_ids

        self.sql_content.append("-- Visit data (weak entity)")
        self.sql_content.append(generate_insert("visit", columns, values_list))

        # Generate visit reference data
        self.generate_visit_references()

    def generate_visit_references(self):
        """Generate data for the visit_reference table"""
        columns = ["cat_id", "visit_id"]
        values_list = []

        # Each unique combination gets one entry
        for cat_id, visit_id in self.visit_references:
            values_list.append((cat_id, visit_id))

        self.sql_content.append("-- Visit Reference data")
        self.sql_content.append(
            generate_insert("visit_reference", columns, values_list)
        )

    def generate_adoption_requests(self, count=20):
        """Generate data for the adoption_request table"""
        columns = [
            "cat_id",
            "customer_id",
            "adoption_fee",
            "adoption_date",
            "adoption_status",
            "return_date",
            "return_reason",
            "payment_link",
        ]
        values_list = []

        adoption_statuses = ["PENDING", "APPROVED", "REJECTED", "RETURNED"]

        for i in range(1, count + 1):
            cat_id = random.choice(self.cat_ids)
            customer_id = random.choice(self.customer_ids)

            # Adoption fee between $50 and $300
            adoption_fee = round(random.uniform(50.0, 300.0), 2)

            # Status weighted towards approved
            status = random.choices(adoption_statuses, weights=[0.2, 0.6, 0.1, 0.1])[0]

            # Dates depend on status
            if status in ["PENDING"]:
                adoption_date = None
                return_date = None
                return_reason = None
            elif status in ["APPROVED", "RETURNED"]:
                adoption_date = fake.date_between(start_date="-1y", end_date="-1w")
                if status == "RETURNED":
                    return_date = fake.date_between(
                        start_date=adoption_date, end_date="today"
                    )
                    return_reason = random.choice(
                        [
                            "Allergies developed",
                            "Moving to new home that doesn't allow pets",
                            "Behavioral issues",
                            "Financial difficulties",
                            "Not compatible with existing pets",
                        ]
                    )
                else:
                    return_date = None
                    return_reason = None
            else:  # REJECTED
                adoption_date = None
                return_date = None
                return_reason = None

            # Payment link
            payment_link = (
                f"https://catcafe.pay/adoption/{fake.uuid4()}"
                if status != "REJECTED"
                else None
            )

            values_list.append(
                (
                    cat_id,
                    customer_id,
                    adoption_fee,
                    adoption_date,
                    status,
                    return_date,
                    return_reason,
                    payment_link,
                )
            )

        self.sql_content.append("-- Adoption Request data")
        self.sql_content.append(
            generate_insert("adoption_request", columns, values_list)
        )

        # Store adoption request IDs
        self.adoption_request_ids = list(range(1, count + 1))

    def generate_interactions(self, avg_per_adoption=2):
        """Generate data for the interaction table"""
        columns = ["adoption_id", "interaction_notes", "start_datetime", "end_datetime"]
        values_list = []

        interaction_id = 1
        for adoption_id in self.adoption_request_ids:
            # Each adoption gets multiple interactions
            num_interactions = random.randint(1, avg_per_adoption * 2)

            for _ in range(num_interactions):
                notes = random.choice(
                    [
                        "Initial meeting with cat",
                        "Follow-up discussion about cat's needs",
                        "Home environment assessment",
                        "Final adoption paperwork review",
                        "Post-adoption check-in",
                        "Discussion about cat's medical history",
                        "Training session for special needs",
                    ]
                )

                start_datetime = fake.date_time_between(
                    start_date="-1y", end_date="-1d"
                )

                # End datetime 30-120 minutes after start
                minutes_diff = random.randint(30, 120)
                end_datetime = start_datetime + datetime.timedelta(minutes=minutes_diff)

                values_list.append((adoption_id, notes, start_datetime, end_datetime))

                if adoption_id not in self.interactions:
                    self.interactions[adoption_id] = []

                self.interactions[adoption_id].append(interaction_id)
                interaction_id += 1

        self.sql_content.append("-- Interaction data")
        self.sql_content.append(generate_insert("interaction", columns, values_list))

    def generate_events(self, count=15):
        """Generate data for the event table"""
        columns = ["event_name", "event_type", "event_date"]
        values_list = []

        event_types = [
            "Adoption Day",
            "Cat Yoga",
            "Kitten Socialization",
            "Senior Cat Meet & Greet",
            "Educational Workshop",
        ]

        event_names = [
            "Spring Adoption Festival",
            "Summer Kitten Party",
            "Holiday Cat Celebration",
            "Valentine's Day Cat Speed Dating",
            "Halloween Cat Costume Contest",
            "Meow & Meditation",
            "Paws & Paint Night",
            "Whiskers & Wine",
            "Senior Cat Appreciation Day",
            "Kitten Kindergarten",
            "Cat Health Workshop",
            "Feline Behavior Seminar",
            "Cat Photography Session",
            "Adopter Reunion",
            "Cat Cafe Anniversary",
        ]

        for i in range(1, count + 1):
            name = event_names[i - 1] if i <= len(event_names) else f"Cat Event {i}"
            event_type = random.choice(event_types)

            # Event date within the last year and next 3 months
            event_date = fake.date_between(start_date="-1y", end_date="+3m")

            values_list.append((name, event_type, event_date))
            self.event_ids.append(i)

        self.sql_content.append("-- Event data")
        self.sql_content.append(generate_insert("event", columns, values_list))

    def generate_event_attendances(self):
        """Generate data for the event_attendance table"""
        columns = ["event_id", "customer_id"]
        values_list = []

        # Each event gets multiple attendees
        for event_id in self.event_ids:
            # Random number of attendees per event
            num_attendees = random.randint(5, 15)

            # Select random customers
            attendees = random.sample(
                self.customer_ids, min(num_attendees, len(self.customer_ids))
            )

            for customer_id in attendees:
                values_list.append((event_id, customer_id))

        self.sql_content.append("-- Event Attendance data")
        self.sql_content.append(
            generate_insert("event_attendance", columns, values_list)
        )

    def generate_event_cats(self):
        """Generate data for the event_features_cat table"""
        columns = ["event_id", "cat_id"]
        values_list = []

        # Each event features multiple cats
        for event_id in self.event_ids:
            # Random number of cats per event
            num_cats = random.randint(3, 10)

            # Select random cats
            event_cats = random.sample(self.cat_ids, min(num_cats, len(self.cat_ids)))

            for cat_id in event_cats:
                values_list.append((event_id, cat_id))

        self.sql_content.append("-- Event Features Cat data")
        self.sql_content.append(
            generate_insert("event_features_cat", columns, values_list)
        )

    def generate_visit_registrations(self):
        """Generate data for the visit_registration table"""
        columns = [
            "customer_id",
            "cat_id",
            "visit_id",
            "signed_waiver",
            "signature_recorded_at",
        ]
        values_list = []

        # For a subset of visits, create registrations
        for cat_id, visit_ids in self.visits.items():
            for visit_id in visit_ids:
                # Only create registration for some visits
                if random.random() < 0.7:
                    customer_id = random.choice(self.customer_ids)
                    signed_waiver = random.random() > 0.1  # Most have signed waivers

                    if signed_waiver:
                        signature_time = fake.date_time_between(
                            start_date="-1y", end_date="now"
                        )
                    else:
                        signature_time = None

                    values_list.append(
                        (customer_id, cat_id, visit_id, signed_waiver, signature_time)
                    )

        self.sql_content.append("-- Visit Registration data")
        self.sql_content.append(
            generate_insert("visit_registration", columns, values_list)
        )

    def generate_products(self, count=40):
        """Generate data for the product table"""
        columns = [
            "product_id",
            "sku",
            "brand",
            "name",
            "description",
            "list_price",
            "cost_price",
            "product_type",
        ]
        values_list = []

        # Product types with weights
        product_types = ["RETAIL", "CONSUMABLE"]
        type_weights = [0.4, 0.6]  # 40% retail, 60% consumable

        # Lists for product generation
        retail_brands = [
            "PawPerfect",
            "CatLife",
            "Whisker Essentials",
            "FurEver",
            "Meow Market",
        ]
        consumable_brands = [
            "Cat Cafe House Brand",
            "Pawsome Treats",
            "WhiskerLicious",
            "Purr Bites",
            "Meow Munch",
        ]

        retail_categories = [
            "Toys",
            "Beds",
            "Grooming",
            "Carriers",
            "Collars",
            "Scratchers",
        ]
        consumable_categories = [
            "Coffee",
            "Tea",
            "Pastry",
            "Sandwich",
            "Salad",
            "Cat Treat",
        ]

        for i in range(1, count + 1):
            # Generate SKU
            sku = f"PROD-{i:04d}"

            # Determine product type
            product_type = random.choices(product_types, weights=type_weights)[0]

            # Set appropriate brand based on type
            if product_type == "RETAIL":
                brand = random.choice(retail_brands)
                category = random.choice(retail_categories)
                name = f"{category} - {fake.word().capitalize()}"
                self.retail_product_ids.append(i)
            else:  # CONSUMABLE
                brand = random.choice(consumable_brands)
                category = random.choice(consumable_categories)
                name = f"{category} - {fake.word().capitalize()}"
                self.consumable_product_ids.append(i)

            # Generate description
            description = fake.sentence(nb_words=10)

            # Set prices based on type
            if product_type == "RETAIL":
                list_price = round(random.uniform(10.0, 100.0), 2)
            else:
                list_price = round(random.uniform(3.0, 15.0), 2)

            # Cost price is less than list price
            cost_price = round(list_price * random.uniform(0.4, 0.7), 2)

            values_list.append(
                (i, sku, brand, name, description, list_price, cost_price, product_type)
            )
            self.product_ids.append(i)

        self.sql_content.append("-- Product data")
        self.sql_content.append(generate_insert("product", columns, values_list))

    def generate_product_subtypes(self):
        """Generate data for retail_product and consumable_product tables"""
        # Generate retail product data
        retail_columns = ["product_id", "weight_grams", "dimensions", "category"]
        retail_values = []

        for product_id in self.retail_product_ids:
            weight = round(random.uniform(100, 5000), 2)
            dimensions = f"{random.randint(5, 50)}x{random.randint(5, 50)}x{random.randint(5, 30)} cm"
            category = random.choice(
                ["Toys", "Beds", "Grooming", "Accessories", "Carriers", "Food Bowls"]
            )
            retail_values.append((product_id, weight, dimensions, category))

        # Generate consumable product data
        consumable_columns = [
            "product_id",
            "requires_refrigeration",
            "is_made_to_order",
            "preparation_time",
            "shelf_life_days",
        ]
        consumable_values = []

        for product_id in self.consumable_product_ids:
            refrigeration = random.choice([0, 1])
            made_to_order = random.choice([0, 1])

            # Preparation time (HH:MM:SS)
            if made_to_order:
                prep_minutes = random.randint(3, 15)
                prep_time = f"00:{prep_minutes:02d}:00"
            else:
                prep_time = "00:01:00"  # Just 1 minute for pre-made items

            shelf_life = random.randint(1, 14)  # 1-14 days
            consumable_values.append(
                (product_id, refrigeration, made_to_order, prep_time, shelf_life)
            )

        self.sql_content.append("-- Retail Product data")
        self.sql_content.append(
            generate_insert("retail_product", retail_columns, retail_values)
        )

        self.sql_content.append("-- Consumable Product data")
        self.sql_content.append(
            generate_insert("consumable_product", consumable_columns, consumable_values)
        )

    def generate_ingredients(self, count=25):
        """Generate data for the ingredient table"""
        columns = ["name", "unit_of_measure", "allergen_flag"]
        values_list = []

        ingredient_names = [
            "Coffee Beans",
            "Milk",
            "Sugar",
            "Flour",
            "Eggs",
            "Butter",
            "Chocolate",
            "Vanilla Extract",
            "Baking Powder",
            "Salt",
            "Cinnamon",
            "Whipped Cream",
            "Caramel Syrup",
            "Coconut Milk",
            "Almond Milk",
            "Honey",
            "Lemon",
            "Blueberries",
            "Strawberries",
            "Bananas",
            "Oats",
            "Almonds",
            "Walnuts",
            "Peanut Butter",
            "Cream Cheese",
            "Apple",
            "Pumpkin",
            "Cocoa Powder",
            "Matcha Powder",
            "Green Tea",
        ]

        units = [
            "g",
            "kg",
            "ml",
            "l",
            "tsp",
            "tbsp",
            "cup",
            "oz",
            "lb",
            "pinch",
            "unit",
        ]

        # Common allergens
        allergens = [
            "Milk",
            "Eggs",
            "Nuts",
            "Peanuts",
            "Wheat",
            "Soy",
            "Fish",
            "Shellfish",
        ]

        for i in range(1, count + 1):
            if i <= len(ingredient_names):
                name = ingredient_names[i - 1]
            else:
                name = f"Ingredient {i}"

            unit = random.choice(units)

            # Determine if it's an allergen
            is_allergen = 1 if name in allergens or random.random() < 0.2 else 0

            values_list.append((name, unit, is_allergen))
            self.ingredient_ids.append(i)

        self.sql_content.append("-- Ingredient data")
        self.sql_content.append(generate_insert("ingredient", columns, values_list))

    def generate_consumable_ingredients(self):
        """Generate data for the consumable_contains_ingredient table"""
        columns = ["product_id", "ingredient_id", "quantity"]
        values_list = []

        # For each consumable product, add multiple ingredients
        for product_id in self.consumable_product_ids:
            # Number of ingredients varies
            num_ingredients = random.randint(2, 6)

            # Select random ingredients
            ingredients = random.sample(
                self.ingredient_ids, min(num_ingredients, len(self.ingredient_ids))
            )

            for ingredient_id in ingredients:
                # Quantity varies
                quantity = round(random.uniform(0.1, 500.0), 2)

                values_list.append((product_id, ingredient_id, quantity))

        self.sql_content.append("-- Consumable Product Ingredients data")
        self.sql_content.append(
            generate_insert("consumable_contains_ingredient", columns, values_list)
        )

    def generate_transactions(self, count=80):
        """Generate data for the transaction table"""
        columns = [
            "customer_id",
            "employee_id",
            "txn_datetime",
            "amount",
            "payment_type",
            "payment_processor",
        ]
        values_list = []

        payment_types = [
            "Credit Card",
            "Debit Card",
            "Cash",
            "Mobile Payment",
            "Gift Card",
        ]
        processors = [
            "Square",
            "PayPal",
            "Stripe",
            "Cash Register",
            "Apple Pay",
            "Google Pay",
        ]

        for i in range(1, count + 1):
            customer_id = (
                random.choice(self.customer_ids) if random.random() > 0.1 else None
            )
            employee_id = random.choice(self.employee_ids)

            # Transaction timestamp within the last year
            txn_datetime = fake.date_time_between(start_date="-1y", end_date="now")

            # Amount varies based on what's being purchased
            amount = round(random.uniform(5.0, 100.0), 2)

            payment_type = random.choice(payment_types)

            # Set appropriate processor based on payment type
            if payment_type == "Cash":
                processor = "Cash Register"
            else:
                processor = random.choice(
                    [p for p in processors if p != "Cash Register"]
                )

            values_list.append(
                (
                    customer_id,
                    employee_id,
                    txn_datetime,
                    amount,
                    payment_type,
                    processor,
                )
            )
            self.transaction_ids.append(i)

        self.sql_content.append("-- Transaction data")
        self.sql_content.append(generate_insert("transaction", columns, values_list))

    def generate_transaction_subtypes(self):
        """Generate data for order, reservation, and refund tables"""
        # Divide transactions into subtypes
        # About 60% orders, 30% reservations, 10% refunds

        random.shuffle(self.transaction_ids)
        cutoff1 = int(len(self.transaction_ids) * 0.6)
        cutoff2 = int(len(self.transaction_ids) * 0.9)

        self.order_ids = self.transaction_ids[:cutoff1]
        self.reservation_ids = self.transaction_ids[cutoff1:cutoff2]
        self.refund_ids = self.transaction_ids[cutoff2:]

        # Generate order data
        order_columns = ["transaction_id", "order_comment"]
        order_values = []

        for order_id in self.order_ids:
            comment = random.choice(
                [
                    "Regular order",
                    "Special request: extra whipped cream",
                    "Birthday celebration order",
                    "To-go order",
                    "Custom order",
                    None,
                ]
            )

            order_values.append((order_id, comment))

        self.sql_content.append("-- Order data")
        self.sql_content.append(generate_insert("`order`", order_columns, order_values))

        # Generate reservation data
        reservation_columns = [
            "transaction_id",
            "cat_id",
            "visit_id",
            "check_in_status",
        ]
        reservation_values = []

        for reservation_id in self.reservation_ids:
            # Select a random cat and one of its visits
            cat_id = random.choice(self.cat_ids)

            if cat_id in self.visits and self.visits[cat_id]:
                visit_id = random.choice(self.visits[cat_id])

                status = random.choice(["SCHEDULED", "CHECKED_IN", "CANCELLED"])

                reservation_values.append((reservation_id, cat_id, visit_id, status))

        self.sql_content.append("-- Reservation data")
        self.sql_content.append(
            generate_insert("reservation", reservation_columns, reservation_values)
        )

        # Generate refund data
        refund_columns = ["transaction_id", "refund_reason", "refund_comment"]
        refund_values = []

        for refund_id in self.refund_ids:
            reason = random.choice(
                [
                    "Customer dissatisfaction",
                    "Service issue",
                    "Product quality issue",
                    "Double charge",
                    "Reservation cancellation",
                    "Store credit",
                ]
            )

            comment = random.choice(
                [
                    "Full refund provided",
                    "Partial refund",
                    "Refund with store credit",
                    "Manager approved",
                    None,
                ]
            )

            refund_values.append((refund_id, reason, comment))

        self.sql_content.append("-- Refund data")
        self.sql_content.append(
            generate_insert("refund", refund_columns, refund_values)
        )

    def generate_order_items(self):
        """Generate data for the order_item table"""
        columns = ["order_id", "product_id", "quantity", "unit_price"]
        values_list = []

        # For each order, add 1-5 items
        for order_id in self.order_ids:
            # Number of items in this order
            num_items = random.randint(1, 5)

            # Select random products
            products = random.sample(
                self.product_ids, min(num_items, len(self.product_ids))
            )

            for product_id in products:
                quantity = random.randint(1, 3)
                unit_price = round(random.uniform(3.0, 25.0), 2)

                values_list.append((order_id, product_id, quantity, unit_price))

        self.sql_content.append("-- Order Item data")
        self.sql_content.append(generate_insert("order_item", columns, values_list))

    def generate_event_organisation(self):
        """Generate data for the event_organisation table"""
        columns = ["employee_id", "event_id"]
        values_list = []

        # For each event, assign 1-3 employees
        for event_id in self.event_ids:
            # Number of employees organizing this event
            num_employees = random.randint(1, 3)

            # Select random employees
            employees = random.sample(
                self.employee_ids, min(num_employees, len(self.employee_ids))
            )

            for employee_id in employees:
                values_list.append((employee_id, event_id))

        self.sql_content.append("-- Event Organisation data")
        self.sql_content.append(
            generate_insert("event_organisation", columns, values_list)
        )

    def generate_transaction_visits(self):
        """Generate data for the transaction_visit table"""
        columns = ["transaction_id", "cat_id", "visit_id"]
        values_list = []

        # Associate some transactions with visits
        for i, transaction_id in enumerate(self.transaction_ids):
            # Only associate about 30% of transactions with visits
            if random.random() < 0.3:
                cat_id = random.choice(self.cat_ids)

                if cat_id in self.visits and self.visits[cat_id]:
                    visit_id = random.choice(self.visits[cat_id])
                    values_list.append((transaction_id, cat_id, visit_id))

        self.sql_content.append("-- Transaction Visit data")
        self.sql_content.append(
            generate_insert("transaction_visit", columns, values_list)
        )


# Run the generator
if __name__ == "__main__":
    generator = CatCafeDataGenerator()
    generator.generate_all_data()
    print(f"Data successfully generated and saved to {OUTPUT_FILE}")
