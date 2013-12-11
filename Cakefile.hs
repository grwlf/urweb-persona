module Cakefile where

import Development.Cake3
import Development.Cake3.Ext.UrWeb as C3
import Cakefile_P

instance IsString File where fromString = file

project = do

  a <- uwapp "-dbms sqlite" "persona.urp" $ do
    allow mime "text/javascript"
    rewrite C3.all "Persona/*"
    database "dbname=persona"
    sql "persona.sql"
    script "/persjs"
    script "https://login.persona.org/include.js"
    ffi "personaFfi"
    jsFunc "PersonaFfi" "request" "request"
    jsFunc "PersonaFfi" "logout" "logout"
    jsFunc "PersonaFfi" "watch" "watch"
    -- effectful "PersonaFfi.request"
    -- effectful "PersonaFfi.logout"
    -- effectful "PersonaFfi.watch"
    ffi "ffi.urs"
    link "ffi.o"
    pkgconfig "jansson" 
    pkgconfig "libcurl"
    include "ffi.h"
    -- benignEffectful "Ffi.http_post"
    -- benignEffectful "Ffi.json_get_string"
    safeGet "signin"
    safeGet "signout"
    allow responseHeader "X-UA-Compatible"
    bin "autogen" "urweb_persona.js"
    safeGet "main"
    safeGet "persjs"

    ur (pair "persona.ur")

  rule $ do
    phony "all"
    depend a

  return ()

main = do
  writeMake (file "Makefile") (project)
  writeMake (file "Makefile.devel") (selfUpdate >> project)


