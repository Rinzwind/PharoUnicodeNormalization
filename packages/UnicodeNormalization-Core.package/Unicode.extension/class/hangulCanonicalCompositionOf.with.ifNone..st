*UnicodeNormalization-Core
hangulCanonicalCompositionOf: character1 with: character2 ifNone: noCompositionBlock

	(((character1 asUnicode >= 16r001100) and: [ character1 asUnicode <= 16r001112 ]) and: [ (character2 asUnicode >= 16r001161) & (character2 asUnicode <= 16r001175) ]) ifTrue: [
		| LPart VPart LIndex VIndex LBase VBase LVIndex NCount TCount VCount TBase LCount SBase |
		LPart := character1 asUnicode.
		VPart := character2 asUnicode.
		LBase := 16r1100.
		VBase := 16r1161.
		TBase := 16r11A7.
		SBase := 16rAC00.
		LCount := 19.
		VCount := 21.
		TCount := 28.
		NCount := VCount * TCount.
		LIndex := LPart - LBase.
		VIndex := VPart - VBase.
		LVIndex := (LIndex * NCount) + (VIndex * TCount).
		^ Character codePoint: (SBase + LVIndex) ].
	(((self hangulSyllableTypeOf: character1) = #LV) and: [ (character2 asUnicode >= 16r0011A8) & (character2 asUnicode <= 16r0011C2) ]) ifTrue: [
		| TPart TBase TIndex LVPart |
		LVPart := character1 asUnicode.
		TPart := character2 asUnicode.
		TBase := 16r11A7.
		TIndex := TPart - TBase.
		^ Character codePoint: (LVPart + TIndex) ].
	^ noCompositionBlock value
