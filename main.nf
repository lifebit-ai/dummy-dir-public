#!/usr/bin/env nextflow

if(params.file) ch_file = Channel.value(file(params.file))


/*
================================================================================
                                Main parts
================================================================================
*/


process gender_qc {
  echo true
  publishDir "results/"
  container 'quay.io/lifebitai/ubuntu'
  input:
  path "${params.file}" from ch_file
  output:
  path "${params.outdir}/results/out.txt"
  script:
  """
  cat ${params.file} > out.txt
  """
}
