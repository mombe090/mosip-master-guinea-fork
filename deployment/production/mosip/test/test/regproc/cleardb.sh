#!/bin/sh
# Script to clear tables related to upload of packet.  This is for testing
# by uploading a single packet
# WARNING: all data in several tables will be erased.
psql -d mosip_regprc -h test_mzworker0.inu.gov.gn -p 30090 -U postgres < sql/regdel.sql
