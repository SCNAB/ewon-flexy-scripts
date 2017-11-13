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
//    Alarm Reminders
//      PARAMS
//      $tagParam$    :  The tag you wish to query
//      myTag@        :  Premade tag with alarm enabled
//      AlarmTimes@   :  Premade tag that tracks alarms
//
//    By: Jonathan Öhrström | jonathan.ohrstrom@scn.se
//**************************************************************

// Script configs
tagName$       =  "myTag" // The tag name with alarm enabled
email$         =  "name@company.com" // Primary email to get notified. Separate several emails with ;
ccMail$        =  "" // Carbon Copy. Leave empty to ignore. Separate several emails with ;
alarmCounter%  =  1 // Enable a tag tracking amount of alarms that has been fired?
counterTag$    =  "AlarmTimes" // If alarmCounter% is set to 1, this is the tag name for tracking alarms

ONALARM (GETIO tagName$), "@AlarmIncr()"
ONTIMER 1, "@alarmReminder()"
Rem --- eWON user (end)
End
Rem --- eWON end section: Init Section
Rem --- eWON start section: Core
Rem --- eWON user (start)
FUNCTION alarmReminder()

  // Code 4 = Returned to normal but not acknowledged
  IF(ALSTAT (GETIO tagName$) = 4) THEN
    SENDMAIL email$, ccMail$, "Alarm has returned to normal", "The alarm for tag myTag has not yet been acknowledged. Please do so as soon as possible."
    
    @log("Sent reminder regarding a nulled alarm that has not been acknowledged") // Do some logging
  ENDIF
  
  // Code 2 = In alarm
  IF(ALSTAT (GETIO tagName$) = 2) THEN
    SENDMAIL email$, ccMail$, "Alarm is still active", "The alarm for tag myTag is still active and has not yet been acknowledged. The tag is set to " + STR$ (GETIO tagName$) + "." + " Please check it as soon as possible."
  
    @log("Sent reminder regarding an active alarm that has not been acknowledged")
  ENDIF
  
  // Kill timer if inactive
  IF((ALSTAT (GETIO tagName$) <> 4) AND (ALSTAT (GETIO tagName$) <> 2)) THEN
    TSET 1, 0
    
    @log("Killed the timer.")
  ENDIF
  
ENDFN

// This will basically just send the mail and increment the tracker
FUNCTION AlarmIncr()
  IF(alarmCounter% = 1) THEN
    SETIO counterTag$, (GETIO counterTag$ +1) // Increment the counter by 1
  ENDIF
  
  TSET 1, 900 // Start checker for alarm reminders
  @log("New timer has been created since an alarm was fired")
ENDFN

// Returns the current status of your tag
FUNCTION getStatus()
  
  IF(ALSTAT (GETIO tagName$) = 0) THEN
    Print "No alarm"
  ENDIF
  
  IF(ALSTAT (GETIO tagName$) = 1) THEN
    Print "Pretrigger"
  ENDIF
  
  IF(ALSTAT (GETIO tagName$) = 2) THEN
    Print "In alarm"
  ENDIF
  
  IF(ALSTAT (GETIO tagName$) = 3) THEN
    Print "In alarm but acknowledged"
  ENDIF
  
  IF(ALSTAT (GETIO tagName$) = 4) THEN
    Print "Returned to normal but not acknowledged"
  ENDIF
  
ENDFN
Rem --- eWON user (end)
End
Rem --- eWON end section: Core
Rem --- eWON start section: Misc.
Rem --- eWON user (start)
FUNCTION log($szMessage$)
  Print "Log: " + $szMessage$
ENDFN
Rem --- eWON user (end)
End
Rem --- eWON end section: Misc.