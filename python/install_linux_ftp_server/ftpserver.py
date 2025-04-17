import logging
import sys

from pyftpdlib.handlers import FTPHandler
# servidor normal
#from pyftpdlib.servers import FTPServer
# servidor multiprocesso
from pyftpdlib.servers import MultiprocessFTPServer
from pyftpdlib.authorizers import UnixAuthorizer
from pyftpdlib.filesystems import UnixFilesystem



def main():
    # configuracao de log
    logger = logging.getLogger()
    ch = logging.StreamHandler(sys.stdout)
    logger.setLevel(logging.DEBUG)
    ch.setLevel(logging.DEBUG)
    formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
    ch.setFormatter(formatter)
    logger.addHandler(ch)
    # fim configuracao de log

    # usando os usuarios UNIX
    authorizer = UnixAuthorizer(rejected_users=["root"], require_valid_shell=True)
    handler = FTPHandler
    handler.authorizer = authorizer
    handler.abstracted_fs = UnixFilesystem
    handler.log_prefix = "%(username)s@%(remote_ip)s"
    #logger.basicConfig(filename='/var/log/pyftpd.log', level=logging.INFO)
    # utilizando o servidor multiprocesso
    server = MultiprocessFTPServer(('', 21), handler)
    server.serve_forever()

if __name__ == "__main__":
    main()