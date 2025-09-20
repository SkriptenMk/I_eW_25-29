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

lavender = rgb_farbe(230, 230, 250)
mediumpurple = rgb_farbe(147, 112, 219)
darkorchid = rgb_farbe(153, 50, 204)
indigo = rgb_farbe(75, 0, 130)

# %%

bluetenblatt_l = ellipse(30, 150, lavender)
bluetenblatt_m = ellipse(30, 150, mediumpurple)
bluetenblatt_d = ellipse(30, 150, darkorchid)
scheibe_i = ellipse(25, 25, indigo)


# %%
bluetenblatt_m_fix = fixiere(unten_mitte, bluetenblatt_m)
bluetenblatt_l_fix = fixiere(unten_mitte, bluetenblatt_l)
bluetenblatt_d_fix = fixiere(unten_mitte, bluetenblatt_d)
blume3 = scheibe_i
for i in range(24):
    bm_temp = drehe(i * 15, bluetenblatt_m_fix)
    bl_temp = drehe(i * 15, bluetenblatt_l_fix)
    bd_temp = drehe(i * 15, bluetenblatt_d_fix)
    
    if i % 4 == 0:
        blume3 = kombiniere(blume3, bl_temp)
    elif i % 4 == 2:
        blume3 = kombiniere(blume3, bd_temp)
    else:
        blume3 = kombiniere(blume3, bm_temp)
        
zeige_grafik(blume3)
    
# %%

speichere_grafik('dreifachblume.svg', blume3)

# %%
