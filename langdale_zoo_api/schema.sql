-- Langdale Zoo Database Schema (PostgreSQL)

-- Create database (run this manually if needed)

CREATE DATABASE langdale_zoo;
\c langdale_zoo;

-- Animals table
CREATE TABLE IF NOT EXISTS animals (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    species VARCHAR(100) NOT NULL,
    age INTEGER,
    gender VARCHAR(10),
    habitat VARCHAR(100),
    diet VARCHAR(50),
    description TEXT,
    conservation_status VARCHAR(50),
    arrival_date DATE,
    weight_kg DECIMAL(6,2),
    exhibit_id INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Exhibits table
CREATE TABLE IF NOT EXISTS exhibits (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    location VARCHAR(100),
    size VARCHAR(50),
    climate VARCHAR(50),
    description TEXT,
    opening_hours VARCHAR(100),
    special_features TEXT,
    capacity INTEGER,
    built_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Staff table
CREATE TABLE IF NOT EXISTS staff (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    position VARCHAR(100),
    department VARCHAR(100),
    specialization VARCHAR(100),
    experience_years INTEGER,
    education TEXT,
    bio TEXT,
    hire_date DATE,
    salary DECIMAL(10,2),
    email VARCHAR(100),
    phone VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Visitors table
CREATE TABLE IF NOT EXISTS visitors (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20),
    visit_date DATE,
    ticket_type VARCHAR(50),
    group_size INTEGER,
    special_requests TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Animal Care Logs table
CREATE TABLE IF NOT EXISTS animal_care_logs (
    id SERIAL PRIMARY KEY,
    animal_id INTEGER REFERENCES animals(id),
    staff_id INTEGER REFERENCES staff(id),
    care_type VARCHAR(50),
    notes TEXT,
    care_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Feeding Schedules table
CREATE TABLE IF NOT EXISTS feeding_schedules (
    id SERIAL PRIMARY KEY,
    animal_id INTEGER REFERENCES animals(id),
    feeding_time TIME,
    food_type VARCHAR(100),
    quantity VARCHAR(50),
    frequency VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Add foreign key constraint for animals table
ALTER TABLE animals 
ADD CONSTRAINT fk_animals_exhibit 
FOREIGN KEY (exhibit_id) REFERENCES exhibits(id);

-- Insert sample data
INSERT INTO exhibits (name, location, size, climate, description, opening_hours, special_features, capacity, built_date) VALUES
('African Savanna', 'North Wing', '5 acres', 'Hot and Dry', 'A vast recreation of the African savanna featuring lions, zebras, and giraffes', '9:00 AM - 6:00 PM', 'Viewing platforms, water holes, shade structures', 50, '2018-03-15'),
('Amazon Rainforest', 'East Wing', '3 acres', 'Tropical Humid', 'Lush rainforest habitat with jaguars, monkeys, and colorful birds', '9:00 AM - 6:00 PM', 'Canopy walkways, waterfall, misting systems', 40, '2019-07-20'),
('Arctic Tundra', 'West Wing', '2 acres', 'Cold', 'Frozen landscape home to polar bears and arctic foxes', '9:00 AM - 6:00 PM', 'Underwater viewing, snow machines, ice caves', 35, '2020-11-10'),
('Asian Elephant Sanctuary', 'South Wing', '4 acres', 'Temperate', 'Spacious sanctuary for Asian elephants with pools and mud wallows', '9:00 AM - 6:00 PM', 'Swimming pools, mud baths, enrichment areas', 60, '2017-05-30'),
('Reptile House', 'Central Building', '0.5 acres', 'Controlled', 'Climate-controlled building housing snakes, lizards, and turtles', '9:00 AM - 6:00 PM', 'Glass terrariums, UV lighting, temperature control', 25, '2016-09-12'),
('Great Ape Habitat', 'East Wing', '3.5 acres', 'Tropical', 'Large outdoor and indoor spaces for gorillas and orangutans', '9:00 AM - 6:00 PM', 'Climbing structures, glass viewing areas, educational displays', 45, '2021-04-18'),
('Australian Outback', 'South Wing', '2.5 acres', 'Arid', 'Red sand landscape featuring kangaroos, wallabies, and emus', '9:00 AM - 6:00 PM', 'Walk-through experience, feeding stations, interpretive trail', 35, '2019-10-22'),
('Penguin Cove', 'North Wing', '1.5 acres', 'Cold', 'Antarctic-style habitat with swimming areas and nesting sites', '9:00 AM - 6:00 PM', 'Underwater viewing tunnel, ice machine, feeding demonstrations', 40, '2020-02-14'),
('Big Cat Canyon', 'West Wing', '6 acres', 'Varied', 'Multi-level habitat for tigers, leopards, and mountain lions', '9:00 AM - 6:00 PM', 'Elevated walkways, glass barriers, waterfall features', 55, '2018-08-30'),
('Nocturnal House', 'Central Building', '0.8 acres', 'Controlled', 'Reversed lighting system showcasing night-active animals', '9:00 AM - 6:00 PM', 'Red lighting, sound dampening, interactive exhibits', 30, '2017-12-01'),
('Children''s Zoo', 'East Entrance', '1 acre', 'Temperate', 'Interactive area with domestic animals and educational programs', '9:00 AM - 6:00 PM', 'Petting areas, feeding opportunities, playground', 75, '2015-06-15'),
('Marine Mammal Pool', 'North Wing', '2 acres', 'Aquatic', 'Large pool system for seals and sea lions with performance area', '9:00 AM - 6:00 PM', 'Amphitheater seating, underwater viewing, training demonstrations', 150, '2019-03-12'),
('Butterfly Conservatory', 'South Wing', '0.3 acres', 'Tropical Humid', 'Glass house filled with exotic butterflies from around the world', '9:00 AM - 6:00 PM', 'Climate control, native plants, emergence chambers', 20, '2020-07-08'),
('Prairie Grasslands', 'West Wing', '4.5 acres', 'Temperate', 'Open grassland exhibit featuring bison, prairie dogs, and raptors', '9:00 AM - 6:00 PM', 'Boardwalk trails, underground viewing, bird of prey demonstrations', 40, '2016-11-20'),
('Primate Island', 'Central Area', '2 acres', 'Tropical', 'Island habitat surrounded by water featuring various monkey species', '9:00 AM - 6:00 PM', 'Suspension bridges, feeding platforms, enrichment activities', 35, '2018-05-25');

INSERT INTO animals (name, species, age, gender, habitat, diet, description, conservation_status, arrival_date, weight_kg, exhibit_id) VALUES
-- African Savanna Animals
('Simba', 'African Lion', 8, 'Male', 'Grasslands', 'Carnivore', 'Majestic male lion with a full mane, known for his impressive roar', 'Vulnerable', '2019-04-15', 190.5, 1),
('Nala', 'African Lion', 6, 'Female', 'Grasslands', 'Carnivore', 'Graceful lioness and excellent hunter, companion to Simba', 'Vulnerable', '2019-04-15', 140.2, 1),
('Zara', 'Giraffe', 12, 'Female', 'Grasslands', 'Herbivore', 'Tallest resident of the zoo with distinctive spot patterns', 'Least Concern', '2020-06-08', 800.0, 1),
('Thunder', 'Plains Zebra', 9, 'Male', 'Grasslands', 'Herbivore', 'Striking stallion with bold black and white stripes', 'Least Concern', '2019-07-22', 350.0, 1),
('Stripe', 'Plains Zebra', 7, 'Female', 'Grasslands', 'Herbivore', 'Gentle mare known for her calm demeanor with visitors', 'Least Concern', '2019-07-22', 320.0, 1),

-- Amazon Rainforest Animals
('Rex', 'Jaguar', 5, 'Male', 'Rainforest', 'Carnivore', 'Powerful spotted cat known for his swimming abilities', 'Near Threatened', '2021-02-20', 95.3, 2),
('Luna', 'Howler Monkey', 3, 'Female', 'Rainforest', 'Omnivore', 'Vocal primate known for her loud morning calls', 'Least Concern', '2022-01-10', 6.8, 2),
('Phoenix', 'Scarlet Macaw', 8, 'Male', 'Rainforest', 'Omnivore', 'Brilliant red parrot with impressive vocabulary and wingspan', 'Least Concern', '2020-03-18', 1.5, 2),
('Ruby', 'Scarlet Macaw', 6, 'Female', 'Rainforest', 'Omnivore', 'Vibrant female macaw who loves interacting with keepers', 'Least Concern', '2020-03-18', 1.3, 2),
('Mango', 'Toucan', 4, 'Male', 'Rainforest', 'Omnivore', 'Colorful bird with an oversized beak and playful personality', 'Least Concern', '2021-06-12', 0.6, 2),

-- Arctic Tundra Animals
('Frost', 'Polar Bear', 7, 'Male', 'Arctic', 'Carnivore', 'Massive white bear who loves swimming in cold water', 'Vulnerable', '2020-12-05', 450.0, 3),
('Snow', 'Arctic Fox', 4, 'Female', 'Arctic', 'Omnivore', 'Fluffy white fox with seasonal coat changes', 'Least Concern', '2021-08-18', 3.2, 3),
('Blizzard', 'Arctic Fox', 5, 'Male', 'Arctic', 'Omnivore', 'Playful male fox with thick winter coat', 'Least Concern', '2021-08-18', 4.1, 3),
('Aurora', 'Snowy Owl', 6, 'Female', 'Arctic', 'Carnivore', 'Magnificent white owl with piercing yellow eyes', 'Least Concern', '2022-09-30', 2.1, 3),

-- Asian Elephant Sanctuary Animals
('Ganesh', 'Asian Elephant', 25, 'Male', 'Forest', 'Herbivore', 'Gentle giant who loves mud baths and playing with enrichment toys', 'Endangered', '2018-03-20', 4500.0, 4),
('Priya', 'Asian Elephant', 22, 'Female', 'Forest', 'Herbivore', 'Intelligent matriarch known for her problem-solving skills', 'Endangered', '2018-03-20', 3800.0, 4),
('Kavi', 'Asian Elephant', 12, 'Male', 'Forest', 'Herbivore', 'Young bull elephant learning from the older males', 'Endangered', '2021-11-08', 2800.0, 4),

-- Reptile House Animals
('Venom', 'King Cobra', 6, 'Male', 'Various', 'Carnivore', 'Impressive snake known for his defensive displays', 'Least Concern', '2021-05-15', 12.0, 5),
('Emerald', 'Green Tree Python', 4, 'Female', 'Rainforest', 'Carnivore', 'Beautiful green python with perfect camouflage', 'Least Concern', '2022-02-28', 1.8, 5),
('Spike', 'Bearded Dragon', 3, 'Male', 'Desert', 'Omnivore', 'Friendly lizard who enjoys basking under heat lamps', 'Least Concern', '2021-10-14', 0.5, 5),
('Shell', 'Aldabra Giant Tortoise', 45, 'Male', 'Various', 'Herbivore', 'Ancient tortoise with impressive size and longevity', 'Vulnerable', '2015-04-20', 200.0, 5),

-- Great Ape Habitat Animals
('King', 'Western Lowland Gorilla', 18, 'Male', 'Forest', 'Herbivore', 'Powerful silverback gorilla and leader of his troop', 'Critically Endangered', '2017-08-15', 180.0, 6),
('Grace', 'Western Lowland Gorilla', 16, 'Female', 'Forest', 'Herbivore', 'Gentle mother gorilla with strong maternal instincts', 'Critically Endangered', '2017-08-15', 90.0, 6),
('Titan', 'Bornean Orangutan', 12, 'Male', 'Forest', 'Omnivore', 'Intelligent orange ape known for his tool use abilities', 'Critically Endangered', '2019-05-30', 75.0, 6),
('Amber', 'Bornean Orangutan', 10, 'Female', 'Forest', 'Omnivore', 'Curious female orangutan who loves puzzles and enrichment', 'Critically Endangered', '2019-05-30', 40.0, 6),

-- Australian Outback Animals
('Rusty', 'Red Kangaroo', 8, 'Male', 'Grasslands', 'Herbivore', 'Large male kangaroo with powerful jumping abilities', 'Least Concern', '2020-01-25', 85.0, 7),
('Penny', 'Red Kangaroo', 6, 'Female', 'Grasslands', 'Herbivore', 'Gentle female kangaroo often seen with a joey', 'Least Concern', '2020-01-25', 35.0, 7),
('Dash', 'Emu', 5, 'Male', 'Grasslands', 'Omnivore', 'Fast-running flightless bird with curious nature', 'Least Concern', '2020-11-12', 45.0, 7),
('Dingo', 'Dingo', 4, 'Male', 'Various', 'Carnivore', 'Wild dog native to Australia with pack hunting instincts', 'Vulnerable', '2021-03-08', 18.0, 7),

-- Penguin Cove Animals
('Wadsworth', 'Emperor Penguin', 7, 'Male', 'Antarctic', 'Carnivore', 'Largest penguin species with distinctive yellow markings', 'Near Threatened', '2020-06-15', 35.0, 8),
('Penny', 'Emperor Penguin', 5, 'Female', 'Antarctic', 'Carnivore', 'Graceful swimmer known for her diving abilities', 'Near Threatened', '2020-06-15', 28.0, 8),
('Flipper', 'Adelie Penguin', 4, 'Male', 'Antarctic', 'Carnivore', 'Smaller penguin with distinctive white eye rings', 'Least Concern', '2021-02-20', 5.0, 8),
('Splash', 'Adelie Penguin', 3, 'Female', 'Antarctic', 'Carnivore', 'Energetic penguin who loves playing in the water', 'Least Concern', '2021-02-20', 4.5, 8),

-- Big Cat Canyon Animals
('Raja', 'Siberian Tiger', 9, 'Male', 'Forest', 'Carnivore', 'Magnificent orange tiger with bold black stripes', 'Endangered', '2018-12-10', 220.0, 9),
('Sasha', 'Siberian Tiger', 7, 'Female', 'Forest', 'Carnivore', 'Powerful tigress known for her hunting prowess', 'Endangered', '2018-12-10', 140.0, 9),
('Shadow', 'Black Leopard', 6, 'Male', 'Forest', 'Carnivore', 'Elusive melanistic leopard with stunning coat', 'Near Threatened', '2020-04-22', 65.0, 9),
('Storm', 'Mountain Lion', 8, 'Female', 'Mountains', 'Carnivore', 'Agile predator with incredible jumping abilities', 'Least Concern', '2019-09-18', 55.0, 9),

-- Nocturnal House Animals
('Hoot', 'Great Horned Owl', 5, 'Male', 'Forest', 'Carnivore', 'Large owl with distinctive ear tufts and hooting call', 'Least Concern', '2021-01-15', 1.8, 10),
('Echo', 'Fennec Fox', 3, 'Female', 'Desert', 'Omnivore', 'Small fox with oversized ears adapted for desert life', 'Least Concern', '2022-03-22', 1.2, 10),
('Bandit', 'Raccoon', 4, 'Male', 'Various', 'Omnivore', 'Intelligent mammal known for washing food before eating', 'Least Concern', '2021-07-08', 8.0, 10),

-- Marine Mammal Pool Animals
('Splash', 'California Sea Lion', 12, 'Male', 'Coastal', 'Carnivore', 'Playful sea lion who performs in daily shows', 'Least Concern', '2018-06-30', 240.0, 12),
('Marina', 'California Sea Lion', 8, 'Female', 'Coastal', 'Carnivore', 'Graceful swimmer known for her acrobatic abilities', 'Least Concern', '2019-04-12', 110.0, 12),
('Whiskers', 'Harbor Seal', 6, 'Male', 'Coastal', 'Carnivore', 'Spotted seal with distinctive whiskers and gentle nature', 'Least Concern', '2020-08-25', 85.0, 12),

-- Prairie Grasslands Animals
('Thunder', 'American Bison', 15, 'Male', 'Grasslands', 'Herbivore', 'Massive bull bison with impressive horns and shoulder hump', 'Near Threatened', '2017-05-14', 900.0, 14),
('Prairie', 'American Bison', 12, 'Female', 'Grasslands', 'Herbivore', 'Strong female bison who leads the small herd', 'Near Threatened', '2017-05-14', 550.0, 14),
('Squeaky', 'Black-footed Ferret', 2, 'Male', 'Grasslands', 'Carnivore', 'Rare ferret species making a comeback from near extinction', 'Endangered', '2022-11-18', 1.0, 14),

-- Primate Island Animals
('Coco', 'Capuchin Monkey', 8, 'Female', 'Forest', 'Omnivore', 'Intelligent monkey known for using tools to obtain food', 'Least Concern', '2019-12-05', 3.5, 15),
('Mango', 'Spider Monkey', 6, 'Male', 'Rainforest', 'Omnivore', 'Agile monkey with long limbs perfect for swinging', 'Vulnerable', '2020-07-30', 7.2, 15),
('Ginger', 'Golden Lion Tamarin', 4, 'Female', 'Rainforest', 'Omnivore', 'Small monkey with distinctive golden mane', 'Endangered', '2021-09-14', 0.6, 15);

INSERT INTO staff (name, position, department, specialization, experience_years, education, bio, hire_date, email, phone) VALUES
-- Senior Management
('Dr. Sarah Johnson', 'Head Veterinarian', 'Animal Health', 'Large Mammals', 15, 'DVM from UC Davis', 'Passionate about wildlife conservation with expertise in elephant care', '2018-01-15', 'sarah.johnson@langdalezoo.com', '555-0101'),
('David Thompson', 'Curator of Mammals', 'Animal Care', 'Mammalogy', 20, 'PhD in Animal Science', 'Renowned expert in mammalian behavior and breeding programs', '2015-09-01', 'david.thompson@langdalezoo.com', '555-0104'),
('Jennifer Adams', 'Conservation Biologist', 'Conservation', 'Species Preservation', 14, 'PhD in Conservation Biology', 'Leading researcher in endangered species breeding programs', '2016-07-18', 'jennifer.adams@langdalezoo.com', '555-0107'),
('Dr. Mark Peterson', 'Zoo Director', 'Administration', 'Zoo Management', 25, 'DVM, MBA', 'Visionary leader committed to conservation and education excellence', '2012-01-01', 'mark.peterson@langdalezoo.com', '555-0120'),

-- Animal Care Staff
('Mike Rodriguez', 'Senior Zookeeper', 'Animal Care', 'Big Cats', 12, 'BS in Zoology', 'Experienced keeper specializing in carnivore behavior and enrichment', '2017-03-20', 'mike.rodriguez@langdalezoo.com', '555-0102'),
('Carlos Martinez', 'Keeper Supervisor', 'Animal Care', 'Primates', 10, 'BS in Biology', 'Expert in primate behavior with focus on enrichment programs', '2018-11-12', 'carlos.martinez@langdalezoo.com', '555-0106'),
('Amy Foster', 'Senior Zookeeper', 'Animal Care', 'Marine Mammals', 14, 'BS in Marine Biology', 'Specialist in marine mammal training and husbandry', '2016-05-22', 'amy.foster@langdalezoo.com', '555-0109'),
('Jake Morrison', 'Zookeeper', 'Animal Care', 'Birds', 8, 'BS in Ornithology', 'Passionate bird expert focusing on flight and free-flight programs', '2019-08-15', 'jake.morrison@langdalezoo.com', '555-0110'),
('Rachel Green', 'Zookeeper', 'Animal Care', 'Reptiles', 6, 'BS in Herpetology', 'Reptile specialist with expertise in venomous species handling', '2020-09-10', 'rachel.green@langdalezoo.com', '555-0111'),
('Maria Santos', 'Zookeeper', 'Animal Care', 'Ungulates', 9, 'BS in Animal Science', 'Expert in hoofed animal care and breeding management', '2018-04-12', 'maria.santos@langdalezoo.com', '555-0112'),
('Brandon Lee', 'Zookeeper', 'Animal Care', 'Small Mammals', 5, 'AS in Zoology', 'Dedicated keeper specializing in nocturnal and small mammal care', '2021-06-01', 'brandon.lee@langdalezoo.com', '555-0113'),

-- Veterinary Staff
('Lisa Park', 'Veterinary Technician', 'Animal Health', 'Veterinary Medicine', 6, 'Associate Degree in Vet Tech', 'Skilled in animal handling and medical procedures', '2020-04-05', 'lisa.park@langdalezoo.com', '555-0105'),
('Dr. Rebecca Walsh', 'Associate Veterinarian', 'Animal Health', 'Wildlife Medicine', 8, 'DVM from Cornell', 'Wildlife veterinarian specializing in exotic animal surgery', '2019-11-20', 'rebecca.walsh@langdalezoo.com', '555-0114'),
('Kevin O''Brien', 'Veterinary Technician', 'Animal Health', 'Anesthesia', 12, 'BS in Veterinary Technology', 'Expert in anesthesia protocols for diverse species', '2017-02-14', 'kevin.obrien@langdalezoo.com', '555-0115'),

-- Education Staff
('Emma Chen', 'Education Coordinator', 'Education', 'Environmental Education', 8, 'MS in Environmental Science', 'Dedicated to inspiring the next generation of conservationists', '2019-06-10', 'emma.chen@langdalezoo.com', '555-0103'),
('Robert Martinez', 'Education Specialist', 'Education', 'School Programs', 6, 'BS in Education, Biology Minor', 'Enthusiastic educator creating engaging programs for students', '2020-01-08', 'robert.martinez@langdalezoo.com', '555-0116'),
('Samantha Davis', 'Education Specialist', 'Education', 'Public Programs', 4, 'BS in Environmental Studies', 'Expert in developing interactive public education experiences', '2021-09-20', 'samantha.davis@langdalezoo.com', '555-0117'),

-- Operations Staff
('Tom Wilson', 'Maintenance Supervisor', 'Operations', 'Facility Management', 18, 'Trade School Certificate', 'Ensures all exhibits and facilities are safe and functional', '2014-02-28', 'tom.wilson@langdalezoo.com', '555-0108'),
('Janet Phillips', 'Food Service Manager', 'Operations', 'Food Service', 12, 'Culinary Arts Certificate', 'Manages all food preparation for animals and visitor dining', '2017-07-12', 'janet.phillips@langdalezoo.com', '555-0118'),
('Steve Anderson', 'Security Chief', 'Operations', 'Security', 15, 'Criminal Justice Degree', 'Oversees zoo security and emergency response protocols', '2015-03-18', 'steve.anderson@langdalezoo.com', '555-0119'),
('Michelle Carter', 'Groundskeeper', 'Operations', 'Landscaping', 7, 'Horticulture Certificate', 'Maintains beautiful gardens and natural landscaping throughout the zoo', '2019-05-25', 'michelle.carter@langdalezoo.com', '555-0121'),

-- Research Staff
('Dr. Patricia Moore', 'Research Scientist', 'Research', 'Animal Behavior', 11, 'PhD in Animal Behavior', 'Conducts research on animal cognition and enrichment effectiveness', '2018-10-01', 'patricia.moore@langdalezoo.com', '555-0122'),
('Alex Thompson', 'Research Associate', 'Research', 'Conservation Genetics', 5, 'MS in Genetics', 'Specializes in genetic research for breeding program management', '2021-03-15', 'alex.thompson@langdalezoo.com', '555-0123'),

-- Guest Services
('Lauren White', 'Guest Services Manager', 'Guest Services', 'Customer Relations', 9, 'BS in Hospitality Management', 'Ensures exceptional visitor experiences and handles guest relations', '2018-06-18', 'lauren.white@langdalezoo.com', '555-0124'),
('Daniel Kim', 'Gift Shop Manager', 'Guest Services', 'Retail Operations', 6, 'BS in Business', 'Manages zoo retail operations and educational merchandise', '2020-11-30', 'daniel.kim@langdalezoo.com', '555-0125');

INSERT INTO visitors (name, email, phone, visit_date, ticket_type, group_size, special_requests) VALUES
-- Recent Visitors
('John Smith', 'john.smith@email.com', '555-1001', '2024-01-15', 'Adult', 2, 'Wheelchair accessible paths'),
('Maria Garcia', 'maria.garcia@email.com', '555-1002', '2024-01-16', 'Family Pack', 4, 'Birthday party setup'),
('Robert Johnson', 'robert.johnson@email.com', '555-1003', '2024-01-17', 'Senior', 1, NULL),
('Emily Davis', 'emily.davis@email.com', '555-1004', '2024-01-18', 'Student Group', 25, 'Educational tour requested'),
('Michael Brown', 'michael.brown@email.com', '555-1005', '2024-01-19', 'Adult', 3, 'Photography permission'),
('Sarah Williams', 'sarah.williams@email.com', '555-1006', '2024-01-20', 'Family Pack', 5, 'Stroller rental needed'),
('David Chen', 'david.chen@email.com', '555-1007', '2024-01-21', 'Adult', 1, 'Behind-the-scenes tour'),
('Jennifer Lopez', 'jennifer.lopez@email.com', '555-1008', '2024-01-22', 'Child', 2, 'First visit to zoo'),
('Mark Wilson', 'mark.wilson@email.com', '555-1009', '2024-01-23', 'Senior', 2, 'Guided tour preferred'),
('Lisa Anderson', 'lisa.anderson@email.com', '555-1010', '2024-01-24', 'Adult', 4, 'Animal feeding experience'),
('James Taylor', 'james.taylor@email.com', '555-1011', '2024-01-25', 'Family Pack', 6, 'Birthday celebration'),
('Amy Foster', 'amy.foster.visitor@email.com', '555-1012', '2024-01-26', 'Adult', 3, 'Educational materials requested'),
('Carlos Rivera', 'carlos.rivera@email.com', '555-1013', '2024-01-27', 'Student Group', 15, 'School field trip'),
('Rachel Green', 'rachel.green.visitor@email.com', '555-1014', '2024-01-28', 'Adult', 2, 'Conservation program interest'),
('Kevin Murphy', 'kevin.murphy@email.com', '555-1015', '2024-01-29', 'Senior', 1, 'Mobility assistance needed'),
('Sophie Turner', 'sophie.turner@email.com', '555-1016', '2024-01-30', 'Family Pack', 4, 'Zoo membership inquiry'),
('Alex Rodriguez', 'alex.rodriguez@email.com', '555-1017', '2024-02-01', 'Adult', 2, 'Marine mammal show tickets'),
('Hannah White', 'hannah.white@email.com', '555-1018', '2024-02-02', 'Child', 1, 'Junior zookeeper program'),
('Ryan O''Connor', 'ryan.oconnor@email.com', '555-1019', '2024-02-03', 'Adult', 5, 'Group discount applied'),
('Nicole Kim', 'nicole.kim@email.com', '555-1020', '2024-02-04', 'Family Pack', 3, 'Butterfly garden visit'),
('Thomas Lee', 'thomas.lee@email.com', '555-1021', '2024-02-05', 'Adult', 1, 'Wildlife photography'),
('Jessica Martinez', 'jessica.martinez@email.com', '555-1022', '2024-02-06', 'Senior', 2, 'Quiet hours preferred'),
('Brandon Scott', 'brandon.scott@email.com', '555-1023', '2024-02-07', 'Student Group', 20, 'Biology class visit'),
('Melissa Clark', 'melissa.clark@email.com', '555-1024', '2024-02-08', 'Family Pack', 4, 'Animal adoption program'),
('Christopher Hall', 'chris.hall@email.com', '555-1025', '2024-02-09', 'Adult', 2, 'Conservation donation'),
('Amanda Lewis', 'amanda.lewis@email.com', '555-1026', '2024-02-10', 'Adult', 3, 'Primate research interest'),
('Matthew Young', 'matthew.young@email.com', '555-1027', '2024-02-11', 'Family Pack', 5, 'Educational workshop'),
('Diana King', 'diana.king@email.com', '555-1028', '2024-02-12', 'Senior', 1, 'Volunteer program inquiry'),
('Jacob Wright', 'jacob.wright@email.com', '555-1029', '2024-02-13', 'Adult', 2, 'Annual membership renewal'),
('Victoria Adams', 'victoria.adams@email.com', '555-1030', '2024-02-14', 'Family Pack', 6, 'Valentine''s Day special');

INSERT INTO animal_care_logs (animal_id, staff_id, care_type, notes, care_date) VALUES
-- Big Cat Care
(1, 1, 'Health Check', 'Annual physical exam completed. All vitals normal.', '2024-01-10'),
(1, 5, 'Feeding', 'Fed 15kg of meat. Good appetite observed.', '2024-01-15'),
(2, 1, 'Health Check', 'Routine examination. Weight stable at 140kg.', '2024-01-12'),
(17, 5, 'Health Check', 'Tiger health assessment. All parameters normal.', '2024-01-08'),
(18, 5, 'Vaccination', 'Annual vaccinations completed without issues.', '2024-01-09'),

-- Elephant Care
(8, 1, 'Health Check', 'Routine check-up. Minor cut on trunk treated.', '2024-01-14'),
(8, 2, 'Enrichment', 'Provided new puzzle feeder. Showed great interest.', '2024-01-18'),
(9, 1, 'Health Check', 'Matriarch exam completed. Excellent health status.', '2024-01-16'),
(10, 1, 'Health Check', 'Young bull exam. Growth progressing well.', '2024-01-20'),

-- Reptile Care
(13, 9, 'Feeding', 'Fed frozen-thawed rat. Normal feeding response.', '2024-01-16'),
(13, 9, 'Shed Assistance', 'Assisted with partial shed. Skin health good.', '2024-01-22'),
(14, 9, 'Health Check', 'Python examination complete. Weight optimal.', '2024-01-24'),

-- Primate Care
(19, 6, 'Enrichment', 'New climbing structure introduced. High engagement.', '2024-01-11'),
(20, 6, 'Health Check', 'Gorilla troop health assessment completed.', '2024-01-13'),
(21, 6, 'Behavioral', 'Tool use training session. Excellent progress.', '2024-01-17'),

-- Marine Mammal Care
(29, 7, 'Training', 'Sea lion show preparation. New behaviors learned.', '2024-01-19'),
(30, 7, 'Health Check', 'Marine mammal pool water quality and health check.', '2024-01-21'),

-- Bird Care
(11, 8, 'Feeding', 'Macaw dietary supplement added. Response positive.', '2024-01-25'),
(12, 8, 'Training', 'Flight training session completed successfully.', '2024-01-26'),

-- Ungulate Care
(4, 12, 'Health Check', 'Giraffe neck examination. Joint health excellent.', '2024-01-28'),
(5, 12, 'Grooming', 'Zebra hoof care and grooming completed.', '2024-01-30'),

-- Small Mammal Care
(7, 13, 'Health Check', 'Arctic fox winter coat assessment.', '2024-02-01'),
(33, 13, 'Enrichment', 'Fennec fox new toy introduction.', '2024-02-03'),

-- Penguin Care
(25, 7, 'Feeding', 'Emperor penguin fish feeding. Appetite excellent.', '2024-02-05'),
(26, 7, 'Health Check', 'Penguin colony health monitoring completed.', '2024-02-07');

INSERT INTO feeding_schedules (animal_id, feeding_time, food_type, quantity, frequency) VALUES
-- Big Cats
(1, '08:00:00', 'Raw meat', '15kg', 'Daily'),
(1, '16:00:00', 'Raw meat', '10kg', 'Daily'),
(2, '08:30:00', 'Raw meat', '12kg', 'Daily'),
(2, '16:30:00', 'Raw meat', '8kg', 'Daily'),
(17, '09:00:00', 'Raw meat', '20kg', 'Daily'),
(17, '17:00:00', 'Raw meat', '12kg', 'Daily'),
(18, '09:30:00', 'Raw meat', '15kg', 'Daily'),
(18, '17:30:00', 'Raw meat', '10kg', 'Daily'),

-- Elephants
(8, '07:00:00', 'Hay and produce', '150kg', 'Daily'),
(8, '14:00:00', 'Hay and produce', '100kg', 'Daily'),
(8, '19:00:00', 'Enrichment treats', '20kg', 'Daily'),
(9, '07:30:00', 'Hay and produce', '130kg', 'Daily'),
(9, '14:30:00', 'Hay and produce', '90kg', 'Daily'),
(10, '08:00:00', 'Hay and produce', '80kg', 'Daily'),
(10, '15:00:00', 'Hay and produce', '60kg', 'Daily'),

-- Giraffes and Zebras
(4, '09:00:00', 'Hay and browse', '25kg', 'Daily'),
(4, '15:00:00', 'Vegetables', '5kg', 'Daily'),
(5, '09:30:00', 'Hay and grass', '15kg', 'Daily'),
(5, '15:30:00', 'Vegetables', '3kg', 'Daily'),
(6, '10:00:00', 'Hay and grass', '12kg', 'Daily'),

-- Reptiles
(13, '10:00:00', 'Frozen-thawed rodent', '1 medium rat', 'Weekly'),
(14, '11:00:00', 'Frozen-thawed rodent', '1 small rabbit', 'Bi-weekly'),
(15, '14:00:00', 'Insects and vegetables', '200g', 'Daily'),
(16, '12:00:00', 'Vegetables and fruits', '5kg', 'Daily'),

-- Primates
(19, '08:00:00', 'Fruits and vegetables', '8kg', 'Daily'),
(19, '15:00:00', 'Protein and enrichment', '3kg', 'Daily'),
(20, '08:30:00', 'Fruits and vegetables', '6kg', 'Daily'),
(21, '09:00:00', 'Fruits and nuts', '2kg', 'Daily'),
(22, '09:30:00', 'Fruits and insects', '1kg', 'Daily'),

-- Birds
(11, '10:00:00', 'Seeds and fruits', '300g', 'Daily'),
(11, '16:00:00', 'Nuts and supplements', '200g', 'Daily'),
(12, '10:30:00', 'Seeds and fruits', '250g', 'Daily'),
(13, '11:00:00', 'Insects and fruits', '150g', 'Daily'),

-- Marine Mammals
(29, '09:00:00', 'Fish', '12kg', 'Daily'),
(29, '15:00:00', 'Fish and supplements', '8kg', 'Daily'),
(30, '09:30:00', 'Fish', '8kg', 'Daily'),
(31, '10:00:00', 'Fish', '6kg', 'Daily'),

-- Penguins
(25, '11:00:00', 'Fish', '2kg', 'Daily'),
(25, '16:00:00', 'Fish', '1.5kg', 'Daily'),
(26, '11:30:00', 'Fish', '1.8kg', 'Daily'),
(27, '12:00:00', 'Fish', '800g', 'Daily'),
(28, '12:30:00', 'Fish', '700g', 'Daily');