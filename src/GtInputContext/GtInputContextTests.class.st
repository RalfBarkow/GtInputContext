Class {
	#name : #GtInputContextTests,
	#superclass : #TestCase,
	#category : #'GtInputContext-Tests'
}

{ #category : #tests }
GtInputContextTests >> testBestParserPicksSpecSetAdapterOnMarkers [
	| ctx tmp input winner |
	ctx := GtInputContext new initializeDefault.
	ctx registerParser: GtSpecSetMarkdownParserAdapter.
	tmp := FileSystem memory / 'draft.md'.
	tmp
		writeStreamDo: [ :s | 
			s
				nextPutAll: '# SPEC';
				cr;
				nextPutAll: 'Goal';
				cr;
				cr;
				nextPutAll: '# IMPLEMENTATION_PLAN';
				cr;
				nextPutAll: 'Step 1' ].
	input := GtInputFile on: tmp inContext: ctx.
	winner := ctx bestParserFor: input.
	self assert: winner equals: GtSpecSetMarkdownParserAdapter
]

{ #category : #tests }
GtInputContextTests >> testExplainSelectionWithNoParsersShowsNoMatch [
	| ctx tmp explanation |
	ctx := GtInputContext new initializeDefault.	"no parsers registered"
	tmp := FileSystem memory / 'empty.md'.
	tmp writeStreamDo: [ :s | s nextPutAll: 'Hello' ].
	explanation := ctx explainSelectionFor: tmp.
	self assert: (explanation includesSubstring: 'No parser matched')
]

{ #category : #tests }
GtInputContextTests >> testWhyViewListsCandidates [
	| ctx tmp input candidates explanation |
	ctx := GtInputContext new initializeDefault.
	ctx registerParser: GtSpecSetMarkdownParserAdapter.
	tmp := FileSystem memory / 'draft.md'.
	tmp
		writeStreamDo: [ :s | 
			s
				nextPutAll: '# RESEARCH';
				cr;
				nextPutAll: 'Notes' ].
	input := GtInputFile on: tmp inContext: ctx.
	candidates := ctx candidateParsersFor: input.
	self deny: candidates isEmpty.
	explanation := ctx explainSelectionFor: tmp.
	self assert: (explanation includesSubstring: 'Chosen parser:')
]
