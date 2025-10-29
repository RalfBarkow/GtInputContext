Extension { #name : #FileReference }

{ #category : #'*GtInputContext-extensions' }
FileReference >> asGtInputFile [
	^ GtInputFile on: self inContext: GtInputContext default
]

{ #category : #'*GtInputContext-UI' }
FileReference >> gtInputWhyViewOn: composite [
	<gtView>
	^ composite text
		title: 'Parsers (why & matches)';
		priority: 6;
		display: [ self asGtInputFile selectionExplanation ]
]
