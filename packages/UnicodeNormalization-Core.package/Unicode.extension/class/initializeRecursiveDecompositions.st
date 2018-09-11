*UnicodeNormalization-Core-initialization
initializeRecursiveDecompositions

	RecursiveCanonicalDecompositionTable := SparseLargeTable new: 16r10FFFF + 1 chunkSize: 32 arrayClass: Array base: 1 defaultValue: nil.
	RecursiveCompatibilityDecompositionTable := SparseLargeTable new: 16r10FFFF + 1 chunkSize: 32 arrayClass: Array base: 1 defaultValue: nil.

	0 to: 16r10FFFF do: [ :codePoint |
		| character hasCanonicalDecomposition hasCompatibilityDecomposition |
		character := Character codePoint: codePoint.
		hasCanonicalDecomposition := (self canonicalDecompositionOf: character ifNotDecomposable: [ nil ]) ~= nil.
		hasCompatibilityDecomposition := (self compatibilityDecompositionOf: character ifNotDecomposable: [ nil ]) ~= nil.
		hasCanonicalDecomposition ifTrue: [ 
			RecursiveCanonicalDecompositionTable at: codePoint + 1 put: (String streamContents: [ :stream | self writeRecursiveCanonicalDecompositionOf: character on: stream ]) ].
		(hasCompatibilityDecomposition | hasCanonicalDecomposition) ifTrue: [ 
			RecursiveCompatibilityDecompositionTable at: codePoint + 1 put: (String streamContents: [ :stream | self writeRecursiveCompatibilityDecompositionOf: character on: stream ]) ] ].

	RecursiveCanonicalDecompositionTable zapDefaultOnlyEntries.
	RecursiveCompatibilityDecompositionTable zapDefaultOnlyEntries.
