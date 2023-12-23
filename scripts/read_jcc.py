import re

jcc_file = 'scripts/jcc-list.txt'
jcg_file = 'scripts/jcg-list.txt'
ku_file = 'scripts/ku-list.txt'

jcc_out_file = 'scripts/jcc.csv'

pat = re.compile(r'^([0-9]{4,})\s+(\w+)\s+(\w+)')

out_list = []

with open(jcc_file, encoding='utf-8', mode='r') as f:
    lines = f.readlines()
    for l in lines:
        l = l.strip()
        res1 = re.search(r'^[*|0-9]', l)
        if not res1:
            # tdfk
            tdfk_code = re.sub(r'\s', r'', l)
        else:
            jcc_code = re.sub(r'^\* ', r'', l, 1)
            jcc_code = jcc_code.strip()
        
        res2 = re.findall(pat, l)
        if res2:
            code, name, kanji = res2[0]
            out_list.append([tdfk_code, code, name, kanji])

with open(jcc_out_file, 'w') as of:
    for item in out_list:
        if len(item) > 0:
            of.write(f'{item[0][:-2]},{item[1]},{item[2]},{item[3]}\n')
            # print(item[0][0])







