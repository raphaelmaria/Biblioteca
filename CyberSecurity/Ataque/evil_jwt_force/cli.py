import argparse
from core import jwt_bruteforce

def main():
    parser = argparse.ArgumentParser(description="EVIL_JWT_FORCE - Offensive JWT Toolkit")
    parser.add_argument("--token", help="JWT Token alvo")
    parser.add_argument("--wordlist", help="Caminho da wordlist")
    parser.add_argument("--brute", action="store_true", help="Ativar modo brute-force")

    args = parser.parse_args()

    if args.brute:
        jwt_bruteforce.try_decode(args.token, args.wordlist)

if __name__ == "__main__":
    main()
