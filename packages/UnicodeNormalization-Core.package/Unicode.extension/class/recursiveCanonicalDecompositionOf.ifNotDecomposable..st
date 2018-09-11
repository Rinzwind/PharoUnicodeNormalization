*UnicodeNormalization-Core
recursiveCanonicalDecompositionOf: character ifNotDecomposable: notDecomposableBlock

	^ (RecursiveCanonicalDecompositionTable at: (character asUnicode + 1)) ifNil: notDecomposableBlock
