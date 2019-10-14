import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/**
  * Classe che rappresenta una forma
  * @author Mauri Davide, Francesco Ferlin
  */
public class Forma implements Disegnabile {
    /** Campo in cui si trova questa figura */
    private final CampoDiGioco campo;
    
    /** Lista dei quadrati che compongono la forma. */
    private final List<Quadrato> quadrati;
    /**
     * Lista non modificabile dei quadrati che compongono la forma.
     * E' un wrapper di {@link #quadrati} creato usando {@link Collections#unmodifiableList(List)}
     */
    private final List<Quadrato> readOnlyQuadrati;
    /**
     * Quadrato che fa da perno attorno al quale la figura viene ruotata da {@link #ruotaDestra()}.
     * Assume il valore di null se la figura non può essere ruotata.
     */
    private final Quadrato perno;
    
    /**
     * @brief Costruisce una forma ruotabile con i parametri dati
     *
     * @param campo CampoDiGioco in cui si trova questa figura
     * @param quadrati quadrati che compongono la figura
     * @author Francesco Ferlin
     */
    public Forma(CampoDiGioco campo,
                  Quadrato[] quadrati) {
        this(campo, true, quadrati);
    }

    /**
     * @brief Costruisce una forma con i parametri dati
     *
     * @param campo CampoDiGioco in cui si trova questa figura
     * @param puoRuotare true se la forma può essere ruotata
     * @param quadrati quadrati che compongono la figura
     * @author Francesco Ferlin
     */
    public Forma(CampoDiGioco campo,
                    boolean puoRuotare,
                    Quadrato[] quadrati) {
        this.campo = campo;

        this.quadrati = new ArrayList<Quadrato>();
        Collections.addAll(this.quadrati, quadrati);
        this.readOnlyQuadrati = Collections.unmodifiableList(this.quadrati);

        if(puoRuotare)
            this.perno = trovaPerno();
        else
            this.perno = null;
    }

    // Traslazioni

    /**
     * @brief Trasla, se possibile, tutti i quadrati della figura di quanto richiesto
     * @return true se la traslazione è avvenuta con successo
     * @author Francesco Ferlin
     */
    public boolean trasla(int righe, int colonne) {
        final Traslazione traslazione = new Traslazione(righe, colonne);
        final Traslazione[] traslazioni = new Traslazione[quadrati.size()];
        for(int i = 0; i < quadrati.size(); i++)
            traslazioni[i] = traslazione;
        return trasla(traslazioni);
    }

    /**
     * @brief Trasla, se possibile, ogni singolo quadrato della traslazione con indice associato
     *
     * Per ogni quadrato della figura, viene cercata la traslazione corrispondente nel vettore
     * in base all'indice numerico.
     *
     * @param traslazioni Vettore di oggetti Traslazione che deve avere la stessa dimensione
     *                    del numero di quadrati che compongono la figura
     * @return true se la traslazione è avvenuta con successo
     * @throws RuntimeException se il numero di oggetti translazione non è uguale al numero di quadrati
     * @author Francesco Ferlin
     */
    private boolean trasla(Traslazione... traslazioni) {
        if(traslazioni.length < quadrati.size())
            throw new RuntimeException("Numero invalido di oggetti Traslazione");

        boolean puoTraslare = true;
        for(int i = 0; i < quadrati.size(); i++) {
            final Quadrato quadrato = quadrati.get(i);
            final Traslazione traslazione = traslazioni[i];

            if(!quadrato.puoTraslare(traslazione.getRighe(), traslazione.getColonne())) {
                puoTraslare = false;
                break;
            }
        }

        if(puoTraslare)
            for(int i = 0; i < quadrati.size(); i++) {
                final Quadrato quadrato = quadrati.get(i);
                final Traslazione traslazione = traslazioni[i];
                quadrato.trasla(traslazione.getRighe(), traslazione.getColonne());
            }
        return puoTraslare;
    }
    
    /**
     * @brief Classe che rappresenta una traslazione
     * @author Francesco Ferlin
     */
    protected class Traslazione {
        /** Numero di righe da traslare */
        private final int righe;
        /** Numero di colonne da traslare */
        private final int colonne;
        
        /**
         * @brief Costruisce una traslazione con i parametri dati
         * @param righe numero di righe da traslare
         * @param colonne numero di colonne da traslare
         * @author Francesco Ferlin
         */
        Traslazione(int righe, int colonne) {
            this.righe = righe;
            this.colonne = colonne;
        }

        /** 
         * @brief Restituisce il numero di righe di cui traslare l'oggetto
         * @return numero di righe da traslare 
         */
        int getRighe() {
            return righe;
        }

        /** 
         * @brief Restituisce il numero di colonne di cui traslare l'oggetto
         * @return numero di colonne da traslare 
         */
        int getColonne() {
            return colonne;
        }
    }

    // Rotazioni

    /**
     * @brief Ruota, se possibile, la forma in senso orario
     *
     * La rotazione avviene attorno al {@link #perno} trovato nel costruttore.
     * @author Francesco Ferlin, Davide Mauri
     */
    public void ruotaDestra() {
        // Immaginiamo di inserire la forma in una matrice
        //
        //  A(-1, -1)   |               |
        // -------------------------------------------
        //   B(-1, 0)   |  Perno(0, 0)  |   C(1, 0)
        // -------------------------------------------
        //              |               |
        //
        // La figura ruota attorno al perno.
        // La differenza delle colonne tra il singolo quadrato e il perno
        // corrisponde alla coordinata X e quella delle righe alla Y.
        //
        // Per eseguire la rotazione la nuova coordinata X corrisponde a -Y
        // e la nuova coordinata Y alla X.
        //
        //              |    B(0, -1)   |  A(1, -1)
        // -------------------------------------------
        //              |  Perno(0, 0)  |
        // -------------------------------------------
        //              |    C(0, 1)    |
        //
        // Questo tipo di rotazione dovrebbe essere equivalente
        // al Nintendo Rotation System (http://tetris.wikia.com/wiki/Nintendo_Rotation_System).

        if(perno == null)
            return;

        final Traslazione[] traslazioni = new Traslazione[quadrati.size()];

        for(int i = 0; i < quadrati.size(); i++) {
            final Quadrato quadrato = quadrati.get(i);

            if(quadrato == perno) {
                traslazioni[i] = new Traslazione(0, 0);
                continue;
            }

            final int diffColonne = (quadrato.getPosX() - perno.getPosX()) / quadrato.getLarghezza(); // x del 3x3
            final int diffRighe = (quadrato.getPosY() - perno.getPosY()) / quadrato.getAltezza(); // y del 3x3

            final int newDiffColonne = -diffRighe; // nuova x del 3x3
            final int newDiffRighe = diffColonne; // nuova y del 3x3

            traslazioni[i] = new Traslazione(
                    newDiffRighe - diffRighe,
                    newDiffColonne - diffColonne
            );

            // Super Rotation System (http://tetris.wikia.com/wiki/SRS).
            //
            // Potrebbe essere usato, ma bisognerebbe salvare alla creazione della forma
            // il Quadrato in alto a sinistra della matrice in cui è inserita la forma,
            // per la corretta individuazione del centro attorno a cui ruotare.
            // Bisognerebbe inoltre cambiarre lo spawn dei locchi e introdurre i wall kicks.
            // E non c'ho voja. E non so manco se sta roba sotto funzia.

//            double xDistance = centerX - quadrato.getPosX();
//            double yDistance = centerY - quadrato.getPosY();
//
//            final int newPosX = (int) (centerX - yDistance);
//            final int newPosY = (int) (centerY + xDistance);
//
//            quadrato.posX = newPosX;
//            quadrato.posY = newPosY;

//            traslazioni[i] = new Traslazione(
//                    (newPosY - quadrato.getPosY()) / quadrato.getAltezza(),
//                    (newPosX - quadrato.getPosX()) / quadrato.getLarghezza()
//            );
        }

        trasla(traslazioni);
    }

    /**
     * @brief Ruota, se possibile, la forma in senso anti-orario
     *
     * La rotazione avviene attorno al {@link #perno} trovato nel costruttore.
     * @author Francesco Ferlin
     *
     * @bug L'implementazione fa schifo e semplicemente ruota a destra 3 volte.
     *      Potrebbe accadere che sia possibile ruotare a destra solo una volta
     *      e quindi ruoti nella direzione sbagliata, 2 al posto di 3 volte o
     *      non ruoti affatto anche se dovrebbe.
     */
    public void ruotaSinistra() {
        ruotaDestra();
        ruotaDestra();
        ruotaDestra();
    }

    /**
     * @brief Trova il quadrato perno della figura
     *
     * Viene trovato il quadrato perno della figura tra i 4 quadrati che la compongono.
     * @return Quadrato perno della figura
     * @author Davide Mauri
     */
    private Quadrato trovaPerno() {
        Quadrato perno = null;
        double distanza = 0;
        for(Quadrato q : quadrati) {
            double nuovaDistanza = 0;
            for(Quadrato q2 : quadrati)
                if(q != q2)
                    nuovaDistanza += q.distanzaDa(q2);

            if(perno == null || nuovaDistanza < distanza) {
                perno = q;
                distanza = nuovaDistanza;
            } else if(nuovaDistanza == distanza) {
                perno = q.getPosY() < perno.getPosY() ? q :
                        q.getPosY() > perno.getPosY() ? perno :
                                q.getPosX() < perno.getPosX() ? q : perno;
            }
        }
        return perno;
    }

    /**
     * @brief Disegna la figura
     * @author Francesco Ferlin
     */
    @Override
    public void draw() {
        pushMatrix();

        for(Quadrato quadrato : quadrati)
            quadrato.draw();

        popMatrix();
    }

    // Getters

    /**
     * @brief Ritorna una lista non modificabile dei quadrati
     *        che compongono questa forma
     * @return lista dei quadrati
     * @author Francesco Ferlin
     */
    public List<Quadrato> getQuadrati() {
        return readOnlyQuadrati;
    }

    /**
     * @brief Restituisce la posizione X del quadrato costruito attorno alla forma
     * @return posizione X
     * @author Francesco Ferlin
     */
    @Override
    public int getPosX() {
        int posX = quadrati.get(0).getPosX();
        for(int i = 1; i < quadrati.size(); i++)
            posX = Math.min(posX, quadrati.get(i).getPosX());
        return posX;
    }

    /**
     * @brief Restituisce la posizione Y del quadrato costruito attorno alla forma
     * @return posizione Y
     * @author Francesco Ferlin
     */
    @Override
    public int getPosY() {
        int posY = quadrati.get(0).getPosY();
        for(int i = 1; i < quadrati.size(); i++)
            posY = Math.min(posY, quadrati.get(i).getPosY());
        return posY;
    }

    /**
     * @brief Restituisce la posizione X massima del quadrato costruito attorno alla forma
     * @return posizione X massima
     * @author Francesco Ferlin
     */
    @Override
    public int getMaxPosX() {
        int posX = quadrati.get(0).getMaxPosX();
        for(int i = 1; i < quadrati.size(); i++)
            posX = Math.max(posX, quadrati.get(i).getMaxPosX());
        return posX;
    }

    /**
     * @brief Restituisce la posizione Y del quadrato costruito attorno alla forma
     * @return posizione Y massima
     * @author Francesco Ferlin
     */
    @Override
    public int getMaxPosY() {
        int posX = quadrati.get(0).getMaxPosY();
        for(int i = 1; i < quadrati.size(); i++)
            posX = Math.max(posX, quadrati.get(i).getMaxPosY());
        return posX;
    }

    /**
     * @brief Restituisce la larghezza del quadrato costruito attorno alla forma
     * @return larghezza
     * @author Davide Mauri
     */
    @Override
    public int getLarghezza() {
        return getMaxPosX() - getPosX();
    }

    /**
     * @brief Restituisce l'altezza del quadrato costruito attorno alla forma
     * @return altezza
     * @author Davide Mauri
     */
    @Override
    public int getAltezza() {
        return getMaxPosY() - getPosY();
    }

    /**
     * @brief Restituisce l'ascissa del centro
     * @return Ascissa Centro 
     * @author Davide Mauri
     */
    @Override
    public int getCentroX() {
        return getPosX() + getLarghezza() / 2;
    }
    
    /**
     * @brief Restituisce l'ordinata del centro
     * @return Ordinata Centro
     * @author Davide Mauri
     */
    @Override
    public int getCentroY() {
        return getPosY() + getAltezza() / 2;
    }
}
