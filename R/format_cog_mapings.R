#' Format the COG mappings file for geneplast functions
#'
#' @param path File path to COG mappings (.txt downloaded file)
#'
#' @return A data.frame with three columns: `ssp_id` (species ID from NCBI), `protein_id`
#' (the ENSEMBL peptide ID) and `cog_id` (COG ID from STRINGdb).
#' @export
#'
#' @examples
format_cog_mapings <- function(path) {
    if (!require("pacman")) {
        install.packages("pacman")
    }
    pacman::p_load(data.table, tidyr)
    cols <- c("protein_symbol", "start", "end", "cog", "protein_annotation")
    cog_mapings <- fread(input = path, col.names = cols)
    cog_mapings <-cog_mapings[, -c(2, 3)]
    cog_mapings <- separate(cog_mapings, col = protein_symbol,
                            into = c("ssp_id", "protein"),
                            sep = "\\.")
    cog_mapings$protein <- paste0(cog_mapings$ssp_id, '.', cog_mapings$protein)
    cog_mapings <- cog_mapings[,-c(4)]
    colnames(cog_mapings) <- c('ssp_id', 'protein_id','cog_id')
    cog_mapings <- cog_mapings[,c(2,1,3)]
    cog_mapings
}
