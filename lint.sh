#!/bin/bash
LINT_FILES=$(fd '.hs$')
FORMAT_FILES=$(fd '.hs$')
stack exec hindent -- $FORMAT_FILES
stack exec hlint -- $LINT_FILES