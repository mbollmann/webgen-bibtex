# webgen-bibtex
A webgen extension to produce bibliography entries from BibTeX files

## Introduction

This package extends [webgen](http://webgen.gettalong.org/), a static website
generator, by a simple facility to generate bibliography entries from BibTeX
files.

## Requirements

The following Ruby packages are required:

+ [`bibtex-ruby`](https://github.com/inukshuk/bibtex-ruby)
+ [`citeproc-ruby`](https://github.com/inukshuk/citeproc-ruby)
+ [`csl-styles`](https://github.com/inukshuk/csl-styles)

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

+ `tag.bibliography.format`

  A hash containing formatting options for the
  [HTML renderer](https://github.com/inukshuk/citeproc-ruby/blob/master/lib/citeproc/ruby/formats/html.rb)

+ `tag.bibliography.link_style`

  The style of generated links in bibliography entries; one of 'append',
  'inline', 'both', or 'none' (defaults to 'append')

+ `tag.bibliography.locale`

  Locale setting to use; defaults to the language setting of the current webgen
  node, but can be overridden if you want

+ `tag.bibliography.style`

  The citation style; can be the name of any style file in the
  [official CSL style repository](https://github.com/citation-style-language/styles)
  (defaults to 'apa')

### Generate individual bibliography entries

Produce bibliography entries from individual items in your BibTeX file like this:

    {bib_item: 'Smith2005'}

If you want to set additional options, you need to put the citation key in the
`key` field:

    {bib_item: {key: 'Smith2005', style: 'chicago-author-date'}}

URLs contained in the rendered output will be hyperlinked automatically.

### Adding links to bibliography entries

Bibliographies on websites often contain hyperlinks, but the nature of these
links varies, and it is not uncommon for an entry to have more than one link:
for example, a download link for the cited work itself (possibly in various
formats), slides of a presentation of the cited work, a poster presenting the
cited work, an associated website, etc.

For this reason, we use a new BibTeX field `Webgenlink` to store information
about the desired links, with the following format:

    Webgenlink = {PDF|http://example.com/work.pdf||Slides|/pub/my-slides.pdf}

Multiple links can be separated by `||`, while each link can *optionally* have a
title that is separated from the link itself by a single `|`.

Links that contain a protocol (such as `http://`) are copied verbatim, while
others (such as `/pub/my-slides.pdf`) are treated as internal paths that will be
resolved by webgen and should be **absolute to the project's root directory.**

If you never need more than one link, you can also use the standard BibTeX `Url`
field.  If it is present and no `Webgenlink` field exists, it will be used
instead.

#### Rendering styles for links

The appearance of links in bibliography entries differs depending on the value
of `tag.bibliography.link_style`:

+ "append"

  Links are added to the bibliography entry with their title in square brackets,
  such as "\[PDF\] \[Slides\]".

+ "inline"

  The title of the work will become a hyperlink; only the first link in a
  `Webgenlink` entry is used.

+ "both"

  The first link in a `Webgenlink` entry will be inlined, while any further
  links will be appended.

+ "none" *(or any other value really)*

  Don't generate hyperlinks.

### Generating full bibliographies

Generate a full bibliography of entries in your BibTeX file:

    {bibliography: }

You can specify selector conditions in the `conditions` field; these will be
passed on to
[the respective method of the CiteProc module](http://www.rubydoc.info/gems/citeproc/CiteProc/Processor#bibliography-instance_method).
For example, generate a bibliography containing only entries of type 'book':

    {bibliography: {conditions: {all: {type: 'book'}}}}

## Contact

For any questions, contact Marcel Bollmann (<bollmann@linguistics.rub.de>).

## License

This extension is licensed under GPLv3, just like webgen itself.
