#!/usr/bin/env python3
"""
UUID to URL-safe base64 converter and vice versa.
"""

import uuid
import sys
from typing import Optional


# URL-safe base64 encoding table (RFC 4648 Table 2)
TABLE_TO_URL = (
    'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_'
)

# Decoding table for URL-safe base64
TABLE_FROM_URL = {char: i for i, char in enumerate(TABLE_TO_URL)}


def uuid_to_url(u: uuid.UUID) -> str:
    """Convert a UUID to a URL-safe base64 string."""
    most_sig = (u.int >> 64) & 0xFFFFFFFFFFFFFFFF
    least_sig = u.int & 0xFFFFFFFFFFFFFFFF

    # Convert to signed 64-bit integers (Java behavior)
    if most_sig >= 0x8000000000000000:
        most_sig -= 0x10000000000000000
    if least_sig >= 0x8000000000000000:
        least_sig -= 0x10000000000000000

    chars = []
    shift = 58

    # Encode first 10 characters from most significant bits
    for i in range(10):
        index = (most_sig >> shift) & 0x3F
        chars.append(TABLE_TO_URL[index])
        shift -= 6

    # Encode 11th character (bridge between most and least significant bits)
    index = ((most_sig << 2) & 0x3C) | ((least_sig >> 62) & 0x3)
    chars.append(TABLE_TO_URL[index])

    # Encode characters 12-21 from least significant bits
    shift = 56
    for i in range(10):
        index = (least_sig >> shift) & 0x3F
        chars.append(TABLE_TO_URL[index])
        shift -= 6

    # Encode 22nd character
    index = (least_sig << 4) & 0x30
    chars.append(TABLE_TO_URL[index])

    return ''.join(chars)


def url_to_uuid(s: str) -> Optional[uuid.UUID]:
    """Convert a URL-safe base64 string back to a UUID."""
    if not s or len(s) != 22:
        return None

    try:
        msb = 0

        # Decode first 10 characters
        for i in range(10):
            v = TABLE_FROM_URL.get(s[i])
            if v is None:
                return None
            msb <<= 6
            msb |= v

        # Decode 11th character (bridge)
        lsb = TABLE_FROM_URL.get(s[10])
        if lsb is None:
            return None
        msb <<= 4
        msb |= (lsb >> 2)

        # Decode characters 12-21
        for i in range(11, 21):
            v = TABLE_FROM_URL.get(s[i])
            if v is None:
                return None
            lsb <<= 6
            lsb |= v

        # Decode 22nd character
        v = TABLE_FROM_URL.get(s[21])
        if v is None:
            return None
        lsb <<= 2
        lsb |= (v >> 4)

        # Convert to unsigned 64-bit integers
        if msb < 0:
            msb += 0x10000000000000000
        if lsb < 0:
            lsb += 0x10000000000000000

        # Combine into 128-bit UUID
        uuid_int = (msb << 64) | lsb

        return uuid.UUID(int=uuid_int)

    except (KeyError, ValueError, IndexError):
        return None


def main():
    if len(sys.argv) < 3:
        print("Usage: uuid_converter.py <encode|decode> <value>", file=sys.stderr)
        sys.exit(1)

    command = sys.argv[1].lower()
    value = sys.argv[2]

    try:
        if command == "encode":
            u = uuid.UUID(value)
            print(uuid_to_url(u))
        elif command == "decode":
            result = url_to_uuid(value)
            if result:
                print(str(result))
            else:
                print("Error: Invalid URL-safe base64 string", file=sys.stderr)
                sys.exit(1)
        else:
            print(f"Error: Unknown command '{command}'. Use 'encode' or 'decode'", file=sys.stderr)
            sys.exit(1)
    except Exception as e:
        print(f"Error: {e}", file=sys.stderr)
        sys.exit(1)


if __name__ == '__main__':
    main()
