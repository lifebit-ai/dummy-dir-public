#!/usr/bin/env python3
# RPC 291122
# Aim take family file and convert to passed

from ped_parser import Individual, Family
import pandas as pd
import os
import argparse

# local test
# os.chdir("/Users/ryancardenas/Documents/exomiser-pipeline-nf/bin")
# input_dat = pd.read_csv("familytest.tsv", sep="\t")

#build arg parser here
parser = argparse.ArgumentParser(description='Create PED file from family file - Exomiser')
parser.add_argument('--input_family', nargs=1, required=True, help='Enter the path for the familt TSV file')
args = parser.parse_args()


#bamfile set
input = str(args.input_family[0])
input_dat = pd.read_csv(input, sep="\t")

# --------------- create function for ped_parser
def PED_function(proband_ID, vcf_path, vcf_index, proband_sex, mother_ID, father_ID):
    # Extract
    output_name = (f"{proband_ID}.ped")
    outfile = open(output_name,'a')
    my_individuals = []

    # extract filename without extention or path
    file_name = os.path.basename(f"{vcf_path}")
    file_base = os.path.splitext(file_name)[0]


    #proband_ID
    my_individuals.append(Individual(
                                        'proband',
                                        family=f'{file_base}',
                                        mother=f'{mother_ID}',
                                        father=f'{father_ID}',
                                        sex=f'1',#needs changing
                                        phenotype='2'
                                      ))
    #mother
    my_individuals.append(Individual(
                                        'mother_ID',
                                        family=f'{file_base}',
                                        mother='0',
                                        father='0',
                                        sex='2',
                                        phenotype='1'
                                      ))
    #father
    my_individuals.append(Individual(
                                        'father_ID',
                                        family=f'{file_base}',
                                        mother='0',
                                        father='0',
                                        sex='1',
                                        phenotype='1'
                                      ))
    my_family = Family(family_id=f'{file_base}')
    for individual in my_individuals:
        my_family.add_individual(individual)

    # save PED files
    my_family.to_ped(outfile)


for index, row in input_dat.iterrows():

    # define variables
    proband_id1 = row["proband_id"]
    hpo1 = row["hpo"]
    mother_id1 = row["mother_id"]
    father_id1 = row["father_id"]
    vcf_path1 = row["vcf_path"]
    vcf_index_path1 = row["vcf_index_path"]
    proband_sex1 = row["proband_sex"]

    PED_function(proband_id1, vcf_path1, vcf_index_path1, proband_sex1, mother_id1, father_id1)

    # create HPO file here.
    hpo_str = row["hpo"]
    hpo_list = hpo_str.split(",")

    os.system(f"rm -fr {proband_id1}-HPO.txt" )
    if hpo_list:
        for i in hpo_list:

            os.system(f"echo '{i}' >> {proband_id1}-HPO.txt")
    else:
        print("HPO list is empty")
