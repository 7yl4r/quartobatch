# quartobatch
Batch generate quarto reports from a common template across a dataset.

# To Create a New Batch:
1. Use create_batch R function:
    ```R
    source("create_batch.R")
    create_batch("testBatchName", "testExampleValue")
    ```
2. in the new {batch_name} folder, modify getData & getListOfValues to work with your data.
3. modify the {batch_name}/template.yml
4. `quarto publish`

# Notes
This project is a generalized implementation inspired by the following projects:

* [FCRWQDC_data_ingest](https://github.com/USF-IMARS/FCRWQDC_data_ingest) : Applies a common template across water quality analytes & data providers from multiple data file sources
* [seus-mbon-cruise-ctd-processing](https://github.com/USF-IMARS/seus-mbon-cruise-ctd-processing) : Applies a common template across CTD casts and research cruises.
