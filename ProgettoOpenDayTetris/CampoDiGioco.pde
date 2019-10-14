import java.awt.*;
import java.util.Random;

/**
 * Classe che gestisce il campo di gioco,
 * tenendo traccia di tutti i quadrati e della forma attiva.
 * @author Davide Mauri, Francesco Ferlin
 */
public class CampoDiGioco implements Disegnabile {
    /** Costante che rappresenta un quadrato vuoto */
    private final Quadrato EMPTY = null;
    /** Ascissa del campo di gioco rispetto alla schermata */
    private final int posX;
    /** Ordinata del campo di gioco rispetto alla schermata */
    private final int posY;
    /** Larghezza del campo di gioco */
    private final int larghezza;
    /** Altezza del campo di gioco */
    private final int altezza;

    /** Righe del campo di gioco */
    private final int righe;
    /** Colonne del campo di gioco */
    private final int colonne;

    /** Matrice che corrisponde alla griglia del campo di gioco */
    private final Quadrato[][] quadrati;
    /** La forma che può essere spostata e ruotata dal giocatore */
    private Forma formaAttiva; 
    
    /** Random utilizzato per generare colori casuali */
    private final Random randomColore;
    /** Random utilizzato per generare figure casuali */
    private final Random randomForma;
    
    /**
     * @brief Costruttore vuoto
     *
     * Viene generato un campo da gioco con valori standard
     * @author Davide Mauri
     */
    public CampoDiGioco() {
        this.larghezza = 300;
        this.posX = (width - larghezza) / 2;

        this.posY = 50;
        this.altezza = height - this.posY * 2;

        this.righe = altezza / GRANDEZZA_QUADRATO;
        this.colonne = larghezza / GRANDEZZA_QUADRATO;

        this.quadrati = new Quadrato[righe][colonne];
        
        this.randomColore = new Random();
        this.randomForma = new Random();
    }

    /**
     * @brief Crea una nuova forma.
     * @return la forma creata
     */
    public Forma nuovaForma() {
        return (formaAttiva = creaFormaRandom());
    }

    /**
     * @brief Restituisce una forma casuale con un colore randomico (eccetto colori scuri)
     *
     * Genera una forma casuale tra: I, Quadrato, L, J, Z, S, T e la restituisce
     * @return forma casuale
     * @author Davide Mauri
     */
    private Forma creaFormaRandom() {
        Color colore = new Color(randomColore.nextInt(254), randomColore.nextInt(254), randomColore.nextInt(254));
        switch(randomForma.nextInt(7)) {
            case 0: // Linea
                // colore = new Color(0, 255, 255);
                return new Forma(this,
                        new Quadrato[] {
                                new Quadrato(this, colore, 100, 0),
                                new Quadrato(this, colore, 125, 0),
                                new Quadrato(this, colore, 150, 0),
                                new Quadrato(this, colore, 175, 0)
                        });
            case 1: // Quadrato
                // colore = new Color(255, 255, 0);
                return new Forma(this, false, new Quadrato[] {
                        new Quadrato(this, colore, 125, 0),
                        new Quadrato(this, colore, 150, 0),
                        new Quadrato(this, colore, 125, 25),
                        new Quadrato(this, colore, 150, 25)
                });
            case 2: // L
                // colore = new Color(255, 170, 0);
                return new Forma(this, new Quadrato[] {
                        new Quadrato(this, colore, 125, 0),
                        new Quadrato(this, colore, 150, 0),
                        new Quadrato(this, colore, 150, 25),
                        new Quadrato(this, colore, 150, 50)
                });
            case 3: // J
                // colore = new Color(0, 0, 255);
                return new Forma(this, new Quadrato[] {
                        new Quadrato(this, colore, 125, 0),
                        new Quadrato(this, colore, 150, 0),
                        new Quadrato(this, colore, 125, 25),
                        new Quadrato(this, colore, 125, 50)
                });
            case 4: // Z
                // colore = new Color(255, 0, 0);
                return new Forma(this, new Quadrato[] {
                        new Quadrato(this, colore, 150, 0),
                        new Quadrato(this, colore, 150, 25),
                        new Quadrato(this, colore, 125, 25),
                        new Quadrato(this, colore, 125, 50)
                });
            case 5: // S
                // colore = new Color(0, 255, 0);
                return new Forma(this, new Quadrato[] {
                        new Quadrato(this, colore, 125, 0),
                        new Quadrato(this, colore, 125, 25),
                        new Quadrato(this, colore, 150, 25),
                        new Quadrato(this, colore, 150, 50)
                });
            case 6: // T
            default:
                // colore = new Color(153, 0, 255);
                return new Forma(this, new Quadrato[] {
                        new Quadrato(this, colore, 125, 0),
                        new Quadrato(this, colore, 125, 25),
                        new Quadrato(this, colore, 125, 50),
                        new Quadrato(this, colore, 150, 25)
                });
        }
    }
    
    /**
     * @brief Cancella le righe complete e ne ritorna il numero
     * @return Numero di righe che sono state cancellate
     * @author Davide Mauri
     */
    public int cancellaRigheComplete() {
        int cancellate = 0;
        for(int i = 0; i < righe(); i++)
            if(isRigaCompleta(i)) {
                cancellaRiga(i);
                isRigaCompleta(i);
                cancellate++;
            }
        return cancellate;
    }
    
    /**
     * @brief Verifica se la riga data è completa
     *
     * Viene verificato che la riga sia completa, confrontando i quadrati presenti
     * su di essa con le dimensioni della riga. 
     * @param riga riga da controllare
     * @return true se la riga è completa, altrimenti false
     * @author Davide Mauri
     */
    private boolean isRigaCompleta(int riga) {
        int quadsInRiga = 0;
        for(int col = 0; col < colonne(); col++)
            quadsInRiga += quadrati[riga][col] != EMPTY ? 1 : 0;
        return quadsInRiga >= colonne();
    }
    /**
     * @brief Cancella la riga data
     *
     * Viene passata per parametro la riga da cancellare, che viene rimossa
     * @param daCancellare Riga da cancellare
     * @author Davide Mauri
     */
    private void cancellaRiga(int daCancellare) {
        for(int riga = daCancellare - 1; riga >= 0; riga--) {
            for (int col = 0; col < colonne(); col++)
                if (quadrati[riga][col] != EMPTY)
                    quadrati[riga][col].trasla(1, 0);
            quadrati[riga + 1] = quadrati[riga];
        }
        // Crea una nuova riga vuota
        quadrati[0] = new Quadrato[colonne()];
    }
    
    /**
     * @brief Restituisce se è stata raggiunta la prima riga
     *
     * Viene verificato se è stata raggiunta la prima riga (Game Over).
     * @return true/false Colonna piena o no
     * @author Davide Mauri
     */
    public boolean hasReachedPrimaRiga() {
        for(int i = 0; i < colonne(); i++)
            if(quadrati[0][i] != EMPTY)
                return true;
        return false;
    }
    
    /**
     * @brief Verifica che la posizione data sia valida
     *
     * Viene verificato che la posizione sia compresa nei limiti del campo
     * e che non sia già occupata da altri quadrati
     * @param posX coordinata X della posizione da controllare
     * @param posY coordinata Y della posizione da controllare
     * @param larghezza larghezza della posizione da controllare
     * @param altezza altezza della posizione da controllare
     * @return true/false Posizione valida o no
     * @author Davide Mauri
     */
    public boolean isPosizioneValida(int posX, int posY,
                                     int larghezza, int altezza) {
        // Controllo se è nei bounds
        final boolean ret = posX >= 0 &&
                posX + larghezza <= getLarghezza() &&
                posY >= 0 &&
                posY + altezza <= getAltezza();

        if(!ret)
            return false;

        // Se è nei bounds, controllo che la posizione non sia già occupata
        return quadrati[getRiga(posY)][getColonna(posX)] == EMPTY;
    }
    
    /**
     * @brief Disattiva la forma attiva corrente
     * @author Davide Mauri
     */
    public void disattiva() {
        if(formaAttiva == null)
            return;

        for (Quadrato quadrato : formaAttiva.getQuadrati())
            quadrati[getRiga(quadrato)][getColonna(quadrato)] = quadrato;
        formaAttiva = null;
    }

    /**
     * @brief Disegna il campo di gioco
     *
     * Disegna il contorno, i quadrati e la forma attiva
     * @author Francesco Ferlin
     */
    @Override
    public void draw() {
        // Contorno
        
        pushStyle();
        pushMatrix();

        fill(0);
        stroke(0, 0, 255);
        rect(getPosX(), getPosY(), getLarghezza(), getAltezza());

        popMatrix();
        popStyle();

        translate(getPosX(), getPosY());
      
        // Quadrati
        
        for(Quadrato[] righe : quadrati)
            for(Quadrato quadrato : righe)
                if(quadrato != EMPTY)
                    quadrato.draw();

        // Forma attiva

        if(formaAttiva != null)
            formaAttiva.draw();

        translate(-getPosX(), -getPosY());
    }

    /**
     * @brief Restituisce la forma che può essere spostata e ruotata dal giocatore
     * @return la forma che può essere spostata e ruotata dal giocatore
     * @author Davide Mauri
     */
    public Forma getFormaAttiva() {
        return formaAttiva;
    }

    /**
     * @brief Restituisce l'ascissa del campo di gioco rispetto alla schermata
     * @return Ascissa del campo di gioco rispetto alla schermata
     * @author Davide Mauri
     */
    @Override
    public int getPosX() {
        return posX;
    }

    /**
     * @brief Restituisce l'ordinata del campo di gioco rispetto alla schermata
     * @return Ordinata del campo di gioco rispetto alla schermata
     * @author Davide Mauri
     */
    @Override
    public int getPosY() {
        return posY;
    }
    
    /**
     * @brief Restituisce la larghezza del campo di gioco
     * @return Larghezza del campo di gioco
     * @author Davide Mauri
     */
    @Override
    public int getLarghezza() {
        return larghezza;
    }

    /**
     * @brief Restituisce l'altezza del campo di gioco
     * @return Altezza del campo di gioco
     * @author Davide Mauri
     */
    @Override
    public int getAltezza() {
        return altezza;
    }
    
    /**
     * @brief Restituisce la larghezza della schermata
     * @return Larghezza della schermata
     * @author Davide Mauri
     */
    @Override
    public int getMaxPosX() {
        return getPosX() + getLarghezza();
    }
    
    /**
     * @brief Restituisce l'altezza della schermata
     * @return Altezza della schermata
     * @author Davide Mauri
     */
    @Override
    public int getMaxPosY() {
        return getPosY() + getAltezza();
    }
    
    /**
     * @brief Restituisce l'ascissa del centro del campo di gioco
     * @return Ascissa del centro del campo di gioco
     * @author Davide Mauri
     */
    @Override
    public int getCentroX() {
        return getPosX() + getLarghezza() / 2;
    }
    
    /**
     * @brief Restituisce l'ordinata del centro del campo di gioco
     * @return Ordinata del centro del campo di gioco
     * @author Davide Mauri
     */
    @Override
    public int getCentroY() {
        return getPosY() + getAltezza() / 2;
    }
    
    /**
     * @brief Restituisce il numero di righe del campo di gioco
     * @return Numero righe del campo di gioco
     * @author Davide Mauri
     */
    public int righe() {
        return righe;
    }
    
    /**
     * @brief Restituisce il numero di colonne del campo di gioco
     * @return Numero colonne del campo di gioco
     * @author Davide Mauri
     */
    public int colonne() {
        return colonne;
    }
    
    /**
     * @brief Resituisce la riga in cui è contenuto il quadrato dato
     * @param quadrato quadrato da controllare
     * @return la riga in cui è contenuta il quadrato dato
     * @author Francesco Ferlin
     */
    public int getRiga(Quadrato quadrato) {
        return getRiga(quadrato.getPosY());
    }
    
    /**
     * @brief Resituisce la colonna in cui è contenuto il quadrato dato
     * @param quadrato quadrato da controllare
     * @return la colonna in cui è contenuta il quadrato dato
     * @author Francesco Ferlin
     */
    public int getColonna(Quadrato quadrato) {
        return getColonna(quadrato.getPosX());
    }
    
    /**
     * @brief Resituisce la riga della coordinata Y data
     * @param posY coordinata Y 
     * @return la riga in cui è contenuta la posizione Y data
     * @author Francesco Ferlin
     */
    public int getRiga(int posY) {
        return posY / GRANDEZZA_QUADRATO;
    }
    
    /**
     * @brief Resituisce la colonna della coordinata X data
     * @param posX coordinata X 
     * @return la colonna in cui è contenuta la posizione X data
     * @author Francesco Ferlin
     */
    public int getColonna(int posX) {
        return posX / GRANDEZZA_QUADRATO;
    }
}
