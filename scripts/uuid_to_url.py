import uuid
import base64
import sys

u = uuid.UUID(sys.argv[1])
print(u)
print(base64.urlsafe_b64encode(u.bytes).decode("utf-8"))