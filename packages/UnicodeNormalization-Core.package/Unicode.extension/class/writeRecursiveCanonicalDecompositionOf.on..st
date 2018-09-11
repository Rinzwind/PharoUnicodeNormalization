*UnicodeNormalization-Core-initialization
writeRecursiveCanonicalDecompositionOf: character on: stream

	(self canonicalDecompositionOf: character ifNotDecomposable: [ stream nextPut: character asUnicodeChar. ^ self ]) do: [ :character2 |
		self writeRecursiveCanonicalDecompositionOf: character2 on: stream ].
