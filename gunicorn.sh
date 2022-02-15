#!/bin/sh
gunicorn "flaskr:create_app()" -w 2 --threads 2 -b 0.0.0.0:8888 --log-level debug --access-logfile -