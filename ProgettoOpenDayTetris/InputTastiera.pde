import java.awt.event.KeyEvent;
import java.util.LinkedList;
import java.util.Queue;

/**
 * Legge l'input dell'utente da tastiera
 * @author Francesco Ferlin
 */
public class InputTastiera implements Input {
    /** Vettore di tasti di cui deve essere gestito l'input */
    private final Key[] keys = new Key[] {
            new Key(KeyEvent.VK_D, true, Input.SPOSTA_DESTRA),
            new Key(KeyEvent.VK_A, true, Input.SPOSTA_SINISTRA),
            new Key(KeyEvent.VK_W, true, Input.SPOSTA_GIU),
            new Key(KeyEvent.VK_RIGHT, false, Input.RUOTA_DESTRA),
            new Key(KeyEvent.VK_LEFT, false, Input.RUOTA_SINISTRA),
            new Key(KeyEvent.VK_SPACE, false, Input.DROP),
            new Key(KeyEvent.VK_ENTER, false, Input.NUOVA_PARTITA)
    };
    /** Fila di tasti premuti ma di cui {@link #leggiTasto()} non ha ancora restituito il valore */
    private final Queue<Key> pressed = new LinkedList<Key>();

    /**
     * @brief Costruisce un nuovo oggetto per leggere input da tastiera
     * @author Francesco Ferlin
     */
    public InputTastiera() {
        registerMethod("keyEvent", this);
    }
  
    /**
     * @brief Restituisce l'input letto da tastiera
     * 
     * @see Input#leggiTasto()
     * @return input letto da tastiera
     * @author Francesco Ferlin
     */
    @Override
    public int leggiTasto() {
        if(pressed.isEmpty())
            return Input.NO_INPUT;
        return pressed.poll().getValue();
    }

    /**
     * @brief Metodo che riceve e gestisce i pulsanti premuti
     *
     * E' un metodo di processing registrato nel costruttore
     * e si occupa di aggiungere alla coda {@link #pressed} 
     * i tasti premuti in base agli eventi ricevuti.
     * @param event KeyEvent che descrive il tasto che è stato premuto
     * @author Francesco Ferlin
     */
    public void keyEvent(processing.event.KeyEvent event) {
        final boolean isPressEvent = event.getAction() == processing.event.KeyEvent.PRESS;

        if(!isPressEvent && event.getAction() != processing.event.KeyEvent.RELEASE)
            return;

        for(Key key : keys)
            if(key.getKeyCode() == event.getKeyCode()) {
                if(isPressEvent)
                    if(!key.isPressed() || key.isRepeatEnabled())
                        pressed.offer(key);
                key.setPressed(isPressEvent);
            }
    }

    /**
     * Oggetto che mette in correlazione il codice identificativo effettivo di un tasto
     * con il corrispettivo input da ritornare, come richiesto da {@link Input#leggiTasto()}.
     * 
     * Contiene inoltre lo stato corrente del tasto e preferenze che lo riguardano.
     *
     * @author Francesco Ferlin
     */
    private class Key {
        /** Codice identificativo effettivo del tasto */
        private final int keyCode;
        /** 
         * Indica se il tasto, quando premuto, deve generare 
         * nuovi eventi senza aspettare che venga rilasciato 
         */
        private final boolean repeatEnabled;
        /** Valore in input da ritornare, come richiesto da {@link Input#leggiTasto()}.  */
        private final int value;

        /** Indica se il tasto è premuto. */
        private boolean isPressed;

        /**
         * @brief Costruisce un nuovo tasto con i parametri desiderati.
         *
         * @param keyCode codice identificativo effettivo del tasto
         * @param repeatEnabled se vero il tasto quando premuto genererà 
         *                      nuovi eventi senza aspettare di essere rilasciato
         * @param value valore in input da ritornare, come richiesto da {@link Input#leggiTasto()}
         * @author Francesco Ferlin
         */
        public Key(int keyCode, boolean repeatEnabled, int value) {
            this.keyCode = keyCode;
            this.repeatEnabled = repeatEnabled;
            this.value = value;
        }

        /**
         * @brief Setta se il tasto è premuto o meno.
         * @param pressed vero se il tasto è premuto
         * @author Francesco Ferlin
         */
        public void setPressed(boolean pressed) {
            isPressed = pressed;
        }

        /**
         * @brief Restituisce il codice identificativo effettivo del tasto
         * @return codice identificativo del tasto
         * @author Francesco Ferlin
         */
        public int getKeyCode() {
            return keyCode;
        }

        /**
         * @brief Restituisce se il tasto, quando premuto, deve generare 
         *        nuovi eventi senza aspettare che venga rilasciato.
         * @return true se è abilitato
         * @author Francesco Ferlin
         */
        public boolean isRepeatEnabled() {
            return repeatEnabled;
        }

        /** 
         * @brief Restituisce il valore in input da ritornare,
         *        come richiesto da {@link Input#leggiTasto()}
         * @return valore in input
         * @author Francesco Ferlin
         */
        public int getValue() {
            return value;
        }

        /**
         * @brief Restituisce se il tasto è premuto
         * @return true se il tasto è premuto
         * @author Francesco Ferlin
         */
        public boolean isPressed() {
            return isPressed;
        }
    }
}
