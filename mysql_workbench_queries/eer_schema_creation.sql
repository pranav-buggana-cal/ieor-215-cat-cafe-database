/* ==============================================================
   CAT CAFE — complete schema (weak entities + sales sub‑types)
   MySQL 8.x  •  utf8mb4  •  April 2025
   ============================================================== */

/* --------------------------------------------------------------
   0.  CREATE & USE DATABASE
   -------------------------------------------------------------- */
CREATE DATABASE IF NOT EXISTS catcafe
  DEFAULT CHARACTER SET utf8mb4
  DEFAULT COLLATE utf8mb4_unicode_ci;
USE catcafe;

/* --------------------------------------------------------------
   1.  PERSON SUPERTYPE & SUBTYPES
   -------------------------------------------------------------- */
CREATE TABLE person (
    person_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name  VARCHAR(50) NOT NULL,
    phone_number VARCHAR(20),
    email        VARCHAR(120),
    address      TEXT,
    PRIMARY KEY (person_id)
);

CREATE TABLE customer (
    person_id INT UNSIGNED PRIMARY KEY,
    FOREIGN KEY (person_id) REFERENCES person(person_id) ON DELETE CASCADE
);

CREATE TABLE employee (
    person_id     INT UNSIGNED PRIMARY KEY,
    ssn           CHAR(11) UNIQUE,
    position_title VARCHAR(60),
    full_time_flag BOOLEAN,
    work_hours     DECIMAL(4,2),
    start_date     DATE,
    supervisor_id  INT UNSIGNED,
    FOREIGN KEY (person_id)     REFERENCES person(person_id)   ON DELETE CASCADE,
    FOREIGN KEY (supervisor_id) REFERENCES employee(person_id) ON DELETE SET NULL
);

/* --------------------------------------------------------------
   1.a  CARE‑SPECIALIST SUPERTYPE  (works_for → shelter)
   -------------------------------------------------------------- */
CREATE TABLE shelter (
    shelter_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    name       VARCHAR(120) NOT NULL,
    address    TEXT,
    PRIMARY KEY (shelter_id)
);

CREATE TABLE care_specialist (
    person_id  INT UNSIGNED PRIMARY KEY,
    shelter_id BIGINT UNSIGNED NOT NULL,             -- "works for" FK
    FOREIGN KEY (person_id)  REFERENCES employee(person_id) ON DELETE CASCADE,
    FOREIGN KEY (shelter_id) REFERENCES shelter(shelter_id)
);

CREATE TABLE behaviorist  (
    person_id INT UNSIGNED PRIMARY KEY,
    FOREIGN KEY (person_id) REFERENCES care_specialist(person_id) ON DELETE CASCADE
);
CREATE TABLE groomer      (
    person_id INT UNSIGNED PRIMARY KEY,
    FOREIGN KEY (person_id) REFERENCES care_specialist(person_id) ON DELETE CASCADE
);
CREATE TABLE veterinarian (
    person_id INT UNSIGNED PRIMARY KEY,
    FOREIGN KEY (person_id) REFERENCES care_specialist(person_id) ON DELETE CASCADE
);

/* --------------------------------------------------------------
   2.  CATS & WEAK ENTITIES
   -------------------------------------------------------------- */
CREATE TABLE cat (
    cat_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    shelter_id BIGINT UNSIGNED,
    name        VARCHAR(50),
    gender      CHAR(1) CHECK (gender IN ('M','F')),
    breed       VARCHAR(60),
    description TEXT,
    energy_level VARCHAR(30),
    first_day_in_cafe DATE,
    last_day_in_cafe  DATE,
    PRIMARY KEY (cat_id),
    FOREIGN KEY (shelter_id) REFERENCES shelter(shelter_id)
);

/* ---- WEAK ENTITY medical_record (owner = cat) --------------- */
CREATE TABLE medical_record (
    medical_record_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    cat_id    BIGINT UNSIGNED NOT NULL,
    record_id INT            NOT NULL,   -- partial key (may repeat across cats)
    recorded_at TIMESTAMP NOT NULL,
    weight_kg   DECIMAL(5,2),
    vaccinations TEXT,
    allergies    TEXT,
    notes        TEXT,
    PRIMARY KEY (medical_record_id),
    INDEX idx_cat_record (cat_id, record_id),  -- Index for performance but no unique constraint
    FOREIGN KEY (cat_id) REFERENCES cat(cat_id) ON DELETE CASCADE
);

/* -- Create a reference table for medical record tracking -- */
CREATE TABLE medical_record_reference (
    reference_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    cat_id    BIGINT UNSIGNED NOT NULL,
    record_id INT            NOT NULL,
    PRIMARY KEY (reference_id),
    UNIQUE KEY uk_cat_record_ref (cat_id, record_id), -- This gives us a unique reference point
    FOREIGN KEY (cat_id) REFERENCES cat(cat_id) ON DELETE CASCADE
);

/* ---- WEAK ENTITY visit (owner = cat) ------------------------ */
CREATE TABLE visit (
    visit_record_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    cat_id   BIGINT UNSIGNED NOT NULL,
    visit_id INT            NOT NULL, -- partial key
    customer_id INT UNSIGNED,
    visit_datetime TIMESTAMP,
    duration_minutes INT,
    PRIMARY KEY (visit_record_id),
    INDEX idx_cat_visit (cat_id, visit_id),  -- Index for performance but no unique constraint
    FOREIGN KEY (cat_id)      REFERENCES cat(cat_id)      ON DELETE CASCADE,
    FOREIGN KEY (customer_id) REFERENCES customer(person_id)
);

/* -- Create a reference table for visit tracking -- */
CREATE TABLE visit_reference (
    reference_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    cat_id   BIGINT UNSIGNED NOT NULL,
    visit_id INT            NOT NULL,
    PRIMARY KEY (reference_id),
    UNIQUE KEY uk_cat_visit_ref (cat_id, visit_id), -- This gives us a unique reference point
    FOREIGN KEY (cat_id) REFERENCES cat(cat_id) ON DELETE CASCADE
);

/* --------------------------------------------------------------
   3.  ADOPTION PROCESS & INTERACTIONS
   -------------------------------------------------------------- */
CREATE TABLE adoption_request (
    adoption_id  BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    cat_id       BIGINT UNSIGNED NOT NULL,
    customer_id  INT UNSIGNED    NOT NULL,
    adoption_fee DECIMAL(10,2),
    adoption_date DATE,
    adoption_status ENUM('PENDING','APPROVED','REJECTED','RETURNED'),
    return_date   DATE,
    return_reason TEXT,
    payment_link  VARCHAR(255),
    PRIMARY KEY (adoption_id),
    FOREIGN KEY (cat_id)      REFERENCES cat(cat_id),
    FOREIGN KEY (customer_id) REFERENCES customer(person_id)
);

CREATE TABLE interaction (
    interaction_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    adoption_id    BIGINT UNSIGNED NOT NULL,
    interaction_notes TEXT,
    start_datetime TIMESTAMP,
    end_datetime   TIMESTAMP,
    PRIMARY KEY (interaction_id),
    FOREIGN KEY (adoption_id) REFERENCES adoption_request(adoption_id) ON DELETE CASCADE
);

/* --------------------------------------------------------------
   4.  EVENTS & VISIT REGISTRATION
   -------------------------------------------------------------- */
CREATE TABLE event (
    event_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    event_name VARCHAR(100),
    event_type VARCHAR(60),
    event_date DATE,
    PRIMARY KEY (event_id)
);

CREATE TABLE event_attendance (
    event_id    BIGINT UNSIGNED,
    customer_id INT UNSIGNED,
    PRIMARY KEY (event_id, customer_id),
    FOREIGN KEY (event_id)    REFERENCES event(event_id)     ON DELETE CASCADE,
    FOREIGN KEY (customer_id) REFERENCES customer(person_id) ON DELETE CASCADE
);

CREATE TABLE event_features_cat (
    event_id BIGINT UNSIGNED,
    cat_id   BIGINT UNSIGNED,
    PRIMARY KEY (event_id, cat_id),
    FOREIGN KEY (event_id) REFERENCES event(event_id) ON DELETE CASCADE,
    FOREIGN KEY (cat_id)   REFERENCES cat(cat_id)   ON DELETE CASCADE
);

CREATE TABLE visit_registration (
    registration_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    customer_id INT UNSIGNED,
    cat_id      BIGINT UNSIGNED,
    visit_id    INT,
    signed_waiver BOOLEAN DEFAULT FALSE,
    signature_recorded_at TIMESTAMP,
    PRIMARY KEY (registration_id),
    INDEX idx_customer_cat_visit (customer_id, cat_id, visit_id),
    FOREIGN KEY (customer_id) REFERENCES customer(person_id),
    INDEX idx_cat_visit (cat_id, visit_id),
    CONSTRAINT fk_visit_reg FOREIGN KEY (cat_id, visit_id) REFERENCES visit_reference(cat_id, visit_id) ON DELETE CASCADE
);

/* --------------------------------------------------------------
   5.  PRODUCT & INGREDIENTS
   -------------------------------------------------------------- */
CREATE TABLE product (
    product_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    sku   VARCHAR(40) UNIQUE NOT NULL,
    brand VARCHAR(80),
    name  VARCHAR(120),
    description TEXT,
    list_price DECIMAL(10,2),
    cost_price DECIMAL(10,2),
    product_type ENUM('RETAIL','CONSUMABLE') NOT NULL,
    PRIMARY KEY (product_id)
);

CREATE TABLE retail_product (
    product_id  BIGINT UNSIGNED PRIMARY KEY,
    weight_grams DECIMAL(10,2),
    dimensions   VARCHAR(100),
    category     VARCHAR(60),
    FOREIGN KEY (product_id) REFERENCES product(product_id) ON DELETE CASCADE
);

CREATE TABLE consumable_product (
    product_id  BIGINT UNSIGNED PRIMARY KEY,
    requires_refrigeration BOOLEAN DEFAULT FALSE,
    is_made_to_order       BOOLEAN DEFAULT FALSE,
    preparation_time       TIME,
    shelf_life_days        INT,
    FOREIGN KEY (product_id) REFERENCES product(product_id) ON DELETE CASCADE
);

CREATE TABLE ingredient (
    ingredient_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    name            VARCHAR(100) NOT NULL,
    unit_of_measure VARCHAR(20),
    allergen_flag   BOOLEAN DEFAULT FALSE,
    PRIMARY KEY (ingredient_id)
);

CREATE TABLE consumable_contains_ingredient (
    product_id    BIGINT UNSIGNED,
    ingredient_id BIGINT UNSIGNED,
    quantity      DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (product_id, ingredient_id),
    FOREIGN KEY (product_id)    REFERENCES consumable_product(product_id) ON DELETE CASCADE,
    FOREIGN KEY (ingredient_id) REFERENCES ingredient(ingredient_id)      ON DELETE CASCADE
);

/* --------------------------------------------------------------
   6.  SALES TRANSACTIONS & SUBTYPES
   -------------------------------------------------------------- */
CREATE TABLE transaction (
    transaction_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    customer_id INT UNSIGNED,
    employee_id INT UNSIGNED,
    txn_datetime TIMESTAMP NOT NULL,
    amount       DECIMAL(10,2),
    payment_type VARCHAR(30),
    payment_processor VARCHAR(60),
    PRIMARY KEY (transaction_id),
    FOREIGN KEY (customer_id) REFERENCES customer(person_id),
    FOREIGN KEY (employee_id) REFERENCES employee(person_id)
);

/* ---- ORDER sub‑type ----------------------------------------- */
CREATE TABLE `order` (
    transaction_id BIGINT UNSIGNED PRIMARY KEY,
    order_comment  TEXT,
    FOREIGN KEY (transaction_id) REFERENCES transaction(transaction_id) ON DELETE CASCADE
);

CREATE TABLE order_item (
    order_id   BIGINT UNSIGNED,
    product_id BIGINT UNSIGNED,
    quantity   INT NOT NULL CHECK (quantity > 0),
    unit_price DECIMAL(10,2),
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id)   REFERENCES `order`(transaction_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);

/* ---- RESERVATION sub‑type ----------------------------------- */
CREATE TABLE reservation (
    transaction_id BIGINT UNSIGNED PRIMARY KEY,
    cat_id         BIGINT UNSIGNED,
    visit_id       INT,
    check_in_status ENUM('SCHEDULED','CHECKED_IN','CANCELLED') DEFAULT 'SCHEDULED',
    FOREIGN KEY (transaction_id) REFERENCES transaction(transaction_id) ON DELETE CASCADE,
    INDEX idx_cat_visit (cat_id, visit_id),
    CONSTRAINT fk_reservation_visit FOREIGN KEY (cat_id, visit_id) REFERENCES visit_reference(cat_id, visit_id)
);

/* ---- REFUND sub‑type ---------------------------------------- */
CREATE TABLE refund (
    transaction_id BIGINT UNSIGNED PRIMARY KEY,
    refund_reason  TEXT,
    refund_comment TEXT,
    FOREIGN KEY (transaction_id) REFERENCES transaction(transaction_id) ON DELETE CASCADE
);

/* --------------------------------------------------------------
   7.  AUXILIARY RELATIONSHIPS
   -------------------------------------------------------------- */
CREATE TABLE event_organisation (
    employee_id INT UNSIGNED,
    event_id    BIGINT UNSIGNED,
    PRIMARY KEY (employee_id, event_id),
    FOREIGN KEY (employee_id) REFERENCES employee(person_id) ON DELETE CASCADE,
    FOREIGN KEY (event_id)    REFERENCES event(event_id)     ON DELETE CASCADE
);

CREATE TABLE transaction_visit (
    transaction_id BIGINT UNSIGNED PRIMARY KEY,
    cat_id         BIGINT UNSIGNED,
    visit_id       INT,
    FOREIGN KEY (transaction_id) REFERENCES transaction(transaction_id) ON DELETE CASCADE,
    INDEX idx_cat_visit (cat_id, visit_id),
    CONSTRAINT fk_transaction_visit FOREIGN KEY (cat_id, visit_id) REFERENCES visit_reference(cat_id, visit_id) ON DELETE CASCADE
);
