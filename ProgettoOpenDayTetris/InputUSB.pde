import processing.serial.*;

/**
 * Classe che si occupa della lettura dell'input da una porta usb
 * @author Mirko Ghislanzoni, Francesco Ferlin
 */
public class InputUSB implements Input {
    /** Porta da cui leggere l'input */
    private final Serial port;
    /** Ultimo carattere letto dalla porta USB */
    private char comando;

    private boolean contatore;

    /**
     * @brief Crea un oggetto che legge input dalla porta data
     * @param port porta da cui leggere l'input
     * @author Mirko Ghislanzoni
     */
    public InputUSB(Serial port) {
        this.port = port;
    }

    /**
     * @brief Ritorna l'input letto dalla porta
     *
     * Viene letto il carattere dal vecchio metodo {@link #leggi} e
     * viene rimappato ai nuovi valori.
     * Mancano alcuni valori ({@link Input#RUOTA_SINISTRA} e {@link Input#DROP}).
     *
     * @return valore tra quelli indicati in {@link Input#leggiTasto()}
     * @author Francesco Ferlin
     */
    public int leggiTasto() {
        final char input = leggi();

        switch(input) {
            case 'd':
                return 0;
            case 's':
                return 1;
            case 'g':
                return 2;
            case '1':
                return 3;
        }
        return -1;
    }

    /**
     * @brief Ritorna il valore letto in input dalla porta data.
     * @return valore in input
     * @author Mirko Ghislanzoni
     */
    @Deprecated
    private char leggi() {
        final String serial = port.readStringUntil(10);

        if (contatore) {
            contatore = false;
            comando = '0';
        }

        if (serial != null) {
            contatore = true;
            comando = serial.charAt(0);
        }

        return comando;
    }
}
