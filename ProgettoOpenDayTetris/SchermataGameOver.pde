import java.awt.*;

/**
 * Classe che disegna e gestisce la schermata di fine gioco.
 * @author Francesco Ferlin, Mirko Ghislanzoni
 */
public class SchermataGameOver extends Schermata {
    /** Schermata della partita persa a cui è riferito questo oggetto */
    private final SchermataDiGioco schermataPartitaPersa;
	  
    /**
     * @brief Costruisce una nuova schermata di game over
     *        data la schermata della partita appena persa
     * @param schermataPartitaPersa schermata della partita appena persa 
     * @author Francesco Ferlin
     */
    public SchermataGameOver(SchermataDiGioco schermataPartitaPersa) {
        this.schermataPartitaPersa = schermataPartitaPersa;
    }

	  /**
	   * @brief Disegna la schermata di Game Over
	   * @author Francesco Ferlin
	   */	
    @Override
    public void draw() {
        // In background la partita persa
        
        pushMatrix();
        schermataPartitaPersa.draw();
        popMatrix();

        // Disegna il Game Over

        pushStyle();
        pushMatrix();
        
        textAlign(CENTER);
        textSize(75);
        
        fill(Color.gray);
        text("GAME OVER", getLarghezza() / 2 - 5, getAltezza() / 2 - 5);

        fill(255);
        text("GAME OVER", getLarghezza() / 2, getAltezza() / 2);

        popMatrix();
        popStyle();
    }

	  /**
	   * @brief Gestisce l'input dell'utente per far cominciare una nuova partita
	   * @author Mirko Ghislanzoni
	   */
    @Override
    public void onInput(int inputVal) {
        // Inizia una nuova partita
        if(inputVal == Input.NUOVA_PARTITA)
            mostraSchermata(new SchermataIniziale());
    }

  	/**
  	 * @brief Gestisce la logica della schermata
  	 * @author Francesco Ferlin
  	 */
    @Override
    public void runTick() {
    }
}
