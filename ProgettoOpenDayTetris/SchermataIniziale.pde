import java.awt.*;
import java.util.Random;

/**
 * Classe che disegna e gestisce la schermata di inizio gioco.
 * @author Stefano Perazzolo, Mirko Ghislanzoni, Francesco Ferlin
 */
public class SchermataIniziale extends Schermata {
    /** Contatore di tick che determina quando è necessario cambiare il colore delle scritte */
    private int cambioColoreTickCounter;
    /** Colore della scritta "TETRIS" */
    private Color coloreTetris;
    /** Sfumatura di grigio che va da 0 a 255 con cui disegnare la scritta "Nuova Partita" */
    private int coloreNuovaPartita;

    /**
     * @brief Costruisce una nuova schermata di gioco
     *        e inizializza i parametri
     * @author Mirko Ghislanzoni
     */
    public SchermataIniziale() {
        cambioColoreTickCounter = 0;
        coloreTetris = Color.black;
        coloreNuovaPartita = 0;
    }

    /**
     * @brief Disegna il menu iniziale di gioco
	   * @author Francesco Ferlin
     */
    @Override
    public void draw() {
        pushMatrix();
        pushStyle();

        background(0);
        textAlign(CENTER);

        textSize(50);
        fill(coloreTetris);
        text("TETRIS", getLarghezza() / 2, getAltezza() * 6 / 25);

        textSize(20);
        fill(coloreNuovaPartita);
        text("Nuova Partita", getLarghezza() / 2, getAltezza() * 3 / 5);

        popMatrix();
        popStyle();
    }

    /**
     * @brief Gestisce la scelta dell'utente di iniziare una nuova partita
	   * @author Mirko Ghislanzoni
     */
    @Override
    public void onInput(int inputVal) {
        if(inputVal == Input.NUOVA_PARTITA)
            mostraSchermata(new SchermataDiGioco());
    }

  	/**
  	 * @brief Gestisce la logica e i colori della schermata
  	 * @author Stefano Perazzolo, Francesco Ferlin
  	 */
    @Override
    public void runTick() {
        cambioColoreTickCounter++;
        // Originariamente il gioco andava a ~7 fps/tps, e il colore cambiava ogni frame, quindi ogni ~150 ms.
        // Adesso è a 20 tps, quindi questo metodo viene chiamato ogni 50 ms.
        // 142 / 50 ~= 3 ticks
        if(cambioColoreTickCounter >= 3) {
            cambioColoreTickCounter = 0;
            
            final Random rn = new Random();
            coloreTetris = new Color(rn.nextInt(254) + 1,
                                     rn.nextInt(254) + 1,
                                     rn.nextInt(254) + 1);
            coloreNuovaPartita = rn.nextInt(254) + 1;
        }
    }
}
