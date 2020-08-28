关于status显示错误问题，项目地址书写为  
```
	location /status {
            healthcheck_status json;
        } 
发现报错：[ngx-healthcheck][status-interface] peers == NULL 
经验证 此处写法为
	location /stat {
		check_status json;（可以不指定json）
	}
Syntax: check_status [html|csv|json]
Default: check_status html
Context: location
```
直接访问 ip/stat 就是json，也可以配置上不指定，url上指定 格式为  
> /status?format=html  
/status?format=csv  
/status?format=json  


也可以加上状态    
>/status?format=html&status=down  
/status?format=csv&status=up  

参考地址：https://www.cnblogs.com/rainy-shurun/p/5416160.html  
```
docker run \
	--name nginx-1 \
	--ulimit nproc=1048576:1048576 \
	--ulimit nofile=1048576:1048576 \
	-p 443:443 \
	-p 80:80 \
	-v /hdd1/nginx:/nginx
	images
```
