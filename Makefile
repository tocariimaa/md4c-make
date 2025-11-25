.POSIX:

include config.mk

all: md2html/md2html

src/md4c.o: $(MD4C_SRC) src/md4c.h
	$(CC) $(LIBCFLAGS) -c -DMD4C_USE_UTF8 -o $@ $(MD4C_SRC)

src/entity.o: src/entity.c src/entity.h
	$(CC) $(LIBCFLAGS) -c -o $@ $<

src/md4c-html.o: src/md4c-html.c src/md4c-html.h src/entity.o
	$(CC) $(LIBCFLAGS) -c -o $@ $<

md2html/cmdline.o: md2html/cmdline.c md2html/cmdline.h
	$(CC) $(CFLAGS) -c -o $@ $<

md2html/md2html: md2html/md2html.c $(MD4LIBS) md2html/cmdline.o
	$(CC) $(CFLAGS) $(VERSION_DEFS) -o $@ $^

clean:
	rm -rf src/*.o md2html/md2html md2html/*.o

.PHONY: all clean
