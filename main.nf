#!/usr/bin/env nextflow

// Process design file
if(params.families_file) {
   Channel
      .fromPath( "${params.families_file}")
      .ifEmpty { exit 1, "Family file: ${params.families_file} not found"}
      .set {ch_vcf}
} else {
  exit 1, "please specify Family file with --family_file parameter"
}



// run process
process dummy {
  container 'quay.io/lifebitaiorg/ubuntu'
  tag "${vcf_path1}"
  publishDir "${sample_name}", mode: 'copy'

  input:
  file vcf_path1 from ch_vcf
  script:
    """
    ls $vcf_path1
    """

}
