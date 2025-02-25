import image_prepross as ip

for i in range(20, 30):
    PATH = f"DVD3/037{i}"
    img = ip.read_img(f"RIMES/{PATH}_L.jpg")
    img = ip.bin_img(img)
    lines = ip.find_lines(img)
    words = ip.find_words(img, lines)
    ip.save_words(img, words, f"Preprocessed/{PATH}")

print("Finished")
