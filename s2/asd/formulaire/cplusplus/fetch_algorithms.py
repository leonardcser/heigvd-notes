import json
from urllib.request import urlopen

from lxml import etree

base_url = "https://cplusplus.com"
containers = [
    base_url + "/reference/array/array",
    base_url + "/reference/vector/vector",
    base_url + "/reference/list/list",
    base_url + "/reference/forward_list/forward_list",
    base_url + "/reference/queue/queue",
    base_url + "/reference/stack/stack",
    base_url + "/reference/deque/deque",
    base_url + "/reference/map/map",
    base_url + "/reference/set/set",
    base_url + "/reference/unordered_map/unordered_map",
    base_url + "/reference/unordered_set/unordered_set",
]


def parse_to_text(el):
    if not el:
        return ""
    text = etree.tostring(el[0], method="text").decode("utf-8")
    lines = [l for l in text.split("\n") if l.strip()][1:]
    return "".join(lines).strip()


def get_html(url):
    html = urlopen(url).read().decode("utf-8")
    return etree.HTML(html)


html = get_html("https://cplusplus.com/reference/algorithm/")
functions = html.xpath('//*[@id="I_content"]/div[1]/dl[@class="links"]//a/@href')

data = {"url": "https://cplusplus.com/reference/algorithm/", "functions": []}
output = {"algorithm": data}
for function in functions:
    html = get_html(base_url + function)
    c_proto = html.xpath(
        '//*[@id="I_content"]/div[1]//div[@class="C_prototype"]//pre/text()'
    )[-1].strip()
    complexity = parse_to_text(html.xpath('//*[@id="complexity"]'))
    data["functions"].append(
        {
            "method": function.split("/")[-2],
            "prototype": c_proto,
            "complexity": complexity,
        }
    )
    output["algorithm"] = data
    with open("output_alg.json", "w") as f:
        json.dump(output, f, indent=2)
