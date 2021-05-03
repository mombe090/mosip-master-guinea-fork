#!/bin/sh
# Script to query transaction table
psql -d mosip_regprc -h test_mzworker0.wuriguinee.unir -p 30090 -U postgres < sql/trans.sql
