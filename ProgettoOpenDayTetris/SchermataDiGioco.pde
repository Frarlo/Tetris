/**
 * Classe che disegna e gestisce una sessioen di gioco vera e propria.
 * @author Francesco Ferlin, Perazzolo Stefano
 */  
public class SchermataDiGioco extends Schermata {
    /** Forza con cui la forma attiva viene spostata verso il basso */
    private final float GRAVITA = 1f;

    /** Collezione per gestire la gestione delle forme */
    private CampoDiGioco campo;
    /** Il giocatore della partita corrente */
    private final Giocatore giocatore;
    /** Contatore di tick necessario a determinare quando la forma attiva deve scendere di uno per la gravità */
    private float contatoreTickCaduta;
    
    /**
     * @brief Costruisce una nuova schermata di gioco
     *        e azzera i parametri
     * @author Perazzolo Stefano
     */
    public SchermataDiGioco() {
        campo = new CampoDiGioco();
        giocatore = new Giocatore();
        contatoreTickCaduta = 0;
    }

    /**
     * @brief Disegna l'interfaccia di gioco
     * @author Perazzolo Stefano, Francesco Ferlin
     */
    @Override
    public void draw() {

        pushStyle();
        pushMatrix();

        background(0, 0, 0);

        // Disegno le figure

        campo.draw();

        // Informazioni sul giocatore

        final int altezzaTesto = 24;
        final int bordo = 20;

        textSize(altezzaTesto);

        final int startX = campo.getMaxPosX();
        final int larghezza = Math.round(textWidth("Punteggio:")) + bordo * 2;

        final int altezza = altezzaTesto * 2 + bordo * 2 + 2;
        final int startY = campo.getCentroY() - altezza / 2;

        noFill();
        stroke(0, 0, 255);
        rect(startX, startY, larghezza, altezza);

        fill(255, 0, 0);
        text("Punteggio:", startX + bordo, startY + bordo + altezzaTesto);
        text(giocatore.getPunteggio(), startX + bordo, startY + bordo + 2 + altezzaTesto * 2);

        popMatrix();
        popStyle();
    }

    /**
     * @brief Gestisce la forma attiva(creazione e gravità) e il punteggio
     * @author Perazzolo Stefano, Francesco Ferlin
     */
    @Override
    public void runTick() {
      
        // Controllo se ho disattivato la figura attiva e in caso negativo ne creo una nuova

        if (campo.getFormaAttiva() == null) {
            campo.nuovaForma();
        } else /* if(formaAttiva != null) */ {
            // A velocità = 1, a 20 tick, cade un blocco ogni 5 tick,
            // ovvero 1 blocck ogni 250 ms.
            // Velocità 2 sarà un blocco ogni 100 ms e così via.
            contatoreTickCaduta++;

            final float ticksNecessari = GAME_TICKS / (4f * GRAVITA);
            for(; contatoreTickCaduta > ticksNecessari; contatoreTickCaduta -= ticksNecessari)
                spostaGiu();
        }

        //inizio dei controlli per le righe e le colonne

        giocatore.setPunteggio(campo.cancellaRigheComplete() * 100);

        //controllo un possibile gameOver in base al riempimento delle varie colonne

        final FileDiTesto file = new FileDiTesto();
        if(campo.hasReachedPrimaRiga()) {
            file.scriviSuFileESuVettore("Giocatore", giocatore.getPunteggio());
            mostraSchermata(new SchermataGameOver(this));
        }
    }

    /**
     * @brief Gestisce l'input dell'utente
     *
     * Il metodo prende come parametro la scelta dell'utente ed esegue l'azione adeguata
     * @param key valore tra quelli descritti in {@link Input#leggiTasto()}
     * @author Perazzolo Stefano
     */
    @Override
    public void onInput(int inputVal) {
        if(campo.getFormaAttiva() == null)
            return;

        if(inputVal == Input.SPOSTA_DESTRA) {
            //controllo se è possibile spostare la figura a destra(secondo richesta dell'utente)
            campo.getFormaAttiva().trasla(0, 1);
        } else if(inputVal == Input.SPOSTA_SINISTRA) {
            //controllo se è possibile spostare la figura a sinistra(secondo richesta dell'utente)
            campo.getFormaAttiva().trasla(0, -1);
        } else if(inputVal == Input.SPOSTA_GIU) {
            //controllo se è possibile spostare la figura in basso(secondo richesta dell'utente)
            spostaGiu();
        } else if(inputVal == Input.RUOTA_DESTRA) {
            //controllo se è possibile ruotare la figura(secondo richesta dell'utente)
            campo.getFormaAttiva().ruotaDestra();
        } else if(inputVal == Input.RUOTA_SINISTRA) {
            //controllo se è possibile ruotare la figura(secondo richesta dell'utente)
            campo.getFormaAttiva().ruotaSinistra();
        } else if(inputVal == Input.DROP) {
            //controllo se è possibile ruotare la figura(secondo richesta dell'utente)
            while(campo.getFormaAttiva() != null)
                spostaGiu();
        }
    }

    /**
     * @brief Sposta la figura attiva verso il basso
     *
     * Sposta la figura attiva verso il basso e la disattiva
     * se collide verticalmente con una superficie.
     * @author Perazzolo Stefano
     */
    private void spostaGiu() {
        if (!campo.getFormaAttiva().trasla(1, 0))
            campo.disattiva();
    }
}
