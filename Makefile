.PHONY: bump-version
bump-version:
	gem bump -v patch
	gem tag -p