*UnicodeNormalization-Core-initialization
parseHangulSyllableTypeFrom: stream

	| fields codePointValues interval syllableType semicolon numberSign space fullStop rangeSplit |

	HangulSyllableTypes := SparseLargeTable new: 16r10FFFF + 1 chunkSize: 32 arrayClass: Array base: 1 defaultValue: #NA.

	semicolon := Character codePoint: 16r00003B.
	numberSign := Character codePoint: 16r000023.
	space := Character codePoint: 16r000020.	
	fullStop := Character codePoint: 16r00002E.
	rangeSplit := String with: fullStop with: fullStop.

	stream linesDo: [ :line |
		(line isEmpty not and: [ line first ~= numberSign ]) ifTrue: [
			fields := (line copyUpTo: numberSign) splitOn: semicolon.
			self assert: [ fields size = 2 ] description: 'Each non-empty, non-comment line consists of two fields'.
			codePointValues := (fields first splitOn: rangeSplit) collect: [ :string | Integer readFrom: string base: 16 ].
			self assert: [ (codePointValues size = 1) | (codePointValues size = 2) ] description: 'The first field on each line is either a singular codepoint, or a codepoint followed by two dots followed by a codepoint'.
			interval := (codePointValues size = 2) ifTrue: [ Interval from: codePointValues first to: codePointValues second ] ifFalse: [ Interval from: codePointValues first to: codePointValues first ].
			syllableType := (fields second copyFrom: 2 to: fields second size - 1) asSymbol.
			interval do: [ :codePointValue |
				HangulSyllableTypes at: codePointValue + 1 put: syllableType ] ] ].

	HangulSyllableTypes zapDefaultOnlyEntries.
