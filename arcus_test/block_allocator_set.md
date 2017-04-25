- 테스트 환경

	- server : m001 장비 사용(./memcached -E .libs/default_engine.so -X .libs/syslog_logger.so -X .libs/ascii_scrub.so -d -v -r -R5 -U 0 -D: -b 8192 -m100 -p 11299 -c 1000 -t 6 -z 11.11.11.11:9181)
		- block 미적용 cache server : https://github.com/jam2in/arcus-memcached.git develop branch 사용
		- block 적용 cache server : https://github.com/jooho812/arcus-memcached.git jooho812/block_allocator branch 사용

	- client : m002 장비 사용(acp-java)
	- acp java 설정 (모든 테스트 동일한 설정으로 수행함)
        - client=20
        - rate=0
        - request=0
        - time=600
        - keyset_size=20
        - key_prefix=setgetwithdelete:
        - valueset_min_size=20
        - valueset_max_size=20
        - client_profile=torture_blk_set_case01
        - client_exptime=0
        - pool=1
        - pool_size=20
        - pool_use_random=false
        - ins_element_size=200000
        - act_element_size=100000

	- test case
		- case01 : 각 50,000 element 가지는 cache item에 대해 1 ~ 50,000 random get
		- case02 : 각 50,000 element 가지는 cache item에 대해 1 ~ 1,000 random get
		- case03 : 각 50,000 element 가지는 cache item에 대해 30,000 ~ 50,000 random get
		- case04 : 각 100 element 가지는 cache item에 대해 30,000 ~ 50,000 random get


- block 적용 case 01

        elapsed(s)=102 requests/s=253 [error=0] cumulative requests/client=956 [error=0] cumulative requests/s=229
        per-client requests. min=2 median=14 avg=12 max=22
        latency (usec). requests=253 min=2731 10th=17701 50th=51556 80th=89896 90th=162376 99th=544307 max=603404
        253     0               X       X       X
        elapsed(s)=103 requests/s=248 [error=0] cumulative requests/client=968 [error=0] cumulative requests/s=229
        per-client requests. min=7 median=13 avg=12 max=24
        latency (usec). requests=248 min=2163 10th=19205 50th=61402 80th=93095 90th=132943 99th=531585 max=988090
        248     0               X       X       X
        elapsed(s)=104 requests/s=221 [error=0] cumulative requests/client=979 [error=0] cumulative requests/s=228
        per-client requests. min=3 median=11 avg=11 max=18
        latency (usec). requests=221 min=2056 10th=19602 50th=57760 80th=98016 90th=138377 99th=521596 max=559822
        221     0               X       X       X
        elapsed(s)=105 requests/s=255 [error=0] cumulative requests/client=992 [error=0] cumulative requests/s=229
        per-client requests. min=1 median=15 avg=12 max=22
        latency (usec). requests=255 min=1007 10th=9558 50th=40738 80th=83123 90th=160526 99th=568502 max=923378
        255     0               X       X       X
        elapsed(s)=106 requests/s=233 [error=0] cumulative requests/client=1004 [error=0] cumulative requests/s=229
        per-client requests. min=5 median=11 avg=11 max=21
        latency (usec). requests=233 min=1729 10th=18564 50th=50012 80th=96529 90th=234476 99th=550648 max=586440
        233     0               X       X       X
        elapsed(s)=107 requests/s=237 [error=0] cumulative requests/client=1015 [error=0] cumulative requests/s=229
        per-client requests. min=6 median=12 avg=11 max=20
        latency (usec). requests=237 min=1321 10th=15594 50th=53764 80th=106480 90th=153983 99th=522394 max=723440
        237     0               X       X       X


- block 미적용 case 01

        elapsed(s)=102 requests/s=255 [error=0] cumulative requests/client=849 [error=0] cumulative requests/s=227
        per-client requests. min=7 median=13 avg=12 max=15
        latency (usec). requests=255 min=8825 10th=29229 50th=68434 80th=101777 90th=127599 99th=237249 max=475170
        255     0               X       X       X
        elapsed(s)=103 requests/s=243 [error=0] cumulative requests/client=861 [error=0] cumulative requests/s=227
        per-client requests. min=3 median=14 avg=12 max=20
        latency (usec). requests=243 min=3026 10th=16614 50th=46254 80th=81349 90th=134004 99th=550459 max=900547
        243     0               X       X       X
        elapsed(s)=104 requests/s=223 [error=0] cumulative requests/client=872 [error=0] cumulative requests/s=226
        per-client requests. min=6 median=11 avg=11 max=18
        latency (usec). requests=223 min=1556 10th=21057 50th=64527 80th=108610 90th=169981 99th=539528 max=676912
        223     0               X       X       X
        elapsed(s)=105 requests/s=226 [error=0] cumulative requests/client=884 [error=0] cumulative requests/s=226
        per-client requests. min=2 median=11 avg=11 max=19
        latency (usec). requests=226 min=1126 10th=14955 50th=49967 80th=98044 90th=213664 99th=504358 max=960177
        226     0               X       X       X
        elapsed(s)=106 requests/s=224 [error=0] cumulative requests/client=895 [error=0] cumulative requests/s=225
        per-client requests. min=3 median=11 avg=11 max=19
        latency (usec). requests=224 min=5327 10th=18315 50th=57769 80th=109964 90th=204012 99th=735372 max=745197
        224     0               X       X       X
        elapsed(s)=107 requests/s=237 [error=0] cumulative requests/client=907 [error=0] cumulative requests/s=225
        per-client requests. min=4 median=12 avg=11 max=21
        latency (usec). requests=237 min=2151 10th=20109 50th=62099 80th=104252 90th=149038 99th=436096 max=485943
        237     0               X       X       X

- block 적용 case 02

        elapsed(s)=104 requests/s=6679 [error=0] cumulative requests/client=18825 [error=0] cumulative requests/s=5706
        per-client requests. min=259 median=332 avg=333 max=403
        latency (usec). requests=6679 min=262 10th=1106 50th=2405 80th=3673 90th=4639 99th=9705 max=95391
        6679    0               X       X       X
        elapsed(s)=105 requests/s=6412 [error=0] cumulative requests/client=19146 [error=0] cumulative requests/s=5741
        per-client requests. min=236 median=340 avg=320 max=382
        latency (usec). requests=6412 min=254 10th=1259 50th=2675 80th=4075 90th=4956 99th=8758 max=88736
        6412    0               X       X       X
        elapsed(s)=106 requests/s=5643 [error=0] cumulative requests/client=19428 [error=0] cumulative requests/s=5736
        per-client requests. min=143 median=296 avg=282 max=358
        latency (usec). requests=5643 min=296 10th=1190 50th=2685 80th=4368 90th=5727 99th=12556 max=114840
        5643    0               X       X       X
        elapsed(s)=107 requests/s=6433 [error=0] cumulative requests/client=19750 [error=0] cumulative requests/s=5770
        per-client requests. min=255 median=334 avg=321 max=386
        latency (usec). requests=6433 min=295 10th=1214 50th=2651 80th=3994 90th=4917 99th=9999 max=100978
        6433    0               X       X       X
        elapsed(s)=108 requests/s=5569 [error=0] cumulative requests/client=20028 [error=0] cumulative requests/s=5759
        per-client requests. min=228 median=273 avg=278 max=337
        latency (usec). requests=5569 min=265 10th=1201 50th=2765 80th=4500 90th=5830 99th=12146 max=106327
        5569    0               X       X       X
        elapsed(s)=109 requests/s=6636 [error=0] cumulative requests/client=20360 [error=0] cumulative requests/s=5802
        per-client requests. min=272 median=333 avg=331 max=390
        latency (usec). requests=6636 min=294 10th=1117 50th=2414 80th=3773 90th=4764 99th=9839 max=98997
        6636    0               X       X       X

- block 미적용 case 02

        elapsed(s)=104 requests/s=4718 [error=0] cumulative requests/client=17081 [error=0] cumulative requests/s=4661
        per-client requests. min=157 median=235 avg=235 max=340
        latency (usec). requests=4718 min=255 10th=909 50th=2598 80th=5653 90th=7912 99th=17515 max=539024
        4718    0               X       X       X
        elapsed(s)=105 requests/s=5188 [error=0] cumulative requests/client=17340 [error=0] cumulative requests/s=4687
        per-client requests. min=45 median=267 avg=259 max=394
        latency (usec). requests=5188 min=247 10th=779 50th=2121 80th=4564 90th=6536 99th=14107 max=988103
        5188    0               X       X       X
        elapsed(s)=106 requests/s=4584 [error=0] cumulative requests/client=17569 [error=0] cumulative requests/s=4681
        per-client requests. min=171 median=230 avg=229 max=282
        latency (usec). requests=4584 min=308 10th=1143 50th=3217 80th=5944 90th=8221 99th=16139 max=208484
        4584    0               X       X       X
        elapsed(s)=107 requests/s=4999 [error=0] cumulative requests/client=17819 [error=0] cumulative requests/s=4696
        per-client requests. min=152 median=242 avg=249 max=441
        latency (usec). requests=4999 min=266 10th=742 50th=1795 80th=4034 90th=6509 99th=18734 max=545871
        4999    0               X       X       X
        elapsed(s)=108 requests/s=4815 [error=0] cumulative requests/client=18060 [error=0] cumulative requests/s=4701
        per-client requests. min=147 median=237 avg=240 max=350
        latency (usec). requests=4815 min=265 10th=867 50th=2453 80th=5080 90th=7041 99th=16838 max=572636
        4815    0               X       X       X
        elapsed(s)=109 requests/s=4584 [error=0] cumulative requests/client=18289 [error=0] cumulative requests/s=4695
        per-client requests. min=174 median=221 avg=229 max=417
        latency (usec). requests=4584 min=261 10th=919 50th=2771 80th=4967 90th=6936 99th=14940 max=246905
        4584    0               X       X       X


- block 적용 case 03

        elapsed(s)=99 requests/s=160 [error=0] cumulative requests/client=511 [error=0] cumulative requests/s=146
        per-client requests. min=6 median=8 avg=8 max=10
        latency (usec). requests=160 min=45854 10th=64202 50th=121523 80th=166995 90th=200445 99th=307843 max=316650
        160     0               X       X       X
        elapsed(s)=100 requests/s=152 [error=0] cumulative requests/client=518 [error=0] cumulative requests/s=146
        per-client requests. min=5 median=8 avg=7 max=11
        latency (usec). requests=152 min=39595 10th=65144 50th=122388 80th=160718 90th=191198 99th=340112 max=353991
        152     0               X       X       X
        elapsed(s)=101 requests/s=177 [error=0] cumulative requests/client=527 [error=0] cumulative requests/s=147
        per-client requests. min=6 median=9 avg=8 max=12
        latency (usec). requests=177 min=35804 10th=61547 50th=107269 80th=162902 90th=180609 99th=296448 max=309722
        177     0               X       X       X
        elapsed(s)=102 requests/s=163 [error=0] cumulative requests/client=535 [error=0] cumulative requests/s=147
        per-client requests. min=5 median=8 avg=8 max=11
        latency (usec). requests=163 min=44572 10th=71473 50th=111358 80th=165378 90th=194445 99th=258203 max=344692
        163     0               X       X       X
        elapsed(s)=103 requests/s=162 [error=0] cumulative requests/client=543 [error=0] cumulative requests/s=147
        per-client requests. min=5 median=8 avg=8 max=11
        latency (usec). requests=162 min=34310 10th=63788 50th=116832 80th=156036 90th=184545 99th=275829 max=342490
        162     0               X       X       X
        elapsed(s)=104 requests/s=159 [error=0] cumulative requests/client=551 [error=0] cumulative requests/s=147
        per-client requests. min=5 median=8 avg=7 max=11
        latency (usec). requests=159 min=41740 10th=64552 50th=116926 80th=165535 90th=203384 99th=290297 max=294262
        159     0               X       X       X
        elapsed(s)=105 requests/s=152 [error=0] cumulative requests/client=559 [error=0] cumulative requests/s=147
        per-client requests. min=5 median=7 avg=7 max=12
        latency (usec). requests=152 min=43712 10th=66324 50th=118180 80th=170491 90th=209862 99th=315127 max=364380
        152     0               X       X       X

- block 미적용 case 03

        elapsed(s)=99 requests/s=156 [error=0] cumulative requests/client=501 [error=0] cumulative requests/s=139
        per-client requests. min=5 median=8 avg=7 max=10
        latency (usec). requests=156 min=52727 10th=74639 50th=119435 80th=157907 90th=194548 99th=258619 max=266021
        156     0               X       X       X
        elapsed(s)=100 requests/s=155 [error=0] cumulative requests/client=509 [error=0] cumulative requests/s=139
        per-client requests. min=5 median=8 avg=7 max=10
        latency (usec). requests=155 min=39240 10th=64988 50th=123819 80th=177232 90th=202297 99th=266229 max=281136
        155     0               X       X       X
        elapsed(s)=101 requests/s=157 [error=0] cumulative requests/client=516 [error=0] cumulative requests/s=139
        per-client requests. min=5 median=8 avg=7 max=10
        latency (usec). requests=157 min=42468 10th=64729 50th=110371 80th=159669 90th=203206 99th=270670 max=312177
        157     0               X       X       X
        elapsed(s)=102 requests/s=162 [error=0] cumulative requests/client=524 [error=0] cumulative requests/s=140
        per-client requests. min=6 median=8 avg=8 max=11
        latency (usec). requests=162 min=44777 10th=70671 50th=120086 80th=175506 90th=211022 99th=269243 max=297363
        162     0               X       X       X
        elapsed(s)=103 requests/s=164 [error=0] cumulative requests/client=533 [error=0] cumulative requests/s=141
        per-client requests. min=6 median=8 avg=8 max=10
        latency (usec). requests=164 min=46815 10th=61819 50th=111090 80th=176258 90th=204807 99th=270090 max=278422
        164     0               X       X       X
        elapsed(s)=104 requests/s=174 [error=0] cumulative requests/client=541 [error=0] cumulative requests/s=142
        per-client requests. min=6 median=9 avg=8 max=11
        latency (usec). requests=174 min=31002 10th=71985 50th=109041 80th=139941 90th=163083 99th=257786 max=316227
        174     0               X       X       X
        elapsed(s)=105 requests/s=166 [error=0] cumulative requests/client=550 [error=0] cumulative requests/s=143
        per-client requests. min=5 median=8 avg=8 max=10
        latency (usec). requests=166 min=41107 10th=61965 50th=111124 80th=155163 90th=176153 99th=257165 max=363167
        166     0               X       X       X


- block 적용 case 04

        elapsed(s)=99 requests/s=20345 [error=0] cumulative requests/client=107652 [error=0] cumulative requests/s=21290
        per-client requests. min=752 median=1019 avg=1017 max=1367
        latency (usec). requests=20345 min=292 10th=455 50th=631 80th=946 90th=1363 99th=6569 max=50777
        20345   0               X       X       X
        elapsed(s)=100 requests/s=21738 [error=0] cumulative requests/client=108738 [error=0] cumulative requests/s=21312
        per-client requests. min=982 median=1105 avg=1086 max=1160
        latency (usec). requests=21738 min=296 10th=474 50th=676 80th=979 90th=1313 99th=5677 max=41833
        21738   0               X       X       X
        elapsed(s)=101 requests/s=21706 [error=0] cumulative requests/client=109824 [error=0] cumulative requests/s=21331
        per-client requests. min=955 median=1084 avg=1085 max=1231
        latency (usec). requests=21706 min=277 10th=472 50th=652 80th=960 90th=1295 99th=5999 max=61965
        21706   0               X       X       X
        elapsed(s)=102 requests/s=21083 [error=0] cumulative requests/client=110878 [error=0] cumulative requests/s=21318
        per-client requests. min=921 median=1042 avg=1054 max=1251
        latency (usec). requests=21083 min=293 10th=475 50th=675 80th=989 90th=1389 99th=6015 max=34937
        21083   0               X       X       X
        elapsed(s)=103 requests/s=21624 [error=0] cumulative requests/client=111959 [error=0] cumulative requests/s=21333
        per-client requests. min=922 median=1080 avg=1081 max=1246
        latency (usec). requests=21624 min=285 10th=481 50th=668 80th=934 90th=1236 99th=5946 max=44355
        21624   0               X       X       X

- block 미적용 case 04

        elapsed(s)=99 requests/s=20535 [error=0] cumulative requests/client=100728 [error=0] cumulative requests/s=20264
        per-client requests. min=890 median=1052 avg=1026 max=1125
        latency (usec). requests=20535 min=306 10th=478 50th=683 80th=1027 90th=1472 99th=6224 max=25802
        20535   0               X       X       X
        elapsed(s)=100 requests/s=20606 [error=0] cumulative requests/client=101758 [error=0] cumulative requests/s=20281
        per-client requests. min=880 median=1027 avg=1030 max=1204
        latency (usec). requests=20606 min=308 10th=476 50th=687 80th=1021 90th=1427 99th=6428 max=34908
        20606   0               X       X       X
        elapsed(s)=101 requests/s=19677 [error=0] cumulative requests/client=102742 [error=0] cumulative requests/s=20250
        per-client requests. min=723 median=1020 avg=983 max=1129
        latency (usec). requests=19677 min=305 10th=479 50th=690 80th=1049 90th=1468 99th=6680 max=37208
        19677   0               X       X       X
        elapsed(s)=102 requests/s=20406 [error=0] cumulative requests/client=103762 [error=0] cumulative requests/s=20257
        per-client requests. min=888 median=1033 avg=1020 max=1217
        latency (usec). requests=20406 min=318 10th=477 50th=683 80th=1029 90th=1461 99th=5910 max=31652
        20406   0               X       X       X
        elapsed(s)=103 requests/s=20486 [error=0] cumulative requests/client=104787 [error=0] cumulative requests/s=20268
        per-client requests. min=877 median=1061 avg=1024 max=1134
        latency (usec). requests=20486 min=313 10th=475 50th=676 80th=1015 90th=1418 99th=6755 max=38055
        20486   0               X       X       X




