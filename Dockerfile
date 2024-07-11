# 使用官方的Tomcat基础镜像
FROM tomcat:9.0-jre8

# 安装net-tools
RUN apt-get update && \
    apt-get install -y net-tools && \
    apt-get clean


# 将 auth.jar文件从主机复制到容器的某个目录
COPY auth.jar /usr/local/bin/

# 执行xxx.jar文件
RUN java -jar /usr/local/bin/auth.jar

# 将.war文件从主机复制到容器的Tomcat webapps目录
COPY hhwe-total-account.war /usr/local/tomcat/webapps/

# 复制配置文件到容器的相应目录
COPY log4j.properties /usr/local/system/hhwe-total-account/
COPY cas-server.properties /usr/local/system/
COPY redis.properties /usr/local/system/
COPY config.properties /usr/local/system/hhwe-total-account/
COPY jdbc.properties /usr/local/system/hhwe-total-account/

# 需要注意cas-sever中的casServerUrl_outAddress 不能缺失

# 启动Tomcat
CMD ["catalina.sh", "run"]

