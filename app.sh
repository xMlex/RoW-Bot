#!/usr/bin/env bash
java -server -Dfile.encoding=UTF-8 -Xms16m -Xmx32m \
    -cp ./target/*-jar-with-dependencies.jar ru.xmlex.Server
