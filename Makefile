TEMPLATE=readable
INPUT=index.md

index.html:

%.html: %.md
	md2resume html --template $(TEMPLATE) --output $@ $<

%.pdf: %.md
	md2resume pdf --template $(TEMPLATE) --output $@ $<

publish: index.html
	cp index.html gh-pages/
	cd gh-pages && git commit --all --message "Publish `date "+%Y%m%d-%H%M%S"`"
	cd gh-pages && git push
	git add gh-pages
	git commit --message "Publish `date "+%Y%m%d-%H%M%S"`"
	git push

stats:
	md2resume stats $(INPUT)

clean:
	-rm index.html
	-rm index.pdf

.PHONY: publish stats clean
