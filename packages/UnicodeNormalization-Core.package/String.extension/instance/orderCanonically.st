*UnicodeNormalization-Core
orderCanonically

	| swapped combiningClassA codepointA combiningClassB codepointB |

	swapped := true.
	[ swapped ] whileTrue: [
		swapped := false.
		1 to: self size - 1 do: [ :index |
			((((combiningClassA := Unicode combiningClassOf: (codepointA := self at: index)) ~= 0)
				and: [ (combiningClassB := Unicode combiningClassOf: (codepointB := self at: index + 1)) ~= 0 ])
					and: [ combiningClassA > combiningClassB ]) ifTrue: [
						self at: index put: codepointB; at: index + 1 put: codepointA.
						swapped := true ] ] ]
