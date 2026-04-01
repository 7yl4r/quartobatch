# quartobatch
Batch generate quarto reports from a common template across a dataset.


## parts of each batch variable
1. `/{batch_name}_reports/` directory
2. `/{batch_name}_reports/{batch_name}_reports.qmd`
3. `/{batch_name}_reports/{batch_name}_reports_template.qmd`
4. `/R/pre_render/generate_{batch_name}_reports.R`
5. `/R/get{batch_name}Data.R` 
6. `/R/getListOf{batch_name}s.R`
7. `.gitignore` entry for `{batch_name}/{batch_name}` folder


### Usage
1. copy 1, 2, 3, 4 using example_reports as a template
2. create 5, 6
3. add line to .gitignore for 7