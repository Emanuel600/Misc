labels = open("label.txt", 'r', encoding='utf-8').readlines()
counter = 0
errors = 0
for label in labels:
    if label.startswith('#'):   # Linha comentada
        continue
    if label == '\n':           # Linha em branco
        continue
    # words[0] = PATH, words[1] = Imagem, words[2] = Label
    words = label.split('-')
    img_n = int(words[1])
    str = words[2].rstrip()
    if str == "**error**":
        errors = errors+1
        continue

    counter = counter+1

print(
    f"Palavras etiquetadas: {counter}\nBatches: {counter/16}\nErros no processamento: {errors}")
