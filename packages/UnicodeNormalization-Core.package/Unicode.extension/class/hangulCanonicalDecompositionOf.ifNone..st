*UnicodeNormalization-Core
hangulCanonicalDecompositionOf: character ifNone: noDecompositionBlock

	| hangulSyllableType |

	hangulSyllableType := self hangulSyllableTypeOf: character.
	((hangulSyllableType ~= #NA) and: [ (hangulSyllableType = #LV) | (hangulSyllableType = #LVT) ]) ifTrue: [
		| SBase LBase VBase TBase LCount VCount TCount NCount SCount SIndex |
		SBase := 16rAC00.
		LBase := 16r1100.
		VBase := 16r1161.
		TBase := 16r11A7.
		LCount := 19.
		VCount := 21.
		TCount := 28.
		NCount := VCount * TCount.
		SCount := LCount * NCount.
		SIndex := character asUnicode - SBase.
		(hangulSyllableType = #LV) ifTrue: [
			| LIndex VIndex LPart VPart |
			LIndex := SIndex // NCount.
			VIndex := (SIndex \\ NCount) // TCount.
			LPart := LBase + LIndex.
			VPart := VBase + VIndex.
			^ String with: (Character codePoint: LPart) with: (Character codePoint: VPart).
		] ifFalse: [
			| LVIndex TIndex LVPart TPart |
			LVIndex := (SIndex // TCount) * TCount.
   			TIndex := SIndex \\ TCount.
			LVPart := SBase + LVIndex.
			TPart := TBase + TIndex.
			^ String with: (Character codePoint: LVPart) with: (Character codePoint: TPart) ] ].
	^ noDecompositionBlock value
