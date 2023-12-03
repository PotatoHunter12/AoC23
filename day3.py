import re
from collections import defaultdict

lines = [line.strip()+"." for line in open("Input/input3.txt")]
[lines.insert(x,"."*142) for x in (0,142)]

partsum = 0
zvezdice = defaultdict(list)

for n,line in enumerate(lines):
    for x in re.finditer("\\d+",line):
        stvari = [(lines[i][j], i, j) for i in range(n - 1, n + 2) for j in range(x.start() - 1, x.end() + 1) if lines[i][j] not in "1234567890."]
        partsum += int(x.group(0))*bool(stvari)
        [zvezdice[z[1],z[2]].append(int(x.group(0))) for z in stvari if z[0]=="*"]    
print("Answer 1:", partsum)
print("Answer 2:", sum(n[0] * n[1] for n in zvezdice.values() if len(n) == 2))
