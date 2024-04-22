
from snakemake.remote.GS import RemoteProvider as GSRemoteProvider
GS = GSRemoteProvider()

rule download_sampleMetadata:
    params:
        url = config['metadata']['sampleMetadata']['url']
    output:
        sampleMetadata = 'rawdata/metadata/sampleMetadata.csv'
    shell:
        """
        wget {params.url} -O {output.sampleMetadata}
        """

rule download_treatmentMetadata:
    params:
        url = config['metadata']['treatmentMetadata']['url']
    output:
        treatmentMetadata = 'rawdata/metadata/treatmentMetadata.csv'
    shell:
        """
        wget {params.url} -O {output.treatmentMetadata}
        """

rule download_genomeAnnotation:
    input:
        gtf = GS.remote(config['metadata']['genomeMetadata']['url']),
    output:
        genomeAnnotation = 'rawdata/metadata/genomeAnnotation.gtf'
    shell:
        """
        mv {input.gtf} {output.genomeAnnotation}
        """

###############################################################################
# sample metadata

rule preprocess_sampleMetadata:
    input:
        sampleMetadata = 'rawdata/metadata/sampleMetadata.csv'
    output:
        sampleMetadata = 'procdata/metadata/sampleMetadata.csv'
    script:
        "../scripts/preprocess_sampleMetadata.R"

rule annotate_sampleMetadata:
    input:
        sampleMetadata = 'procdata/metadata/sampleMetadata.csv',
    output:
        sampleMetadata_annotated = 'procdata/metadata/sampleMetadata_annotated.csv'
    script:
        "../scripts/annotate_sampleMetadata.R"

###############################################################################
# treatment metadata

rule preprocess_treatmentMetadata:
    input:
        treatmentMetadata = 'rawdata/metadata/treatmentMetadata.csv'
    output:
        treatmentMetadata = 'procdata/metadata/treatmentMetadata.csv'
    script:
        "../scripts/preprocess_treatmentMetadata.R"

rule annotate_treatmentMetadata:
    input:
        treatmentMetadata = 'procdata/metadata/treatmentMetadata.csv',
    output:
        treatmentMetadata_annotated = 'procdata/metadata/treatmentMetadata_annotated.csv'
    script:
        "../scripts/annotate_treatmentMetadata.R"

###############################################################################
# genome annotation

rule preprocess_genomeAnnotation:
    input:
        genomeAnnotation = 'rawdata/metadata/genomeAnnotation.gtf'
    output:
        genomeAnnotation = 'procdata/metadata/genomeAnnotation.RDS'
    script:
        "../scripts/preprocess_genomeAnnotation.R"