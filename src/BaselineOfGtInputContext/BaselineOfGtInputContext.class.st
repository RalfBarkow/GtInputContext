Class {
	#name : #BaselineOfGtInputContext,
	#superclass : #BaselineOf,
	#category : #BaselineOfGtInputContext
}

{ #category : #baseline }
BaselineOfGtInputContext >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ spec package: 'GtInputContext'.
			spec
				package: 'GtInputContext-UI'
				with: [ :p | p requires: #('GtInputContext') ].
			spec
				package: 'GtInputContext-Tests'
				with: [ :p | p requires: #('GtInputContext') ] ].
	spec
		group: 'default' with: #('GtInputContext' 'GtInputContext-UI');
		group: 'tests' with: #('GtInputContext-Tests');
		group: 'all'
			with: #('GtInputContext' 'GtInputContext-UI' 'GtInputContext-Tests')
]
