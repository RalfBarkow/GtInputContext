Class {
	#name : #GtInputContext,
	#superclass : #Object,
	#instVars : [
		'parsers',
		'rootDirectory',
		'outputDirectory',
		'projectLabel'
	],
	#classVars : [
		'Default'
	],
	#category : #GtInputContext
}

{ #category : #accessing }
GtInputContext class >> default [
	^ Default ifNil: [ Default := self new initializeDefault ]
]

{ #category : #accessing }
GtInputContext class >> resetDefault [
	Default := nil
]

{ #category : #parsers }
GtInputContext >> availableParsers [
	^ parsers asArray
]

{ #category : #selection }
GtInputContext >> bestParserFor: aGtInputFile [
	| c |
	c := self candidateParsersFor: aGtInputFile.
	c isEmpty ifTrue: [ ^ nil ].
	^ c first at: #parser
]

{ #category : #selection }
GtInputContext >> candidateParsersFor: aGtInputFile [
	| scored |
	scored := parsers
			collect: [ :cls | 
				| sc |
				sc := self scoreParser: cls for: aGtInputFile.
				{#parser -> cls.
					#score -> sc} ].
	scored := scored
			select: [ :e | (e at: #score) at: #canHandle ifAbsent: [ false ] ].
	^ scored
		asSortedCollection: [ :a :b | 
			| pa pb ca cb |
			pa := (a at: #score) at: #priority ifAbsent: [ 9999 ].
			pb := (b at: #score) at: #priority ifAbsent: [ 9999 ].
			pa < pb ifTrue: [ ^ true ].
			pa > pb ifTrue: [ ^ false ].
			ca := (a at: #score) at: #confidence ifAbsent: [ 0.0 ].
			cb := (b at: #score) at: #confidence ifAbsent: [ 0.0 ].
			^ ca > cb ]
]

{ #category : #selection }
GtInputContext >> explainSelectionFor: aFileReference [
	| input candidates winner |
	input := GtInputFile on: aFileReference inContext: self.
	candidates := self candidateParsersFor: input.
	candidates isEmpty ifTrue: [ ^ 'No parser matched this input.' ].
	winner := candidates first.
	^ String
		streamContents: [ :s | 
			s
				nextPutAll: 'Chosen parser: ';
				nextPutAll: (winner at: #parser) name;
				cr;
				nextPutAll: 'Reason: ';
				nextPutAll: ((winner at: #score) at: #why ifAbsent: [ '—' ]) asString;
				cr;
				cr;
				nextPutAll: 'All candidates (sorted):';
				cr.
			candidates
				do: [ :cand | 
					| cls sc |
					cls := cand at: #parser.
					sc := cand at: #score.
					s
						nextPutAll: '- ';
						nextPutAll: cls name;
						nextPutAll: ' | priority=';
						nextPutAll: (sc at: #priority ifAbsent: [ '—' ]) asString;
						nextPutAll: ' confidence=';
						nextPutAll: (sc at: #confidence ifAbsent: [ '—' ]) asString;
						nextPutAll: ' matches=';
						nextPutAll: (sc at: #canHandle ifAbsent: [ false ]) asString;
						cr;
						nextPutAll: '  why: ';
						nextPutAll: (sc at: #why ifAbsent: [ '—' ]) asString;
						cr ] ]
]

{ #category : #initialization }
GtInputContext >> initialize [
	super initialize.
	parsers := OrderedCollection new
]

{ #category : #initialization }
GtInputContext >> initializeDefault [
	self initialize.
	rootDirectory := FileSystem workingDirectory.
	outputDirectory := rootDirectory / 'specset'.
	projectLabel := 'default'.
	^ self
]

{ #category : #parsers }
GtInputContext >> registerParser: aParserClass [
	parsers add: aParserClass.
	^ self
]

{ #category : #selection }
GtInputContext >> scoreParser: parserClass for: aGtInputFile [
	| score |
	[ score := parserClass matchScoreFor: aGtInputFile inContext: self ]
		on: MessageNotUnderstood
		do: [ ^ Dictionary
				newFrom: {#canHandle -> false.
						#priority -> 9999.
						#confidence -> 0.0.
						#why -> 'Parser lacks matchScoreFor:inContext:'} ].
	^ score
]
