@rem
@rem Copyright 2015 the original author or authors.
@rem
@rem Licensed under the Apache License, Version 2.0 (the "License");
@rem you may not use this file except in compliance with the License.
@rem You may obtain a copy of the License at
@rem
@rem      https://www.apache.org/licenses/LICENSE-2.0
@rem
@rem Unless required by applicable law or agreed to in writing, software
@rem distributed under the License is distributed on an "AS IS" BASIS,
@rem WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
@rem See the License for the specific language governing permissions and
@rem limitations under the License.
@rem

@if "%DEBUG%" == "" @echo off
@rem ##########################################################################
@rem
@rem  mirogate-consumer startup script for Windows
@rem
@rem ##########################################################################

@rem Set local scope for the variables with windows NT shell
if "%OS%"=="Windows_NT" setlocal

set DIRNAME=%~dp0
if "%DIRNAME%" == "" set DIRNAME=.
set APP_BASE_NAME=%~n0
set APP_HOME=%DIRNAME%..

@rem Add default JVM options here. You can also use JAVA_OPTS and MIROGATE_CONSUMER_OPTS to pass JVM options to this script.
set DEFAULT_JVM_OPTS=

@rem Find java.exe
if defined JAVA_HOME goto findJavaFromJavaHome

set JAVA_EXE=java.exe
%JAVA_EXE% -version >NUL 2>&1
if "%ERRORLEVEL%" == "0" goto init

echo.
echo ERROR: JAVA_HOME is not set and no 'java' command could be found in your PATH.
echo.
echo Please set the JAVA_HOME variable in your environment to match the
echo location of your Java installation.

goto fail

:findJavaFromJavaHome
set JAVA_HOME=%JAVA_HOME:"=%
set JAVA_EXE=%JAVA_HOME%/bin/java.exe

if exist "%JAVA_EXE%" goto init

echo.
echo ERROR: JAVA_HOME is set to an invalid directory: %JAVA_HOME%
echo.
echo Please set the JAVA_HOME variable in your environment to match the
echo location of your Java installation.

goto fail

:init
@rem Get command-line arguments, handling Windows variants

if not "%OS%" == "Windows_NT" goto win9xME_args

:win9xME_args
@rem Slurp the command line arguments.
set CMD_LINE_ARGS=
set _SKIP=2

:win9xME_args_slurp
if "x%~1" == "x" goto execute

set CMD_LINE_ARGS=%*

:execute
@rem Setup the command line

set CLASSPATH=%APP_HOME%\lib\mirogate-consumer-1.0-SNAPSHOT.jar;%APP_HOME%\lib\wot-td-java-0.0.1.jar;%APP_HOME%\lib\slf4j-log4j12-2.0.0-alpha1.jar;%APP_HOME%\lib\rdf4j-storage-3.7.0.pom;%APP_HOME%\lib\rdf4j-client-3.7.0.pom;%APP_HOME%\lib\rdf4j-repository-manager-3.7.0.jar;%APP_HOME%\lib\rdf4j-repository-http-3.7.0.jar;%APP_HOME%\lib\rdf4j-queryalgebra-geosparql-3.7.0.jar;%APP_HOME%\lib\rdf4j-sail-federation-3.7.0.jar;%APP_HOME%\lib\rdf4j-sail-nativerdf-3.7.0.jar;%APP_HOME%\lib\rdf4j-lucene-spin-3.7.0.jar;%APP_HOME%\lib\rdf4j-sail-spin-3.7.0.jar;%APP_HOME%\lib\rdf4j-spin-3.7.0.jar;%APP_HOME%\lib\rdf4j-repository-dataset-3.7.0.jar;%APP_HOME%\lib\rdf4j-shacl-3.7.0.jar;%APP_HOME%\lib\rdf4j-sail-elasticsearch-3.7.0.jar;%APP_HOME%\lib\rdf4j-sail-lucene-3.7.0.jar;%APP_HOME%\lib\rdf4j-sail-solr-3.7.0.jar;%APP_HOME%\lib\rdf4j-sail-lucene-api-3.7.0.jar;%APP_HOME%\lib\rdf4j-repository-sail-3.7.0.jar;%APP_HOME%\lib\rdf4j-sail-inferencer-3.7.0.jar;%APP_HOME%\lib\rdf4j-sail-memory-3.7.0.jar;%APP_HOME%\lib\rdf4j-sail-base-3.7.0.jar;%APP_HOME%\lib\rdf4j-queryalgebra-evaluation-3.7.0.jar;%APP_HOME%\lib\rdf4j-repository-sparql-3.7.0.jar;%APP_HOME%\lib\rdf4j-http-client-3.7.0.jar;%APP_HOME%\lib\rdf4j-rio-jsonld-3.7.0.jar;%APP_HOME%\lib\rdf4j-queryparser-serql-3.7.0.jar;%APP_HOME%\lib\rdf4j-queryparser-sparql-3.7.0.jar;%APP_HOME%\lib\rdf4j-queryrender-3.7.0.jar;%APP_HOME%\lib\rdf4j-queryparser-api-3.7.0.jar;%APP_HOME%\lib\rdf4j-sail-model-3.7.0.jar;%APP_HOME%\lib\rdf4j-sail-api-3.7.0.jar;%APP_HOME%\lib\rdf4j-queryalgebra-model-3.7.0.jar;%APP_HOME%\lib\rdf4j-queryresultio-binary-3.7.0.jar;%APP_HOME%\lib\rdf4j-queryresultio-sparqljson-3.7.0.jar;%APP_HOME%\lib\rdf4j-queryresultio-sparqlxml-3.7.0.jar;%APP_HOME%\lib\rdf4j-queryresultio-text-3.7.0.jar;%APP_HOME%\lib\rdf4j-queryresultio-api-3.7.0.jar;%APP_HOME%\lib\rdf4j-http-protocol-3.7.0.jar;%APP_HOME%\lib\rdf4j-repository-contextaware-3.7.0.jar;%APP_HOME%\lib\rdf4j-repository-event-3.7.0.jar;%APP_HOME%\lib\rdf4j-repository-api-3.7.0.jar;%APP_HOME%\lib\rdf4j-query-3.7.0.jar;%APP_HOME%\lib\rdf4j-rio-binary-3.7.0.jar;%APP_HOME%\lib\rdf4j-rio-n3-3.7.0.jar;%APP_HOME%\lib\rdf4j-rio-nquads-3.7.0.jar;%APP_HOME%\lib\rdf4j-rio-ntriples-3.7.0.jar;%APP_HOME%\lib\rdf4j-rio-rdfjson-3.7.0.jar;%APP_HOME%\lib\rdf4j-rio-rdfxml-3.7.0.jar;%APP_HOME%\lib\rdf4j-rio-trig-3.7.0.jar;%APP_HOME%\lib\rdf4j-rio-trix-3.7.0.jar;%APP_HOME%\lib\rdf4j-rio-turtle-3.7.0.jar;%APP_HOME%\lib\rdf4j-rio-datatypes-3.7.0.jar;%APP_HOME%\lib\rdf4j-rio-languages-3.7.0.jar;%APP_HOME%\lib\rdf4j-rio-api-3.7.0.jar;%APP_HOME%\lib\jsonld-java-0.13.3.jar;%APP_HOME%\lib\httpclient-osgi-4.5.13.jar;%APP_HOME%\lib\httpclient-cache-4.5.13.jar;%APP_HOME%\lib\solr-solrj-7.7.2.jar;%APP_HOME%\lib\httpmime-4.5.13.jar;%APP_HOME%\lib\fluent-hc-4.5.13.jar;%APP_HOME%\lib\httpclient-4.5.13.jar;%APP_HOME%\lib\commons-logging-1.2.jar;%APP_HOME%\lib\log4j-core-2.5.jar;%APP_HOME%\lib\californium-core-3.0.0-M2.jar;%APP_HOME%\lib\httpclient5-fluent-5.1.jar;%APP_HOME%\lib\httpclient5-5.1.jar;%APP_HOME%\lib\gson-2.8.7.jar;%APP_HOME%\lib\element-connector-3.0.0-M2.jar;%APP_HOME%\lib\rdf4j-sparqlbuilder-3.7.0.jar;%APP_HOME%\lib\rdf4j-model-3.7.0.jar;%APP_HOME%\lib\rdf4j-util-3.7.0.jar;%APP_HOME%\lib\jcl-over-slf4j-1.7.30.jar;%APP_HOME%\lib\slf4j-api-2.0.0-alpha1.jar;%APP_HOME%\lib\log4j-1.2.17.jar;%APP_HOME%\lib\log4j-api-2.5.jar;%APP_HOME%\lib\californium-legal-3.0.0-M2.jar;%APP_HOME%\lib\httpcore5-h2-5.1.1.jar;%APP_HOME%\lib\httpcore5-5.1.1.jar;%APP_HOME%\lib\commons-codec-1.15.jar;%APP_HOME%\lib\rdf4j-model-vocabulary-3.7.0.jar;%APP_HOME%\lib\rdf4j-model-api-3.7.0.jar;%APP_HOME%\lib\jaxb-api-2.3.1.jar;%APP_HOME%\lib\guava-30.1.1-jre.jar;%APP_HOME%\lib\jackson-databind-2.11.4.jar;%APP_HOME%\lib\jackson-annotations-2.11.4.jar;%APP_HOME%\lib\jackson-core-2.11.4.jar;%APP_HOME%\lib\opencsv-4.6.jar;%APP_HOME%\lib\commons-text-1.9.jar;%APP_HOME%\lib\commons-io-2.8.0.jar;%APP_HOME%\lib\mapdb-1.0.8.jar;%APP_HOME%\lib\lucene-spatial-extras-7.7.2.jar;%APP_HOME%\lib\spatial4j-0.8.jar;%APP_HOME%\lib\jts-core-1.17.1.jar;%APP_HOME%\lib\lucene-highlighter-7.7.2.jar;%APP_HOME%\lib\lucene-queryparser-7.7.2.jar;%APP_HOME%\lib\lucene-queries-7.7.2.jar;%APP_HOME%\lib\lucene-analyzers-common-7.7.2.jar;%APP_HOME%\lib\lucene-core-7.7.2.jar;%APP_HOME%\lib\commons-lang3-3.12.0.jar;%APP_HOME%\lib\httpcore-osgi-4.4.14.jar;%APP_HOME%\lib\httpcore-nio-4.4.14.jar;%APP_HOME%\lib\httpcore-4.4.14.jar;%APP_HOME%\lib\javax.activation-api-1.2.0.jar;%APP_HOME%\lib\failureaccess-1.0.1.jar;%APP_HOME%\lib\listenablefuture-9999.0-empty-to-avoid-conflict-with-guava.jar;%APP_HOME%\lib\commons-beanutils-1.9.3.jar;%APP_HOME%\lib\commons-collections4-4.2.jar;%APP_HOME%\lib\lucene-join-7.7.2.jar;%APP_HOME%\lib\lucene-memory-7.7.2.jar;%APP_HOME%\lib\lucene-sandbox-7.7.2.jar;%APP_HOME%\lib\lucene-spatial3d-7.7.2.jar;%APP_HOME%\lib\s2-geometry-library-java-1.0.0.jar;%APP_HOME%\lib\commons-math3-3.6.1.jar;%APP_HOME%\lib\zookeeper-3.4.14.jar;%APP_HOME%\lib\stax2-api-3.1.4.jar;%APP_HOME%\lib\woodstox-core-asl-4.4.1.jar;%APP_HOME%\lib\noggit-0.8.jar;%APP_HOME%\lib\commons-collections-3.2.2.jar

@rem Execute mirogate-consumer
"%JAVA_EXE%" %DEFAULT_JVM_OPTS% %JAVA_OPTS% %MIROGATE_CONSUMER_OPTS%  -classpath "%CLASSPATH%" App %CMD_LINE_ARGS%

:end
@rem End local scope for the variables with windows NT shell
if "%ERRORLEVEL%"=="0" goto mainEnd

:fail
rem Set variable MIROGATE_CONSUMER_EXIT_CONSOLE if you need the _script_ return code instead of
rem the _cmd.exe /c_ return code!
if  not "" == "%MIROGATE_CONSUMER_EXIT_CONSOLE%" exit 1
exit /b 1

:mainEnd
if "%OS%"=="Windows_NT" endlocal

:omega
