import glob

d = {}

for key_word in open("key-phrases"):
    key_word = key_word.rstrip()
    d[key_word] = {}



f = glob.glob("*txt")
for x in f:
    for line in open(x):
        for key_word in d:
            if key_word in line:
                d[key_word][x] = d[key_word].get(x, 0) + 1

list_journals = []
for x in f:
    list_journals.append(x)
l = sorted(list_journals)

fp = open('summary.tsv', 'w')
for x in l:
    fp.write('\t%s' % x)
fp.write('\n')


for k in d:
    fp.write('%s\t' % k)
    for j in l:
        if d[k].has_key(j):
            fp.write('%s\t' % d[k][j])
        else:
            fp.write('0\t')
    fp.write('\n')
