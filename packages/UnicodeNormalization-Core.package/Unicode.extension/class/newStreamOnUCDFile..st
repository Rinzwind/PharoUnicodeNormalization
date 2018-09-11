*UnicodeNormalization-Core-initialization
newStreamOnUCDFile: filename

	^ ZnFastLineReader on: (ZnCharacterReadStream on: (File openForReadFileNamed: filename asFileReference fullName))