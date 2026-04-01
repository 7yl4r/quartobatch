# quartobatch
Batch generate quarto reports from a common template across a dataset.


# structure of each batch
1. `/{batch_name}/` directory
2. `/{batch_name}/listing.qmd`
3. `/{batch_name}/template.qmd`
4. `/{batch_name}/generate_batch_qmds.R`
5. `/{batch_name}/getData.R` 
6. `/{batch_name}/getListOfValues.R`

# To Create a New Batch:
```R
source("create_batch.R")
create_batch("testBatchName", "testExampleValue")
```
Then, in the new {batch_name} folder, modify getData & getListOfValues to work with your data
