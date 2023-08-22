carthage_bootstrap:
	(cd Vendor && carthage bootstrap --use-xcframeworks --platform ios --cache-builds)
	rm -Rf Vendor/Carthage/Checkouts

carthage_update:
	(cd Vendor && carthage update --use-xcframeworks  --platform ios --cache-builds)
	rm -Rf Vendor/Carthage/Checkouts