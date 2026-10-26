"""usage: python3 tools/check_md5.py FILE EXPECTED_MD5   (exit status 1 if different)"""
import hashlib, sys
got = hashlib.md5(open(sys.argv[1], 'rb').read()).hexdigest()
print('%s  %s  %s' % (got, sys.argv[1], 'OK' if got == sys.argv[2] else 'DIFFERENT (expected %s)' % sys.argv[2]))
sys.exit(0 if got == sys.argv[2] else 1)
