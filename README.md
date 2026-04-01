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