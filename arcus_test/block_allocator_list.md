- 테스트 환경

	- server : m001 장비 사용(./memcached -E .libs/default_engine.so -X .libs/syslog_logger.so -X .libs/ascii_scrub.so -d -v -r -R5 -U 0 -D: -b 8192 -m100 -p 11299 -c 1000 -t 6 -z 10.32.24.105:9181)
		- block 미적용 cache server : https://github.com/jam2in/arcus-memcached.git develop branch 사용
		- block 적용 cache server : https://github.com/jooho812/arcus-memcached.git jooho812/block_allocator branch 사용

	- client : m002 장비 사용(acp-java)
	- acp java 설정 (모든 테스트 동일한 설정으로 수행함)
        - client=10
        - rate=0
        - request=0
        - time=600
        - keyset_size=20
        - key_prefix=listgetwithdelete:
        - valueset_min_size=20
        - valueset_max_size=20
        - client_profile=torture_blk_list_case01
        - client_exptime=0
        - pool=1
        - pool_size=20
        - pool_use_random=false
        - ins_element_size=200000
        - act_element_size=100000

	- test case
		- case01 : 각 50,000 element 가지는 cache item에 대해 1 ~ 50,000 random get
		- case02 : 각 50,000 element 가지는 cache item에 대해 1 ~ 1,000 random get
		- case03 : 각 50,000 element 가지는 cache item에 대해 10,000 ~ 50,000 random get
		- case04 : 각 100 element 가지는 cache item에 대해 200 ~ 50,000 random get






- block 적용 case 01

        elapsed(s)=89 requests/s=182 [error=0] cumulative requests/client=1570 [error=0] cumulative requests/s=165
        per-client requests. min=4 median=23 avg=18 max=34
        latency (usec). requests=182 min=902 10th=7137 50th=31782 80th=57700 90th=74463 99th=459608 max=506481
        182     0               X       X       X
        elapsed(s)=90 requests/s=166 [error=0] cumulative requests/client=1586 [error=0] cumulative requests/s=165
        per-client requests. min=10 median=15 avg=16 max=30
        latency (usec). requests=166 min=1358 10th=8191 50th=33639 80th=60219 90th=88544 99th=479503 max=503306
        166     0               X       X       X
        elapsed(s)=91 requests/s=174 [error=0] cumulative requests/client=1604 [error=0] cumulative requests/s=165
        per-client requests. min=3 median=19 avg=17 max=35
        latency (usec). requests=174 min=927 10th=9342 50th=32080 80th=64754 90th=104845 99th=488432 max=942358
        174     0               X       X       X
        elapsed(s)=92 requests/s=177 [error=0] cumulative requests/client=1622 [error=0] cumulative requests/s=165
        per-client requests. min=7 median=20 avg=17 max=25
        latency (usec). requests=177 min=1977 10th=10841 50th=31984 80th=54708 90th=79852 99th=453594 max=491372
        177     0               X       X       X
        elapsed(s)=93 requests/s=164 [error=0] cumulative requests/client=1638 [error=0] cumulative requests/s=164
        per-client requests. min=3 median=17 avg=16 max=31
        latency (usec). requests=164 min=768 10th=7895 50th=26343 80th=55634 90th=227864 99th=473080 max=522141
        164     0               X       X       X

- block 미적용 case 01

        elapsed(s)=90 requests/s=204 [error=0] cumulative requests/client=1225 [error=0] cumulative requests/s=165
        per-client requests. min=0 median=24 avg=20 max=38
        latency (usec). requests=204 min=1132 10th=6707 50th=28119 80th=47649 90th=69266 99th=463928 max=939746
        204     0               X       X       X
        elapsed(s)=91 requests/s=169 [error=0] cumulative requests/client=1242 [error=0] cumulative requests/s=165
        per-client requests. min=0 median=19 avg=16 max=27
        latency (usec). requests=169 min=967 10th=8845 50th=27995 80th=48924 90th=70005 99th=444975 max=464568
        169     0               X       X       X
        elapsed(s)=92 requests/s=175 [error=0] cumulative requests/client=1260 [error=0] cumulative requests/s=165
        per-client requests. min=0 median=19 avg=17 max=33
        latency (usec). requests=175 min=1070 10th=8646 50th=24980 80th=43624 90th=63147 99th=487995 max=688374
        175     0               X       X       X
        elapsed(s)=93 requests/s=174 [error=0] cumulative requests/client=1277 [error=0] cumulative requests/s=165
        per-client requests. min=0 median=18 avg=17 max=39
        latency (usec). requests=174 min=1178 10th=6333 50th=27450 80th=45936 90th=70041 99th=491738 max=516945
        174     0               X       X       X
        elapsed(s)=94 requests/s=179 [error=0] cumulative requests/client=1295 [error=0] cumulative requests/s=165
        per-client requests. min=0 median=19 avg=17 max=30
        latency (usec). requests=179 min=908 10th=5783 50th=25636 80th=48934 90th=109059 99th=428400 max=480058
        179     0               X       X       X

- block 적용 case 02

        elapsed(s)=90 requests/s=1135 [error=0] cumulative requests/client=6576 [error=0] cumulative requests/s=1001
        per-client requests. min=89 median=101 avg=113 max=189
        latency (usec). requests=1135 min=586 10th=2921 50th=7550 80th=12478 90th=16362 99th=28467 max=36846
        1135    0               X       X       X
        elapsed(s)=91 requests/s=1088 [error=0] cumulative requests/client=6684 [error=0] cumulative requests/s=1005
        per-client requests. min=86 median=100 avg=108 max=157
        latency (usec). requests=1088 min=734 10th=3143 50th=7906 80th=12966 90th=16580 99th=31459 max=51965
        1088    0               X       X       X
        elapsed(s)=92 requests/s=1302 [error=0] cumulative requests/client=6815 [error=0] cumulative requests/s=1019
        per-client requests. min=99 median=118 avg=130 max=202
        latency (usec). requests=1302 min=619 10th=2404 50th=6593 80th=10894 90th=14226 99th=26453 max=37504
        1302    0               X       X       X
        elapsed(s)=93 requests/s=1215 [error=0] cumulative requests/client=6936 [error=0] cumulative requests/s=1028
        per-client requests. min=100 median=106 avg=121 max=190
        latency (usec). requests=1215 min=711 10th=2540 50th=6759 80th=12210 90th=15685 99th=28125 max=39283
        1215    0               X       X       X
        elapsed(s)=94 requests/s=1216 [error=0] cumulative requests/client=7058 [error=0] cumulative requests/s=1037
        per-client requests. min=102 median=108 avg=121 max=189
        latency (usec). requests=1216 min=851 10th=2673 50th=7085 80th=11685 90th=15296 99th=27328 max=46487
        1216    0               X       X       X

- block 미적용 case 02

        elapsed(s)=89 requests/s=1162 [error=0] cumulative requests/client=5872 [error=0] cumulative requests/s=856
        per-client requests. min=83 median=109 avg=116 max=183
        latency (usec). requests=1162 min=628 10th=2679 50th=6888 80th=12778 90th=16923 99th=30236 max=40050
        1162    0               X       X       X
        elapsed(s)=90 requests/s=1163 [error=0] cumulative requests/client=5988 [error=0] cumulative requests/s=871
        per-client requests. min=96 median=104 avg=116 max=181
        latency (usec). requests=1163 min=464 10th=2773 50th=7490 80th=12658 90th=16207 99th=25573 max=31022
        1163    0               X       X       X
        elapsed(s)=91 requests/s=1261 [error=0] cumulative requests/client=6114 [error=0] cumulative requests/s=890
        per-client requests. min=97 median=110 avg=126 max=217
        latency (usec). requests=1261 min=829 10th=2498 50th=6166 80th=11186 90th=15649 99th=30872 max=46380
        1261    0               X       X       X
        elapsed(s)=92 requests/s=1185 [error=0] cumulative requests/client=6233 [error=0] cumulative requests/s=904
        per-client requests. min=88 median=103 avg=118 max=202
        latency (usec). requests=1185 min=525 10th=2447 50th=6679 80th=12387 90th=16400 99th=33905 max=41806
        1185    0               X       X       X
        elapsed(s)=93 requests/s=1063 [error=0] cumulative requests/client=6339 [error=0] cumulative requests/s=911
        per-client requests. min=86 median=98 avg=106 max=153
        latency (usec). requests=1063 min=634 10th=2644 50th=7822 80th=14245 90th=18457 99th=29297 max=39350
        1063    0               X       X       X

- block 적용 case 03

        elapsed(s)=96 requests/s=148 [error=0] cumulative requests/client=1108 [error=0] cumulative requests/s=135
        per-client requests. min=0 median=17 avg=14 max=32
        latency (usec). requests=148 min=6708 10th=12578 50th=30643 80th=46483 90th=74249 99th=459783 max=538915
        148     0               X       X       X
        elapsed(s)=97 requests/s=141 [error=0] cumulative requests/client=1122 [error=0] cumulative requests/s=135
        per-client requests. min=0 median=17 avg=14 max=29
        latency (usec). requests=141 min=7292 10th=14451 50th=30484 80th=52900 90th=72254 99th=500797 max=537470
        141     0               X       X       X
        elapsed(s)=98 requests/s=155 [error=0] cumulative requests/client=1137 [error=0] cumulative requests/s=136
        per-client requests. min=0 median=15 avg=15 max=30
        latency (usec). requests=155 min=7364 10th=14201 50th=28695 80th=53627 90th=76679 99th=478606 max=528479
        155     0               X       X       X
        elapsed(s)=99 requests/s=155 [error=0] cumulative requests/client=1153 [error=0] cumulative requests/s=136
        per-client requests. min=0 median=17 avg=15 max=34
        latency (usec). requests=155 min=8203 10th=13193 50th=33012 80th=54386 90th=76269 99th=518530 max=534947
        155     0               X       X       X
        elapsed(s)=100 requests/s=141 [error=0] cumulative requests/client=1167 [error=0] cumulative requests/s=136
        per-client requests. min=0 median=12 avg=14 max=37
        latency (usec). requests=141 min=6848 10th=14516 50th=29678 80th=48839 90th=78944 99th=499087 max=507423
        141     0               X       X       X

- block 미적용 case 03

        elapsed(s)=69 requests/s=144 [error=0] cumulative requests/client=708 [error=0] cumulative requests/s=128
        per-client requests. min=0 median=16 avg=14 max=23
        latency (usec). requests=144 min=8548 10th=14235 50th=35864 80th=55681 90th=75414 99th=510299 max=646121
        144     0               X       X       X
        elapsed(s)=70 requests/s=141 [error=0] cumulative requests/client=722 [error=0] cumulative requests/s=128
        per-client requests. min=0 median=16 avg=14 max=21
        latency (usec). requests=141 min=12435 10th=18028 50th=35208 80th=63791 90th=81669 99th=484902 max=833155
        141     0               X       X       X
        elapsed(s)=71 requests/s=158 [error=0] cumulative requests/client=737 [error=0] cumulative requests/s=129
        per-client requests. min=0 median=16 avg=15 max=40
        latency (usec). requests=158 min=5451 10th=12795 50th=26057 80th=46447 90th=212375 99th=510897 max=743343
        158     0               X       X       X
        elapsed(s)=72 requests/s=146 [error=0] cumulative requests/client=752 [error=0] cumulative requests/s=129
        per-client requests. min=0 median=15 avg=14 max=25
        latency (usec). requests=146 min=7138 10th=14996 50th=29590 80th=50448 90th=86194 99th=493123 max=502782
        146     0               X       X       X
        elapsed(s)=73 requests/s=145 [error=0] cumulative requests/client=767 [error=0] cumulative requests/s=129
        per-client requests. min=0 median=13 avg=14 max=26
        latency (usec). requests=145 min=7325 10th=10966 50th=26175 80th=45810 90th=83649 99th=502770 max=721417
        145     0               X       X       X

- block 적용 case 04

        elapsed(s)=55 requests/s=17555 [error=0] cumulative requests/client=91927 [error=0] cumulative requests/s=16236
        per-client requests. min=1450 median=1816 avg=1755 max=2009
        latency (usec). requests=17555 min=244 10th=384 50th=502 80th=657 90th=822 99th=1504 max=4954
        17555   0               X       X       X
        elapsed(s)=56 requests/s=16231 [error=0] cumulative requests/client=93550 [error=0] cumulative requests/s=16235
        per-client requests. min=1216 median=1614 avg=1623 max=1864
        latency (usec). requests=16231 min=230 10th=388 50th=513 80th=668 90th=808 99th=1432 max=200390
        16231   0               X       X       X
        elapsed(s)=57 requests/s=17632 [error=0] cumulative requests/client=95313 [error=0] cumulative requests/s=16304
        per-client requests. min=1606 median=1817 avg=1763 max=2009
        latency (usec). requests=17632 min=232 10th=392 50th=509 80th=661 90th=808 99th=1386 max=13332
        17632   0               X       X       X
        elapsed(s)=58 requests/s=17405 [error=0] cumulative requests/client=97054 [error=0] cumulative requests/s=16359
        per-client requests. min=1599 median=1733 avg=1740 max=2083
        latency (usec). requests=17405 min=231 10th=387 50th=511 80th=670 90th=825 99th=1459 max=14345
        17405   0               X       X       X
        elapsed(s)=59 requests/s=17337 [error=0] cumulative requests/client=98788 [error=0] cumulative requests/s=16407
        per-client requests. min=1574 median=1752 avg=1733 max=1844
        latency (usec). requests=17337 min=241 10th=384 50th=502 80th=668 90th=824 99th=1424 max=39947
        17337   0               X       X       X
        elapsed(s)=60 requests/s=16936 [error=0] cumulative requests/client=100481 [error=0] cumulative requests/s=16433
        per-client requests. min=1481 median=1737 avg=1693 max=1886
        latency (usec). requests=16936 min=234 10th=393 50th=522 80th=698 90th=861 99th=1501 max=15065
        16936   0               X       X       X
        elapsed(s)=61 requests/s=17196 [error=0] cumulative requests/client=102201 [error=0] cumulative requests/s=16471
        per-client requests. min=1502 median=1719 avg=1719 max=2093
        latency (usec). requests=17196 min=243 10th=387 50th=512 80th=683 90th=843 99th=1472 max=13476
        17196   0               X       X       X


- block 미적용 case 04

        elapsed(s)=55 requests/s=16023 [error=0] cumulative requests/client=88400 [error=0] cumulative requests/s=15657
        per-client requests. min=1420 median=1622 avg=1602 max=1689
        latency (usec). requests=16023 min=251 10th=401 50th=528 80th=732 90th=924 99th=1570 max=65312
        16023   0               X       X       X
        elapsed(s)=56 requests/s=17220 [error=0] cumulative requests/client=90122 [error=0] cumulative requests/s=15735
        per-client requests. min=1427 median=1750 avg=1722 max=1871
        latency (usec). requests=17220 min=246 10th=396 50th=511 80th=686 90th=850 99th=1459 max=6477
        17220   0               X       X       X
        elapsed(s)=57 requests/s=17169 [error=0] cumulative requests/client=91839 [error=0] cumulative requests/s=15806
        per-client requests. min=1521 median=1703 avg=1716 max=2058
        latency (usec). requests=17169 min=231 10th=397 50th=513 80th=684 90th=848 99th=1473 max=11685
        17169   0               X       X       X
        elapsed(s)=58 requests/s=16899 [error=0] cumulative requests/client=93528 [error=0] cumulative requests/s=15860
        per-client requests. min=1404 median=1705 avg=1689 max=1842
        latency (usec). requests=16899 min=248 10th=396 50th=520 80th=703 90th=865 99th=1489 max=11237
        16899   0               X       X       X
        elapsed(s)=59 requests/s=16654 [error=0] cumulative requests/client=95194 [error=0] cumulative requests/s=15899
        per-client requests. min=1278 median=1720 avg=1665 max=1975
        latency (usec). requests=16654 min=242 10th=385 50th=513 80th=729 90th=917 99th=1614 max=16900
        16654   0               X       X       X
        elapsed(s)=60 requests/s=17043 [error=0] cumulative requests/client=96898 [error=0] cumulative requests/s=15956
        per-client requests. min=1481 median=1707 avg=1704 max=1940
        latency (usec). requests=17043 min=268 10th=391 50th=507 80th=683 90th=849 99th=1484 max=43299
        17043   0               X       X       X
        elapsed(s)=61 requests/s=17069 [error=0] cumulative requests/client=98605 [error=0] cumulative requests/s=16011
        per-client requests. min=1476 median=1679 avg=1706 max=2052
        latency (usec). requests=17069 min=239 10th=386 50th=499 80th=682 90th=865 99th=1630 max=11309
        17069   0               X       X       X
