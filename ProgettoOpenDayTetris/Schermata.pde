/**
 * Classe base per oggetti che sono in grado di disegnare
 * e gestire un'intera schermata di gioco che occupa l'intera finestra.
 * @author Francesco Ferlin, Mirko Ghislanzoni
 */
public abstract class Schermata implements Disegnabile {

    /**
     * @brief Gestisce l'input dell'utente.
     * @param key valore tra quelli descritti in {@link Input#leggiTasto()}
     * @author Francesco Ferlin
     */
    public abstract void onInput(int inputVal);

    /**
     * @brief Gestisce la logica della schermata.
     * @author Francesco Ferlin
     */
    public abstract void runTick();

    /**
     * @brief Restituisce la coordinata X dell'origine, ovvero 0
     * @return 0
     * @author Mirko Ghislanzoni
     */
    @Override
    public int getPosX() {
        return 0;
    }

    /**
     * @brief Restituisce la coordinata Y dell'origine, ovvero 0
     * @return 0
     * @author Mirko Ghislanzoni
     */
    @Override
    public int getPosY() {
        return 0;
    }
    
    /**
     * @brief Restituisce la larghezza della finestra
     * @return larghezza
     * @author Mirko Ghislanzoni
     */
    @Override
    public int getLarghezza() {
        return width;
    }
    
    /**
     * @brief Restituisce l'altezza della finestra
     * @return altezza
     * @author Mirko Ghislanzoni
     */
    @Override
    public int getAltezza() {
        return height;
    }
    
    /**
     * @brief Restituisce la coordinata X del centro della finestra
     * @return coordinata X del centro della finestra
     * @author Mirko Ghislanzoni
     */
    @Override
    public int getCentroX() {
        return getPosX() + getLarghezza() / 2;
    }

    /**
     * @brief Restituisce la coordinata Y del centro della finestra
     * @return coordinata Y del centro della finestra
     * @author Mirko Ghislanzoni
     */
    @Override
    public int getCentroY() {
        return getPosY() + getAltezza() / 2;
    }
    
    /**
     * @brief Restituisce la larghezza della finestra
     * @return larghezza
     * @author Mirko Ghislanzoni
     */
    @Override
    public int getMaxPosX() {
        return getPosX() + getLarghezza();
    }
    
    /**
     * @brief Restituisce l'altezza della finestra
     * @return altezza
     * @author Mirko Ghislanzoni
     */
    @Override
    public int getMaxPosY() {
        return getPosY() + getAltezza();
    }
}
