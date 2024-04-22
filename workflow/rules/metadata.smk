from snakemake.remote.HTTP import RemoteProvider as HTTPRemoteProvider
HTTP = HTTPRemoteProvider()

rule download_sampleMetadata:
    input:
        rawSampleMetadata = HTTP.remote(config['metadata']['sampleMetadata']['url'])
    output:
        sampleMetadata = 'rawdata/metadata/sampleMetadata.csv'
    shell:
        """
        mv {input.rawSampleMetadata} {output.sampleMetadata}
        """

rule download_treatmentMetadata:
    input:
        rawTreatmentMetadata = HTTP.remote(config['metadata']['treatmentMetadata']['url'])
    output:
        treatmentMetadata = 'rawdata/metadata/treatmentMetadata.csv'
    shell:
        """
        mv {input.rawTreatmentMetadata} {output.treatmentMetadata}
        """