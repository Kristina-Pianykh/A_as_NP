import re
import nltk

# with open(r'C:\Users\krist\YandexDisk\FSU Studium\Python\Course\Session2\Blake_London.txt', 'r', encoding='utf8') as input:
# 	walrus = input.read()

with open(r'C:\Users\krist\YandexDisk\FSU Studium\Python\Course\Session2\w_acad_1996_clean.txt', 'r', encoding='utf8') as fobj:
	raw = fobj.read()
# raw2 = re.sub(r'thro\'', r'through', raw)
# print(raw2)

# with open(r'C:\Users\krist\YandexDisk\FSU Studium\Python\Course\Session2\Blake_London1.txt', 'w', encoding='utf8') as output:
# 	output.write(raw2)

string = 'I am the smartest cat in the world'
print(string[-1])

def splitter(i):
	a = i.split(' ')
	c = []
	for item in i:
		if "'" in item:
			split_item = [i for i in item.split("'")]
			c.append(split_item)
	b = len(a)
	c = [y for x in c for y in x]
	c1 = len(c) * 2
	# length_c = sum(c1)
	return b + c1

from nltk.tokenize import word_tokenize
print(len(word_tokenize(raw)))
print()
print(len(re.findall('\w+', raw)))
print()
print(splitter(raw))


[item ]


# from nltk.tokenize import word_tokenize
# walrus_toks = word_tokenize(walrus)
# walrus_toks = walrus_toks[2:]
# # print(walrus_toks)
# walrus_pos = ' '.join(['_'.join(list(w)) for w in nltk.pos_tag(walrus_toks)])
# print(walrus_pos)

# with open(r'C:\Users\krist\YandexDisk\FSU Studium\Python\Course\Session2\walrus_pos_tagged.txt', 'w', encoding='utf8') as output:
# 	output.write(walrus_pos)