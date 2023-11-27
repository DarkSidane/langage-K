all: alp-compilateur-k

alp-compilateur-k:
	bison -d alp-parseur-K.y
	flex alp-lexeur-K.l
	gcc -o $@ alp-parseur-K.tab.c lex.yy.c -lfl

clean:
	rm -f alp-compilateur-k parseur-K.tab.c parseur-K.tab.h lex.yy.c
