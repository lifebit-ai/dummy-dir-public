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

// place into channel
Channel
    .fromPath(params.families_file)
    .ifEmpty { exit 1, "Cannot find input file : ${params.input}" }
    .splitCsv(header:true, sep:'\t', strip: true)
    .map {row -> [ row.run_id, row.proband_id, row.hpo, file(row.vcf_path), file(row.vcf_index_path), row.proband_sex, row.mother_id, row.father_id ] }
    .set {ch_input}


// run process
process dummy {
  tag "${vcf_path1}"
  publishDir "${params.outdir}/${sample_name}", mode: 'copy'

  input:
  set run_id, proband_id1, hpo, file(vcf_path1), file(vcf_index_path1), proband_sex, mother_id, father_id from ch_input

  script:

    """

    ls $vcf_path1

    """

}
