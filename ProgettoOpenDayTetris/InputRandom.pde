import java.util.Random;

/**
 * Classe che genera un input randomico
 * @author Davide Mauri
 */
public class InputRandom implements Input {
    /** Oggetto utilizzato per generare i numeri randomici */
    private final Random rn = new Random();
    /** Timer per avere un po' di delay tra i tasti premuti */
    private final Timer timer = new Timer();

    /**
     * @brief Ritorna un input randomico
     *
     * Il valore è scelto tra quello indicato in {@link Input#leggiTasto()}
     * @return input randomico
     * @author Davide Mauri
     */
    public int leggiTasto() {
        if(!timer.hasPassed(250))
            return NO_INPUT;

        timer.reset();
        return rn.nextInt(6);
    }
}
