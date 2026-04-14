from flask import Flask, jsonify, render_template
import psycopg2
from psycopg2.extras import RealDictCursor
from psycopg2 import Error
from os import environ
from dotenv import load_dotenv

app = Flask(__name__)


def get_db_connection():
    try:
        connection = psycopg2.connect(
            database=environ.get("DATABASE_NAME", "test-db"),
            user=environ.get("DATABASE_USERNAME", "test_password"),
            password=environ.get("DATABASE_PASSWORD", "test_password"),
            host=environ.get("DATABASE_IP", "test_ip"),
            port=environ.get("DATABASE_PORT", "5432"),
        )
        return connection
    except Error as e:
        print(f"Error connecting to database: {e}")
        return None

# JSON API Endpoints


@app.route('/api/animals')
def get_animals():
    connection = get_db_connection()
    if not connection:
        return jsonify({"error": "Database connection failed"}), 500

    try:
        cursor = connection.cursor(cursor_factory=RealDictCursor)
        cursor.execute("SELECT * FROM animals")
        animals = cursor.fetchall()
        return jsonify([dict(animal) for animal in animals])
    except Error as e:
        return jsonify({"error": str(e)}), 500
    finally:
        if connection:
            cursor.close()
            connection.close()


@app.route('/api/animals/<int:animal_id>')
def get_animal(animal_id):
    connection = get_db_connection()
    if not connection:
        return jsonify({"error": "Database connection failed"}), 500

    try:
        cursor = connection.cursor(cursor_factory=RealDictCursor)
        cursor.execute("SELECT * FROM animals WHERE id = %s", (animal_id,))
        animal = cursor.fetchone()
        if animal:
            return jsonify(dict(animal))
        return jsonify({"error": "Animal not found"}), 404
    except Error as e:
        return jsonify({"error": str(e)}), 500
    finally:
        if connection:
            cursor.close()
            connection.close()


@app.route('/api/exhibits')
def get_exhibits():
    connection = get_db_connection()
    if not connection:
        return jsonify({"error": "Database connection failed"}), 500

    try:
        cursor = connection.cursor(cursor_factory=RealDictCursor)
        cursor.execute("SELECT * FROM exhibits")
        exhibits = cursor.fetchall()
        return jsonify([dict(exhibit) for exhibit in exhibits])
    except Error as e:
        return jsonify({"error": str(e)}), 500
    finally:
        if connection:
            cursor.close()
            connection.close()


@app.route('/api/staff')
def get_staff():
    connection = get_db_connection()
    if not connection:
        return jsonify({"error": "Database connection failed"}), 500

    try:
        cursor = connection.cursor(cursor_factory=RealDictCursor)
        cursor.execute("SELECT * FROM staff")
        staff = cursor.fetchall()
        return jsonify([dict(member) for member in staff])
    except Error as e:
        return jsonify({"error": str(e)}), 500
    finally:
        if connection:
            cursor.close()
            connection.close()


@app.route('/api/visitors')
def get_visitors():
    connection = get_db_connection()
    if not connection:
        return jsonify({"error": "Database connection failed"}), 500

    try:
        cursor = connection.cursor(cursor_factory=RealDictCursor)
        cursor.execute("SELECT * FROM visitors")
        visitors = cursor.fetchall()
        return jsonify([dict(visitor) for visitor in visitors])
    except Error as e:
        return jsonify({"error": str(e)}), 500
    finally:
        if connection:
            cursor.close()
            connection.close()

# Template Endpoints (HTML Pages)


@app.route('/')
def home():
    return render_template('home.html')


@app.route('/animals')
def animals_page():
    connection = get_db_connection()
    animals = []

    if connection:
        try:
            cursor = connection.cursor(cursor_factory=RealDictCursor)
            cursor.execute("SELECT * FROM animals")
            animals = [dict(animal) for animal in cursor.fetchall()]
        except Error as e:
            print(f"Error fetching animals: {e}")
        finally:
            if connection:
                cursor.close()
                connection.close()

    return render_template('animals.html', animals=animals)


@app.route('/exhibits')
def exhibits_page():
    connection = get_db_connection()
    exhibits = []

    if connection:
        try:
            cursor = connection.cursor(cursor_factory=RealDictCursor)
            cursor.execute("SELECT * FROM exhibits")
            exhibits = [dict(exhibit) for exhibit in cursor.fetchall()]
        except Error as e:
            print(f"Error fetching exhibits: {e}")
        finally:
            if connection:
                cursor.close()
                connection.close()

    return render_template('exhibits.html', exhibits=exhibits)


@app.route('/staff')
def staff_page():
    connection = get_db_connection()
    staff = []

    if connection:
        try:
            cursor = connection.cursor(cursor_factory=RealDictCursor)
            cursor.execute("SELECT * FROM staff")
            staff = [dict(member) for member in cursor.fetchall()]
        except Error as e:
            print(f"Error fetching staff: {e}")
        finally:
            if connection:
                cursor.close()
                connection.close()

    return render_template('staff.html', staff=staff)


@app.route('/visit')
def visit_page():
    return render_template('visit.html')


if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)
    load_dotenv()
