#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [ -z "$1" ]; then
  echo "Please provide an element as an argument."
  exit 1
fi

# Find element by atomic number, symbol, or name
RESULT=$($PSQL "SELECT e.atomic_number, e.symbol, e.name, p.atomic_mass, p.melting_point_celsius, p.boiling_point_celsius, t.type
                 FROM elements e
                 JOIN properties p ON e.atomic_number = p.atomic_number
                 JOIN types t ON p.type_id = t.type_id
                 WHERE e.atomic_number = '$1' OR e.symbol = '$1' OR e.name = '$1';")

if [ -z "$RESULT" ]; then
  echo "I could not find that element in the database."
else
  echo "$RESULT"
fi