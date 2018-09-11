*UnicodeNormalization-Core-initialization
initializeNormalization

	self withStreamOnUCDFile: 'UnicodeData.txt' do: [ :stream | self parseUnicodeDataCombiningClassesAndDecompositionsFrom: stream ].
	self withStreamOnUCDFile: 'HangulSyllableType.txt' do: [ :stream | self parseHangulSyllableTypeFrom: stream ].
	self withStreamOnUCDFile: 'CompositionExclusions.txt' do: [ :stream | self parseCompositionExclusionsFrom: stream ].
	self initializeCanonicalCompositions.
	self initializeRecursiveDecompositions.
