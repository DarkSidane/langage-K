all:    
	make clean
	make alp-compilateur-k
	./alp-compilateur-k 

alp-compilateur-k:
	bison -d alp-parseur-K.y
	flex alp-lexeur-K.l
	gcc -o $@ main.c alp-parseur-K.tab.c lex.yy.c table_symbole.c -lfl

clean:
	rm -f alp-compilateur-k alp-parseur-K.tab.c alp-parseur-K.tab.h lex.yy.c
