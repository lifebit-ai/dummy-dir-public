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
  mkdir -p ${params.outdir}/results
  cat ${params.file} > ${params.outdir}/results/out.txt
  """
}
