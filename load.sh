#!/bin/bash
psql -d uni -f createTables.sql
psql -d uni -f loadData.sql

