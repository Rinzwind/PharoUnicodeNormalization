*UnicodeNormalization-Core-initialization
parseUnicodeDataCombiningClassesAndDecompositionsFrom: stream

	| fields codePointField codePointValue combiningClassField combiningClass decompositionField decompositionCodepoints semicolon space lessThanSign digitZero digitNine |
	
	CombiningClasses := SparseLargeTable new: 16r10FFFF + 1 chunkSize: 32 arrayClass: Array base: 1 defaultValue: 0.
	CanonicalDecompositionTable := SparseLargeTable new: 16r10FFFF + 1 chunkSize: 32 arrayClass: Array base: 1 defaultValue: nil.
	CompatibilityDecompositionTable := SparseLargeTable new: 16r10FFFF + 1 chunkSize: 32 arrayClass: Array base: 1 defaultValue: nil.
	
	semicolon := Character codePoint: 16r00003B.
	space := Character codePoint: 16r000020.	
	lessThanSign := Character codePoint: 16r00003C.
	digitZero := Character codePoint: 16r000030.
	digitNine := Character codePoint: 16r000039.
	
	stream linesDo: [ :line |
		fields := line splitOn: semicolon.

		codePointField := fields at: 1.
		codePointValue := Integer readFrom: codePointField base: 16.

		combiningClassField := fields at: 4.
		self assert: [ combiningClassField allSatisfy: [ :c | (c value >= digitZero value) & (c value <= digitNine value) ] ] description: 'The field is expected to always contain digits'.
		combiningClass := Integer readFrom: combiningClassField base: 10.
		(combiningClass ~= 0) ifTrue: [ CombiningClasses at: codePointValue + 1 put: combiningClass ].

		decompositionField := fields at: 6.
		(decompositionField isEmpty not) ifTrue: [
			(decompositionField first ~= lessThanSign) ifTrue: [
				decompositionCodepoints := (decompositionField splitOn: space) collect: [ :codepointString | Integer readFrom: codepointString base: 16 ] as: Array.
				CanonicalDecompositionTable at: codePointValue + 1 put: (decompositionCodepoints collect: [ :codePoint | Character codePoint: codePoint ] as: String).
			] ifFalse: [
				decompositionCodepoints := ((decompositionField copyAfter: space) splitOn: space) collect: [ :codepointString | Integer readFrom: codepointString base: 16 ] as: Array.
				CompatibilityDecompositionTable at: codePointValue + 1 put: (decompositionCodepoints collect: [ :codePoint | Character codePoint: codePoint ]) ] ] ].

	CombiningClasses zapDefaultOnlyEntries.
	CanonicalDecompositionTable zapDefaultOnlyEntries.
	CompatibilityDecompositionTable zapDefaultOnlyEntries.
