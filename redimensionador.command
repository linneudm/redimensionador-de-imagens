#!/usr/bin/python
from PIL import Image
from fpdf import FPDF
import os
import pathlib
import time
#Obtem o diretorio atual. Supoe-se que o script esta na mesma pasta das imagens para serem redimensionadas.
directory = os.path.dirname(os.path.abspath(__file__))
imgs_reduzidas = directory + "/imgs_reduzidas/"
print(directory)
pdf = FPDF(format="A4")
pdf.set_compression(False)
#result = pathlib.Path('imgs_reduzidas/').mkdir(exist_ok=True)
try:
    os.stat(imgs_reduzidas)
except:
    os.mkdir(imgs_reduzidas)
w = int(input("Insira a largura da imagem (cm): "))
h = int(input("Insira a altura da imagem (cm): "))
#Converte CM para Pixels
w_px = int(38 * w)
h_px = int(38 * h)
size = w_px, h_px
list_formats = (".jpg", ".png", ".jpeg")
for i,file in enumerate(os.listdir(directory)):
    is_image = False
    #Obtem o nome do arquivo e o formato e coloca-os em uma lista ("nome", "formato")
    file_name = os.path.splitext(file)
    #print(">>", file_name[1])
    for f in list_formats:
        if(file_name[1] == f):
            #Verifica se o formato do arquivo pode ser convertido. Se sim, encerra a verificacao.
            is_image = True
            break
    if(is_image):
    print(directory)
        #Abre a imagem
        im = Image.open("{}/{}".format(directory, file))
    print(im)
        #Redimensiona a imagem para o tamanho escolhido
        im_resized = im.resize(size, Image.ANTIALIAS)
        #Verifica se existe a pasta "imgs". Se nao, ele cria.
        #Salva a imagem.
        im_resized.save("{}/redimensionado_{}{}".format(imgs_reduzidas,file_name[0],file_name[1]))
    else:
        #Imprime mensagem dos formatos que encontrou e nao foram suportados.
        print("O formato do arquivo {}{} nao e suportado.".format(file_name[0],file_name[1]))
#X e Y sao as margens da folha
x, y = 10,10
#j verifica se existem 2 elementos na mesma linha para fazer o espacamento entre as imagens
j = 0
#adapta o tamanho das imagens para o tamanho da folha
w_px = w_px/3.7
h_px = h_px/3.7
#percorre as imagens dentro do diretorio criado
for i,image in enumerate(os.listdir(imgs_reduzidas)):
    #So serao criado 6 elementos por folha
    if(i % 6 == 0):
        x, y = 10,10
        j=0
        #Adiciona uma nova pagina
        pdf.add_page()
    #Verifica se existem 2 elementos na mesma linha. Se sim, salta para proxima linha.
    if (j == 2):
        j=0
        y += h_px + 4
        pdf.image('{}/{}'.format(imgs_reduzidas,image),x,y,w_px,h_px)
        j+=1
    else:
        #Verifica se eh o primeiro elemento da linha.
        if(j==0):
            pdf.image('{}/{}'.format(imgs_reduzidas,image),x,y,w_px,h_px)
        else:
        #Caso nao, faz o espacamento horizontal.
            pdf.image('{}/{}'.format(imgs_reduzidas,image),x+w_px+4,y,w_px,h_px)
        j+=1
#Cria o PDF na pasta raiz com o nome indicado
pdf.output("{}/imagens_reduzidas.pdf".format(directory), "F")
