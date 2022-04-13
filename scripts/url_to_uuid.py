import uuid
import base64
import sys

url = sys.argv[1]
print(url)
print(base64.urlsafe_b64decode(url.encode()).decode('utf-8'))
