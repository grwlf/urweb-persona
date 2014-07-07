# This Makefile was generated by the Cake3
# https://github.com/grwlf/cake3

GUARD = .cake3/GUARD_$(1)_$(shell echo $($(1)) | md5sum | cut -d ' ' -f 1)

ifeq ($(MAIN),1)
unexport MAIN

# Main section

LIBJANSSON = $(shell pkg-config --libs jansson)
LIBLIBCURL = $(shell pkg-config --libs libcurl)
URCC = $(shell $(shell urweb -print-ccompiler) -print-prog-name=gcc)
URINCL = -I$(shell urweb -print-cinclude) 
URVERSION = $(shell urweb -version)
.PHONY: all
all: ./Makefile ./persona.exe ./persona.sql
./persona.exe: .fix-multy1
./persona.urp: ./../uru3/Uru/lib.urp ./Makefile ./ffi.h ./ffi.o ./persona.ur ./persona.urs .cake3/tmppersona.in0 autogen/Urweb_persona_js.ur autogen/Urweb_persona_js.urs autogen/Urweb_persona_js_c.h autogen/Urweb_persona_js_c.o $(call GUARD,LIBJANSSON) $(call GUARD,LIBLIBCURL)
	cat .cake3/tmppersona.in0 | sed 's@%LIBCURL%@$(LIBLIBCURL)@' | sed 's@%JANSSON%@$(LIBJANSSON)@' > ./persona.urp
.cake3/tmppersona.in0: ./Makefile
	-rm -rf .cake3/tmppersona.in0
	echo 'allow mime text/javascript' >> .cake3/tmppersona.in0
	echo 'database dbname=persona' >> .cake3/tmppersona.in0
	echo 'sql ./persona.sql' >> .cake3/tmppersona.in0
	echo 'script https://login.persona.org/include.js' >> .cake3/tmppersona.in0
	echo 'ffi ./personaFfi' >> .cake3/tmppersona.in0
	echo 'jsFunc PersonaFfi.request = request' >> .cake3/tmppersona.in0
	echo 'jsFunc PersonaFfi.logout = logout' >> .cake3/tmppersona.in0
	echo 'jsFunc PersonaFfi.watch = watch' >> .cake3/tmppersona.in0
	echo 'ffi ./ffi' >> .cake3/tmppersona.in0
	echo 'link %JANSSON%' >> .cake3/tmppersona.in0
	echo 'link %LIBCURL%' >> .cake3/tmppersona.in0
	echo 'link ./ffi.o' >> .cake3/tmppersona.in0
	echo 'include ./ffi.h' >> .cake3/tmppersona.in0
	echo 'safeGet Persona/signin' >> .cake3/tmppersona.in0
	echo 'safeGet Persona/signout' >> .cake3/tmppersona.in0
	echo 'allow responseHeader X-UA-Compatible' >> .cake3/tmppersona.in0
	echo 'include autogen/Urweb_persona_js_c.h' >> .cake3/tmppersona.in0
	echo 'link autogen/Urweb_persona_js_c.o' >> .cake3/tmppersona.in0
	echo 'ffi autogen/Urweb_persona_js_c' >> .cake3/tmppersona.in0
	echo 'ffi autogen/Urweb_persona_js_js' >> .cake3/tmppersona.in0
	echo 'allow mime text/javascript' >> .cake3/tmppersona.in0
	echo 'safeGet Urweb_persona_js/blobpage' >> .cake3/tmppersona.in0
	echo 'safeGet Urweb_persona_js/blob' >> .cake3/tmppersona.in0
	echo 'safeGet Persona/main' >> .cake3/tmppersona.in0
	echo 'safeGet Persona/persjs' >> .cake3/tmppersona.in0
	echo 'library ./../uru3/Uru' >> .cake3/tmppersona.in0
	echo 'debug' >> .cake3/tmppersona.in0
	echo '' >> .cake3/tmppersona.in0
	echo 'autogen/Urweb_persona_js' >> .cake3/tmppersona.in0
	echo './persona' >> .cake3/tmppersona.in0
./ffi.o: ./Makefile ./ffi.c $(call GUARD,URCC) $(call GUARD,URINCL) $(call GUARD,UR_CFLAGS)
	$(URCC) -c $(URINCL) $(UR_CFLAGS) $(shell pkg-config --cflags libcurl) $(shell pkg-config --cflags jansson)  -o ./ffi.o ./ffi.c
./persona.sql: .fix-multy1
.INTERMEDIATE: .fix-multy1
.fix-multy1: ./Makefile ./persona.urp $(call GUARD,URVERSION)
	urweb -dbms sqlite ./persona
autogen/Urweb_persona_js_c.o: ./Makefile autogen/Urweb_persona_js_c.c $(call GUARD,URCC) $(call GUARD,URINCL) $(call GUARD,UR_CFLAGS)
	$(URCC) -c $(URINCL) $(UR_CFLAGS) $(shell pkg-config --cflags libcurl) $(shell pkg-config --cflags jansson)  -o autogen/Urweb_persona_js_c.o autogen/Urweb_persona_js_c.c
$(call GUARD,LIBJANSSON):
	rm -f .cake3/GUARD_LIBJANSSON_*
	touch $@
$(call GUARD,LIBLIBCURL):
	rm -f .cake3/GUARD_LIBLIBCURL_*
	touch $@
$(call GUARD,URCC):
	rm -f .cake3/GUARD_URCC_*
	touch $@
$(call GUARD,URINCL):
	rm -f .cake3/GUARD_URINCL_*
	touch $@
$(call GUARD,URVERSION):
	rm -f .cake3/GUARD_URVERSION_*
	touch $@
$(call GUARD,UR_CFLAGS):
	rm -f .cake3/GUARD_UR_CFLAGS_*
	touch $@

else

# Prebuild/postbuild section

ifneq ($(MAKECMDGOALS),clean)

.PHONY: all
all: .fix-multy1
.PHONY: ./persona.exe
./persona.exe: .fix-multy1
.PHONY: ./persona.urp
./persona.urp: .fix-multy1
.PHONY: .cake3/tmppersona.in0
.cake3/tmppersona.in0: .fix-multy1
.PHONY: ./ffi.o
./ffi.o: .fix-multy1
.PHONY: ./persona.sql
./persona.sql: .fix-multy1
.INTERMEDIATE: .fix-multy1
.fix-multy1: 
	-mkdir .cake3
	urweb -print-cinclude >/dev/null
	$(MAKE) -C ./../uru3/Uru -f Makefile 
	MAIN=1 $(MAKE) -f ./Makefile $(MAKECMDGOALS)
.PHONY: autogen/Urweb_persona_js_c.o
autogen/Urweb_persona_js_c.o: .fix-multy1

endif
.PHONY: clean
clean: 
	-rm ./ffi.o ./persona.exe ./persona.sql ./persona.urp .cake3/tmppersona.in0 autogen/Urweb_persona_js_c.o
	-rm -rf .cake3

endif
