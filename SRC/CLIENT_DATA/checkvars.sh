#!/bin/bash
#===========================================================
# Check usage von variables in OPSI scripts 
# (*.ins, *.inc, *opsiscript, *.opsiinc)
# Detect:
#		repeatedly defined variables
#		used but undefined variables
#		unused but defined variables
#
# Version: 1.0
# Jens Boettge <boettge@mpi-halle.mpg.de>  	2017-11-23 16:00:11 +0100
#===========================================================

VARS_DEFINED=$(grep -i -P -e 'def(Var|StringList)' variables.opsiinc  | grep -v "^;" | sed -e 's/^\s+//' -e 's/\s+/ /g' | awk -e '{print $2}' | sort )
VARS_USED=$(cat *.ins *.inc *.opsiscript *.opsiscript.in *.opsiinc *.opsiinc.in 2>/dev/null| grep -v '^\s*;' | grep -i 'set\s*\$' | sed -e 's/^\s*//' | sed -e 's/\t/ /' | cut -f 2 -d " " | sort | uniq)

echo "==============================="
echo "repeatedly defined variables:"
echo "==============================="
echo "$VARS_DEFINED"  |uniq -c | awk -e '{print $1,$2}'| grep -v '^1 '
echo -e ""
VARS_DEFINED=$(echo "$VARS_DEFINED" | uniq)
echo "==============================="
echo "used but undefined variables"
echo "==============================="
for V in $VARS_USED; do [[ " ${VARS_DEFINED} " =~ "$V" ]] || echo "[$V]"; done
echo -e ""
echo "==============================="
echo "unused but defined variables"
echo "==============================="
for V in $VARS_DEFINED; do [[ " ${VARS_USED} " =~ "$V" ]] || echo "[$V]"; done
echo -e ""
#echo "------------------------------------"
#echo "$VARS_DEFINED"
#echo "------------------------------------"
#echo "$VARS_USED"
#echo "------------------------------------"
