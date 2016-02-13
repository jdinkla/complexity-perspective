
/*
 * Die drei "Planeten" in JSON (siehe Abschnitte 6.3 und 2.4)
 */
var cs =
[

    {
        "color": "blau",
        "mass": 3,
        "position": { "x": 2, "y": 1 },
        "velocity": { "x": 2, "y": 0 }
    },

    {
        "color": "grau",
        "mass": 4,
        "position": { "x": 5, "y": 3 },
        "velocity": { "x": 0, "y": 0 }
    },

    {
        "color": "rot",
        "mass": 2,
        "position": { "x": 9, "y": 4 },
        "velocity": { "x": -1, "y": -1 }
    }

];

/*
 * Die in Abschnitt 6.3 im Screenshot von CouchDB gezeigte Abfrage.
 */

var map = function(doc) {
    emit(doc.color, [doc.position.x, doc.velocity.y]);
};




