#!/bin/bash
CURRENT_DIR=$(dirname $(readlink -f $0))
cd $CURRENT_DIR
java -server -Xms32m -Xmx64m -cp $CURRENT_DIR/lib/*: ru.xmlex.Server