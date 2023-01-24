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
  path "${params.file}" from ch_file
  script:
  """
  for i in {1..48}
  do
    echo 'starting' \$i 'hour'
    sleep 3600
    echo \$i 'hours done'
  done

  echo 'done'

  """
}
