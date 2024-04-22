rule download_treatmentResponse:
    params:
        treatmentResponse = config["treatmentResponse"]["url"],
    output:
        treatmentResposne = "rawdata/treatmentResponse/Repurposing_Public_23Q2_LMFI_matrix.csv"
    shell:
        "wget -O {output} {params.treatmentResponse}"

