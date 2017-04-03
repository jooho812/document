- 테스트 환경

	- server : m001 장비 사용(./memcached -E .libs/default_engine.so -X .libs/syslog_logger.so -X .libs/ascii_scrub.so -d -v -r -R5 -U 0 -D: -b 8192 -m100 -p 11299 -c 1000 -t 6 -z 10.32.24.105:9181)
		- block 미적용 cache server : https://github.com/jam2in/arcus-memcached.git develop branch 사용
		- block 적용 cache server : https://github.com/jooho812/arcus-memcached.git jooho812/block_allocator branch 사용

	- client : m002 장비 사용(acp-java)
	- acp java 설정 (모든 테스트 동일한 설정으로 수행함)
        - client=20
        - rate=0
        - request=0
        - time=600
        - keyset_size=30
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
