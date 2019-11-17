"""
Compute ΔP for each type of the A as NP construction and append
the resuls to the Russian_coll_anal.csv file as a new column.
"""

import csv

path = "D:/Russian files/" #specify your directory with English_coll_anal.csv
m = open(path + "Russian_coll_anal.csv")
new_file = [line for line in csv.reader(m, delimiter='\t')]

slot1_slot2 = []
slot2_slot1 = []
for line in new_file[1:]:
	a = float(line[4])
	b = float(line[2]) - a
	c = float(line[3]) - a
	d = 2586 - (float(line[2]) + float(line[3]))
	formula = (a / (a + c)) - (b / (b + d))
	formula1 = str("{0:.4f}".format(formula))
	slot1_slot2.append(formula1)
	formula2 = (a / (a + b)) - (c / (c + d))
	formula22 = str("{0:.4f}".format(formula2))
	slot2_slot1.append((formula22))

slot1_slot2.insert(0, 'slot1_slot2')
slot2_slot1.insert(0, 'slot2_slot1')

slot1_slot2 = [float(i) for i in slot1_slot2[1:]]
slot2_slot1 = [float(i) for i in slot2_slot1[1:]]

delta_p = [str('{0:.4f}'.format(i)) for i in list(map(lambda x, y: x - y, slot2_slot1, slot1_slot2))]
delta_p.insert(0, 'delta_p')

#appeding the calculated delta p results to the origial file Russian_coll_anal.csv
new_data = []
for i, item in enumerate(new_file):
    try:
        item.append(delta_p[i])
    except IndexError:
        item.append('placeholder')
    new_data.append(item)

k = open(path + "Russian_coll_anal.csv", "w", newline='')
csv.writer(k, delimiter='\t').writerows(new_data)

m.close()