Mandarin Audio Utilities
------------------------

This is a set of helper scripts designed to convert various Mandarin audio sources to the format ``source_folder/pin1yin1_extra_info.mp3``.   If the original file isn't an ``.mp3`` it will preserve the audio format (i.e. ``.flac``).  Standard pinyin is modified in these filenames in the following ways:

   #) Instead of diacritics we use numbers at the end of each syllable to denote the tone including using a 5 at the end to mark the neutral tone e.g. shen2me5de5 and not shen2mede.
   #) For erhua syllables we put the erhua 'r' before the tone number e.g. zher4 not zhe4r5. 
   #) We try our best to apply any relevant tone sandhi e.g. ni2hao3 and not ni3hao3.
   #) We replace any pinyin ü with a v and any pinyin ê with an eh

If you are looking for a "Collective Work" of freely available Mandarin audio already in this format for personal and non-commercial use you may use the following commands to download an assembled "Collective Work" of Creative Commons licensed Mandarin audio already in the desired format.  It contains Mandarin audio from chinese-lessons.com, forvo.com, sinosplice.com, and shtooka.net.  See ``cc_README.rst`` for more info.::

    bash$ wget https://u14129277.dl.dropboxusercontent.com/u/14129277/cc_mandarin_audio_pack.zip 
    bash$ unzip cc_mandarin_audio_pack.zip

As an alternative there is also a subset of the above of just the "Free Cultural Works" that can be used for commercial use.  It contains Mandarin audio from shtooka.net.  See ``fc_README.rst`` for more info.::

    bash$ wget https://u14129277.dl.dropboxusercontent.com/u/14129277/fc_mandarin_audio_pack.zip 
    bash$ unzip fc_mandarin_audio_pack.zip

Audio sources
-------------

Creative Commons Audio
~~~~~~~~~~~~~~~~~~~~~~

Some sources of Creative Commons licensed Mandarin audio files:

#) chinese-lessons.com "Mandarin voice soundset".  CC BY-NC-ND 3.0 US.  http://www.chinese-lessons.com/download.htm
#) Shtooka "Base Audio Libre De Mots Chinois (Congcong)".  CC-BY 3.0 US.  http://download.shtooka.net/cmn-balm-congcong_flac.tar
#) Shtooka "Base Audio Libre De Mots Chinois (Wei Gao and Vion Nicolas)".  CC-BY 2.0 FR.  http://download.shtooka.net/cmn-balm-hsk1_flac.tar
#) Shtooka "Collection Audio Libre De Mots Chinois (Yue Tan)".  CC-BY 3.0 US.  http://download.shtooka.net/cmn-caen-tan_flac.tar
#) Sinosplice (John Pasden) "Tone Pair drills".  CC BY-NC-SA 2.5.  http://www.sinosplice.com/learn-chinese/tone-pair-drills
#) Forvo.  CC BY-NC-SA 3.0.  https://forvo.com/

Non-Creative Commons Audio
~~~~~~~~~~~~~~~~~~~~~~~~~~

#) 625 Words Mandarin Word package by Gabriel Wyner:  https://fluent-forever.com/product/most-awesome-word-lists-ever-seen/
#) Mandarin Pronunciation Trainer package by Gabriel Wyner:  https://fluent-forever.com/product/fluent-forever-pronunciation-trainer/ 

Helper scripts
~~~~~~~~~~~~~~

In this directory are helper scripts to format some of the above audio sources into the above-mentioned format.  Some of them require you download the following additional data files to a ``cache`` directory and run ``build_pinyin_mapping.R`` first.

1) ``cedict_1_0_ts_utf-8_mdbg.txt.gz`` ( https://www.mdbg.net/chinese/dictionary?page=cc-cedict )
2) ``internet-zh.num`` ( http://corpus.leeds.ac.uk/query-zh.html )

License
-------

Most rights reside with authors of the separate and independent Works which constitute this Collective Work.  Any residual rights from the assembling of this Collective Work are released under a `CC0 license <https://creativecommons.org/publicdomain/zero/1.0/legalcode>`_.
