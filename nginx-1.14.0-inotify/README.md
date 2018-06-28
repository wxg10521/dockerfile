docker run \
	--name nginx-1 \
	--ulimit nproc=1048576:1048576 \
	--ulimit nofile=1048576:1048576 \
	-p 443:443 \
	-p 80:80 \
	-v /hdd1/nginx:/nginx
	images
