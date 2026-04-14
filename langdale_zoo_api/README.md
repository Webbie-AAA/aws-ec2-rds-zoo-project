# Langdale Zoo API

A comprehensive Flask-based web application and API for Langdale Zoo, featuring both JSON REST endpoints and beautifully designed web pages for visitors and staff.

## 🦁 Features

### Web Application
- **Home Page**: Welcome page with zoo overview and visitor information
- **Animals Page**: Browse all animals with detailed information
- **Exhibits Page**: Explore zoo exhibits and habitats
- **Staff Page**: Meet the zoo team and their specializations
- **Visit Planning**: Comprehensive visitor information and guidelines

### REST API Endpoints
- `GET /api/animals` - Retrieve all animals
- `GET /api/animals/<id>` - Get specific animal details
- `GET /api/exhibits` - List all exhibits
- `GET /api/staff` - View all staff members
- `GET /api/visitors` - Access visitor records

## 🚀 Quick Start

### Prerequisites
- Python 3.8+
- PostgreSQL database
- pip (Python package manager)

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd langdale_zoo_api
   ```

2. **Install dependencies**
   ```bash
   pip install -r requirements.txt
   ```

3. **Set up the database**
   ```bash
   # Create PostgreSQL database
   createdb langdale_zoo
   
   # Run the schema to create tables and populate data
   psql langdale_zoo < schema.sql
   ```

4. **Run the application**
   ```bash
   python app.py
   ```

The application will be available at `http://localhost:5000`

## 🗄️ Database Schema

The database includes comprehensive tables for:

- **Animals** (50+ species across 15 exhibits)
- **Exhibits** (15 themed habitats)
- **Staff** (22+ employees across departments)
- **Visitors** (30+ recent visitor records)
- **Animal Care Logs** (health checks, feeding, training)
- **Feeding Schedules** (species-specific feeding times)

### Key Tables

#### Animals
- Species information, age, weight, conservation status
- Habitat details and behavioral descriptions
- Linked to specific exhibits

#### Exhibits
- Location, size, climate specifications
- Special features and capacity information
- Opening hours and visitor accessibility

#### Staff
- Roles from zookeepers to veterinarians
- Specializations and educational background
- Contact information and hire dates

## 🌐 API Documentation

### Animals Endpoint
```http
GET /api/animals
```

Returns all animals with complete information:
```json
[
  {
    "id": 1,
    "name": "Simba",
    "species": "African Lion",
    "age": 8,
    "gender": "Male",
    "habitat": "Grasslands",
    "diet": "Carnivore",
    "conservation_status": "Vulnerable",
    "weight_kg": 190.5,
    "exhibit_id": 1
  }
]
```

### Individual Animal
```http
GET /api/animals/1
```

### Exhibits Endpoint
```http
GET /api/exhibits
```

Returns exhibit information including:
- Name, location, size, climate
- Special features and visitor capacity
- Operating hours and accessibility

### Staff Endpoint
```http
GET /api/staff
```

Provides staff directory with:
- Names, positions, departments
- Specializations and experience
- Educational background and contact info

### Visitors Endpoint
```http
GET /api/visitors
```

Recent visitor data including:
- Visit dates and ticket types
- Group sizes and special requests
- Contact information

## 🎨 Web Interface

### Design Features
- **Responsive Design**: Works on desktop, tablet, and mobile
- **Modern Styling**: Clean, professional zoo-themed design
- **Interactive Elements**: Hover effects and smooth transitions
- **Accessibility**: Screen reader friendly with proper semantic HTML

### Color Scheme
- Primary: Forest greens (#2c5530, #4a7c59)
- Accent: Vibrant orange (#ff6b35)
- Background: Light gray (#f8f9fa)
- Text: Dark gray (#333)

### Pages Structure
```
/                 - Home page with hero section and overview
/animals          - Grid layout of all animals with details
/exhibits         - Exhibit information and features
/staff            - Staff directory with specializations
/visit            - Comprehensive visitor planning information
```

## 🛠️ Development

### Project Structure
```
langdale_zoo_api/
├── app.py              # Main Flask application
├── schema.sql          # Database schema and sample data
├── requirements.txt    # Python dependencies
├── README.md          # This file
├── templates/         # Jinja2 templates
│   ├── base.html      # Base template with navigation
│   ├── home.html      # Homepage template
│   ├── animals.html   # Animals listing page
│   ├── exhibits.html  # Exhibits information page
│   ├── staff.html     # Staff directory page
│   └── visit.html     # Visitor information page
└── static/
    └── css/
        └── style.css  # Application styles
```

### Technology Stack
- **Backend**: Flask (Python web framework)
- **Database**: PostgreSQL with psycopg2 driver
- **Frontend**: HTML5, CSS3, Jinja2 templating
- **Styling**: Custom CSS with responsive design

### Adding New Features
1. Database changes: Update `schema.sql`
2. API endpoints: Add routes to `app.py`
3. Web pages: Create templates in `templates/`
4. Styling: Update `static/css/style.css`

## 📊 Sample Data

The database comes pre-populated with:
- **50+ Animals** across various species and exhibits
- **15 Exhibits** representing different global habitats
- **22+ Staff Members** from all zoo departments
- **30+ Visitor Records** with diverse demographics
- **Comprehensive Care Logs** tracking animal health and feeding

### Notable Animals
- **Big Cats**: Lions (Simba & Nala), Tigers (Raja & Sasha)
- **Elephants**: Asian elephants (Ganesh, Priya, Kavi)
- **Primates**: Gorillas (King & Grace), Orangutans (Titan & Amber)
- **Marine Life**: Sea lions, penguins, harbor seals
- **Exotic Species**: Jaguars, polar bears, various birds and reptiles

## 🌍 Conservation Focus

Langdale Zoo emphasizes conservation education with:
- Endangered species breeding programs
- Educational visitor experiences
- Research partnerships
- Conservation status tracking for all animals

## 📞 Support

For questions about the API or web application:
- Email: info@langdalezoo.com
- Phone: (+44) 314 123 4567
- Address: 123 Monkeypatch Lane, Langdale, UK

## 🔧 Configuration

### Production Deployment
For production deployment, consider:
- Use a production WSGI server (gunicorn, uWSGI)
- Set `debug=False` in app configuration
- Use environment-specific database configurations
- Implement proper logging and monitoring
- Add SSL/HTTPS termination
- Configure database connection pooling

## 📝 License

This project is created for educational purposes as part of cloud computing coursework.

---

**Built with 🐾 for Langdale Zoo**
