import os
import cv2 as cv
import numpy as np
import matplotlib.pyplot as plt

import glob as glob

from skimage import io, exposure, filters, color


def read_img(PATH):
    # assert PATH is str, "Caminho para a imagem deve ser uma string"
    img = io.imread(PATH)
    assert img is not None, "Imagem não encontrada, verifique se ela existe ou se o caminho fornecido está correto"
    return img


def bin_img(img):
    assert img is not None, "Imagem inexistente"
    # assert img is np.ndarray, "Formato de imagem desconhecido"
    assert len(np.shape(img)) == 2, "Imagem deve ter 2 dimensões"
    th, img_bin = cv.threshold(
        img, 0, 1.0, cv.THRESH_BINARY_INV+cv.THRESH_OTSU)
    return img_bin


def find_lines(img, dil_n=99, ero_n=55):
    assert img is not None, "Imagem inexistente"
    # assert img is np.ndarray, "Formato de imagem desconhecido"
    assert len(np.shape(img)) == 2, "Imagem deve ter 2 dimensões"
    # Criando Contornos para Linhas
    dil_kernel = np.ones((3, dil_n), np.uint8)
    ero_kernel = np.ones((1, ero_n), np.uint8)
    line_img = cv.erode(cv.dilate(img, dil_kernel), ero_kernel)

    (contours, hierarchy) = cv.findContours(
        line_img.copy(), cv.RETR_TREE, cv.CHAIN_APPROX_SIMPLE)
    sorted_contours_lines = sorted(
        contours, key=lambda ctr: cv.boundingRect(ctr)[1])
    return sorted_contours_lines


def find_words(img, lines, n=15):
    assert img is not None, "Imagem inexistente"
    # assert img is np.ndarray, "Formato de imagem desconhecido"
    assert len(np.shape(img)) == 2, "Imagem deve ter 2 dimensões"

    assert lines is not None, "As linhas da imagem devem ser fornecidas"

    # Criando Contornos para Palavras
    dil_kernel = np.ones((3, n), np.uint8)
    word_img = cv.dilate(img, dil_kernel)

    words = []

    for line in lines:
        if cv.contourArea(line) < 1200:
            continue
        # roi of each line
        x, y, w, h = cv.boundingRect(line)
        roi_line = word_img[y:y+h, x:x+w]

        # draw contours on each word
        (cnt, hierarchy) = cv.findContours(
            roi_line.copy(), cv.RETR_EXTERNAL, cv.CHAIN_APPROX_NONE)
        sorted_words = sorted(cnt, key=lambda cntr: cv.boundingRect(cntr)[0])

        for word in sorted_words:
            if cv.contourArea(word) < 400:
                continue

            x2, y2, w2, h2 = cv.boundingRect(word)
            if h2 < 20:
                continue
            words.append([x+x2, y+y2, x+x2+w2, y+y2+h2])
    return words


def save_words(img, words, folder="words"):
    # export word images
    if not os.path.exists(folder):
        os.makedirs(folder)

    counter = 0

    for i in range(len(words)):
        word = words[i]
        roi = img[word[1]:word[3], word[0]:word[2]]
        roi = cv.resize(roi, (300, 60))
        cv.imwrite(f"{folder}/{counter}.jpg", 255*roi.astype(int))
        print(f"Wrote image #{counter} to {folder}/{counter}.jpg")
        counter = counter + 1
    return
