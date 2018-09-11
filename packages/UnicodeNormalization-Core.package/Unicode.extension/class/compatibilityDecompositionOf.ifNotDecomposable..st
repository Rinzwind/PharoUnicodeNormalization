*UnicodeNormalization-Core
compatibilityDecompositionOf: character ifNotDecomposable: notDecomposableBlock

	^ (CompatibilityDecompositionTable at: character asUnicode + 1) ifNil: notDecomposableBlock