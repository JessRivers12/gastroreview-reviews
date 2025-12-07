from flask import Flask, jsonify, request
import psycopg2
from psycopg2.extras import RealDictCursor
import uuid
from datetime import datetime

app = Flask(__name__)

# Neon Database connection
DATABASE_URL = "postgresql://neondb_owner:npg_GduJi8PA2vTb@ep-patient-credit-adceyqvj-pooler.c-2.us-east-1.aws.neon.tech:5432/neondb?sslmode=require"

def get_db_connection():
    return psycopg2.connect(DATABASE_URL, cursor_factory=RealDictCursor)

@app.route('/')
def home():
    return jsonify({
        "service": "Reviews Microservice",
        "status": "running",
        "database": "Neon PostgreSQL",
        "endpoints": [
            "GET /reviews - List all reviews",
            "POST /reviews - Create a review",
            "GET /health - Health check"
        ]
    })

@app.route('/health')
def health():
    try:
        conn = get_db_connection()
        conn.close()
        return jsonify({"status": "healthy", "database": "connected"})
    except Exception as e:
        return jsonify({"status": "unhealthy", "error": str(e)}), 500

@app.route('/reviews', methods=['GET'])
def get_reviews():
    try:
        conn = get_db_connection()
        cur = conn.cursor()
        cur.execute("SELECT * FROM reviews ORDER BY created_at DESC LIMIT 10")
        reviews = cur.fetchall()
        cur.close()
        conn.close()
        return jsonify({"reviews": reviews, "count": len(reviews)})
    except Exception as e:
        return jsonify({"error": str(e)}), 500

@app.route('/reviews', methods=['POST'])
def create_review():
    try:
        data = request.get_json()
        user_id = data.get('user_id')
        restaurant_id = data.get('restaurant_id')
        rating = data.get('rating', 5)
        comment = data.get('comment', '')

        review_id = str(uuid.uuid4())

        conn = get_db_connection()
        cur = conn.cursor()
        cur.execute(
            """INSERT INTO reviews
               (id, user_id, restaurant_id, rating, comment, sentiment_score, sentiment_label, created_at, updated_at)
               VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s) RETURNING *""",
            (review_id, user_id, restaurant_id, rating, comment, 0.5, 'NEUTRAL', datetime.now(), datetime.now())
        )
        new_review = cur.fetchone()
        conn.commit()
        cur.close()
        conn.close()

        return jsonify({"message": "Review created", "review": new_review}), 201
    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == '__main__':
    print("=" * 50)
    print("Starting Reviews Microservice")
    print("Port: 5000")
    print("Database: Neon PostgreSQL")
    print("=" * 50)
    app.run(debug=True, host='0.0.0.0', port=5000)
