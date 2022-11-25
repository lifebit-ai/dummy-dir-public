#!/usr/bin/env nextflow



if (params.bindir) ch_bin = Channel.value(file(params.bindir))
if(params.file) ch_file = Channel.value(file(params.file))


// A txt file with one bin file per row
if (params.binlist) {
  Channel
    .fromPath(params.binlist)
    .splitText() { it.trim() }
    .collect()
    .set {ch_bins}
}




/*
================================================================================
                                Main parts
================================================================================
*/


process gender_qc {
  echo true
  publishDir "results/"
  time '10h'

  input:
  path "${params.project}/${params.file}" from ch_file
  output:
  path "file2.txt"

  script:
  """
  cp ${params.project}/${params.file} file2.txt

  """
}
