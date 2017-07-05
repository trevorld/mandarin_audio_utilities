# This program assumes you've downloaded and unpacked the "Mandarin Sounds MP3" zipfile by Chinese Lessons available under a CC BY-NC-ND 3.0 US license from http://www.chinese-lessons.com/download.htm (http://www.chinese-lessons.com/sounds/Mandarin_sounds.zip).
   
DATA_DIR <- "cache/chinese_lessons"
AUDIO_DIR <- "audio/chinese_lessons"
dir.create(AUDIO_DIR)

files <- list.files(DATA_DIR, pattern=".mp3$")
targets <- file.path(DATA_DIR, files) 

links <- files
lack_tone <- grep("[1-4].mp3", links, invert=TRUE)
links[lack_tone] <- sub(".mp3", "5.mp3", links[lack_tone])
links <- sub("uu", "v", links)
links <- file.path(AUDIO_DIR, links)

invisible(file.copy(targets, links))
