      $set sourceformat"free"

      *>==============================================================
       identification division.
       program-id.  CS00006S.
      *>==============================================================

      *>
      *>   --------------------------------------------------------
      *>                           SLEEP
      *>            API p/ WINDOWS || shell system p/ UNIX
      *>   --------------------------------------------------------
      *>

      *>==============================================================
       environment division.
            special-names.
               console is crt                                         *>DOS
               decimal-point is comma
               call-convention 66 is winapi                           *>DOS
               .
      *>==============================================================

      *>==============================================================
       working-storage section.
       78   versao                      value "b".
       77   uso-dll                     procedure-pointer.
       77   ws-mili-segundos            pic 9(09) comp-5 value zeros.
       77   ws-comando-unix             pic x(150) value spaces.

       linkage section.
       01   lk-segundos                 pic 9(06).

      *>==============================================================
       procedure division using lk-segundos.

      *>==============================================================
       0000-controle section.
       0000.
            set uso-dll                 to entry "kernel32.dll".      *>DOS
            compute ws-mili-segundos = lk-segundos * 1000.            *>DOS
            call winapi "Sleep" using by value ws-mili-segundos.      *>DOS

      *>    string "sleep ", lk-segundos, x"00"                       *>UNIX
      *>           into ws-comando-unix                               *>UNIX
      *>    call "SYSTEM" using ws-comando-unix.                      *>UNIX
       0000-saida.
            exit program
            stop run.