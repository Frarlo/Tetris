import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

/**
 * Classe che si occupa di salvare la classifica di gioco
 * sul file "classifica.txt"
 * @author Francesco Ferlin
 */
public class FileDiTesto {

    /**
     * @brief Scrive il punteggio del giocatore dato sul file "classifica.txt"
     *
     * Salva sul file "classifica.txt" le informazioni date, formattandole
     * in 'nome + "," + punteggio' e crea e aggiunge in coda al vettore
     * un nuovo oggetto Giocatore
     *
     * @see Giocatore
     *
     * @param nome nome del giocatore
     * @param punteggio punteggio del giocatore
     * @return true se l'operazione di scrittura è andata a buon fine
     * @author Francesco Ferlin
     */
    public boolean scriviSuFileESuVettore(String nome, int punteggio) {
        final File file = new File("classifica.txt");

        try {
            final BufferedWriter bw = new BufferedWriter(new FileWriter(file, true));
            bw.write(nome + "," + punteggio + "\n");
            bw.close();
            return true;
        } catch (IOException ignored) {
            ignored.printStackTrace();
            return false;
        }
    }
}
