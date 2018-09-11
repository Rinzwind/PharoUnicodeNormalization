*UnicodeNormalization-Core
compatibilityDecomposedNormalForm

	^ (String streamContents: [ :stream |
		self do: [ :character |
			(Unicode recursiveCompatibilityDecompositionOf: character ifNotDecomposable: [ nil ])
				ifNil: [  stream nextPut: character asUnicodeChar ]
				ifNotNil: [ :decomposition | stream nextPutAll: decomposition ] ] ])
		orderCanonically;
		yourself