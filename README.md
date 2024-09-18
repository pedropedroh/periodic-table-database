# Periodic Table Lookup

This project is a Bash script that allows users to retrieve information about chemical elements from a PostgreSQL database. Users can input either the element's name, symbol, or atomic number to receive detailed information about the element.

## Project Overview

The script connects to a PostgreSQL database named `periodic_table` and retrieves information about elements, including their atomic number, name, symbol, type, atomic mass, melting point, and boiling point.

## File

### `periodic_table_lookup.sh`

This Bash script provides the following functionalities:

- Accepts an element name, symbol, or atomic number as a command-line argument.
- Queries the database to retrieve the corresponding element's information.
- Displays detailed information about the element.

#### Usage

To run the script, use the following command:

```bash
bash periodic_table_lookup.sh <element>
