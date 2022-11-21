#!/usr/bin/env nextflow



if (params.bindir) ch_bin = Channel.value(file(params.bindir))



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
  path bin_dir from ch_bin
  output:
  path "list_file.txt"

  script:
  """
  ls $bin_dir > list_file.txt

  """
}
