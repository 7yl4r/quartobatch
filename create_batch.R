# 1. copy example_batch folder
# 2. rename folder to your batch_name
# 3. modify generate_batch_qmds.R
#   1. modify BATCH_NAME to match your batch_name
#   2. modify EXAMPLE_BATCH_VALUE to match an example value from your data
# 4. modify template.qmd params
#   1. use same EXAMPLE_BATCH_VALUE from (3) for batch_value
#   2. modify batch_name to match your batch_name
# 5. modify _quarto.yml
#   1. add `{batch_name}/generate_batch_qmds` to pre-render
#   2. add `{batch_name}/batched_reports/*.qmd` to render
#   3. add `{batch_name}/listing.qmd` to render
#   4. add `{batch_name}/listing.qmd` to navbar


create_batch <- function(batch_name, example_batch_value) {
  # 1. copy example_batch folder
  if (!dir.exists("example_batch")) {
    stop("example_batch folder does not exist")
  }
  
  if (dir.exists(batch_name)) {
    stop(paste("Directory", batch_name, "already exists"))
  }
  
  # Copy the example_batch folder
  system(paste("cp -r example_batch", batch_name))
  
  # 2. modify generate_batch_qmds.R
  generate_file <- file.path(batch_name, "generate_batch_qmds.R")
  if (file.exists(generate_file)) {
    content <- readLines(generate_file)
    
    # Replace BATCH_NAME
    content <- gsub('BATCH_NAME <- "example_batch"', 
                    paste('BATCH_NAME <- "', batch_name, '"'), 
                    content)
    
    # Replace EXAMPLE_BATCH_VALUE
    content <- gsub('EXAMPLE_BATCH_VALUE <- "example_1"', 
                    paste('EXAMPLE_BATCH_VALUE <- "', example_batch_value, '"'), 
                    content)
    
    writeLines(content, generate_file)
  }
  
  # 5. modify template.qmd params
  template_file <- file.path(batch_name, "template.qmd")
  if (file.exists(template_file)) {
    content <- readLines(template_file)
    
    # Replace batch_value in params
    content <- gsub('batch_value: "example_1"', 
                    paste('batch_value: "', example_batch_value, '"'), 
                    content)
    
    # Replace batch_name in params
    content <- gsub('batch_name: "example_batch"', 
                    paste('batch_name: "', batch_name, '"'), 
                    content)
    
    # Replace title
    content <- gsub('title: "example_1 Report"', 
                    paste('title: "', example_batch_value, ' Report"'), 
                    content)
    
    writeLines(content, template_file)
  }
  
  # 6. modify _quarto.yml
  quarto_file <- "_quarto.yml"
  if (file.exists(quarto_file)) {
    content <- readLines(quarto_file)
    
    # Find the pre-render section and add generate_batch_qmds.R
    pre_render_line <- grep("pre-render:", content)
    if (length(pre_render_line) > 0) {
      # Add the new pre-render entry after the existing ones
      insert_line <- pre_render_line + 1
      while (insert_line <= length(content) && grepl("^  ", content[insert_line])) {
        insert_line <- insert_line + 1
      }
      
      pre_render_entry <- paste0("  - ", batch_name, "/generate_batch_qmds.R")
      content <- append(content, pre_render_entry, after = insert_line - 1)
    }
    
    # Find the render section and add batched_reports and listing
    render_line <- grep("render:", content)
    if (length(render_line) > 0) {
      # Add the new render entries after the existing ones
      insert_line <- render_line + 1
      while (insert_line <= length(content) && grepl("^  ", content[insert_line])) {
        insert_line <- insert_line + 1
      }
      
      render_entries <- c(
        paste0("  - ", batch_name, "/batched_reports/*.qmd"),
        paste0("  - ", batch_name, "/listing.qmd")
      )
      
      content <- append(content, render_entries, after = insert_line - 1)
    }
    
    writeLines(content, quarto_file)
  }
  
  print(paste("Successfully created batch:", batch_name))
  print(paste("Example batch value:", example_batch_value))
  print("Don't forget to:")
  print("1. Modify getData.R and getListOfValues.R for your specific data")
  print("2. Add the listing.qmd to the navbar in _quarto.yml if needed")
}
