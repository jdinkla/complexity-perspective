//
// Dieses ist der Code aus Abschnitt 6.3
//

CREATE
    (A:Person {name: 'Anton'}),
    (B:Person {name: 'Berta'}),
    (C:Person {name: 'Charlie'}),
    (D:Person {name: 'Dennis'}),
    (K:Stadt {name: 'Köln'}),
    (Be:Stadt {name: 'Berlin'}),
    (A)-[:KNOWS]->(B),
    (A)-[:KNOWS]->(C),
    (B)-[:KNOWS]->(A),
    (B)-[:KNOWS]->(C),
    (B)-[:KNOWS]->(D),
    (C)-[:KNOWS]->(A),
    (C)-[:KNOWS]->(B),
    (D)-[:KNOWS]->(B),
    (A)-[:LIVES_IN]->(K)-[:LIVES_IN]->(A),
    (C)-[:LIVES_IN]->(K)-[:LIVES_IN]->(C),
    (B)-[:LIVES_IN]->(Be)-[:LIVES_IN]->(B)



