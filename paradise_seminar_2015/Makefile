ALL_MD=$(wildcard *.md)

all : mds

.PRECIOUS: %.md.tex %.pdf

mds :	$(ALL_MD:.md=.pdf)

%.pdf : %.md
	env TEXINPUTS="../texstyles/paradiseBeamer/:.:" pandoc --listings --slide-level=2 -V documentclass=paradise-slide -s $< -t beamer -f markdown+raw_tex -o $@ --template=../texstyles/paradiseBeamer/template.tex

