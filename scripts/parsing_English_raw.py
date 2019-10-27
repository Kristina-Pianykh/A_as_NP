import csv
import re

#specify your directory containing the file
f = open("D:/English files/English_corpus_extracted_and_filtered.csv")
csv_f = csv.reader(f)

s = open("D:/English files/for_coll_anal.csv")
csv_s = csv.reader(s, delimiter = '\t')

adj_orig = []
for line in csv_s:
    adj_orig.append(line[0])
    
np_orig = []
for line in csv_s:
    np_orig.append(line[1])

concatenated = []
for line in csv_f:
    concatenated.append(line[2])

new_file = []
for pair in concatenated:
    separated = pair.split()
    new_file.append(separated)

lower_case = [[j.lower() for j in i] for i in new_file]

adj = []
np = []
for phrase in lower_case:
    like_index = phrase.index('as')
    wanted_items = phrase[:like_index]
    adj.append(wanted_items)
    wanted_items1 = phrase[like_index+1:]
    np.append(wanted_items1)

adj_concanten = []
for i in adj:
    if len(i) > 1:
        adj_concanten.append(' '.join(i))
    else:
        for j in i:
            adj_concanten.append(j)
            
np_concanten = []
for i in np:
    if len(i) > 1:
        np_concanten.append(' '.join(i))
    else:
        for j in i:
            np_concanten.append(j)

adj_concanten.insert(0, 'WORD_SLOT1')
np_concanten.insert(0, 'WORD_SLOT2')

#specify the directory where the created file should be downloaded
with open('D:/English files/English.csv', 'w', newline='') as f:
	writer = csv.writer(f, delimiter='\t')
	writer.writerows(zip(adj_concanten, np_concanten))

f.close()
