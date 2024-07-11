def process_file(input_file, output_file):
    lines = []

    with open(input_file, 'r') as file:
        lines = file.readlines()

    out = ""
    index = 0
    while True:
        if index == len(lines):
            break
        
        print(index)
        if lines[index].startswith(";") or lines[index].startswith(" "):
            index += 1
            continue

        elif lines[index].startswith("e"):
            out += lines[index].split('=')[1].replace('"', '')
            index += 1
            continue

        elif lines[index].startswith("s"):
            for nums in range(15):
                print(index)
                out += lines[index].split('=')[1].replace('\n', ' ')
                index += 1
            out += '\n'
            continue
        
        else:
            index += 1
        

    with open(output_file, 'w') as file:
        file.write(out)

process_file('schedules.txt', 'output.txt')