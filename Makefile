include config.mk
all:

clean:

install: all
	mkdir -p ${DESTDIR}${PREFIX}/bin/
	install bak ${DESTDIR}${PREFIX}/bin/bak
	install colorcheck ${DESTDIR}${PREFIX}/bin/colorcheck
	install decriptdir ${DESTDIR}${PREFIX}/bin/decriptdir
	install dict ${DESTDIR}${PREFIX}/bin/dict
	install double ${DESTDIR}${PREFIX}/bin/double
	install encriptdir ${DESTDIR}${PREFIX}/bin/encriptdir
	install execf ${DESTDIR}${PREFIX}/bin/execf
	install extrename ${DESTDIR}${PREFIX}/bin/extrename
	install lstype ${DESTDIR}${PREFIX}/bin/lstype
	install out ${DESTDIR}${PREFIX}/bin/out
	install rmphdup ${DESTDIR}${PREFIX}/bin/rmphdup
	install run ${DESTDIR}${PREFIX}/bin/run
	install update-grub ${DESTDIR}${PREFIX}/bin/update-grub
	install wminfo ${DESTDIR}${PREFIX}/bin/wminfo
	install ctfix ${DESTDIR}${PREFIX}/bin/ctfix


uninstall:
	rm -f ${DESTDIR}${PREFIX}/bin/bak
	rm -f ${DESTDIR}${PREFIX}/bin/colorcheck
	rm -f ${DESTDIR}${PREFIX}/bin/decriptdir
	rm -f ${DESTDIR}${PREFIX}/bin/dict
	rm -f ${DESTDIR}${PREFIX}/bin/double
	rm -f ${DESTDIR}${PREFIX}/bin/encriptdir
	rm -f ${DESTDIR}${PREFIX}/bin/execf
	rm -f ${DESTDIR}${PREFIX}/bin/extrename
	rm -f ${DESTDIR}${PREFIX}/bin/lstype
	rm -f ${DESTDIR}${PREFIX}/bin/out
	rm -f ${DESTDIR}${PREFIX}/bin/rmphdup
	rm -f ${DESTDIR}${PREFIX}/bin/run
	rm -f ${DESTDIR}${PREFIX}/bin/update-grub
	rm -f ${DESTDIR}${PREFIX}/bin/wminfo
	rm -f ${DESTDIR}${PREFIX}/bin/ctfix

.PHONY: all clean install uninstall
