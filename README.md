# hashcat-scripts
Random Hashcat Scrips

# Fingercut
New script I added, combines dynamic expander and fingerprint attacks into one script

This Bash script automates the process of expanding a wordlist using the `hashcat-utils` `expander.bin` utility, followed by cutting and processing the expanded wordlist. Below is an overview of its functionality:

### Features

1. **Input Validation**: 
   - The script checks if a valid input wordlist file is provided.
   - If the file does not exist or is missing, the script aborts with an error message.

2. **Wordlist Expansion**: 
   - The input wordlist is processed through `expander.bin`, generating variations for each word.
   - The expanded words are stored and appended to the original wordlist.

3. **Dynamic Length Calculation**: 
   - The script determines the length of the longest line in the updated wordlist.
   - The maximum length is capped at 16 characters to avoid overly large cuts.

4. **Cut Operations**: 
   - The wordlist is processed by cutting the first and last portions of each line, up to half the maximum line length.
   - For odd-length lines, the middle character is processed separately.

5. **Sorting and Uniqueness**: 
   - After the cut operations, the results are sorted and made unique to ensure clean output.
   - The final output is saved to a specified file.

6. **Runtime Calculation**: 
   - The script logs the start and end times of the operation.
   - It provides a human-readable summary of the total runtime in hours, minutes, and seconds.

### Usage Example

```bash
./fingercut.sh <input_wordlist>
```

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

for i in $(seq 1 30); do ./hashcat.bin ../ntlm.hash -m 1000 --show  | cut -d: -f2- | /opt/utils/hashcat-utils/src/expander.bin | sort -u > cand.exp; ./hashcat.bin ../ntlm.hash -m 1000 -a 1 cand.exp cand.exp -O; done

## Prince Fingerprint
cut -d: -f2- < ~/.hashcat/hashcat.potfile | sort -u | ~/hashcat-utils/src/expander.bin | sort -u | ~/princeprocessor/pp64.bin | ~/princeprocessor/pp64.bin | hashcat -m1000 ntds.ntds

## Prince Grind - Cutb
for i in $(seq 1 50); do ./hashcat.bin ../ntlm.hash -m 1000 --show | cut -d: -f2- | sort -u > cand.lst; shuf cand.lst | /opt/utils/princeprocessor/src/pp64.bin | ./hashcat.bin ../ntlm.hash -m 1000 -a 0 -O -g 100000; done

## Expander Rockyou generate
expander.bin < rockyou.txt | sort -u > rockyou.exp; for i in $(seq 1 200); do shuf rockyou.exp | ./hashcat.bin -m 1000 -O -w3 ntds.dit -g 100000; done

