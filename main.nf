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
  path "out.txt"
  script:
  """
  mkdir -p ${params.outdir}/childpath
  echo 'randomtext' > out.txt
  ls -R  
  """
}
