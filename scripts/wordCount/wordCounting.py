import array

tablist = [tablist.rstrip('\n').lower() for tablist in open('table_list.txt','r')]

with open('sql_scripts.txt', 'r') as f:
  text = f.read()    
  words = text.replace(',', ' ').replace('.',' ').replace(';',' ').split()

  dic = {}
  for w in words:
    if w.lower() in tablist:
      if w in dic:
        dic[w] += 1
      else:
        dic[w] = 1

  lst = sorted(dic.items(), key=lambda kv: kv[1], reverse=True)
  for w, c in lst[:3000]:
    print(w, c)


