# webgen-bibtex
A webgen extension to produce bibliography entries from BibTeX files

## Introduction

This package extends [webgen](http://webgen.gettalong.org/), a static website
generator, by a simple facility to generate bibliography entries from BibTeX
files.

## Requirements

The following Ruby packages are required:

+ `bibtex-ruby`
+ `citeproc-ruby`
+ `csl-styles`

All of them can be installed via `gem install <package>`.

## How to Use

Copy the contained `bibtex/` folder to the `ext/` folder within your webgen
project.

### Global configuration options

The following configuration options apply to all BibTeX-related tags.  They can
be set globally or individually in each tag.

+ `tag.bibliography.bibfile`

  Path to the .bib file, either absolute or relative to the project's `src/`
  directory **(required)**

+ `tag.bibliography.style`

  The citation style; can be the name of any style file in the
  [official CSL style repository](https://github.com/citation-style-language/styles)
  (defaults to 'apa')

+ `tag.bibliography.format`

  A hash containing formatting options for the
  [HTML renderer](https://github.com/inukshuk/citeproc-ruby/blob/master/lib/citeproc/ruby/formats/html.rb)

### Citing individual bibliography items

Cite individual items from your BibTeX file like this:

    {bib_item: 'Smith2005'}

If you want to set additional options, you need to put the citation key in the
`key` field:

    {bib_item: {key: 'Smith2005', style: 'chicago-author-date'}}

### Generating bibliographies

Generate a full bibliography of entries in your BibTeX file:

    {bibliography: }

You can specify selector conditions in the `conditions` field; these will be
passed on to
[the respective method of the CiteProc module](http://www.rubydoc.info/gems/citeproc/CiteProc/Processor#bibliography-instance_method).
For example, generate a bibliography containing only entries of type 'book':

    {bibliography: {conditions: {all: {type: 'book'}}}}

## Contact

For any questions, contact Marcel Bollmann <bollmann@linguistics.rub.de>.

## License

This extension is licensed under GPLv3, just like webgen itself.
