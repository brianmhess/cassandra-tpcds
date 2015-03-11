#!/bin/bash
OUTDIR=/root/dev/tpcds/cass-tpcds/out
TPCDS_ROOT=/root/dev/tpcds/tpcds-kit
TPCDS_SCALE_FACTOR=1

${TPCDS_ROOT}/tools/dsdgen \
  -SCALE ${TPCDS_SCALE_FACTOR} \
  -DISTRIBUTIONS ${TPCDS_ROOT}/tools/tpcds.idx \
  -TERMINATE N \
  -QUIET Y \
  -DIR ${OUTDIR}


