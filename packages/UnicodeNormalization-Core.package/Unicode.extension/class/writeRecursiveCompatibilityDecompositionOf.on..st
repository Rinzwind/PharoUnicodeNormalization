*UnicodeNormalization-Core-initialization
writeRecursiveCompatibilityDecompositionOf: character on: stream
	
	(Unicode compatibilityDecompositionOf: character ifNotDecomposable: [ 
		Unicode canonicalDecompositionOf: character ifNotDecomposable: [ ^ stream nextPut: character asUnicodeChar ] ]) do: [ :character2 |
		self writeRecursiveCompatibilityDecompositionOf: character2 on: stream ].
