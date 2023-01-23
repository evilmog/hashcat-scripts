# hashcat-scripts
Random Hashcat Scrips

# evilmogs random ad methodology
realistically I would go with the following approach:

1. run rockyou with -g 100000 or all the rulesets combined
2. run expander (modified to max at 8 or 10), and then run -a1
3. run cutb with -a1
4. run rockyou through princeprocessor and then pipe into hashcat with -g 100000
5. extract the plains from the potfile, pipe them through expander and cutb again, run the -a1 attack, then run the founds through princeprocessor with -g 100000
6. repeat step 5
7. run expanded dict through prince processor with -g 100000
8. run cutb through pp, same deal
9. repeat step 5
10. use PACK and generate masks
11. try other random rules
12. run rockyou through expander, run -a1
and then basically repeat
13. also pipe in the usernames into the above process
14. when using rules turn on debug mode and capture the rules
15. use cewl and crunch to generate a wordlist, repeat the above

# random snippits

## A1 Grind
```
or i in $(seq 1 30); do ./hashcat.bin ../ntlm.hash -m 1000 --show  | cut -d: -f2- | /opt/utils/hashcat-utils/src/expander.bin | sort -u > cand.exp; ./hashcat.bin ../ntlm.hash -m 1000 -a 1 cand.exp cand.exp -O; done
```
