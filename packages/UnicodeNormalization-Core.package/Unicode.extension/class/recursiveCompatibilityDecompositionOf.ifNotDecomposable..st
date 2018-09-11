*UnicodeNormalization-Core
recursiveCompatibilityDecompositionOf: character ifNotDecomposable: notDecomposableBlock

	^ (RecursiveCompatibilityDecompositionTable at: (character asUnicode + 1)) ifNil: notDecomposableBlock
