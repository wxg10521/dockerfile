/usr/bin/docker run \
	--name 29unison \
	-p 222:222 \       
	-e SSHD_PORT="222" \
	-e SYNCIP="x.x.x.x" \
        -v /syncdir:/syncdir \
	images

双向同步 互为同步
