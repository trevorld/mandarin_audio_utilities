# This program assumes you have downloaded the Sinosplice Tone Pair drills (John Pasden).  CC BY-NC-SA 2.5.  http://www.sinosplice.com/learn-chinese/tone-pair-drills

DATA_DIR <- "cache/sinosplice_tone_audio"
AUDIO_DIR <- "audio/sinosplice"
dir.create(AUDIO_DIR)

targets <- list.files(DATA_DIR, recursive=TRUE, pattern=".mp3$", full=TRUE)

files <- list.files(DATA_DIR, recursive=TRUE, pattern=".mp3$")
links <- gsub(".*/(.*)", "\\1", files)
links <- gsub("0", "5", links)
links <- file.path(AUDIO_DIR, links)

invisible(file.copy(targets, links))
