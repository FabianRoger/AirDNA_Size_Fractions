#function parser for cutadapt output

Cutadapt_parser <- 
  function(temp){
    
    i_1 <- which(grepl("Total read pairs processed", temp))
    i_2 <- which(grepl("Read 1 with adapter", temp))
    i_3 <- which(grepl("Read 2 with adapter", temp))
    i_4 <- which(grepl("Pairs that were too short", temp))
    i_5 <- which(grepl("Pairs written", temp))
    
    
      
    
      Total_reads = ifelse(!isEmpty(i_1), 
                           {str_split(temp[i_1], pattern = "\\s+")[[1]][5] %>% 
                               gsub(",", "", .) %>% 
                               as.numeric()},
                           NA)
      
      
      R1_with_adapter =   ifelse(!isEmpty(i_2), 
                                 {str_split(temp[i_2], pattern = "\\s+")[[1]][6] %>% 
                                     gsub(",", "", .) %>% 
                                     as.numeric()},
                                 NA)
      
      R1_with_adapter_prct = ifelse(!isEmpty(i_2), 
                                    {str_split(temp[i_2], pattern = "\\s+")[[1]][7] %>% 
                                        gsub("\\(|\\)|%", "", .) %>% 
                                        as.numeric()},
                                    NA)
      
      
      R2_with_adapter = ifelse(!isEmpty(i_3), 
                               {str_split(temp[i_3], pattern = "\\s+")[[1]][6] %>% 
                                   gsub(",", "", .) %>% 
                                   as.numeric()},
                               NA)
      
      R2_with_adapter_prct = ifelse(!isEmpty(i_3), 
                                    {str_split(temp[i_3], pattern = "\\s+")[[1]][7] %>% 
                                        gsub("\\(|\\)|%", "", .) %>% 
                                        as.numeric()},
                                    NA)
      
      
      Pairs_too_short = ifelse(!isEmpty(i_4), 
                               {str_split(temp[i_4], pattern = "\\s+")[[1]][6] %>% 
                                   gsub(",", "", .) %>% 
                                   as.numeric()},
                               NA)
      
      Pairs_too_short_prct = ifelse(!isEmpty(i_4),
                                    {str_split(temp[i_4], pattern = "\\s+")[[1]][7] %>% 
                                        gsub("\\(|\\)|%", "", .) %>% 
                                        as.numeric()},
                                    NA)
      
      
      Pairs_written = ifelse(!isEmpty(i_5),
                             {str_split(temp[i_5], pattern = "\\s+")[[1]][5] %>% 
                                 gsub(",", "", .) %>% 
                                 as.numeric()},
                             NA)
      
      Pairs_written_prct = ifelse(!isEmpty(i_5),
                                  {str_split(temp[i_5], pattern = "\\s+")[[1]][6] %>% 
                                      gsub("\\(|\\)|%", "", .) %>% 
                                      as.numeric()},
                                  NA)
      
      res <- list(Total_reads = Total_reads,
                  R1_with_adapter = R1_with_adapter,
                  R1_with_adapter_prct = R1_with_adapter_prct,
                  R2_with_adapter = R2_with_adapter,
                  R2_with_adapter_prct = R2_with_adapter_prct,
                  Pairs_too_short = Pairs_too_short,
                  Pairs_too_short_prct = Pairs_too_short_prct,
                  Pairs_written = Pairs_written,
                  Pairs_written_prct = Pairs_written_prct)
      
      
      res <- res[!is.na(res)]
      
      res <- as_tibble(res)
      
      return(res)
    
  }


# function to get all orientations of a primer
# from https://benjjneb.github.io/dada2/ITS_workflow.html

allOrients <- function(primer) {
  # Create all orientations of the input sequence
  require(Biostrings)
  dna <- Biostrings::DNAString(primer)  # The Biostrings works w/ DNAString objects rather than character vectors
  orients <- c(Forward = dna, Complement = Biostrings::complement(dna), Reverse = Biostrings::reverse(dna), 
               RevComp = Biostrings::reverseComplement(dna))
  return(sapply(orients, toString))  # Convert back to character vector
}

primerHits <- function(primer, fn) {
  # Counts number of reads in which the primer is found
  nhits <- vcountPattern(primer, sread(readFastq(fn)), fixed = FALSE)
  return(sum(nhits > 0))
}


dir.create_ifnot <- function(x) {if(!dir.exists(x)) {dir.create(x)}}


# function to prepare a taxonomic dataframe for the name_backbone function from rgbif
# it takes a taxon table and appends a name column which contains the species, the genus sp. if species is missing or 
# the lowest non-NA value for that sequence. 

# It assumes that the first column of the dataframe contain the sequence and all subsequent column contain taxonomic ranks. 

prepare_tax_for_rgbif <- 
function(df){
    
  df_new <- 
    df %>% 
    rowwise() %>% 
    mutate(name = case_when(!is.na(species) ~ species,
                           is.na(species) & !is.na(genus) ~ paste(genus, "sp."),
                           TRUE ~ { 
                                   idx <- which(!is.na(c_across(cols = -1))) 
                                   if (!identical(idx, integer(0))) c_across(cols = -1)[max(idx)] else NA 
                                 } 
                           ))
   
  return(df_new)
  
}
  
  
  


