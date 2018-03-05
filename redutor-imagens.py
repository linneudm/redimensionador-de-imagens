from PIL import Image
import os

#Obtem o diretorio atual. Supoe-se que o script esta na mesma pasta das imagens para serem redimensionadas.
directory = os.fsencode(os.getcwd())
print(directory)

w = int(input("Insira a largura da imagem (cm): "))
h = int(input("Insira a altura da imagem (cm): "))
#Converte CM para Pixels
w_px = int(37.795 * w)
h_px = int(37.795 * h)
size = w_px, h_px
list_formats = ("jpg", "png", "jpeg")
for i,file in enumerate(os.listdir(directory)):
    is_image = False
    #Obtem o formato do arquivo
    file_format = str(file, 'utf-8')
    #Obtem o nome do arquivo
    file_name = file_format.split(".")[0]
    file_format = file_format.split(".")[-1]
    for f in list_formats:
        if(file_format == f):
            #Verifica se o formato do arquivo pode ser convertido. Se sim, encerra a verificacao.
            is_image = True
            break
    if(is_image):
        #Abre a imagem
        im = Image.open(file)
        #Redimensiona a imagem para o tamanho escolhido
        im_resized = im.resize(size, Image.ANTIALIAS)
        #Verifica se existe a pasta "imgs". Se nao, ele cria.
        try:
            os.stat("imgs")
        except:
            os.mkdir("imgs") 
        #Salva a imagem.
        im_resized.save("imgs/reduzido_{}.{}".format(file_name,file_format))
    else:
        #Imprime mensagem dos formatos que encontrou e nao foram suportados.
        print("O formato .{} nao e suportado.".format(file_format))