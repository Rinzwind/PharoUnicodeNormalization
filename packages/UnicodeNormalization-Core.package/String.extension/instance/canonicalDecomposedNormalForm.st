*UnicodeNormalization-Core
canonicalDecomposedNormalForm

	^ (String streamContents: [ :stream |
		self do: [ :character |
			(Unicode recursiveCanonicalDecompositionOf: character ifNotDecomposable: [ nil ])
				ifNil: [  stream nextPut: character asUnicodeChar ]
				ifNotNil: [ :decomposition | stream nextPutAll: decomposition ] ] ])
		orderCanonically;
		yourself