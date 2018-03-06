from PIL import Image
import os
import pathlib
#Obtem o diretorio atual. Supoe-se que o script esta na mesma pasta das imagens para serem redimensionadas.
directory = os.path.dirname(os.path.abspath(__file__))
print(directory)

w = int(input("Insira a largura da imagem (cm): "))
h = int(input("Insira a altura da imagem (cm): "))
#Converte CM para Pixels
w_px = int(37.795 * w)
h_px = int(37.795 * h)
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
        #Abre a imagem
        im = Image.open(file)
        #Redimensiona a imagem para o tamanho escolhido
        im_resized = im.resize(size, Image.ANTIALIAS)
        #Verifica se existe a pasta "imgs". Se nao, ele cria.
        pathlib.Path('/imgs/').mkdir(exist_ok=True) 
        #Salva a imagem.
        im_resized.save("imgs/redimensionado_{}{}".format(file_name[0],file_name[1]))
    else:
        #Imprime mensagem dos formatos que encontrou e nao foram suportados.
        print("O formato do arquivo {}{} nao e suportado.".format(file_name[0],file_name[1]))
