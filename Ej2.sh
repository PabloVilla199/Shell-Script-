#!/bin/bash

dias=30

usuarios_inactivos=$(lastlog -b $dias | grep -v "Never"| cut -d' ' -f1)

echo "$usuarios_inactivos"
