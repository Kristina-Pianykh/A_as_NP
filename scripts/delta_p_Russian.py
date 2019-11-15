"""
Compute ΔP for each type of the A as NP construction and append
the resuls to the Russian_coll_anal.csv file as a new column.
"""

import csv

#specify your directory with Russian_coll_anal.csv
m = open("D:/Russian files/Russian_coll_anal.csv")
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

with open('D:/Russian files/intermediate_file.csv', 'w', newline='') as output:  #think how to calculate delta p without writing an extra file
	writer = csv.writer(output, delimiter='\t')
	writer.writerows(zip(slot2_slot1, slot1_slot2))
	
m.close()

l = open("D:/Russian files/intermediate_file.csv")
new_list = [line for line in csv.reader(l, delimiter='\t')]

for row in new_list[1:]:
    row[0] = float(row[0])
    row[1] = float(row[1])

def delta_pi(a):
	return [line[0] - line[1] for line in a]

all_diff_lists = []
all_diff_lists.append(delta_pi(new_list[1:]))
all_diff = [val for sublist in all_diff_lists for val in sublist]
all_diff_format = []
for item in all_diff:
	new_format = str("{0:.4f}".format(item))
	all_diff_format.append(new_format)

counter = 0
for row in new_list[1:]:
	row.append(all_diff_format[counter])
	counter += 1

delta_p = ['delta_p']
for i in new_list[1:]:
    delta_p.append(i[2])

#appeding the calculated delta p results to the origial file Russian_coll_anal.csv
new_data = []
for i, item in enumerate(new_file):
    try:
        item.append(delta_p[i])
    except IndexError:
        item.append('placeholder')
    new_data.append(item)

k = open("D:/Russian files/Russian_coll_anal.csv", "w", newline='')
csv.writer(k, delimiter='\t').writerows(new_data)

k.close()
l.close()
