
/**
 * Interfaccia base per classi che leggono l'input dell'utente.
 * @author Francesco Ferlin
 */
public interface Input {
    /** Valore che, se ritornato da {@link #leggiTasto()}, significa che non è accaduto nulla */
    int NO_INPUT = -1;
    /** Valore che, se ritornato da {@link #leggiTasto()}, significa che l'utente vuole spostare la forma a destra */
    int SPOSTA_DESTRA = 0;
    /** Valore che, se ritornato da {@link #leggiTasto()}, significa che l'utente vuole spostare la forma a sinistra */
    int SPOSTA_SINISTRA = 1;
    /** Valore che, se ritornato da {@link #leggiTasto()}, significa che l'utente vuole spostare la forma in basso */
    int SPOSTA_GIU = 2;
    /** Valore che, se ritornato da {@link #leggiTasto()}, significa che l'utente vuole ruotare la forma a destra */
    int RUOTA_DESTRA = 3;
    /** Valore che, se ritornato da {@link #leggiTasto()}, significa che l'utente vuole ruotare la forma a sinistra */
    int RUOTA_SINISTRA = 4;
    /** Valore che, se ritornato da {@link #leggiTasto()}, significa che l'utente vuole lasciar cadere la forma in basso */
    int DROP = 5;
    /** 
     * Valore che, se ritornato da {@link #leggiTasto()}, significa che l'utente vuole iniziare una nuova partita (se è nel menu iniziale)
     * @bug Per ragioni di compatibilità con la vecchia classe che gestiva arduino, questo ha lo stesso valore di {@link #RUOTA_DESTRA}
     */
    int NUOVA_PARTITA = 3;

    /**
     * @brief Restituisce un intero che rappresenta la scelta dell'utente.
     *
     * Il valore restituito è compreso tra 0 a 4, che rispettivamente indicano:
     * - -1 - Nessun input {@link #NO_INPUT}
     * - 0 - Spostamento a destra {@link #SPOSTA_DESTRA}
     * - 1 - Spostamento a sinistra {@link #SPOSTA_SINISTRA}
     * - 2 - Spostamento in giù {@link #SPOSTA_GIU}
     * - 3 - Rotazione a destra {@link #RUOTA_DESTRA} / Nuova partita nel menu iniziale {@link #NUOVA_PARTITA}
     * - 4 - Rotazione a sinistra {@link #RUOTA_SINISTRA}
     * - 5 - Hard drop {@link #DROP}
     *
     * Questo metodo non deve bloccare l'esecuzione del thread, 
     * ovvero non deve aspettare la presenza effettiva di input, 
     * ma ritornare un input se è presente o {@link #NO_INPUT} altrimenti.
     *
     * @return input dell'utente tra quelli sopra specificati
     * @author Francesco Ferlin
     */
    int leggiTasto();
}
