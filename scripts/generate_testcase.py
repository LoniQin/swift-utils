import os
import datetime
from models import  *
from utils import *
if __name__ == "__main__":
    lib_name = "FoundationLib"
    date = datetime.date.today()
    date_str = "%d/%d/%d"%(date.year, date.month, date.day)
    items = __file__.split("/")
    file_directory = "/".join(items[:-1])
    base_path = "/".join(items[:-2])
    source_path = base_path + "/Sources/{lib_name}".format(lib_name=lib_name)
    test_path = base_path + "/Tests/{lib_name}Tests".format(lib_name=lib_name)
    swift_files = get_files(source_path, lambda f : f.endswith(".swift"))
    for file in swift_files:
        item_path = test_path + file.split("FoundationLib")[1]
        name = item_path.split("/")[-1].split(".")[0]
        name = name.replace("+", "_")
        dir = "/".join(item_path.split("/")[:-1])
        if not os.path.exists(dir):
            os.mkdir(dir)
        final_path = dir + "/" + name + "TestCase.swift"
        if os.path.exists(final_path):
            contents = []
            with open(final_path, 'r') as f:
                contents = f.readlines()
            index = -1
            for i in range(len(contents) - 1, 0, -1):
                if contents[i].startswith("}"):
                    index = i
            if index != -1:
                contents = contents[0:index]
                # TODO! Append necessary functions
                contents.append("}\n")
        else:
            content = template.replace("{name}", name).replace("{date}", date_str)
            with open(final_path, 'w') as f:
                f.write(content)
    manifests_path = test_path + "/" + "XCTestManifests.swift"
    current_root = ""
    swift_files = get_files(test_path, lambda f : f.endswith(".swift") and not f.endswith("XCTestManifests.swift"))
    test_cases = []
    for file in swift_files:
        with open(file) as f:
            lines = f.readlines()
            begin = False
            test_case = TestCase()
            for line in lines:
                if line.__contains__("XCTestCase"):
                    begin = True
                    value = line.split("class ")
                    value.pop(0)
                    if len(value) >= 1:
                        test_case.name = value[0].split(":")[0]
                else:
                    if begin == True:
                        if line.__contains__("func test"):
                            value = line.split(" ")
                            f_name = value[value.index("func") + 1]
                            if f_name.endswith("()"):
                                f_name = f_name.rstrip("()")
                                test_case.functions.append(f_name)
            if test_case.name != "":
                test_cases.append(test_case)

    manifests = "#if !canImport(ObjectiveC)\n"
    for test_case in test_cases:
        manifests += "extension " + test_case.name + " {\n"
        manifests += "\tstatic var allTests = [\n"
        for function in test_case.functions:
            manifests += "\t\t(\"{a}\", {b}),\n".format(a=function, b=function)
        manifests += "\t]\n"
        manifests += "}\n"
    manifests += "public func allTests() -> [XCTestCaseEntry] {\n\treturn [\n"
    for test_case in test_cases:
        manifests += "\t\ttestCase({name}.allTests),\n".format(name=test_case.name)
    manifests += "\t]\n}\n#endif\n"
    with open(manifests_path, 'w') as f:
        f.write(manifests)

                
        



