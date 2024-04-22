from snakemake.remote.HTTP import RemoteProvider as HTTPRemoteProvider
HTTP = HTTPRemoteProvider()


configfile: "config/pipeline.yaml"

include: "workflow/rules/metadata.smk"
include: "workflow/rules/rnaseq.smk"
include: "workflow/rules/treatmentResponse.smk"

rule build_PSet:
    input:
        mae = "procdata/multiAssayExperiment.RDS",
        tre = "procdata/treatmentResponseExperiment.RDS",
        treatmentMetadata_annotated = 'procdata/metadata/treatmentMetadata_annotated.csv',
        sampleMetadata_annotated = 'procdata/metadata/sampleMetadata_annotated.csv'

rule build_MultiAssayExperiment:
    input:
        rnaseq_SE = "procdata/rnaseq/RNASEQ_SE.RDS",
        sampleMetadata = 'procdata/metadata/sampleMetadata.csv',
    output:
        mae = "procdata/multiAssayExperiment.RDS"
    script:
        "workflow/scripts/build_MultiAssayExperiment.R"

rule build_treatmentResponseExperiment:
    input:
        treatmentResponse = "rawdata/treatmentResponse/Repurposing_Public_23Q2_LMFI_matrix.csv",
        sampleMetadata = 'procdata/metadata/sampleMetadata.csv',
        treatmentMetadata = 'procdata/metadata/treatmentMetadata.csv',
    output:
        treatmentResponseExperiment = "procdata/treatmentResponseExperiment.RDS"
    script:
        "../scripts/build_treatmentResponseExperiment.R"