docs:
	quarto render --output-dir docs/
html:
	quarto render --to html --output-dir docs/
docs/Unterlagen-für-das-obligatorische-Fach-Informatik.pdf:
	quarto render --to pdf
.PHONY: docs html# Update docs everytime
files/lektionen_hs25/251110_listen/Chomp_gameplay.png:
	wget wget https://upload.wikimedia.org/wikipedia/commons/f/f9/Chomp_gameplay.png -O $@
files/lektionen_hs25/251215_rekurisv/Mergesort_example.png:
	wget https://upload.wikimedia.org/wikipedia/commons/9/99/Mergesort_example.png -O $@
# dl: files/lektionen_hs25/251110_listen/Chomp_gameplay.png
