*UnicodeNormalization-Core
findNonBlockedStarterIn: collection forIndex: index

	| characterC characterA characterCCombiningClass codePointACombiningClass |

	characterC := collection at: index.
	characterCCombiningClass := Unicode combiningClassOf: characterC.

	index - 1 to: 1 by: -1 do: [ :i |
		characterA := (collection at: i).
		codePointACombiningClass := Unicode combiningClassOf: characterA.
		(codePointACombiningClass = 0) ifTrue: [ ^ i ].
		(codePointACombiningClass >= characterCCombiningClass) ifTrue: [ ^ nil ] ].
	^ nil