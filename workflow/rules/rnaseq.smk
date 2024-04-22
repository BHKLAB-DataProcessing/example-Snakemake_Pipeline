from snakemake.remote.HTTP import RemoteProvider as HTTPRemoteProvider
HTTP = HTTPRemoteProvider()

rule download_RNASEQ:
    input:
        genes_tpm = HTTP.remote(config["molecularProfiles"]["rnaseq"]["url"])
    output:
        genes_tpm = "rawdata/rnaseq/CCLE_RNAseq_rsem_genes_tpm_20180929.txt.gz"
    shell:
        """
        gzip -dc {input.genes_tpm} > {output.genes_tpm}
        """

rule build_RNASEQ_SE:
    input:
        genes_tpm = "rawdata/rnaseq/CCLE_RNAseq_rsem_genes_tpm_20180929.txt.gz",
        sampleMetadata = 'procdata/metadata/sampleMetadata.csv',
        genomeAnnotation = 'procdata/metadata/genomeAnnotation.RDS'
    output:
        rnaseq_SE = "procdata/rnaseq/RNASEQ_SE.RDS",
    script:
        "../scripts/build_RNASEQ_SE.R"