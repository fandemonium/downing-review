import glob, string

d = {}
f = glob.glob("*txt")
for x in f:
    for line in open(x):
        line = line.translate(string.maketrans("",""), string.punctuation)
        for word in line.rstrip().split(' '):
            word = word.lower()
            try:
                word.decode('ascii')
                if set('[~ !@#$%^&*()_+{}":;\']+$').intersection(word):
                    continue
                if len(word) < 7:
                    continue
                else:
                    if d.has_key(word):
                        d[word][x] = d[word].get(x,0) + 1
                    else:
                        d[word] = {}
                        d[word][x] = 1
            except:
                continue

list_journals = []
for x in f:
    list_journals.append(x)
l = sorted(list_journals)

fp = open('summary_cum.tsv', 'w')
for x in l:
    fp.write('%s\t' % x)
fp.write('\n')


for k in d:
    fp.write('%s\t' % k)
    for j in l:
        if d[k].has_key(j):
            fp.write('%s\t' % d[k][j])
        else:
            fp.write('0\t')
    fp.write('\n')

