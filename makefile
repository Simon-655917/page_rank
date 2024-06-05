CC=gcc
CFLAGS=-std=c11 -Wall -g -O3 -pthread
LDLIBS=-lm -lrt -pthread

# elenco degli eseguibili da creare
EXECS=pagerank

# primo target: gli eseguibili sono precondizioni
# quindi verranno tutti creati
all: $(EXECS)

pctestCV.o: pctest.c xerrori.h
	$(CC) $(CFLAGS) -c $< -DUSACV -o $@

# regola per la creazione degli eseguibili utilizzando xerrori.o
$(EXECS): pagerank.o xerrori.o
	$(CC) $(LDFLAGS) -o $@ $^ $(LDLIBS)

# regola per la creazione di file oggetto che dipendono da xerrori.h
%.o: %.c xerrori.h
	$(CC) $(CFLAGS) -c $<

# esempio di target che non corrisponde a una compilazione
# ma esegue la cancellazione dei file oggetto e degli eseguibili
clean:
	rm -f *.o $(EXECS)

# crea file zip della lezione
zip:
	zip threads.zip *.c *.h *.py makefile
