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
  path "${params.outdir}/childpath/out.txt"
  script:
  """
  mkdir -p ${params.outdir}/childpath
  echo 'randomtext' > ${params.outdir}/childpath/out.txt
  
  echo 'run ls -la :'
  ls -la
  echo 'run ls -R :'
  ls -R  
  """
}
