TEMPLATE=readable
INPUT=index.md

index.html:

%.html: %.md
	pandoc --from=markdown --to=html5 --output=$@ --smart --standalone \
		--section-divs $<

%.docx: %.md
	pandoc --from=markdown --to=docx --output=$@ --smart --standalone \
		--section-divs $<

%.pdf: %.md
	pandoc --from=markdown --to=latex --output=$@ --smart --standalone \
		--section-divs $<

resume.pdf: index.pdf
	mv $< $@

publish: index.html resume.pdf
	cp index.html gh-pages/
	cp resume.pdf gh-pages/
	cd gh-pages && git add index.html resume.pdf
	cd gh-pages && git commit --message "Publish `date "+%Y%m%d-%H%M%S"`"
	cd gh-pages && git push
	git add gh-pages
	git commit --message "Publish `date "+%Y%m%d-%H%M%S"`"
	git push

clean:
	-rm index.html
	-rm index.pdf

.PHONY: publish clean
