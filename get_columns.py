file = "col_names.dcf"

with open(file, "r") as f:
    raw = f.readlines()
    f.close()

print(raw[:20])
labels = []
for line in range(0,len(raw)):
    if raw[line] == "[Item]\n":
        labels.append(raw[line+1])

with open("labels.txt", "w+") as wf:
    wf.writelines(labels)
    wf.close()