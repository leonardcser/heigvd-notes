import json

with open("output_alg.json") as f:
    data = json.load(f)


complexities = {
    "n*log": ("$O(n\\log(n))$", "cred"),
    "linear": ("$O(n)$", "corange"),
    "logarithmic": ("$O(\\log(n))$", "clime"),
    "constant": ("$O(1)$", "cgreen"),
}

for container in data:
    for f in data[container]["functions"]:
        c = f["complexity"].lower()
        for k, v in complexities.items():
            if k in c:
                f["c"] = v[0]
                f["color"] = v[1]
                break

with open("output_alg_2.json", "w") as f:
    json.dump(data, f, indent=2)
