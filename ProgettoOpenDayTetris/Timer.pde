/**
 * Semplice Timer che tiene il tempo dall'ultima volta che è stato resettato.
 * @author Francesco Ferlin
 */
public class Timer {
    /** Millisecondi di quando è stato resettato */
    private long resetMillis;

    /**
     * @brief Crea un nuovo timer e lo resetta
     * @author Francesco Ferlin
     */
    public Timer() {
        reset();
    }

    /**
     * @brief Resetta il timer
     * @author Francesco Ferlin
     */
    public void reset() {
        resetMillis = currentMillis();
    }

    /**
     * @brief Restituisce i millisecondi passati dall'ultimo reset
     * @return millis dall'ultimo reset
     * @author Francesco Ferlin
     */
    public long elapsedMillis() {
        return currentMillis() - resetMillis;
    }

    /**
     * @brief Restituisce i millisecondi correnti
     * @return millis correnti
     * @author Francesco Ferlin
     */
    public long currentMillis() {
        return System.nanoTime() / 1000000;
    }

    /**
     * @brief Restituisce se è passato il tempo richiesto dall'ultimo reset
     *
     * @param millis il tempo da controllare in millisecondi
     * @return true se il tempo richiesto è passato
     * @author Francesco Ferlin
     */
    public boolean hasPassed(int millis) {
        return elapsedMillis() >= millis;
    }
}
