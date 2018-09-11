*UnicodeNormalization-Core-initialization
initializeCanonicalCompositions

	CanonicalCompositions := IdentityDictionary new.

	CanonicalDecompositionTable keysAndValuesDo: [ :codePointPlusOne :string |
		(string notNil and: [ (CompositionExclusions includes: codePointPlusOne - 1) not & string size = 2 ]) ifTrue: [
			(CanonicalCompositions at: string first asUnicode ifAbsentPut: [ IdentityDictionary new ]) at: string second asUnicode put: (Character codePoint: codePointPlusOne - 1) ] ].
