#!/bin/bash
dd if=/dev/urandom of=./file_$(date '+%Y%m%d%H%M')  bs=1M count=10
if [ $? -eq 0 ]; then
	rsync -avz --delete -e "ssh -p 22" ./file_* devtest1@vm2-dos-linux:/home/devtest1/lesson2/
fi
retval=$?
if [ $retval -eq 0 ]; then
	rm /home/devtest1/lesson2/file_*
fi
ssh devtest1@vm2-dos-linux "find /home/devtest1/lesson2/ -name 'file_*' -mtime 7 -exec rm -f {} \;"
