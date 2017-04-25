- 테스트 환경

	- server : m001 장비 사용(./memcached -E .libs/default_engine.so -X .libs/syslog_logger.so -X .libs/ascii_scrub.so -d -v -r -R5 -U 0 -D: -b 8192 -m100 -p 11299 -c 1000 -t 6 -z 11.11.11.11:9181)
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
        - client_profile=torture_blk_btree_case01
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
		- case04 : 각 100 element 가지는 cache item에 대해 10,000 ~ 50,000 random get



- block 적용 case 01

        elapsed(s)=100 requests/s=121 [error=0] cumulative requests/client=1019 [error=0] cumulative requests/s=108
        per-client requests. min=0 median=14 avg=12 max=24
        latency (usec). requests=121 min=2718 10th=14491 50th=57864 80th=87165 90th=107151 99th=500247 max=505153
        121     0               X       X       X
        elapsed(s)=101 requests/s=108 [error=0] cumulative requests/client=1030 [error=0] cumulative requests/s=108
        per-client requests. min=0 median=12 avg=10 max=24
        latency (usec). requests=108 min=4312 10th=15627 50th=51936 80th=88635 90th=124357 99th=504919 max=554444
        108     0               X       X       X
        elapsed(s)=102 requests/s=117 [error=0] cumulative requests/client=1042 [error=0] cumulative requests/s=108
        per-client requests. min=0 median=13 avg=11 max=20
        latency (usec). requests=117 min=1016 10th=14135 50th=57756 80th=95708 90th=124277 99th=519205 max=573883
        117     0               X       X       X
        elapsed(s)=103 requests/s=130 [error=0] cumulative requests/client=1055 [error=0] cumulative requests/s=109
        per-client requests. min=0 median=14 avg=13 max=21
        latency (usec). requests=130 min=2146 10th=17234 50th=55543 80th=91138 90th=257980 99th=472385 max=495750
        130     0               X       X       X
        elapsed(s)=104 requests/s=130 [error=0] cumulative requests/client=1068 [error=0] cumulative requests/s=110
        per-client requests. min=0 median=15 avg=13 max=22
        latency (usec). requests=130 min=1042 10th=10923 50th=46292 80th=77435 90th=119460 99th=440792 max=491305
        130     0               X       X       X
        elapsed(s)=105 requests/s=109 [error=0] cumulative requests/client=1078 [error=0] cumulative requests/s=109
        per-client requests. min=0 median=11 avg=10 max=20
        latency (usec). requests=109 min=1060 10th=17650 50th=60395 80th=80463 90th=104822 99th=317767 max=333323
        109     0               X       X       X

- block 미적용 case 01

        elapsed(s)=100 requests/s=123 [error=0] cumulative requests/client=1026 [error=0] cumulative requests/s=109
        per-client requests. min=8 median=12 avg=12 max=17
        latency (usec). requests=123 min=1727 10th=11035 50th=60175 80th=108808 90th=125495 99th=544507 max=594854
        123     0               X       X       X
        elapsed(s)=101 requests/s=119 [error=0] cumulative requests/client=1037 [error=0] cumulative requests/s=109
        per-client requests. min=6 median=12 avg=11 max=18
        latency (usec). requests=119 min=655 10th=14146 50th=57488 80th=86111 90th=292517 99th=509066 max=529186
        119     0               X       X       X
        elapsed(s)=102 requests/s=126 [error=0] cumulative requests/client=1050 [error=0] cumulative requests/s=109
        per-client requests. min=3 median=15 avg=12 max=17
        latency (usec). requests=126 min=2261 10th=11659 50th=52491 80th=83416 90th=118473 99th=333824 max=457619
        126     0               X       X       X
        elapsed(s)=103 requests/s=119 [error=0] cumulative requests/client=1062 [error=0] cumulative requests/s=109
        per-client requests. min=5 median=11 avg=11 max=19
        latency (usec). requests=119 min=2877 10th=9364 50th=51609 80th=79589 90th=238405 99th=493989 max=966114
        119     0               X       X       X
        elapsed(s)=104 requests/s=125 [error=0] cumulative requests/client=1074 [error=0] cumulative requests/s=109
        per-client requests. min=2 median=12 avg=12 max=29
        latency (usec). requests=125 min=1708 10th=5977 50th=45920 80th=79568 90th=235078 99th=491928 max=520654
        125     0               X       X       X
        elapsed(s)=105 requests/s=122 [error=0] cumulative requests/client=1087 [error=0] cumulative requests/s=109
        per-client requests. min=8 median=13 avg=12 max=20
        latency (usec). requests=122 min=945 10th=13622 50th=58454 80th=111620 90th=278248 99th=512912 max=548776
        122     0               X       X       X

- block 적용 case 02

        elapsed(s)=100 requests/s=5887 [error=0] cumulative requests/client=48872 [error=0] cumulative requests/s=5749
        per-client requests. min=540 median=569 avg=588 max=717
        latency (usec). requests=5887 min=249 10th=770 50th=1589 80th=2234 90th=2664 99th=4549 max=9394
        5887    0               X       X       X
        elapsed(s)=101 requests/s=5890 [error=0] cumulative requests/client=49461 [error=0] cumulative requests/s=5756
        per-client requests. min=550 median=569 avg=589 max=695
        latency (usec). requests=5890 min=254 10th=788 50th=1592 80th=2236 90th=2701 99th=4339 max=8176
        5890    0               X       X       X
        elapsed(s)=102 requests/s=5939 [error=0] cumulative requests/client=50055 [error=0] cumulative requests/s=5765
        per-client requests. min=540 median=572 avg=593 max=718
        latency (usec). requests=5939 min=255 10th=783 50th=1576 80th=2241 90th=2686 99th=4409 max=7555
        5939    0               X       X       X
        elapsed(s)=103 requests/s=5817 [error=0] cumulative requests/client=50637 [error=0] cumulative requests/s=5767
        per-client requests. min=537 median=566 avg=581 max=671
        latency (usec). requests=5817 min=275 10th=802 50th=1619 80th=2294 90th=2735 99th=4064 max=7318
        5817    0               X       X       X
        elapsed(s)=104 requests/s=5759 [error=0] cumulative requests/client=51213 [error=0] cumulative requests/s=5766
        per-client requests. min=530 median=560 avg=575 max=688
        latency (usec). requests=5759 min=281 10th=817 50th=1615 80th=2275 90th=2721 99th=4327 max=20487
        5759    0               X       X       X
        elapsed(s)=105 requests/s=5659 [error=0] cumulative requests/client=51779 [error=0] cumulative requests/s=5760
        per-client requests. min=523 median=537 avg=565 max=700
        latency (usec). requests=5659 min=286 10th=809 50th=1638 80th=2298 90th=2738 99th=4621 max=13705
        5659    0               X       X       X

- block 미적용 case 02

        elapsed(s)=100 requests/s=5859 [error=0] cumulative requests/client=49298 [error=0] cumulative requests/s=5807
        per-client requests. min=547 median=564 avg=585 max=702
        latency (usec). requests=5859 min=284 10th=790 50th=1588 80th=2252 90th=2706 99th=4180 max=11750
        5859    0               X       X       X
        elapsed(s)=101 requests/s=5900 [error=0] cumulative requests/client=49888 [error=0] cumulative requests/s=5811
        per-client requests. min=546 median=567 avg=590 max=708
        latency (usec). requests=5900 min=278 10th=776 50th=1585 80th=2216 90th=2663 99th=4199 max=12179
        5900    0               X       X       X
        elapsed(s)=102 requests/s=5928 [error=0] cumulative requests/client=50480 [error=0] cumulative requests/s=5816
        per-client requests. min=550 median=580 avg=592 max=712
        latency (usec). requests=5928 min=306 10th=774 50th=1580 80th=2190 90th=2578 99th=4322 max=40840
        5928    0               X       X       X
        elapsed(s)=103 requests/s=5680 [error=0] cumulative requests/client=51048 [error=0] cumulative requests/s=5809
        per-client requests. min=511 median=552 avg=568 max=673
        latency (usec). requests=5680 min=261 10th=831 50th=1640 80th=2320 90th=2763 99th=4522 max=11259
        5680    0               X       X       X
        elapsed(s)=104 requests/s=5699 [error=0] cumulative requests/client=51618 [error=0] cumulative requests/s=5803
        per-client requests. min=533 median=544 avg=569 max=692
        latency (usec). requests=5699 min=260 10th=821 50th=1615 80th=2293 90th=2740 99th=4511 max=12956
        5699    0               X       X       X
        elapsed(s)=105 requests/s=5985 [error=0] cumulative requests/client=52217 [error=0] cumulative requests/s=5812
        per-client requests. min=549 median=576 avg=598 max=722
        latency (usec). requests=5985 min=266 10th=768 50th=1564 80th=2228 90th=2664 99th=4243 max=10928
        5985    0               X       X       X

- block 적용 case 03

        elapsed(s)=100 requests/s=150 [error=0] cumulative requests/client=1289 [error=0] cumulative requests/s=138
        per-client requests. min=0 median=16 avg=15 max=22
        latency (usec). requests=150 min=460 10th=13228 50th=45582 80th=65628 90th=100064 99th=321255 max=478550
        150     0               X       X       X
        elapsed(s)=101 requests/s=146 [error=0] cumulative requests/client=1303 [error=0] cumulative requests/s=138
        per-client requests. min=0 median=18 avg=14 max=25
        latency (usec). requests=146 min=1745 10th=9188 50th=37823 80th=65171 90th=90182 99th=499199 max=520456
        146     0               X       X       X
        elapsed(s)=102 requests/s=151 [error=0] cumulative requests/client=1318 [error=0] cumulative requests/s=138
        per-client requests. min=0 median=15 avg=15 max=27
        latency (usec). requests=151 min=2146 10th=13448 50th=44892 80th=70252 90th=82869 99th=491387 max=514189
        151     0               X       X       X
        elapsed(s)=103 requests/s=146 [error=0] cumulative requests/client=1333 [error=0] cumulative requests/s=138
        per-client requests. min=0 median=16 avg=14 max=26
        latency (usec). requests=146 min=3116 10th=11892 50th=40859 80th=60300 90th=95402 99th=290822 max=331018
        146     0               X       X       X
        elapsed(s)=104 requests/s=164 [error=0] cumulative requests/client=1349 [error=0] cumulative requests/s=139
        per-client requests. min=0 median=16 avg=16 max=30
        latency (usec). requests=164 min=1578 10th=10398 50th=41092 80th=60747 90th=86422 99th=488011 max=522804
        164     0               X       X       X
        elapsed(s)=105 requests/s=157 [error=0] cumulative requests/client=1365 [error=0] cumulative requests/s=139
        per-client requests. min=0 median=19 avg=15 max=29
        latency (usec). requests=157 min=516 10th=7255 50th=41104 80th=63272 90th=83630 99th=459993 max=490856
        157     0               X       X       X


- block 미적용 case 03

        elapsed(s)=100 requests/s=138 [error=0] cumulative requests/client=1296 [error=0] cumulative requests/s=139
        per-client requests. min=2 median=16 avg=13 max=24
        latency (usec). requests=138 min=1536 10th=11693 50th=45298 80th=76752 90th=236348 99th=489199 max=526493
        138     0               X       X       X
        elapsed(s)=101 requests/s=170 [error=0] cumulative requests/client=1313 [error=0] cumulative requests/s=140
        per-client requests. min=4 median=19 avg=17 max=26
        latency (usec). requests=170 min=484 10th=10531 50th=38268 80th=70614 90th=110063 99th=473082 max=503845
        170     0               X       X       X
        elapsed(s)=102 requests/s=157 [error=0] cumulative requests/client=1329 [error=0] cumulative requests/s=140
        per-client requests. min=6 median=16 avg=15 max=28
        latency (usec). requests=157 min=919 10th=8349 50th=39185 80th=76192 90th=104279 99th=492046 max=724290
        157     0               X       X       X
        elapsed(s)=103 requests/s=147 [error=0] cumulative requests/client=1344 [error=0] cumulative requests/s=140
        per-client requests. min=8 median=15 avg=14 max=20
        latency (usec). requests=147 min=2504 10th=11763 50th=42843 80th=75419 90th=221258 99th=497883 max=516796
        147     0               X       X       X
        elapsed(s)=104 requests/s=156 [error=0] cumulative requests/client=1359 [error=0] cumulative requests/s=140
        per-client requests. min=7 median=16 avg=15 max=28
        latency (usec). requests=156 min=1681 10th=8842 50th=40370 80th=62583 90th=90234 99th=499427 max=499476
        156     0               X       X       X
        elapsed(s)=105 requests/s=124 [error=0] cumulative requests/client=1372 [error=0] cumulative requests/s=139
        per-client requests. min=9 median=12 avg=12 max=17
        latency (usec). requests=124 min=1103 10th=13750 50th=45291 80th=84127 90th=248089 99th=475648 max=509239
        124     0               X       X       X

- block 적용 case 04

        elapsed(s)=100 requests/s=18474 [error=0] cumulative requests/client=180745 [error=0] cumulative requests/s=18288
        per-client requests. min=1802 median=1832 avg=1847 max=1974
        latency (usec). requests=18474 min=231 10th=374 50th=510 80th=647 90th=749 99th=1050 max=3028
        18474   0               X       X       X
        elapsed(s)=101 requests/s=18418 [error=0] cumulative requests/client=182587 [error=0] cumulative requests/s=18294
        per-client requests. min=1780 median=1819 avg=1841 max=1950
        latency (usec). requests=18418 min=228 10th=369 50th=508 80th=654 90th=755 99th=1100 max=2646
        18418   0               X       X       X
        elapsed(s)=102 requests/s=18118 [error=0] cumulative requests/client=184399 [error=0] cumulative requests/s=18285
        per-client requests. min=1768 median=1800 avg=1811 max=1945
        latency (usec). requests=18118 min=211 10th=379 50th=518 80th=662 90th=761 99th=1097 max=10023
        18118   0               X       X       X
        elapsed(s)=103 requests/s=18141 [error=0] cumulative requests/client=186213 [error=0] cumulative requests/s=18277
        per-client requests. min=1771 median=1806 avg=1814 max=1915
        latency (usec). requests=18141 min=228 10th=377 50th=512 80th=656 90th=760 99th=1092 max=7144
        18141   0               X       X       X
        elapsed(s)=104 requests/s=18387 [error=0] cumulative requests/client=188051 [error=0] cumulative requests/s=18282
        per-client requests. min=1768 median=1801 avg=1838 max=2001
        latency (usec). requests=18387 min=237 10th=378 50th=513 80th=649 90th=745 99th=1032 max=4538
        18387   0               X       X       X
        elapsed(s)=105 requests/s=18041 [error=0] cumulative requests/client=189855 [error=0] cumulative requests/s=18269
        per-client requests. min=1769 median=1795 avg=1804 max=1895
        latency (usec). requests=18041 min=221 10th=379 50th=519 80th=669 90th=773 99th=1078 max=4492
        18041   0               X       X       X


- block 미적용 case 04

        elapsed(s)=100 requests/s=16297 [error=0] cumulative requests/client=163198 [error=0] cumulative requests/s=16631
        per-client requests. min=1508 median=1568 avg=1629 max=1942
        latency (usec). requests=16297 min=219 10th=387 50th=563 80th=763 90th=905 99th=1351 max=2600
        16297   0               X       X       X
        elapsed(s)=101 requests/s=16670 [error=0] cumulative requests/client=164865 [error=0] cumulative requests/s=16632
        per-client requests. min=1554 median=1612 avg=1667 max=1959
        latency (usec). requests=16670 min=221 10th=386 50th=552 80th=741 90th=869 99th=1314 max=3565
        16670   0               X       X       X
        elapsed(s)=102 requests/s=16394 [error=0] cumulative requests/client=166504 [error=0] cumulative requests/s=16620
        per-client requests. min=1535 median=1583 avg=1639 max=1956
        latency (usec). requests=16394 min=222 10th=392 50th=558 80th=750 90th=889 99th=1317 max=4911
        16394   0               X       X       X
        elapsed(s)=103 requests/s=16951 [error=0] cumulative requests/client=168200 [error=0] cumulative requests/s=16636
        per-client requests. min=1577 median=1616 avg=1695 max=2024
        latency (usec). requests=16951 min=208 10th=381 50th=542 80th=723 90th=859 99th=1337 max=2874
        16951   0               X       X       X
        elapsed(s)=104 requests/s=16949 [error=0] cumulative requests/client=169894 [error=0] cumulative requests/s=16651
        per-client requests. min=1568 median=1623 avg=1694 max=2056
        latency (usec). requests=16949 min=210 10th=384 50th=547 80th=724 90th=851 99th=1268 max=2815
        16949   0               X       X       X
        elapsed(s)=105 requests/s=17060 [error=0] cumulative requests/client=171600 [error=0] cumulative requests/s=16671
        per-client requests. min=1605 median=1652 avg=1706 max=2026
        latency (usec). requests=17060 min=216 10th=389 50th=544 80th=710 90th=830 99th=1263 max=2920
        17060   0               X       X       X
