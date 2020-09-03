DOCKER_NETWORK = docker-hadoop-calmar_default
ENV_FILE = hadoop.env
current_branch := $(shell git rev-parse --abbrev-ref HEAD)
build:
	docker build -t calvalusmarine/hadoop-base:$(current_branch) ./base
	docker build -t calvalusmarine/calvalus-base:$(current_branch) ./calvalus-base
	docker build -t calvalusmarine/hadoop-namenode:$(current_branch) ./namenode
	docker build -t calvalusmarine/hadoop-datanode:$(current_branch) ./datanode
	docker build -t calvalusmarine/hadoop-resourcemanager:$(current_branch) ./resourcemanager
	docker build -t calvalusmarine/hadoop-nodemanager:$(current_branch) ./nodemanager
	docker build -t calvalusmarine/hadoop-historyserver:$(current_branch) ./historyserver
	docker build -t calvalusmarine/hadoop-submit:$(current_branch) ./submit
	docker build -t calvalusmarine/calvalus-portal:$(current_branch) ./calvalus-portal

wordcount:
	docker build -t hadoop-wordcount ./submit
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} calvalusmarine/hadoop-base:$(current_branch) hdfs dfs -mkdir -p /input/
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} calvalusmarine/hadoop-base:$(current_branch) hdfs dfs -copyFromLocal -f /opt/hadoop-3.2.1/README.txt /input/
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} hadoop-wordcount
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} calvalusmarine/hadoop-base:$(current_branch) hdfs dfs -cat /output/*
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} calvalusmarine/hadoop-base:$(current_branch) hdfs dfs -rm -r /output
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} calvalusmarine/hadoop-base:$(current_branch) hdfs dfs -rm -r /input
