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
  time '10h'
  container 'quay.io/lifebitai/ubuntu'
  input:
  path "${params.project}/${params.file}" from ch_file
  script:
  """
  ls ${params.project}/${params.file}
  """
}
