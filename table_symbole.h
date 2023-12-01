// ALP Sidane && EL ARRAM Mouloud
#ifndef TABLE_SYMBOLE_H
#define TABLE_SYMBOLE_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define maxDico 100

typedef enum {
    typeINT, typeVOID
} n_type;

typedef enum {
    GLOBAL, LOCAL, FONCTION
} mode;

typedef struct {
    char *nom;
    mode mode; /* GLOBAL, LOCAL, FONCTION */
    n_type *type; /* type de retour pour les fonctions */
    int adresse; /* en memoire */
} variable;

typedef struct {
    variable tab[maxDico];
    int base;
    int sommet;
} dico;

void initDico(dico *d);
void ajouterVariable(dico *d, char *nom, mode mode, n_type *type, int adresse);
variable *chercherVariable(dico *d, char *nom);

#endif /* TABLE_SYMBOLE_H */
