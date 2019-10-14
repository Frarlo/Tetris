import java.awt.*;

/**
 * Classe rappresenta un quadrato che compone una forma
 * @author Mirko Ghislanzoni, Francesco Ferlin
 */
public class Quadrato implements Disegnabile {
    /** Campo sul quale è disposto il quadrato */
    private final CampoDiGioco campo;
    /** Colore con cui disegnare il quadrato */
    private final Color colore;
    /** Posizione X in cui si trova questo quadrato */
    private int posX;
    /** Posizione Y in cui si trova questo quadrato */
    private int posY;

    /**
     * @brief Costruisce un quadrato con i parametri dati
     * 
     * @param campo campo sul quale è disposto il quadrato
     * @param colore colore con cui disegnare il quadrato
     * @param posX posizione X in cui si trova il quadrato
     * @param posY posizione Y in cui si trova il quadrato
	   * @author Mirko Ghislanzoni
     */
    public Quadrato(CampoDiGioco campo, Color colore, int posX, int posY) {
        this.campo = campo;
        this.colore = colore;
        this.posX = posX;
        this.posY = posY;
    }

    /**
     * @brief Costruttore copia
     *
     * Copia gli attributi del Quadrato passato come parametro
     * @param quad oggetto da copiare
     * @author Mirko Ghislanzoni
     */
    public Quadrato(Quadrato quad) {
        this(quad.campo, quad.colore, quad.posX, quad.posY);
    }

    /**
     * @brief Disegna il Quadrato
	   * @author Mirko Ghislanzoni
	   */	
    @Override
    public void draw() {
        fill(colore);
        rect(posX, posY, getLarghezza(), getAltezza());
    }

    // Traslazioni

   /**
    * @brief Controlla se sia possibile traslare il quadrato
    *
    * @param righe numero di righe di cui traslare il quadrato
    * @param colonne numero di colonne di cui traslare il quadrato
    * @author Mirko Ghislanzoni
    */	
    public boolean puoTraslare(int righe, int colonne) {
        int newPosX = posX + colonne * getLarghezza();
        int newPosY = posY + righe * getAltezza();
        return campo.isPosizioneValida(newPosX, newPosY, getLarghezza(), getAltezza());
    }
    
   /**
    * @brief Trasla il quadrato
    *
    * @param righe numero di righe di cui traslare il quadrato
    * @param colonne numero di colonne di cui traslare il quadrato
    * @author Mirko Ghislanzoni
    */
    public void trasla(int righe, int colonne) {
        posX += colonne * getLarghezza();
        posY += righe * getAltezza();
    }

    // Getters
   
   /**
     * @brief Restituisce la distanza tra due quadrati
     * @author Francesco Ferlin
     */
    public double distanzaDa(Quadrato altro) {
        return Math.hypot(
                this.getPosX() - altro.getPosX(),
                this.getPosY() - altro.getPosY());
    }

    /**
     * @brief Restituisce la posizione X in cui si trova il quadrato
     * @return la posizione X del quadrato
     * @author Mirko Ghislanzoni
     */
    @Override
    public int getPosX() {
        return posX;
    }

    /**
     * @brief Restituisce la posizione Y in cui si trova il quadrato
     * @return la posizione Y del quadrato
     * @author Mirko Ghislanzoni
     */
    @Override
    public int getPosY() {
        return posY;
    }
	
	  /**
     * @brief Restituisce la larghezza del quadrato
     * @return la larghezza del quadrato
     * @author Mirko Ghislanzoni
     */
    @Override
    public int getLarghezza() {
        return GRANDEZZA_QUADRATO;
    }

    /**
     * @brief Restituisce l'altezza del quadrato
     * @return l'altezza del quadrato
     * @author Mirko Ghislanzoni
     */
    @Override
    public int getAltezza() {
        return GRANDEZZA_QUADRATO;
    }

    /**
     * @brief Restituisce la coordinata X massima del quadrato
     * @return la coordinata X massima
     * @author Mirko Ghislanzoni
     */	
    @Override
    public int getMaxPosX() {
        return getPosX() + getLarghezza();
    }

    /**
     * @brief Restituisce la coordinata Y massima del quadrato
     * @return la coordinata Y massima
     * @author Mirko Ghislanzoni
     */	
    @Override
    public int getMaxPosY() {
        return getPosY() + getAltezza();
    }

    /**
     * @brief Restituisce la coordinata X del centro del quadrato
     * @return la coordinata X del centro
     * @author Mirko Ghislanzoni
     */	
    @Override
    public int getCentroX() {
        return getPosX() + getLarghezza() / 2;
    }

    /**
     * @brief Restituisce la coordinata Y del centro del quadrato
     * @return la coordinata Y del centro
     * @author Mirko Ghislanzoni
     */	
    @Override
    public int getCentroY() {
        return getPosY() + getAltezza() / 2;
    }

    /**
     * @brief Restituisce una descrizione dell'oggetto
     * @return stringa che descrive l'oggetto Quadrato
	   * @author Mirko Ghislanzoni, Francesco Ferlin
     */
    public String toString() {
        return "Quadrato(" +
                "x="+ getPosX() + ", " +
                "y="+ getPosY() + ", " +
                "width="+ getLarghezza() + ", " +
                "height=" + getAltezza() + ")" +
                "#" + System.identityHashCode(this);
    }
}
