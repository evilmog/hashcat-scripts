#!/bin/bash
for start in {1..100}; do

/opt/hashcat/hashcat –w 3 –m 1000 –a 0 /opt/hashes/hashlist /opt/wordlists/*.dict –g 100000 –debug-mode=4 –debug-file=/opt/debug/node1.$start.debug

done


cat /opt/debug/node1.*.debug | cut -d: -f2 | sort -u > /opt/rules/debug.rule
cat /opt/debug/node1.*.debug | cut -d: -f1 | sort -u > /opt/wordlists/debug.dict
cat /opt/debug/node1.*.debug | cut -d: -f3 | sort -u >> /opt/wordlists/debug.dict

/opt/hashcat/hashcat -w3 -m 1000 -a 0 /opt/hashes/hashlist /opt/wordlists/debug.dict -r /opt/rules/debug.rule
