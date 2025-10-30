Class {
	#name : #BaselineOfGtInputContext,
	#superclass : #BaselineOf,
	#category : #BaselineOfGtInputContext
}

{ #category : #baseline }
BaselineOfGtInputContext >> baseline: spec [
	<baseline>
	^ spec for: #common do: [ spec package: 'GtInputContext' ]
]
