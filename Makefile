
all: build


build:
	touch putty-0.62.tar.gz 
	rm putty-0.62.tar.gz
	touch putty-0.62 
	rm -r putty-0.62
	wget http://the.earth.li/~sgtatham/putty/0.62/putty-0.62.tar.gz
	tar xvf putty-0.62.tar.gz
	mv putty-0.62 putty
	cd putty/unix ; ./configure ;
	python -c 'temp = open("putty/unix/Makefile", "r").read().replace("CFLAGS = -g", "CFLAGS = -fPIC -g"); open("putty/unix/Makefile", "w").write(temp)'
	cd putty/unix ; make ;
	gcc -O2 -Wall -fPIC -DHAVE_CONFIG_H -I/usr/include/gtk-2.0 -I/usr/lib64/gtk-2.0/include -I/usr/include/atk-1.0 -I/usr/include/cairo -I/usr/include/pango-1.0 -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include -I/usr/include/freetype2 -I/usr/include/libpng12 -Iputty/ -Iputty/charset/ -Iputty/windows/ -Iputty/unix/ -Iputty/macosx/  -DTELNET_DEFAULT -c putty.c -o putty.o
	gcc -shared -o libputty.so putty.o  putty/unix/cmdgen.o putty/unix/import.o putty/unix/misc.o putty/unix/notiming.o putty/unix/sshaes.o putty/unix/sshbn.o putty/unix/sshdes.o putty/unix/sshdss.o putty/unix/sshdssg.o putty/unix/sshmd5.o putty/unix/sshprime.o putty/unix/sshpubk.o putty/unix/sshrand.o putty/unix/sshrsa.o putty/unix/sshrsag.o putty/unix/sshsh256.o putty/unix/sshsh512.o putty/unix/sshsha.o putty/unix/time.o putty/unix/tree234.o putty/unix/uxcons.o putty/unix/uxgen.o putty/unix/uxmisc.o putty/unix/uxnoise.o putty/unix/uxstore.o putty/unix/version.o

clean:
	cd putty/unix ; make clean ;
	rm putty.o
	rm libputty.so
	rm -r putty
	rm putty-0.62.tar.gz
	rm putty.pyc

putty.so:
	gcc -O2 -Wall  -DHAVE_CONFIG_H -I/usr/include/gtk-2.0 -I/usr/lib64/gtk-2.0/include -I/usr/include/atk-1.0 -I/usr/include/cairo -I/usr/include/pango-1.0 -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include -I/usr/include/freetype2 -I/usr/include/libpng12 -Iputty/ -Iputty/charset/ -Iputty/windows/ -Iputty/unix/ -Iputty/macosx/  -DTELNET_DEFAULT -c putty.c -o putty.o
	gcc -shared -o libputty.so putty.o  putty/unix/cmdgen.o putty/unix/import.o putty/unix/misc.o putty/unix/notiming.o putty/unix/sshaes.o putty/unix/sshbn.o putty/unix/sshdes.o putty/unix/sshdss.o putty/unix/sshdssg.o putty/unix/sshmd5.o putty/unix/sshprime.o putty/unix/sshpubk.o putty/unix/sshrand.o putty/unix/sshrsa.o putty/unix/sshrsag.o putty/unix/sshsh256.o putty/unix/sshsh512.o putty/unix/sshsha.o putty/unix/time.o putty/unix/tree234.o putty/unix/uxcons.o putty/unix/uxgen.o putty/unix/uxmisc.o putty/unix/uxnoise.o putty/unix/uxstore.o putty/unix/version.o

test:
	time python -c 'from putty import test; test();'

