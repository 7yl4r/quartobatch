# =====================================================================
# === setup
# =====================================================================
# # Proceed if rendering the whole project, exit otherwise
# if (!nzchar(Sys.getenv("QUARTO_PROJECT_RENDER_ALL"))) {
#   quit()
# }
if (!nzchar(system.file(package = "librarian"))) {
  install.packages("librarian")
}
librarian::shelf(
  dplyr,
  glue,
  here,
  whisker
)
# =====================================================================
# === basic setup
# =====================================================================
# creates a report template .qmd for each
REPORT_NAME <- "example_reports"
REPORT_TEMPLATE <- here(glue("{REPORT_NAME}/{REPORT_NAME}_template.qmd"))
REPORTS_DIR <- here(glue("{REPORT_NAME}/{REPORT_NAME}"))
TEMPLATE_REPLACEMENTS <- list(
  # raw string = replacement string
  "example_1" = "{{batch_value}}"
)

# delete old reports
if (dir.exists(REPORTS_DIR)) {
  unlink(REPORTS_DIR, recursive = TRUE)
}

# create the template
# Modify the analyte_reports.R script:

# Add debug output to verify template path
cat("Template path:", REPORT_TEMPLATE, "\n")
cat("Template exists:", file.exists(REPORT_TEMPLATE), "\n")

# Read the template and verify its content before and after gsub
templ <- readLines(REPORT_TEMPLATE)
cat("First few lines before gsub:\n", paste(head(templ), collapse="\n"), "\n")

for (raw_string in names(TEMPLATE_REPLACEMENTS)){
  templ <- gsub(
    raw_string, TEMPLATE_REPLACEMENTS[[raw_string]], templ
  )
}

# cat("First few lines after gsub:\n", paste(head(templ), collapse="\n"), "\n")

# In the create_template function, add debug output
create_template <- function(batch_value) {
  params <- list(
    batch_value = batch_value
  )
  print(glue("=== creating template for '{batch_value}' ==="))
  
  # Debug: print parameters being used
  cat("Template parameters:", names(params), "=", unlist(params), "\n")
  
  # Render template and output to file
  rendered <- whisker.render(templ, params)
  
  # Debug: print first few lines of rendered output
  cat("First few lines of rendered output:\n", paste(head(strsplit(rendered, "\n")[[1]]), collapse="\n"), "\n")
  
  writeLines(
    rendered,
    file.path(REPORTS_DIR, glue("{batch_value}.qmd"))
  )
}

dir.create(REPORTS_DIR, showWarnings=FALSE)

# =====================================================================
# === iterate through the data structure
# =====================================================================
# get list of analytes
source(here("R/getListOfExamples.R"))

for (batch_value in getListOfExamples()) {
  create_template(batch_value)
}