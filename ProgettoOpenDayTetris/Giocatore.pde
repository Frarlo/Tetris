/**
 * Classe contenitore per il punteggio conseguito da un giocatore
 * @author Stefano Perazzolo
 */
public class Giocatore {
    /** La variabile nickname contiene il nome del giocatore */
    private String nickname;
    /** La variabile punteggio contiene lo score del giocatore */
    private int punteggio;

    /**
     * @brief Costruttore senza parametri
     *
     * Crea un giocatore con nome vuoto e punteggio 0
     * @author Stefano Perazzolo
     */
    public Giocatore() {
        nickname = "";
        punteggio = 0;
    }

    /**
     * @brief Costruttore con parametri
     *
     * Crea un giocatore con i parametri dati
     * @param nickname nome del giocatore
     * @param punteggio punti conseguiti
     * @author Stefano Perazzolo
     */
    public Giocatore(String nickname, int punteggio) {
        this.nickname = nickname;
        this.punteggio = punteggio;
    }

    /**
     * @brief Cambia il nome del giocatore con quello dato
     * @param nome nuovo nome del giocatore
     * @author Stefano Perazzolo
     */
    public void setNome(String nome) {
        this.nickname = nome;
    }

    /**
     * @brief Cambia il punteggio del giocatore con quello dato
     * @param punteggio nuovo punteggio
     * @author Stefano Perazzolo
     */
    public void setPunteggio(int punteggio) {
        this.punteggio += punteggio;
    }

    /**
     * @brief Restituisce il nome del giocatore
     * @return nome
     * @author Stefano Perazzolo
     */
    public String getNickname() {
        return nickname;
    }

    /**
     * @brief Restituisce il punteggio del giocatore
     * @return punteggio
     * @author Stefano Perazzolo
     */
    public int getPunteggio() {
        return punteggio;
    }

    /**
     * @brief Restituisce una descrizione del giocatore
     * @return descrizione con nome e punteggio
     * @author Stefano Perazzolo
     */
    @Override
    public String toString() {
        return "Giocatore{" + "nickname=" + nickname + ", punteggio=" + punteggio + '}';
    }
}
