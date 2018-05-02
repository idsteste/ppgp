#' Extract orthologous groups from a taxon id
#'
#' @param path Path to COG maps file from STRINGdb.
#' @param tax_id A numeric vector of length 1 with the taxon id of interest.
#'
#' @return A data.frame with two columns: the ensembl peptide id and the orthologous groups
#' @export
#'
#' @examples mouse_cogs <- tx_cogs("~/Downloads/COG.mappings.v10.5.txt", 10090)
#'
tx_cogs <- function(path, tax_id) {
    library(readr)
    if (!is.character(path)) {
        stop("path should be a character indicating the directory of cog mappings file.",
             call. = F)
    }
    if (!is.numeric(tax_id)) {
        stop("tax_id should be a numeric entry.", call. = F)
    }
    cols <- c("ensembl_peptide_id", "start", "end", "cog_id", "protein_annotation")
    cog_mapings <- read_delim(file = path, delim = "\t",
                              col_names = cols, col_types = "cddcc", progress = T,
                              comment = "#")
    pattern <- paste("^", tax_id, "\\.", sep = "")
    idx <- grep(pattern, cog_mapings$ensembl_peptide_id)
    cog_mapings1 <- cog_mapings[idx, ]
    cog_mapings1$ensembl_peptide_id <- gsub(pattern, "", cog_mapings1$ensembl_peptide_id)
    cog_mapings2 <- cog_mapings1[, -c(2, 3, 5)]
    return(cog_mapings2)
}









