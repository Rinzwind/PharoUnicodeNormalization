*UnicodeNormalization-Core
canonicalDecompositionOf: character ifNotDecomposable: notDecomposableBlock

	^ self hangulCanonicalDecompositionOf: character ifNone: [ (CanonicalDecompositionTable at: character asUnicode + 1) ifNil: notDecomposableBlock ]
