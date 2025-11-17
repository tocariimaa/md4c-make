MD_VERSION_MAJOR = 0
MD_VERSION_MINOR = 5
MD_VERSION_RELEASE = 2
MD_VERSION = $(MD_VERSION_MAJOR).$(MD_VERSION_MINOR).$(MD_VERSION_RELEASE)
VERSION_DEFS = -DMD_VERSION="\"$(MD_VERSION)\"" \
			   -DMD_VERSION_MINOR="\"$(MD_VERSION_MINOR)\"" \
			   -DMD_VERSION_MAJOR="\"$(MD_VERSION_MAJOR)\""	\
			   -DMD_VERSION_RELEASE="\"$(MD_VERSION_RELEASE)\""

MD4C_SRC = src/md4c.c
MD4LIBS = src/md4c.o src/md4c-html.o src/entity.o

CFLAGS = -O2 -pipe
LIBCFLAGS = $(CFLAGS)

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
