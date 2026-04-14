import pytest
from unittest.mock import patch, MagicMock
from app import app
from psycopg2 import Error as PsyError


@pytest.fixture
def client():
    app.config['TESTING'] = True
    with app.test_client() as client:
        yield client

# Helper to build a fake connection/cursor chain


def build_mock_db(rows):
    mock_cursor = MagicMock()
    # fetchall returns list of dict-like rows
    mock_cursor.fetchall.return_value = rows
    # fetchone returns first element or None
    mock_cursor.fetchone.side_effect = lambda: rows[0] if rows else None
    mock_conn = MagicMock()
    mock_conn.cursor.return_value = mock_cursor
    return mock_conn, mock_cursor


@patch('app.psycopg2.connect')
def test_home_page(connect_mock, client):
    # Home page does not hit DB, ensure no connect call
    response = client.get('/')
    assert response.status_code == 200
    connect_mock.assert_not_called()


@patch('app.psycopg2.connect')
def test_api_animals_list(connect_mock, client):
    rows = [
        {'id': 1, 'name': 'Lion'},
        {'id': 2, 'name': 'Tiger'}
    ]
    mock_conn, mock_cursor = build_mock_db(rows)
    connect_mock.return_value = mock_conn

    resp = client.get('/api/animals')
    assert resp.status_code == 200
    data = resp.get_json()
    assert isinstance(data, list)
    assert {item['name'] for item in data} == {'Lion', 'Tiger'}
    mock_cursor.execute.assert_called_once_with('SELECT * FROM animals')


@patch('app.psycopg2.connect')
def test_api_single_animal_found(connect_mock, client):
    rows = [{'id': 5, 'name': 'Giraffe'}]
    mock_conn, mock_cursor = build_mock_db(rows)
    connect_mock.return_value = mock_conn

    resp = client.get('/api/animals/5')
    assert resp.status_code == 200
    data = resp.get_json()
    assert data['id'] == 5
    assert data['name'] == 'Giraffe'
    mock_cursor.execute.assert_called_once_with(
        'SELECT * FROM animals WHERE id = %s', (5,))


@patch('app.psycopg2.connect')
def test_api_single_animal_not_found(connect_mock, client):
    rows = []  # no rows
    mock_conn, _ = build_mock_db(rows)
    connect_mock.return_value = mock_conn

    resp = client.get('/api/animals/99')
    assert resp.status_code == 404
    data = resp.get_json()
    assert data['error'] == 'Animal not found'


@patch('app.psycopg2.connect')
def test_api_animals_db_failure(connect_mock, client):
    connect_mock.side_effect = PsyError('boom')
    resp = client.get('/api/animals')
    assert resp.status_code == 500
    data = resp.get_json()
    assert 'error' in data


@patch('app.psycopg2.connect')
def test_animals_html_page(connect_mock, client):
    rows = [
        {'id': 1, 'name': 'Penguin'}
    ]
    mock_conn, mock_cursor = build_mock_db(rows)
    connect_mock.return_value = mock_conn

    resp = client.get('/animals')
    assert resp.status_code == 200
    html = resp.get_data(as_text=True)
    assert 'Penguin' in html
    mock_cursor.execute.assert_called_once_with('SELECT * FROM animals')
