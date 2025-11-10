docs: dl
	quarto render --output-dir docs/
html: dl
	quarto render --to html --output-dir docs/
pdf: dl
	quarto render --to pdf
.PHONY: dl docs html pdf# Update docs everytime
files/lektionen_hs25/251110_listen/Chomp_gameplay.png:
	wget wget https://upload.wikimedia.org/wikipedia/commons/f/f9/Chomp_gameplay.png -O $@
dl: files/lektionen_hs25/251110_listen/Chomp_gameplay.png

