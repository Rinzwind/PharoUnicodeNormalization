*UnicodeNormalization-Core-initialization
withStreamOnUCDFile: filename do: block

	| stream |

	stream := self newStreamOnUCDFile: filename.
	^ [ block value: stream ] ensure: [ stream close ]
