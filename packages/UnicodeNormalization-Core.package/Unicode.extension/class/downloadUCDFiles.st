*UnicodeNormalization-Core-initialization
downloadUCDFiles

	| baseURL |

	baseURL := ZnUrl fromString: 'http://www.unicode.org/Public/8.0.0/ucd/'.

	{  'UnicodeData'. 'CompositionExclusions'. 'HangulSyllableType'. 'NormalizationTest' } do: [ :dataName |
		| fileName |
		fileName := dataName , '.txt'.
		fileName asFileReference exists ifTrue: [ fileName asFileReference delete ].
		(ZnClient new url: (baseURL copy addPathSegment: fileName); downloadTo: FileSystem workingDirectory fullName) ifFalse: [  self error: 'Error downloading ' , dataName ] ]
