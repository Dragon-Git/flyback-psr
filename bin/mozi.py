#!/usr/bin/env python3
import os
import mako

import argparse
import pathlib

# create the top-level parser
parser = argparse.ArgumentParser(prog='mozi')
parser.add_argument('--foo', action='store_true', help='foo help')
subparsers = parser.add_subparsers(help='sub-command help')

# create the parser for the "codegen" command
parser_codegen = subparsers.add_parser('codegen', help='generate testbench and RAL')
parser_codegen.add_argument('out_path', type=pathlib.Path, help='bar help')

# create the parser for the "sim" command
paser_sim = subparsers.add_parser('sim', help='sim command')
paser_sim.add_argument('--baz', choices='XYZ', help='baz help')

# create the parser for the "regression" command
paser_regress = subparsers.add_parser('regression', help='regresson command')
paser_regress.add_argument('--baz', choices='XYZ', help='baz help')


args = parser.parse_args()
print(args)