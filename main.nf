#!/usr/bin/env nextflow


/*
================================================================================
                                Main parts
================================================================================
*/


process gender_qc {
  echo true
  publishDir "results/"
  container 'quay.io/lifebitai/ubuntu'
  output:
  path "${params.outdir}/results/out.txt"
  script:
  """
  mkdir -p ${params.outdir}/results
  echo 'randomtext' > ${params.outdir}/results/out.txt
  """
}
