#!/usr/bin/env bash
# Usage: bash audio_utilities/run_all.sh
# Assumes you have downloaded a bunch of files (see individual files for more info)

[ ! -d cache ] && mkdir cache
rm -r audio
[ ! -d audio ] && mkdir audio

# Rscript build_pinyin_mapping.R
Rscript make_shtooka_audio.R
cp fc_README.rst audio/README.rst
zip -rq fc_mandarin_audio_pack.zip audio
mv fc_mandarin_audio_pack.zip ~/a/sync/Dropbox/Public/
Rscript make_chinese_lessons_audio.R
Rscript make_sinosplice_audio.R
Rscript make_forvo_audio.R
cp cc_README.rst audio/README.rst
zip -rq cc_mandarin_audio_pack.zip audio
mv cc_mandarin_audio_pack.zip ~/a/sync/Dropbox/Public/
rm audio/README.rst
 
Rscript make_fluent_forever_word_audio.R
Rscript make_fluent_forever_trainer_audio.R
