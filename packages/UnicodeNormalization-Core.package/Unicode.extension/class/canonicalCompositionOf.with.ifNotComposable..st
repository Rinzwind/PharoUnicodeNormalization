*UnicodeNormalization-Core
canonicalCompositionOf: character1 with: character2 ifNotComposable: notComposableBlock

	^ CanonicalCompositions at: character1 asUnicode
		ifPresent: [ :dictionary |
			dictionary at: character2 asUnicode
				ifPresent: [ :character | ^ character ]
				ifAbsent: [ self hangulCanonicalCompositionOf: character1 with: character2 ifNone: notComposableBlock ] ]
		ifAbsent: [ self hangulCanonicalCompositionOf: character1 with: character2 ifNone: notComposableBlock ]
