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
1. copy example_batch folder
2. rename folder to your batch_name
3. modify getData & getListOfValues to work with your data
4. modify generate_batch_qmds.R
  1. modify BATCH_NAME to match your batch_name
  2. modify EXAMPLE_BATCH_VALUE to match an example value from your data
5. modify template.qmd params
  1. use same EXAMPLE_BATCH_VALUE from (4) for batch_value
  2. modify batch_name to match your batch_name
6. modify _quarto.yml
  1. add `{batch_name}/generate_batch_qmds` to pre-render
  1. add `{batch_name}/batched_reports/*.qmd` to render
  1. add `{batch_name}/listing.qmd` to render
  1. add `{batch_name}/listing.qmd` to navbar

