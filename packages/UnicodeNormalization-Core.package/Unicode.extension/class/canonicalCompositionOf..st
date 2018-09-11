*UnicodeNormalization-Core
canonicalCompositionOf: string

	| characters index starterIdx composite |

	characters := string collect: [ :character | character asUnicodeChar ] as: OrderedCollection.
	index := 2.
	[ index <= characters size ] whileTrue: [
		starterIdx := self findNonBlockedStarterIn: characters forIndex: index.
		starterIdx
			ifNotNil: [
				composite := self canonicalCompositionOf: (characters at: starterIdx) with: (characters at: index) ifNotComposable: [ nil ].
				composite
					ifNotNil: [
						characters removeAt: index.
						characters at: starterIdx put: composite.
						index := starterIdx max: 2 ]
				 	ifNil: [ index := index + 1 ] ]
			ifNil: [ index := index + 1 ] ].
	^ String withAll: characters 