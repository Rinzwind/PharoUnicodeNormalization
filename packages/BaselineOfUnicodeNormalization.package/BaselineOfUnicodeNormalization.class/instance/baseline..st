baseline
baseline: spec

	<baseline>

	spec
		for: #'common'
		do: [ 
			spec
				package: 'UnicodeNormalization-Core' with: [
					spec postLoadDoIt: #postLoadForCore:package: ];
				package: 'UnicodeNormalization-Tests' with: [
					spec requires: #('UnicodeNormalization-Core') ];
				group: 'default' with: #('UnicodeNormalization-Tests');
				yourself ].
