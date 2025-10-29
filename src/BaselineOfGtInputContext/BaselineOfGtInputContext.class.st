Class {
	#name : #BaselineOfGtInputContext,
	#superclass : #BaselineOf,
	#category : #BaselineOfGtInputContext
}

{ #category : #baseline }
BaselineOfGtInputContext class >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ spec package: 'GtInputContext'.
			spec
				package: 'GtInputContext-UI'
				with: [ spec requires: #('GtInputContext') ].
			spec
				package: 'GtInputContext-Tests'
				with: [ spec requires: #('GtInputContext') ].	"Optional, but handy groups"
			spec
				group: 'default'
				with: [ spec requires: #('GtInputContext' 'GtInputContext-UI') ].
			spec group: 'tests' with: [ spec requires: #('GtInputContext-Tests') ] ]
]
