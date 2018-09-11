*UnicodeNormalization-Core-initialization
parseCompositionExclusionsFrom: stream

	| space codePointField codePointValue numberSign |

	CompositionExclusions := IdentitySet new.
	
	space := Character codePoint: 16r000020.	
	numberSign := Character codePoint: 16r000023.

	stream linesDo: [ :line |
		(line isEmpty not and: [ line first ~= numberSign ]) ifTrue: [
			codePointField := line copyUpTo: space.
			codePointValue := Integer readFrom: codePointField base: 16.

			CompositionExclusions add: codePointValue ] ].
	stream close.
