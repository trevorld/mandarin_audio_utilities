# This program assumes you have downloaded and untarred the following Shtooka audio collections:
# 1) Shtooka "Base Audio Libre De Mots Chinois (Wei Gao and Vion Nicolas)".  CC-BY 2.0.  http://download.shtooka.net/cmn-balm-hsk1_flac.tar
# 2) Shtooka "Collection Audio Libre De Mots Chinois (Yue Tan)".  CC-BY 3.0.  http://download.shtooka.net/cmn-caen-tan_flac.tar
# 3) Shtooka "Base Audio Libre De Mots Chinois (Congcong)".  CC-BY 3.0.  http://download.shtooka.net/cmn-balm-congcong_flac.tar

suppressPackageStartupMessages(library("dplyr"))
suppressPackageStartupMessages(library("stringr"))

DATA_DIR1 <- file.path("cache", "shtooka_balm_hsk1")
DATA_DIR2 <- file.path("cache", "shtooka_caen_tan")
DATA_DIR3 <- file.path("cache", "shtooka_balm_congcong")
AUDIO_DIR1 <- "audio/shtooka_balm_hsk1"
AUDIO_DIR2 <- "audio/shtooka_caen_tan"
AUDIO_DIR3 <- "audio/shtooka_balm_congcong"

pinyin_mapping <- read.csv("cache/pinyin_mapping.csv.gz")
pinyin_mapping$pinyin <- str_c(pinyin_mapping$pinyin)

## 1
if (TRUE) {
    dir.create(AUDIO_DIR1)
    ending <- ""
    files <- list.files(DATA_DIR1, pattern=".flac")

    info <- readLines(file.path(DATA_DIR1, "index.tags.txt"))
    files2 <- gsub("\\[|\\]", "", grep(".flac]$", info, value=TRUE))
    simplified <- gsub("SWAC_TEXT=(.*)", "\\1", grep("SWAC_TEXT", info, value=TRUE))
    pinyin <- gsub("SWAC_PRON_PHON=(.*)", "\\1", grep("SWAC_PRON_PHON", info, value=TRUE))
    pinyin <- str_c(pinyin)

    info <- data.frame(target = files2, simplified, pinyin)
    mapping <- left_join(info, pinyin_mapping, by="pinyin")

    targets <- file.path(DATA_DIR1, mapping$target)
    links <- paste0(mapping$tone_sandhi, '_', mapping$simplified, ending, ".flac")
    links <- file.path(AUDIO_DIR1, links)
    invisible(file.copy(targets, links))
}

## 2

if (TRUE) {
    dir.create(AUDIO_DIR2)
    ending <- ""
    files <- list.files(DATA_DIR2, pattern=".flac")

    info <- readLines(file.path(DATA_DIR2, "index.tags.txt"))
    files2 <- gsub("\\[|\\]", "", grep(".flac]$", info, value=TRUE))
    simplified <- gsub("SWAC_TEXT=(.*)", "\\1", grep("SWAC_TEXT", info, value=TRUE))
    simplified <- gsub("/", "_", simplified)
    pinyin <- gsub("SWAC_PRON_PHON=(.*)", "\\1", grep("SWAC_PRON_PHON", info, value=TRUE))
    pinyin <- str_c(pinyin)

    info <- data.frame(target = files2, simplified, pinyin=tolower(pinyin))
    mapping <- left_join(info, pinyin_mapping, by="pinyin") 

    mapping <- mutate(mapping, to_delete = (simplified == "不料" & tone_sandhi == "bu4liao4") |
                               (simplified == "一道" & tone_sandhi == "yi1dao4") |
                               (simplified == "一生" & tone_sandhi == "yi1sheng1") |
                               (simplified == "依旧" & tone_sandhi == "yi1jiu4") |
                               (simplified == "不对" & tone_sandhi == "bu4dui4") |
                               (simplified == "一时" & tone_sandhi == "yi1shi2") |
                               (simplified == "一带" & tone_sandhi == "yi1dai4") |
                               (simplified == "医治" & tone_sandhi == "yi2zhi4") |
                               (simplified == "部件" & tone_sandhi == "bu2jian4") |
                               (simplified == "部队" & tone_sandhi == "bu2dui4") |
                               (simplified == "医生" & tone_sandhi == "yi4sheng1") |
                               (simplified == "部位" & tone_sandhi == "bu2wei4") |
                               (simplified == "依据" & tone_sandhi == "yi2ju4") |
                               (simplified == "依次" & tone_sandhi == "yi2ci4") |
                               (simplified == "不见" & tone_sandhi == "bu4jian4") |
                               (simplified == "布置" & tone_sandhi == "bu2zhi4") |
                               (simplified == "一致" & tone_sandhi == "yi1zhi4"))
    mapping <- filter(mapping, !to_delete)  # 8597
    # system("rm audio/*")
    # m <- mapping
    # mapping <- m[1000:2000,]

    targets <- file.path(DATA_DIR2, mapping$target)
    links <- paste0(mapping$tone_sandhi, '_', mapping$simplified, ending, ".flac")
    links <- file.path(AUDIO_DIR2, links)
    invisible(file.copy(targets, links))
}

## 3
if (TRUE) {
    dir.create(AUDIO_DIR3)
    ending <- ""
    files <- list.files(DATA_DIR3, pattern=".flac")
    
    info <- readLines(file.path(DATA_DIR3, "index.tags.txt"))
    files2 <- gsub("\\[|\\]", "", grep(".flac]$", info, value=TRUE))
    simplified <- gsub("SWAC_TEXT=(.*)", "\\1", grep("SWAC_TEXT", info, value=TRUE))
    simplified <- str_c(simplified)
    info <- data.frame(files = files2, simplified)
    
    simplified2pinyin <- read.csv("cache/simplified_pinyin_mapping.csv.gz")
    simplified2pinyin <- simplified2pinyin %>% mutate(simplified = str_c(simplified))
    
    mapping <- left_join(info, simplified2pinyin, by="simplified") %>% 
        mutate(duplicated = simplified %in% simplified[duplicated(simplified)])
    
    mapping <- mapping %>% mutate(to_delete = (simplified == "空" & pinyin != "kong1") |
                                   (simplified == "长" & pinyin != "chang2") |
                                   (simplified == "雨" & pinyin != "yu3") |
                                   (simplified == "鸟" & pinyin != "niao3") |
                                   (simplified == "脚" & pinyin != "jiao3") |
                                   (simplified == "读" & pinyin != "du2") |
                                   (simplified == "强" & pinyin != "qiang2") |
                                   (simplified == "好" & pinyin != "hao3") |
                                   (simplified == "不是" & pinyin != "bu4shi5") |
                                   (simplified == "头" & pinyin != "tou2") |
                                   (simplified == "叉" & pinyin != "cha1") |
                                   (simplified == "脏" & pinyin != "zang1") |
                                   (simplified == "汤" & pinyin != "tang1") |
                                   (simplified == "妻子" & pinyin != "qi1zi5") |
                                   (simplified == "累" & pinyin != "lei4") |
                                   (simplified == "便宜" & pinyin != "pian2yi5") |
                                   (simplified == "说" & pinyin != "shuo1") |
                                   (simplified == "远" & pinyin != "yuan3") |
                                   (simplified == "还" & pinyin != "hai2") |
                                   (simplified == "大" & pinyin != "da4") |
                                   (simplified == "女人" & pinyin != "nv3ren2") |
                                   (simplified == "给" & pinyin != "gei3") |
                                   (simplified == "喝" & pinyin != "he1") |
                                   (simplified == "难" & pinyin != "nan2") |
                                   (simplified == "听" & pinyin != "ting1"))
    
    mapping <- mapping %>% filter(!to_delete)
    
    mapping <- mapping %>% mutate(tone_sandhi = ifelse(simplified == "唯一的", "wei2yi1de5", tone_sandhi),
                                tone_sandhi = ifelse(simplified == "很多", "hen3duo1", tone_sandhi),
                                tone_sandhi = ifelse(simplified == "少男", "shao4nan2", tone_sandhi),
                                tone_sandhi = ifelse(simplified == "我想要...", "wo2xiang3yao4", tone_sandhi),
                                tone_sandhi = ifelse(simplified == "一个月", "yi2ge4yue4", tone_sandhi),
                                tone_sandhi = ifelse(simplified == "回头见！", "hui2tou2jian4", tone_sandhi),
                                tone_sandhi = ifelse(simplified == "为什么？", "wei4shen2me5", tone_sandhi),
                                tone_sandhi = ifelse(simplified == "等等我！", "deng2deng2wo3", tone_sandhi),
                                tone_sandhi = ifelse(simplified == "我说法语", "wo3shuo1fa2yu3", tone_sandhi),
                                tone_sandhi = ifelse(simplified == "多少？", "duo1shao3", tone_sandhi),
                                tone_sandhi = ifelse(simplified == "晚上好", "wan3shang4hao3", tone_sandhi),
                                tone_sandhi = ifelse(simplified == "祝你身体健康！", "zhu4ni3shen1ti3jian1kang1", tone_sandhi),
                                tone_sandhi = ifelse(simplified == "更多", "geng4duo1", tone_sandhi),
                                tone_sandhi = ifelse(simplified == "这是什么？", "zhe4shi4shen2me5", tone_sandhi),
                                tone_sandhi = ifelse(simplified == "一天", "yi4tian1", tone_sandhi),
                                tone_sandhi = ifelse(simplified == "给...看", "gei3kan4", tone_sandhi),
                                tone_sandhi = ifelse(simplified == "我住大学宿舍", "wo3zhu4da4xue2su4she4", tone_sandhi),
                                tone_sandhi = ifelse(simplified == "你叫什么名字？", "ni3jiao4shen2me5ming2zi5", tone_sandhi),
                                tone_sandhi = ifelse(simplified == "我在巴黎读书", "wo3zai4ba1li2du2shu1", tone_sandhi),
                                tone_sandhi = ifelse(simplified == "应该...", "ying1gai1", tone_sandhi),
                                tone_sandhi = ifelse(simplified == "一小时", "yi4xiao3shi2", tone_sandhi),
                                tone_sandhi = ifelse(simplified == "小心！", "xiao3xin1", tone_sandhi),
                                tone_sandhi = ifelse(simplified == "...在哪里？", "zai4na2li3", tone_sandhi),
                                tone_sandhi = ifelse(simplified == "我叫...", "wo3jiao4", tone_sandhi),
                                tone_sandhi = ifelse(simplified == "我很好", "wo2hen2hao3", tone_sandhi),
                                tone_sandhi = ifelse(simplified == "没人", "mei2ren2", tone_sandhi),
                                tone_sandhi = ifelse(simplified == "我不知道", "wo3bu4zhi1dao4", tone_sandhi),
                                tone_sandhi = ifelse(simplified == "打火机", "da2huo3ji1", tone_sandhi),
                                tone_sandhi = ifelse(simplified == "慢慢地", "man4man4de5", tone_sandhi),
                                tone_sandhi = ifelse(simplified == "谁？", "shei2", tone_sandhi),
                                tone_sandhi = ifelse(simplified == "我20岁", "wo3er4shi2sui4", tone_sandhi),
                                tone_sandhi = ifelse(simplified == "一分钟", "yi4fen1zhong1", tone_sandhi),
                                tone_sandhi = ifelse(simplified == "真的", "zhen1de5", tone_sandhi),
                                tone_sandhi = ifelse(simplified == "更少", "geng4shao3", tone_sandhi),
                                tone_sandhi = ifelse(simplified == "欢迎！", "huang1ying2", tone_sandhi),
                                tone_sandhi = ifelse(simplified == "梯形教室", "ti1xing2jiao4shi4", tone_sandhi),
                                tone_sandhi = ifelse(simplified == "怎样？", "zen3yang4", tone_sandhi),
                                tone_sandhi = ifelse(simplified == "什么时候？", "shen2me5shi2hou5", tone_sandhi),
                                tone_sandhi = ifelse(simplified == "一秒", "yi4miao3", tone_sandhi),
                                tone_sandhi = ifelse(simplified == "你几岁了？", "ni2ji3sui4le5", tone_sandhi),
                                tone_sandhi = ifelse(simplified == "准备好了", "zhun3bei4hao3le5", tone_sandhi),
                                tone_sandhi = ifelse(simplified == "一年", "yi4nian2", tone_sandhi),
                                tone_sandhi = ifelse(simplified == "什么？", "shen2me5", tone_sandhi),
                                tone_sandhi = ifelse(simplified == "手袋", "shou3dai4", tone_sandhi),
                                tone_sandhi = ifelse(simplified == "幸会！", "xing4hui4", tone_sandhi),
                                tone_sandhi = ifelse(simplified == "很少", "hen2shao3", tone_sandhi),
                                tone_sandhi = ifelse(simplified == "哪里？", "na2li3", tone_sandhi),
                                tone_sandhi = ifelse(simplified == "马铃薯", "ma3ling2shu3", tone_sandhi),
                                tone_sandhi = ifelse(simplified == "哪个？", "na3ge5", tone_sandhi),
                                tone_sandhi = ifelse(simplified == "我来自法国", "wo3lai2zi4fa3guo2", tone_sandhi),
                                tone_sandhi = ifelse(simplified == "我不能", "wo3bu4neng2", tone_sandhi),
                                tone_sandhi = ifelse(simplified == "报刊杂志", "bao4kan1za2zhi4", tone_sandhi),
                                tone_sandhi = ifelse(simplified == "一星期", "yi4xing1qi1", tone_sandhi),
                                tone_sandhi = ifelse(simplified == "对不起！", "dui4bu5qi3", tone_sandhi),
                                tone_sandhi = ifelse(simplified == "你好吗？", "ni2hao3ma5", tone_sandhi),
                                tone_sandhi = ifelse(simplified == "单独的", "dan1du2de5", tone_sandhi),
                                tone_sandhi = ifelse(simplified == "这多少钱？", "zhe4duo1shao3qian2", tone_sandhi),
                                tone_sandhi = ifelse(simplified == "你好！", "ni2hao3", tone_sandhi),
                                tone_sandhi = ifelse(simplified == "你说法语吗？", "ni3shuo1fa2yu3ma5", tone_sandhi),
                                tone_sandhi = ifelse(simplified == "外币兑换处", "wai4bi4dui4huan4chu4", tone_sandhi),
                                tone_sandhi = ifelse(simplified == "外国的", "wai4guo2de5", tone_sandhi),
                                tone_sandhi = ifelse(simplified == "再见！", "zai4jian4", tone_sandhi),
                                tone_sandhi = ifelse(simplified == "红酒", "hong2jiu3", tone_sandhi))
    
    targets <- file.path(DATA_DIR3, mapping$files)
    links <- paste0(mapping$tone_sandhi, '_', mapping$simplified, ending, ".flac")
    links <- file.path(AUDIO_DIR3, links)
    
    invisible(file.copy(targets, links))
}
