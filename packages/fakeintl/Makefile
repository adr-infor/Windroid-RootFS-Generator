all:
	$(CC) -shared -fPIC -o libintl.so.8 libintl.c

install:
	install -Dm600 libintl.h $(DESTDIR)/$(PREFIX)/include/libintl.h
	install -Dm755 libintl.so.8 $(DESTDIR)/$(PREFIX)/lib/libintl.so.8
	ln -sf libintl.so.8 $(DESTDIR)/$(PREFIX)/lib/libintl.so