from snakemake.remote.HTTP import RemoteProvider as HTTPRemoteProvider
HTTP = HTTPRemoteProvider()


configfile: "config/pipeline.yaml"

include: "workflow/rules/metadata.smk"

rule all:
    input:
        "results/examplePSet.RDS"

