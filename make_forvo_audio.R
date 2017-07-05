# This program assumes you've downloaded a rather particular collection of audio from Forvo (CC BY-NC-SA 3.0):  https://forvo.com

DATA_DIR <- "cache/forvo"
AUDIO_DIR <- "audio/forvo"
dir.create(AUDIO_DIR)

main <- function() {
    mapping <- read.csv(text = get_mapping())
    files <- mapping$filename

    targets <- file.path(DATA_DIR, files)

    pinyin <- mapping$pinyin
    links <- gsub("pronunciation", "", files)
    links <- gsub("zh_", "", links)
    links <- gsub("yue_", "", links)
    links <- gsub("\\([[:digit:]]\\)", "", links)
    links <- gsub(".mp3", "", links)
    links <- paste0(pinyin, links, "_", mapping$speaker, ".mp3")
    links <- file.path(AUDIO_DIR, links)

    invisible(file.copy(targets, links))
}

get_mapping <- function() { 
"filename,pinyin,speaker
pronunciation_zh_号码儿.mp3,hao4mar3,Rhapsodia
pronunciation_zh_把儿.mp3,bar3,Rhapsodia
pronunciation_zh_刀把儿.mp3,dao1bar3,Rhapsodia
pronunciation_zh_戏法儿.mp3,xi4far3,Rhapsodia
pronunciation_zh_找茬儿.mp3,zhao3char2,Rhapsodia
pronunciation_zh_打杂儿.mp3,da3zar2,Rhapsodia
pronunciation_zh_名牌儿.mp3,mingpair2,Rhapsodia
pronunciation_zh_壶盖儿.mp3,hu2gair4,Rhapsodia
pronunciation_zh_加塞儿.mp3,jia1sair1,Rhapsodia
pronunciation_zh_鞋带儿.mp3,xie2dair4,Rhapsodia
pronunciation_zh_纳闷儿.mp3,na4menr4,Rhapsodia
pronunciation_zh_快板儿.mp3,kuai4banr3,Rhapsodia
pronunciation_zh_蒜瓣儿.mp3,suan4banr4,Rhapsodia
pronunciation_zh_脸蛋儿.mp3,lian3danr4,Rhapsodia
pronunciation_zh_栅栏儿.mp3,shan1lanr2,Rhapsodia
pronunciation_zh_脸盘儿.mp3,lian3panr2,Rhapsodia
pronunciation_zh_收摊儿.mp3,shou1tanr1,Rhapsodia
pronunciation_zh_门槛儿.mp3,men2kanr3,Rhapsodia
pronunciation_zh_药方儿.mp3,yao4fangr1,Rhapsodia
pronunciation_zh_香肠儿.mp3,xiang1changr2,Rhapsodia
pronunciation_zh_瓜瓤儿.mp3,gua1rangr2,Rhapsodia
pronunciation_zh_赶趟儿.mp3,gan3tangr4,Rhapsodia
pronunciation_zh_掉价儿.mp3,diao4jiar4,Rhapsodia
pronunciation_zh_豆芽儿.mp3,dou4yar2,Rhapsodia
pronunciation_zh_小辫儿.mp3,xiao3bianr4,Rhapsodia
pronunciation_zh_扇面儿.mp3,shan4mianr4,Rhapsodia
pronunciation_zh_冒尖儿.mp3,mao4jianr1,Rhapsodia
pronunciation_zh_牙签儿.mp3,ya2xianr1,Rhapsodia
pronunciation_zh_心眼儿.mp3,xin1yanr3,Rhapsodia
pronunciation_zh_照片儿.mp3,zhao4pianr1,Rhapsodia
pronunciation_zh_雨点儿.mp3,yu2dianr3,Rhapsodia
pronunciation_zh_拉链儿.mp3,la1lianr4,Rhapsodia
pronunciation_zh_鼻梁儿.mp3,bi2liangr2,Rhapsodia
pronunciation_zh_花样儿.mp3,hua1yangr4,Rhapsodia
pronunciation_zh_透亮儿.mp3,tou4liangr4,Rhapsodia
pronunciation_zh_脑瓜儿.mp3,nao3guar1,Rhapsodia
pronunciation_zh_麻花儿.mp3,ma2huar1,Rhapsodia
pronunciation_zh_牙刷儿.mp3,ya2shuar1,Rhapsodia
pronunciation_zh_大腕儿.mp3,da4wanr4,Rhapsodia
pronunciation_zh_大褂儿.mp3,da4guar4,Rhapsodia
pronunciation_zh_笑话儿.mp3,xiao4huar5,Rhapsodia
pronunciation_zh_茶馆儿.mp3,cha2guanr3,Rhapsodia
pronunciation_zh_火罐儿.mp3,huo3guanr4,Rhapsodia
pronunciation_zh_打转儿.mp3,da2zhuanr3,Rhapsodia
pronunciation_zh_落款儿.mp3,luo4kuanr3,Rhapsodia
pronunciation_zh_拐弯儿.mp3,guai3wanr1,Rhapsodia
pronunciation_zh_蛋黄儿.mp3,dan4huangr2,Rhapsodia
pronunciation_zh_天窗儿.mp3,tian1chuangr1,Rhapsodia
pronunciation_zh_打晃儿.mp3,da3huangr4,Rhapsodia
pronunciation_zh_人缘儿.mp3,ren2yuanr2,Rhapsodia
pronunciation_zh_杂院儿.mp3,za2yuanr4,Rhapsodia
pronunciation_zh_绕远儿.mp3,rao4yuanr3,Rhapsodia
pronunciation_zh_刀背儿.mp3,dao1beir4,Rhapsodia
pronunciation_zh_摸黑儿.mp3,mo1heir1,Rhapsodia
pronunciation_zh_老本儿.mp3,lao2benr3,Rhapsodia
pronunciation_zh_嗓门儿.mp3,sang3menr2,Rhapsodia
pronunciation_zh_后跟儿.mp3,hou4genr1,Rhapsodia
pronunciation_zh_小人儿书.mp3,xiao3renr2shu1,Rhapsodia
pronunciation_zh_刀刃儿.mp3,dao1renr4,Rhapsodia
pronunciation_zh_花盆儿.mp3,hua1penr2,Rhapsodia
pronunciation_zh_把门儿.mp3,ba3menr2,Rhapsodia
pronunciation_zh_高跟儿鞋.mp3,gao1genr1xie2,Rhapsodia
pronunciation_zh_一阵儿.mp3,yi2zhenr4,Rhapsodia
pronunciation_zh_大婶儿.mp3,da4shenr3,Rhapsodia
pronunciation_zh_杏仁儿.mp3,xing4renr2,Rhapsodia
pronunciation_zh_脖颈儿.mp3,bo2gengr3,Rhapsodia
pronunciation_zh_提成儿.mp3,ti2chengr2,Rhapsodia
pronunciation_zh_小鞋儿.mp3,xiao3xier2,Rhapsodia
pronunciation_zh_旦角儿.mp3,dan4juer2,Rhapsodia
pronunciation_zh_主角儿.mp3,zhu3juer2,Rhapsodia
pronunciation_zh_跑腿儿.mp3,pao2tuir3,Rhapsodia
pronunciation_zh_耳垂儿.mp3,er3chuir2,Rhapsodia
pronunciation_zh_围嘴儿.mp3,wei2zuir3,Rhapsodia
pronunciation_zh_走味儿.mp3,zou3weir4,Rhapsodia
pronunciation_zh_打盹儿.mp3,da2dunr3,Rhapsodia
pronunciation_zh_砂轮儿.mp3,sha1lunr2,Rhapsodia
pronunciation_zh_没准儿.mp3,mei2zhunr3,Rhapsodia
pronunciation_zh_胖墩儿.mp3,pang4dunr1,Rhapsodia
pronunciation_zh_开春儿.mp3,kai1chunr1,Rhapsodia
pronunciation_zh_小瓮儿.mp3,xiao3wengr4,Rhapsodia
pronunciation_zh_石子儿.mp3,shi2zir3,Rhapsodia
pronunciation_zh_没词儿.mp3,mei2cir2,Rhapsodia
pronunciation_zh_挑刺儿.mp3,tiao1cir4,Rhapsodia
pronunciation_zh_墨汁儿.mp3,mo4zhir1,Rhapsodia
pronunciation_zh_锯齿儿.mp3,ju4chir3,Rhapsodia
pronunciation_zh_记事儿.mp3,ji4shir4,Rhapsodia
pronunciation_zh_针鼻儿.mp3,zhen1bir2,Rhapsodia
pronunciation_zh_花瓶儿.mp3,hua1pingr2,Rhapsodia
pronunciation_zh_毛驴儿.mp3,mao2lvr2,Rhapsodia
pronunciation_zh_合群儿.mp3,he2qunr2,Rhapsodia
pronunciation_zh_大伙儿.mp3,da4huor3,monimonica
pronunciation_zh_顶牛儿.mp3,ding3niur2,crowcrow
pronunciation_zh_老头儿.mp3,lao3tour2,startfromabc
pronunciation_zh_面条儿.mp3,mian4tiaor2,
pronunciation_zh_在这儿.mp3,zai4zher4,fv_accn
pronunciation_zh_打嗝儿.mp3,da3ger2,viva7588
pronunciation_zh_模特儿.mp3,mo2ter4,carol_f
pronunciation_zh_有劲儿.mp3,you3jinr4,levincool
pronunciation_zh_玩意儿.mp3,wan2yir4,sd002129353
pronunciation_zh_有数儿.mp3you3shur4,,Chenpeng
pronunciation_zh_胡同儿.mp3,hu2tongr4,Chenpeng
pronunciation_zh_抽空儿.mp3,chou1kongr4,Chenpeng
pronunciation_zh_小熊儿.mp3,xiao3xiongr2,Chenpeng
pronunciation_zh_红包儿.mp3,hong2baor1,Chenpeng
pronunciation_zh_口罩儿.mp3,kou3zhaor4,Chenpeng
pronunciation_zh_口哨儿.mp3,kou3shaor4,Chenpeng
pronunciation_zh_手套儿.mp3,shou3taor4,Chenpeng
pronunciation_zh_衣兜儿.mp3,yi1dour1,Chenpeng
pronunciation_zh_纽扣儿.mp3,niu3kour4,Chenpeng
pronunciation_zh_火锅儿.mp3,huo3guor1,Chenpeng
pronunciation_zh_粉末儿.mp3,fen3mor4,Chenpeng
pronunciation_zh_小说儿.mp3,xiao3shuor1,Chenpeng
pronunciation_zh_饭盒儿.mp3,fan4her2,Chenpeng
pronunciation_zh_逗乐儿.mp3,dou4ler4,Chenpeng
pronunciation_zh_唱歌儿.mp3,chang4ger1,Chenpeng
pronunciation_zh_眼镜儿.mp3,yan3jingr4,Chenpeng
pronunciation_zh_肚脐儿.mp3,du4qir2,Chenpeng
pronunciation_zh_夹缝儿.mp3,jia1fengr4,cloudrainner
pronunciation_zh_走神儿.mp3,zou3chenr2,LEGNOMO
pronunciation_zh_出圈儿.mp3,chu1quanr1,c4127
pronunciation_zh_烟卷儿.mp3,yan1juanr3,hiwyf
pronunciation_zh_饭馆儿.mp3,fan4guanr3,cclwef
pronunciation_zh_好玩儿.mp3,hao3wanr2,luxiya
pronunciation_zh_小曲儿.mp3,xiao2qur3,luxiya
pronunciation_zh_露馅儿.mp3,lou4xianr4,Jenny520081
pronunciation_zh_垫底儿.mp3,dian4dir3,haoliyuan
pronunciation_zh_坎肩儿.mp3,kan3jianr1,haoliyuan
pronunciation_zh_墨水儿.mp3,mo4shuir3,haoliyuan
pronunciation_zh_一下儿.mp3,yi2xiar4,dada264
pronunciation_zh_一会儿.mp3,yi2huir4,dada264
pronunciation_zh_被窝儿.mp3,bei4wor1,witenglish
pronunciation_zh_半道儿.mp3,ban4daor4,witenglish
pronunciation_zh_挨个儿.mp3,ai1ger4,witenglish
pronunciation_zh_瓜子儿.mp3,gua1zir3,witenglish
pronunciation_zh_冰棍儿.mp3,bing1gunr4,witenglish
pronunciation_zh_半截儿.mp3,ban4jier2,witenglish
pronunciation_zh_别针儿.mp3,bie2zhenr1,witenglish
pronunciation_zh_哥们儿.mp3,ge1menr5,witenglish
pronunciation_zh_宝贝儿.mp3,bao1beir4,witenglish
pronunciation_zh_包圆儿.mp3,bao1yuanr2,witenglish
pronunciation_zh_板擦儿.mp3,ban3car1,witenglish
pronunciation_zh_小孩儿.mp3,xiao3hair2,witenglish
pronunciation_zh_笔杆儿.mp3,bi2ganr3,witenglish
pronunciation_zh_包干儿.mp3,bao1ganr4,witenglish
pronunciation_zh_聊天儿.mp3,liao2tianr1,Smoking
pronunciation_zh_差点儿.mp3,cha4dianr3,yuris726
pronunciation_zh_玩儿.mp3,wanr2,huangfu
pronunciation_zh_在哪儿.mp3,zai4nar3,Sawaka
pronunciation_zh_馅儿.mp3,xianr4,kevsea
pronunciation_zh_手绢儿.mp3,shou3juanr4,cha236
pronunciation_zh_孩儿.mp3,hair2,cha236
pronunciation_zh_一块儿.mp3,yi2kuair4,cha236
pronunciation_zh_一点儿.mp3,yi4dianr3,cha236
pronunciation_zh_老伴儿.mp3,lao3banr4,cha236
pronunciation_zh_使劲儿.mp3,shi3jinr4,cha236
pronunciation_zh_一点儿.mp3,yi4dianr3,wangdream
pronunciation_zh_大伙儿.mp3,da4huor3,monimonica
pronunciation_zh_噢.mp3,o1,chihchao
pronunciation_zh_哟.mp3,yo5,Richiecoco
pronunciation_zh_哦.mp3,o4,wangdream
pronunciation_yue_咯.mp3,lo5,Candice
pronunciation_yue_誒.mp3,eh3,daudau
pronunciation_zh_呣.mp3,m4,mrniu
pronunciation_zh_嗯(1).mp3,ng3,nemokuma
pronunciation_zh_嗯(2).mp3,n3,jaspon
pronunciation_zh_摁.mp3,en4,mianlang
pronunciation_zh_哼.mp3,hng1,shadowlydia
pronunciation_zh_头晕.mp3,tou2yun1,Gradisca
pronunciation_zh_蛐蛐.mp3,qu1qu5,cjjjcj4
pronunciation_zh_打的.mp3,da3di1,caoluo
pronunciation_zh_莫名其妙.mp3,mo4ming2qi2miao4,wangdream"
}

main()
