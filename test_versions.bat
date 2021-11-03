@ECHO OFF

SETLOCAL EnableDelayedExpansion

FOR %%A IN ( 2.18 2.18.1 2.19 2.19.1 2.20 2.20.1 2.21.0 2.22.0 2.22.1 2.22.2 ^
    3.0.0-M1 3.0.0-M2 3.0.0-M3 3.0.0-M4 3.0.0-M5 
) DO (
    CALL :execute_mvn_test %%A 
)

EXIT

:execute_mvn_test
SET VERSION=%1
( FOR /F "tokens=* delims=" %%A IN (pom.xml.template) DO ECHO %%A ) > pom.xml
CALL mvn -B test 2>&1 > mvn-test.log
FINDSTR /C:"Tests run: 1" mvn-test.log > NUL
IF %ERRORLEVEL% EQU 0 (
    ECHO Maven %1 DID execute the test^^!
) ELSE (
    ECHO Why didn't Maven %1 execute the test :(
)
REM COPY mvn-test.log mvn-test-%VERSION%.log
DEL mvn-test.log
EXIT /B 0