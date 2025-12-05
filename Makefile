.POSIX:

include config.mk

all: md2html/md2html

src/md4c.o: $(MD4C_SRC) src/md4c.h
	$(CC) $(LIBCFLAGS) -c -DMD4C_USE_UTF8 -o $@ $(MD4C_SRC)

src/entity.o: src/entity.c src/entity.h
	$(CC) $(LIBCFLAGS) -c -o $@ $<

src/md4c-html.a: src/md4c-html.c src/md4c-html.h src/entity.o
	$(CC) $(LIBCFLAGS) -c -o $@ $<
	$(AR) rcs src/md4c-html.a src/md4c-html.o src/entity.o

md2html/cmdline.o: md2html/cmdline.c md2html/cmdline.h
	$(CC) $(CFLAGS) -c -o $@ $<

md2html/md2html: md2html/md2html.c $(MD4LIBS) md2html/cmdline.o
	$(CC) $(CFLAGS) $(VERSION_DEFS) -o $@ $^

clean:
	rm -rf src/*.o src/*.a md2html/md2html md2html/*.o

install-md4c: src/md4c.o
	mkdir -p $(DESTDIR)$(PREFIX)/lib
	cp -f src/md4c.o $(DESTDIR)$(PREFIX)/lib

install-md4c-html: src/md4c-html.a
	mkdir -p $(DESTDIR)$(PREFIX)/lib
	cp -f src/md4c-html.a $(DESTDIR)$(PREFIX)/lib

install-md2html: md2html/md2html
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	cp -f md2html/md2html $(DESTDIR)$(PREFIX)/bin
	chmod 755 $(DESTDIR)$(PREFIX)/bin/md2html
	mkdir -p $(DESTDIR)$(MANPREFIX)/man1
	cp -f md2html/md2html.1 $(DESTDIR)$(MANPREFIX)/man1
	chmod 644 $(DESTDIR)$(MANPREFIX)/man1/md2html.1

install: install-md4c install-md4c-html install-md2html

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/md2html $(DESTDIR)$(MANPREFIX)/man1/md2html.1
	rm -f $(DESTDIR)$(PREFIX)/lib/md4c.o $(DESTDIR)$(PREFIX)/lib/md4c-html.a

.PHONY: all clean install install-md4c install-md4c-html uninstall
