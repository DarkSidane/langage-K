all: compilateur-k

compilateur-k:
	bison -d src/parseur-K.y
	flex src/lexeur-K.l
	gcc -o $@ parseur-K.tab.c lex.yy.c -lfl

clean:
	rm -f compilateur-k parseur-K.tab.c parseur-K.tab.h lex.yy.c
