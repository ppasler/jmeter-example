#!/usr/bin/env bash

JAVA="java"

# java fallback alias (example JAVA_CMD="/opt/jdk8/bin/java")
if command -v $JAVA; then
    echo "java exists"
else
    if command -v $JAVA_CMD; then
        echo "java not found. Set JAVA from variable JAVA_CMD (value ${JAVA_CMD})"
        JAVA="${JAVA_CMD}"
    else
        echo "Command ‘java' is missing and no working command for JAVA_CMD found";
        exit 1;
    fi
fi

jmeter_version="5.4.3"
jmeter_filename="apache-jmeter-${jmeter_version}"
jmeter_folder="apache-jmeter"
jmeter_url="https://archive.apache.org/dist/jmeter/binaries/${jmeter_filename}.tgz"

if [ -d ${jmeter_folder} ]; then
    echo "${jmeter_folder} exists"
else
    rm ${jmeter_folder}.*
    echo "${jmeter_folder} is missing. Downloading it now from ${jmeter_url}"
    wget "${jmeter_url}"
    tar -xzf "${jmeter_filename}.tgz"
    mv ${jmeter_filename} ${jmeter_folder}
fi

./${jmeter_folder}/bin/jmeter.sh --version
