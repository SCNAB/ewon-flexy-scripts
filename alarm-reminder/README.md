# Alarm Reminder

This script will send emails to the configured adress, reminding the user about a alarm. The user can configure how often emails will be sent.

The emails will be sent if there's an active alarm that has **not** been acknowledged yet and/or if there's an alarm that has been reset and **not** acknowledged.

### Configuration
```java
tagName$       =  "myTag"            // The tag name with alarm enabled
email$         =  "name@company.com" // Primary email to get notified. Separate several emails with ;
ccMail$        =  ""                 // Carbon Copy. Leave empty to ignore. Separate several emails with ;
emailTimer%     =  900               // In seconds, how often should checks and emails be sent?
alarmCounter%  =  1                  // Enable a tag tracking amount of alarms that has been fired?
counterTag$    =  "AlarmTimes"       // If alarmCounter% is set to 1, this is the tag name for tracking alarms
```
