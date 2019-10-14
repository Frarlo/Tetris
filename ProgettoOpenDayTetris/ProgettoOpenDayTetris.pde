/**
 * @author Stefano Perazzolo, Francesco Ferlin
 */
import java.awt.*;
import java.util.LinkedList;
import java.util.List;
import java.util.Iterator;

/** Numero massimo di frame al secondo */
private static final int FPS = 240;
/** Numero di game ticks al secondo, ovvero quante volte la logica di gioco deve essere aggiornata in un secondo */
public static final int GAME_TICKS = 20;
/** Valore costante che rappresenta la lunghezza in pixel del lato di ogni quadrato */
public static final int GRANDEZZA_QUADRATO = 25;
/** Indica se deve essere renderizzato il numero di frames al secondo in basso a sinistra dell schermata */
private static final boolean FPS_DISPLAY = true;

/** Oggetto per leggere l'input dell'utente */
private Input userInput;
/** La schermata di gioco corrente */
private Schermata schermataCorrente;
/** Timer usato per determinare i tick del gioco, ovvero quante volte la logica di gioco deve essere aggiornata in un secondo */
private Timer ticksTimer;

/** Lista di timestamps dei frame eseguiti durante il secondo corrente */
private List<Long> framesInSecondo;

/* Porta seriale usata per la comunicazione con arduino */
//private Serial myPort;

/**
 * @brief Setup del programma
 *
 * Inizializza il programma creando tutto ciò che è necessario al
 * funzionamento del gioco (finestra, schermata iniziale, metodo di lettura dell'input, etc.)
 * @author Stefano Perazzolo, Francesco Ferlin
 */
public void setup() {
    size(750, 600);
	
	  userInput = new InputTastiera();

    // myPort = new Serial(this, Serial.list()[0], 9600);
    // myPort.bufferUntil(10);

    frameRate(FPS);
    ticksTimer = new Timer();

    framesInSecondo = new LinkedList<Long>();

    schermataCorrente = new SchermataIniziale();
}

/**
 * @brief Disegna la schermata corrente e gestisce la logica di gioco
 * 
 * Main loop del programma. Si occupa di calcolare i tick,
 * disegnare la schermata corrente e di leggere l'input
 * @author Stefano Perazzolo, Francesco Ferlin
 */
public void draw() {
    if(FPS_DISPLAY) {
        final long currTime = ticksTimer.currentMillis();

        framesInSecondo.add(currTime);
        
        final Iterator<Long> iter = framesInSecondo.iterator();
        
        while(iter.hasNext()) {
            final Long timestamp = iter.next();
            if(currTime - timestamp > 1000)
                iter.remove();
        }
    }

    // Runno i tick in base al tempo passato

    final int elapsedTicks = (int) (ticksTimer.elapsedMillis() / (1000f / GAME_TICKS));

    if(elapsedTicks > 0)
        ticksTimer.reset();

    for (int i = 0; i < elapsedTicks; i++)
        schermataCorrente.runTick();


    pushStyle();
    pushMatrix();

    schermataCorrente.draw();

    popMatrix();
    popStyle();

    if(FPS_DISPLAY) {
        pushStyle();
        pushMatrix();

        fill(Color.white);
        textSize(10);
        text("FPS: " + framesInSecondo.size(), 5, height - 5 - 10);

        popMatrix();
        popStyle();
    }

    int keyInput = userInput.leggiTasto();
    while (keyInput != Input.NO_INPUT) {
        schermataCorrente.onInput(keyInput);
        keyInput = userInput.leggiTasto();
    }
}

/**
 * @brief Sostituisce la schermata corrente con quella data
 * @param nuovaSchermata schermata sostitutiva
 * @author Stefano Perazzolo
 */
public void mostraSchermata(Schermata nuovaSchermata) {
    if (nuovaSchermata != null)
        schermataCorrente = nuovaSchermata;
}

/**
 * @brief Overload del fill di processing
 * 
 * Metodo di utility. Permette di usare la classe Color di awt.
 * @author Francesco Ferlin
 */
void fill(Color colore) {
    fill(colore.getRed(), colore.getGreen(), colore.getBlue(), colore.getAlpha());
}
