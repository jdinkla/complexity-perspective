#!/usr/bin/env bash
#
# Mit diesen Statements werden die drei "Planeten" in CouchDB angelegt (siehe Abschnitt 6.3)
#
# Dazu wird das Programm "curl" benötigt. Man kann diese Planeten auch auf der Weboberfläche anlegen.
#
curl -X PUT http://127.0.0.1:5984/model

curl -H 'Content-type: application/json' -X POST http://127.0.0.1:5984/model -d '{ "color": "blau", "mass": 3, "position": { "x": 2, "y": 1 }, "velocity": { "x": 2, "y": 0 } }'

curl -H 'Content-type: application/json' -X POST http://127.0.0.1:5984/model -d '{ "color": "grau", "mass": 4, "position": { "x": 5, "y": 3 }, "velocity": { "x": 0, "y": 0 } }'

curl -H 'Content-type: application/json' -X POST http://127.0.0.1:5984/model -d '{ "color": "rot", "mass": 2, "position": { "x": 9, "y": 4 }, "velocity": { "x": -1, "y": -1 } }'





