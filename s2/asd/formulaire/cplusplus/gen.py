import json


def snake_to_capital(s):
    return s.replace("_", " ").title().strip()


def simplify_proto(proto):
    return (
        proto.replace("RandomAccessIterator", "RAIter")
        .replace("InputIterator", "InIter")
        .replace("OutputIterator", "OutIter")
        .replace("ForwardIterator", "FwIter")
        .replace("BidirectionalIterator", "BiIter")
        .replace("Predicate", "Pred")
        .replace("_type", "_t")
        .replace("iterator", "iter")
        .replace("reference", "ref")
        .replace("initializer_list", "init_list")
        .replace("position", "pos")
    )


with open("output_2.json") as f:
    data = json.load(f)

with open("output_alg_2.json") as f:
    data.update(json.load(f))


output = "\\setlength{\\fboxsep}{.5\\fboxsep}"

for i, (name, container) in enumerate(data.items()):
    # captilize the first letter
    par = f"{(i + 1)} {snake_to_capital(name)}"
    output += "\n\\sep\n"
    output += "\\addcontentsline{mtd}{section}{" + par + "}\n"
    output += "\\paragraph{" + par + "}\\mbox{}\\vspace{0.5em}\\\\\n"
    for j, f in enumerate(data[name]["functions"]):
        c = f["complexity"].replace("_", "\\_")
        num = f"{(i+1)}.{j+1:02d}"
        output += "\\noindent\\addcontentsline{mtd}{subsection}{" + num
        if "color" in f:
            output += (
                " \\textcolor{"
                + f["color"]
                + "}{\\texttt{"
                + f["method"].replace("_", "\\_")
                + "}}}\\boxed{"
                + num
                + "}\\hspace*{0.25em}\\lstinline[basicstyle=\\ttfamily\\color{"
                + f["color"]
                + "}]{"
            )
        else:
            output += (
                " \\texttt{"
                + f["method"].replace("_", "\\_")
                + "}}\\boxed{"
                + num
                + "}\\hspace*{0.25em}\\lstinline{"
            )

        proto = (
            f["prototype"]
            .replace("( ", "(")
            .replace(" )", ")")
            .replace(" (", "(")
            .replace(" )", ")")
        )
        proto = " ".join(proto.split())
        proto = ";\n".join(proto.split(";")).strip()
        output += simplify_proto(proto).replace("\n", " ") + "} "
        output += "\\textsc{Complexity} " + c
        if "validity" in f and f["validity"] and f["validity"] != "No changes.":
            v = f["validity"].replace("_", "\\_")
            output += " \\textsc{Validity} " + f["validity"].replace("_", "\\_")
        output += "\\\\\\vspace{-0.6em}\n\n"

with open("output.tex", "w") as f:
    f.write(output)
