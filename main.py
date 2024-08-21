#  main.py

import os
import pygame

if not pygame.font:
    print("Warning, fonts disabled")
if not pygame.mixer:
    print("Warning, sound disabled")

main_dir = os.path.split.(os.path.abspath(__file__))[0]
data_dir = os.path.join(main_dir, "data")

def load_image(name, colorkey = None, scale = 1):
    fullname = os.path.join(data_dir, name)
    image = pygame.image.load(fullname)
    
    size = image.get_size()
    size = (size[0] * scale, size[1] * scale)
    image = pygame.transform.scale(image, size)
    
    image = image.convert()
    if colorkey is not None:
        if colorkey == -1:
            colorkey = image.get_at((0,0))
        image.set_colorkey(colorkey, pygame.RLEACCEL)
    return image, image.get_rect()

