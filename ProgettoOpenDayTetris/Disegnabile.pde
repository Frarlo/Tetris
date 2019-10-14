/**
 * Interfaccia che rappresenta un oggetto in grado di
 * esser disegnato in un piano cartesiano con origine in alto a sinistra.
 * @author Francesco Ferlin
 */
public interface Disegnabile {
    /**
     * @brief Restituisce la posizione X minima nel piano di questo oggetto.
     * @return la posizione X minima
     * @author Francesco Ferlin
     */
    int getPosX();
    
    /**
     * @brief Restituisce la posizione Y minima nel piano di questo oggetto.
     * @return la posizione Y minima
     * @author Francesco Ferlin
     */
    int getPosY();

    /**
     * @brief Restituisce la larghezza di questo oggetto.
     * @return la larghezza
     * @author Francesco Ferlin
     */
    int getLarghezza();

    /**
     * @brief Restituisce l'altezza di questo oggetto.
     * @return l'altezza
     * @author Francesco Ferlin
     */
    int getAltezza();

    /**
     * @brief Restituisce la posizione X massima nel piano di questo oggetto.
     * @return la posizione X massima
     * @author Francesco Ferlin
     */
    int getMaxPosX();

    /**
     * @brief Restituisce la posizione Y massima nel piano di questo oggetto.
     * @return la posizione Y massima
     * @author Francesco Ferlin
     */
    int getMaxPosY();
    
    /**
     * @brief Restituisce la posizione X nel piano del centro di questo oggetto.
     * @return la posizione X del centro
     * @author Francesco Ferlin
     */
    int getCentroX();
    
    /**
     * @brief Restituisce la posizione Y nel piano del centro di questo oggetto.
     * @return la posizione Y del centro
     * @author Francesco Ferlin
     */
    int getCentroY();
    
    /**
     * @brief Disegna l'oggetto
     *
     * Viene disegnato all'interno di un piano cartesiano 
     * con origine in alto a sinistra
     * @author Francesco Ferlin
     */
    void draw();
}
