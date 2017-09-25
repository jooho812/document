- kazoo모듈을 통해 zookeeper에 접속하여 노드정보들을 수집하고
	optionParser 이용해서 명령어 옵션에 따른 처리
- 변경해야할 값 설정
	- HOME_DIR -> arcus홈

	- USER ->

	- -f('')
		- 실행 -f [file_name]
		- 주키퍼address가 적혀있는 파일을 읽어옴
		- 형식
		- --vpn_remap 줄경우
    		- remap에 해당하는 파일을 읽어들여서 호스트명에 해당하는 ip를 remapping하여 주키퍼에 접속
		- --vpn_remap 없을경우
    		- ip:port 형태의 line을 읽어들임
		- ex)

		         127.0.0.1:9181   or
		         jam2in-m001:9181 (remap 옵션과 함께 적용)
	- -a('')
		- 실행 -a [zookeeper address]
		- -f 옵션을 사용하지 않을경우 직접 zookeeper의 주소정보를 줄 수 있다.

	- s('')
		- 실행 -s [service_code]
		- /arcus/cache_list 내의 service코드에 해당하는 목록

	- -n('')
		- 실행 -n [ip]
		- /arcus/cache_server_mapping 내의 ip에 해당하는 목록을 가져온다.
		- output **[ ip:port-(service_code) ]**

		         [127.0.0.1:11288-(ngrinder)]
		         [127.0.0.1:11212-(test)]

	- vpn_remap('')
		- 실행 --vpn_remap [ mapping_file_name ]
		- map형태로 저장된 파일을 읽어서 처리 (ex 호스트명 -> reamping ip(호스트파일참조할 ip):port )
		- ex)

		         jam2inServer1 1.255.51.181:2181
		         jam2inServer2 1.255.51.181:5181

	- all_node(false)
		- 실행 --all_node
		- -n 옵션을 함께 줄경우 -n [ip] 에 해당하는 노드들만 가져옴
		- output **[ ip:port-(domain) ]**

		         [127.0.0.1:11211-(localhost)]
		         [1.255.51.181:15211-(jam2in-m001)]
	- all_server(false)
		- 실행 --all_server
		- /arcus/cache_list 내의 service_code를 가져오고 -n 옵션을 같이 줄 경우 service_code내의 -n [ip] 에 해당하는 server 정보만 가져온다.
		- output **[ ip:port:* ]**

		         [1.255.51.181:*]
			     [127.0.0.1:*]

	- -t(200) timeout/1000

 ----------------------------------------------------------------------------------------------------------------------------
 ----------------------------------------------------------------------------------------------------------------------------

	- -i(false)
		- 실행 -i
		- -s, -n 옵션이 있는경우
 		- -s -n 옵션통해 가져온 list들에 한해서 do_ssh_command로 해당 ip에 접속해 free 정보와 각각 노드들에 stats 명령어를 통해 해당 노드의 정보들을 가져온다.
 		-  output

		         [127.0.0.1] system memory
			     total       used       free     shared    buffers     cached
				 Mem:      16269264   15101500    1167764      18784     401052   10136032
				 -/+ buffers/cache:    4564416   11704848
				 Swap:            0          0          0
                 [127.0.0.1:11211-(test)]                MEM: (0/100) 0.000153%, CONN: (2/1000)
                 [127.0.0.1:11212-(test)]                MEM: (0/100) 0.000153%, CONN: (1/1000)
                 [127.0.0.1:11288-(ngrinder)]            MEM: (0/100) 0.000153%, CONN: (1/1000)
                 [127.0.0.1:11289-(ngrinder)]            MEM: (0/100) 0.000153%, CONN: (1/1000)
                 [127.0.0.1:11298-(py_cli)]              MEM: (0/100) 0.000153%, CONN: (1/1000)
                 [127.0.0.1:11299-(py_cli)]              MEM: (0/100) 0.000153%, CONN: (1/1000)
                 TOTAL MEM: (0/600) 0.000153%
		- -s, -n 옵션이 없는경우
			- zookeeper에 접속해 /arcus/cache_list에 있는 service_code에 해당하는 노드들의 메모리정보를 보여준다.
			- output

				  ## jam2in-m001:5181
				  [ngrinder] 1 instances, 4096M memory
                  ## jam2in-m001:9181
                  [test] 2 instances, 200M memory
                  [ngrinder] 2 instances, 200M memory
                  [py_cli] 2 instances, 200M memory
                  TOTAL 7 instances, 4696M memory

	- -c('')
		- 실행 -c [command]
		- telnet통해 선택된 노드에게 명령어를 날린다. 대기시간은 -t로 지정한만큼대기

	- ssh_command_file('')
		- 실행 --ssh_command_file [file_name]
		- ssh_command에 file의 내용을 전달
		- ssh_command 자동화 하기 위해서 쓰이는 것 같음

	- -x('')
		- 실행 -x [execute command]
		- 해당 ip에 [execute command]를 실행

	- -p
		- 실행 -p [prefix_name || all]
		- output에 [ip:port-(service_code)] 형태로 보여지는 경우에만 잘 나타남
		- output

			  [Total]
			  PREFIX arcus       itm      12 kitm      12 litm       0 sitm       0 bitm       0
                     tsz    960 ktsz     960 ltsz       0 stsz       0 btsz       0

			  PREFIX arcus       get  308896 hit  308896 set  784058 del       0 inc       0 dec       0
				     lcs       0 lis  308896 lih  308896 lds  308896 ldh  308896 lgs  308896 lgh  308896
				     scs       0 sis  308896 sih  308896 sds  308896 sdh  308896 sgs       0 sgh       0 ses  308896 seh  308896
				     bcs       0 bis  308896 bih  308896 bus       0 buh       0 bds  308896 bdh  308896
                     bps       0 bph       0 bms       0 bmh       0 bgs  308896 bgh  308896 bns       0 bnh       0
                     pfs       0 pfh       0 pgs       0 pgh       0
				     gps       0 gph       0 gas       0 sas       0

	- dump_script(false)
		- 실행 --dump_script
		- 생성파일 start_mem_[service_code].sh
		- 각 service코드들의 노드들을 실행스크립트로 만드는 것을 목적으로 만든 것 같음 실행전에 arcus_cmd.py 의 맨윗줄에 HOME_DIR과 USER를 세팅해줘야 함
		- ssh 접속을 통해 해당 ip에 해당하는 service_code들을 가져오는데 현재 ssh접속도 문제가 있어보이고 서비스코드별로 최종노드 1개에 해당하는 것만 스크립트화 되는 걸로 보여짐.
		- output에 [ip:port-(service_code)]형태로 보여지는 경우에만 잘 나타나고 [ip:port-(domain)]형태등으로 나타나는 경우에는 service_code별로 스크립트가 나눠지지 않음

### 추가 기능 생각해보기
- 살아있는 노드수 / 총 노드수 
- 주키퍼내에 서비스코드에 등록되어 있는데 죽어있는 노드 정보 불러오기
- 서비스코드에 해당하는 노드들의 프로세스 stop/start

