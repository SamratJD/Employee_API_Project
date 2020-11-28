# Employee_API_Project

## Pre-requisites for this project:
Karate requires Java 8 (at least version 1.8.0_112 or greater), Maven and Eclipse (or any suitable IDE) to be installed.

## Maven Plugins:
1. cluecumber-report-plugin
2. maven-compiler-plugin

## Maven Dependencies:
1. karate-apache
2. karate-junit4
3. cucumber-reporting

## To execute via Junit, run the below file as Junit test:
*\src\test\java\examples\employees\KarateRunner.java*

## To run via Maven command use the 2 commands below:
Command #1 to run the test. Command #2 to generate the HTML report in target/generated-report folder

`mvn clean test -Dtest=KarateRunner -Dkarate.options="--tags @employees`

`mvn cluecumber-report:reporting`
