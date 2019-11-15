"""
Parse the raw Russian data into two columns WORD_SLOT1 and WORD_SLOT2
where the former contains the adjectives and the latter - the NPs.
"""

import csv

#specify your directory containing the file
f = open("D:/Russian files/Russian_corpus_extracted_and_filtered.csv")
csv_f = csv.reader(f)

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
    as_index = phrase.index('как')
    if as_index == 0 and phrase[1] == 'пламя':
        adj.append(phrase[3])
        np.append(phrase[1])
    elif as_index == 0 and phrase[1] == 'вода':
        adj.append(phrase[2:])
        np.append(phrase[1])
    elif as_index == 0 and phrase[1] == 'земля':
        adj.append(phrase[3])
        np.append(phrase[1])
    elif as_index == 0 and phrase[1] == 'голубь':
        adj.append(phrase[2])
        np.append(phrase[1])
    else:
        wanted_items = phrase[:as_index]
        adj.append(wanted_items)
        wanted_items1 = phrase[as_index+1:]
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
with open('D:/Russian files/Russian.csv', 'w', newline='') as f:
	writer = csv.writer(f, delimiter='\t')
	writer.writerows(zip(adj_concanten, np_concanten))

f.close()
