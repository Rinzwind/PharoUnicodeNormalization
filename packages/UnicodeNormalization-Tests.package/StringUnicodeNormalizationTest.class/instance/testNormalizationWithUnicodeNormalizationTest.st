test
testNormalizationWithUnicodeNormalizationTest

	| stream readFieldBlock |
	
	readFieldBlock := [ :field | (field splitOn: Character space) collect: [ :codePointString | Character value: (Integer readFrom: codePointString base: 16) ] as: String ].
	
	stream := ZnFastLineReader on: (ZnCharacterReadStream on: (File openForReadFileNamed: 'NormalizationTest.txt' asFileReference fullName)).

	[
		stream linesDo: [ :line |
			((line first ~= $#) & (line first ~= $@)) ifTrue: [
				| fields sourceString nfcString nfdString nfkcString nfkdString  |
				
				fields := line splitOn: $;.
				sourceString := readFieldBlock value: fields first.
				nfcString := readFieldBlock value: fields second.
				nfdString := readFieldBlock value: fields third.
				nfkcString := readFieldBlock value: fields fourth.
				nfkdString := readFieldBlock value: fields fifth.

				self assert: sourceString canonicalDecomposedNormalForm = nfdString.
				self assert: sourceString compatibilityDecomposedNormalForm = nfkdString.
				self assert: sourceString canonicalComposedNormalForm = nfcString.
				self assert: sourceString compatibilityComposedNormalForm = nfkcString ] ].
	] ensure: [ stream close ]
