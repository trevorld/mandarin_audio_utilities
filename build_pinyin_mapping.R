# This program assumes you have downloaded the following two files:
# 1) ``cedict_1_0_ts_utf-8_mdbg.txt.gz`` ( https://www.mdbg.net/chinese/dictionary?page=cc-cedict )
# 2) ``internet-zh.num`` ( http://corpus.leeds.ac.uk/query-zh.html )

CC_CEDICT_FILE <- gzfile("cache/cedict_1_0_ts_utf-8_mdbg.txt.gz")
FREQ_TABLE_FILE <- "cache/internet-zh.num"

suppressPackageStartupMessages(library("dplyr")) 
suppressPackageStartupMessages(library("stringr"))

pinyin_mapping_text <- readLines(CC_CEDICT_FILE)
pinyin_mapping_text <- pinyin_mapping_text[-c(1:30)]
pinyin_mapping_text <- sub(" ", "\t", pinyin_mapping_text)
pinyin_mapping_text <- sub(" \\[", "\t", pinyin_mapping_text)
pinyin_mapping_text <- sub("\\] ", "\t", pinyin_mapping_text)

pinyin_mapping <- read.delim(text = pinyin_mapping_text, header=FALSE)
names(pinyin_mapping) <- c("traditional", "simplified", "pinyin", "definition")
pinyin_mapping <- pinyin_mapping %>% mutate(pinyin = gsub("u:", "v", tolower(pinyin)),
                                            pinyin = gsub("([[:digit:]]) r5", "r\\1", pinyin),
                                            nsyllables = stringr::str_count(pinyin, " ") + 1,
                                            pinyin = gsub(" ", "", pinyin),
                                            has_alt_pr = grepl("pr\\.", definition))
pinyin_mapping <- pinyin_mapping %>% mutate(has_multiple_readings = (duplicated(simplified) | 
                                               grepl("pr\\.", definition) |
                                               stringr::str_sub(simplified, 2, 2) == "了"))

# one_syllable_pinyin <- sort(unique(filter(pinyin_mapping, nsyllables == 1)$pinyin))
# erhua_one_syllable_pinyin <- grep("r[[:digit:]]", one_syllable_pinyin, value=TRUE)

# Tone Sandhi
bu <- pinyin_mapping %>% filter(nsyllables == 2) %>% 
    filter(stringr::str_sub(simplified, 1, 1) == "不", grepl("4$", pinyin)) %>% 
    mutate(pinyin = gsub("^bu4", "bu2", pinyin))
yi_words <- pinyin_mapping %>% filter(nsyllables == 2) %>% 
        filter(stringr::str_sub(simplified, 1, 1) == "一", !(simplified %in% c("一一", "一二")))
yi_words2 <- yi_words %>% filter(grepl("4$", pinyin)) %>% mutate(pinyin = gsub("^yi1", "yi2", pinyin))
yi_words4 <- yi_words %>% filter(grepl("[123]$", pinyin)) %>% mutate(pinyin = gsub("^yi1", "yi4", pinyin))

updates <- bind_rows(bu, yi_words2, yi_words4) %>% select(simplified, tone_sandhi = pinyin) %>% unique()

pinyin_mapping2 <- pinyin_mapping %>% select(simplified, pinyin) %>% unique()

pinyin_mapping2 <- left_join(pinyin_mapping2, updates, by="simplified") %>%
                    mutate(tone_sandhi = ifelse(is.na(tone_sandhi), pinyin, tone_sandhi)) %>%
                    select(simplified, pinyin, tone_sandhi)
pinyin_mapping2 <- pinyin_mapping2 %>% mutate(
            tone_sandhi = ifelse(grepl("3[[:lower:]]+3[[:lower:]]+3", tone_sandhi), NA, tone_sandhi),
            tone_sandhi = gsub("3([[:lower:]]+)3", "2\\13", tone_sandhi)) %>% arrange(tone_sandhi)

write.csv(pinyin_mapping2, gzfile("cache/simplified_pinyin_mapping.csv.gz"), row.names=FALSE, na="")

pinyin_mapping3 <- pinyin_mapping2 %>% select(ascii = pinyin, tone_sandhi) %>% unique()


unrecognized_pinyin <- c("san1c", "san1p", "a", "aka1", "aquanr1", "apian4", "acai4", "ahuo4", "ezai3", "mjin1", "ndang3", "shir4b", "lai2m", "sha3x", "dong4l", "chang4k", "quan1a", "da4v", "la1k", "ke1p", "a1q", "a1qzheng4zhuan4", "aazhi4", "ba1bi3q", "duo1la1ameng4", "ka3la1ok", "oxing2tui3", "bduan3", "qi2bduan3qun2", "san1kdang3", "yi4wei2asuan1", "qi2bxiao3duan3qun2")

# cjknife <- Vectorize(function(x) { system(paste("cjknife", "-m", x), intern=TRUE)})
cjknife <- function(x) {
    pinyin <- system(paste("cjknife", "-m", shQuote(stringr::str_c(x, collapse=" "))), intern=TRUE)
    stringr::str_split(pinyin, " ")[[1]]
}
if (file.exists("cache/pinyin_cache.csv.gz")) {
    pinyin_mapping3 <- read.csv("cache/pinyin_cache.csv.gz")
} else {
    pinyin_mapping3 <- pinyin_mapping3 %>% mutate(ascii_no_5 = gsub("5", "", ascii))
    pinyin_mapping3 <- filter(pinyin_mapping3, !(ascii %in% unrecognized_pinyin))
    pinyin_mapping3 <- filter(pinyin_mapping3, grepl("[[:digit:]]", ascii)) 

    pinyin_mapping3$group <- rep(1:nrow(pinyin_mapping3), each=100, length.out=nrow(pinyin_mapping3))


    # pinyin_mapping3$pinyin <- cjknife(pinyin_mapping3$ascii) # takes awhile
    pinyin_mapping3 <- pinyin_mapping3 %>% group_by(group) %>% mutate(pinyin = cjknife(ascii)) %>% ungroup() 

    pinyin_mapping3 <- filter(pinyin_mapping3, !grepl("[[:digit:]]", pinyin)) 
    pinyin_mapping3 <- pinyin_mapping3 %>% select(ascii, tone_sandhi, ascii_no_5, pinyin)
    write.csv(pinyin_mapping3, gzfile("cache/pinyin_cache.csv.gz"), row.names=FALSE, na="")
}

manual_mappings <- read.csv("data/manual_pinyin_mappings.csv")
pinyin_mapping3 <- filter(pinyin_mapping3, ! (ascii %in% manual_mappings$ascii))
pinyin_mapping3 <- rbind(pinyin_mapping3, manual_mappings)

pinyin_mapping3 <- pinyin_mapping3 %>% arrange(ascii)

write.csv(pinyin_mapping3, gzfile("cache/pinyin_mapping.csv.gz"), row.names=FALSE, na="")


# Ideal characters to build pinyin from
multiple_readings <- pinyin_mapping %>% filter(has_multiple_readings)
multiple_readings <- unique(multiple_readings$simplified)
# writeLines(multiple_readings, "cache/multiple_readings.txt")

pinyin_mapping_candidates <- pinyin_mapping2 %>% filter(!(simplified %in% multiple_readings))

freq_table <- read.delim(FREQ_TABLE_FILE, sep=' ', skip=4, header=FALSE)
names(freq_table) <- c("freq", "score", "simplified")
freq_table <- freq_table %>% select(simplified, freq)

pinyin_mapping_candidates <- left_join(pinyin_mapping_candidates, freq_table, by="simplified")
suppressWarnings(highest_freq <- pinyin_mapping_candidates %>% group_by(pinyin) %>% summarize(freq = min(freq, na.rm=TRUE)))
highest_freq <- left_join(highest_freq, freq_table, by="freq") %>% filter(!is.na(freq)) %>%
            mutate(freq=as.numeric(freq)) %>% arrange(freq)
write.csv(highest_freq, gzfile("cache/simplified_pinyin_candidates.csv.gz"), row.names=FALSE, na="")
