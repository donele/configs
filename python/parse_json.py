#!/usr/bin/env python3

import json
import sys

if len(sys.argv) < 3:
    print('python parse_ref.py infilename outfilename')
    sys.exit(1)

infile = sys.argv[1]
outfile = sys.argv[2]

with open(infile) as f:
    b = json.load(f)
with open(outfile, 'w') as f:
    json.dump(b, f, indent=4)
