#!/bin/bash

# Start Flask backend on port 3000
python /app/app.py --host=0.0.0.0 --port=3000 &

# Start Nginx frontend on port 3001
nginx -g 'daemon off;'

