all'inizio della funzione PageRank alloco due vettori, x e x_1, che rappresentano rispettivamente il vettore PageRank corrente e il vettore aggiornato dopo ogni iterazione.
inizializzo un set di semafori (sem_work_to_do e sem_work_done) e mutex (mue per l'errore e muidx per l'indice corrente) per gestire la sincronizzazione tra i thread.
Creo un array di strutture ThreadData, una per ogni thread, che contiene tutti i riferimenti necessari per l'esecuzione, inclusi i puntatori ai vettori, i semafori, i mutex e le variabili di controllo.
Ogni thread esegue la funzione aux_thread, che gestisce una porzione del calcolo del PageRank in modo concorrente.

Funzionamento dei Thread

Ogni thread attende un segnale dal semaforo sem_work_to_do che indica la disponibilità di lavoro.
Controlla la variabile continue_working per determinare se deve continuare le iterazioni. Se false, il thread termina.
Accede in modo sicuro all'indice condiviso current_idx usando un mutex. Se l'indice supera il numero di nodi, il thread segnala il completamento del suo lavoro e va alla prossima iterazione del while dove si mette in attesa con sem_wait.
se l'indice non supera il numero dei nodi viene salvato in locale nel thread, viene incrementato e sbloccato per gli altri thread.
Calcola una porzione del PageRank e aggiorna l'errore accumulato tramite la funzione fabs che restituisce il valore assoluto sempre bloccando e sbloccando il mutex.

Sincronizzazione e Aggiornamento:

Dopo aver completato il loro lavoro, i thread segnalano tramite il semaforo sem_work_done.
Il thread principale attende che tutti i thread abbiano finito (usando sem_work_done), poi aggiorna il vettore PageRank x con i nuovi valori calcolati in x_1.
Verifica la condizione di terminazione basata sull'errore accumulato e sul numero massimo di iterazioni. Se soddisfatta, imposta continue_working su false e segnala ai thread di prepararsi a terminare, in caso contrario il ciclo continuera' le iterazioni reimpostando i semafori sem_work_to_do e sem_work_done.
