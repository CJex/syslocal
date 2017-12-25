@ECHO OFF
sc config wzcsvc start= disabled
sc config Alerter start= disabled
sc config ALG start= disabled
sc config wuauserv start= disabled
sc config BITS start= disabled
sc config Browser start= disabled
sc config ERSvc start= disabled
sc config helpsvc start= disabled
sc config Imapiservice start= disabled
sc config cisvc start= disabled
sc config spooler start= disabled
sc config RemoteRegistry start= disabled
sc config wscsvc start= disabled
sc config LanmanServer start= disabled
sc config ShellHWDetection start= disabled
sc config srservice start= disabled
sc config Schedule start= disabled
sc config themes start= disabled
sc config SharedAccess start= disabled
sc config stisvc start= disabled
sc config W32Time start= disabled

@ECHO ON
pause

