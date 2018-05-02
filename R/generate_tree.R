#' Generate a phylotree for geneplast functions
#'
#' @param nwk_file Newick file containing the phylogenetic tree of interest
#' @param ssp_df A data.frame with at least two columns: `ssp_name`, and `ssp_id`.
#'
#' @return A phylotree object ready to be used at geneplast functions
#' @export
#'
#' @examples
generate_tree <- function(nwk_file, ssp_df) {
  package <- "phytools"
  if(!require(package, character.only = T)) {
    install.packages(package)
  }
  phylotree <- read.newick(nwk_file)
  phylotree$tip.alias <- ssp_df$ssp_name[match(phylotree$tip.label, ssp_df$ssp_id)]
  return(phylotree)
}
