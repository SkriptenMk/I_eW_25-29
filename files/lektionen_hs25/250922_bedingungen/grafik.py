# grafik.py

# %%

from pytamaro.de import *

# %%

dunkelblau = ellipse(50, 150, blau)
hellblau   = ellipse(50, 150, rgb_farbe(0, 150, 255))
scheibe    = ellipse(30, 30, rgb_farbe(186, 160, 254))
# %%

dunkelblau_fix = fixiere(unten_mitte, dunkelblau)
hellblau_fix   = fixiere(unten_mitte, hellblau)

blume          = scheibe

for i in range(12):
    bluetenblatt_dunkel = drehe(i * 30, dunkelblau_fix)
    bluetenblatt_hell   = drehe(i * 30, hellblau_fix)
    if i % 2 == 0:
        blume = kombiniere(blume, bluetenblatt_dunkel)
    else:
        blume = kombiniere(blume, bluetenblatt_hell)
        
zeige_grafik(blume)
    

# %%
speichere_grafik('blumenbeispiel.svg', blume)
# %%
