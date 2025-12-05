IDs = ["001002", "001003", "001007", "001009", "001010", "002001", "002002", "002003", "002004", "002005", "002006", "002007", "002008", "002009", "002010", "002011", "003001", "003002", "003003", "003004", "003005", "003006", "003007", "003008", "003009", "003010", "003011", "004001", "004002", "004005", "004006", "004007", "004008", "004009", "004010", "005005", "005006", "005007", "005008", "005009", "005010", "006007", "006008", "006009"]
with open("AiGreenTemplate.bat","r") as f:
    Template = f.read()

with open("AiGreenProcess.bat","w") as f:
    with open("AiGreenHead.bat","r") as h:
        f.write(h.read())

    for ID in IDs:
        Process = Template.replace("000000",ID)
        col = int(ID[:3])
        row = int(ID[3:])
        grid = "col = "+ str(col) + " and row = "+ str(row)
        Process = Process.replace("col = 0 and row = 0",grid)
        f.write(Process)

    

    """
    use with
    exec(open("./filename").read())
    """

