Rem --- eWON start section: Cyclic Section
eWON_cyclic_section:
Rem --- eWON user (start)

Rem --- eWON user (end)
End
Rem --- eWON end section: Cyclic Section
Rem --- eWON start section: Init Section
eWON_init_section:
Rem --- eWON user (start)
//**************************************************************
//    Alarm Indicator
//      Indicates using a tag if any alarm is active!
//
//    By: Jonathan Öhrström | jonathan.ohrstrom@scn.se
//**************************************************************

// Script configs
tagName$       =  "AlarmOn" // The tag that will change
checkTimer%    =  60        // Time in seconds that the script checks for alarms 


//**********************************************
//    Don't change anything below this !
//**********************************************
ONTIMER 1, "@checkAlarm"
TSET 1, checkTimer%
Rem --- eWON user (end)
End
Rem --- eWON end section: Init Section
Rem --- eWON start section: Core
Rem --- eWON user (start)
FUNCTION checkAlarm()
  OPEN "exp:$dtAR$ftT" FOR TEXT INPUT AS 1
  A$ = Get 1 // Title
  A$ = Get 1
  IF(A$ <> "") THEN
    IF((GETIO tagName$) <> 1) THEN
      SETIO tagName$, 1
    ENDIF
  ELSE
    IF((GETIO tagName$) <> 0) THEN
      SETIO tagName$, 0
    ENDIF
  ENDIF
  CLOSE 1
ENDFN
Rem --- eWON user (end)
End
Rem --- eWON end section: Core
