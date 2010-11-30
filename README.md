# PriceTag
## Convert HTML into your favorite lightweight markup language

Who doesn't love themselves some light markup languages? As somebody writing with one _as I type this very sentence_, I am certainly a big fan.

Sure, the whole point of [Markdown][1], [Textile][2], and the like are to generate HTML, but what if you want to go the other way? To undo the horrible mistake of shackling your document in oppressive angled brackets, or perhaps share some love with markup that never knew the sweet embrace of concise, humanist syntax?

With PriceTag, such transformative experiences are just a simple line of code away:

    html = <<-EOF
            <h1>Lorem Ipsum</h1>
            <p>Lorem ipsum dolor sit amet.</p>
           EOF
           
    PriceTag.html_to_markdown(html)
    
Or if you're of the [Textile][2] persuasion:
    
    PriceTag.html_to_textile(html)
    

## Usage
  
You can customize aspects of a document's output by providing optional parameters to the `html\_to\_*` argument:

    PriceTag.html_to_markdown(html, :heading_style => :setext, :link_style => :inline)
    
- `link_style` : markup style for `a` tags (default: `reference`)
  - `reference` -- link URLs are referenced as footnote
  - `inline` -- link URLs are displayed inline with element

There are language-specific options as well:

### Markdown

- `heading_style` : markup style for `h1`...`h6` tags (default: `atx`)
  - `atx` -- Octothorps (#) next to heading
  - `setext` -- Equal signs or dashes (=/-) underneath headings (falls back to atx style for h3 and above)
  
### Textile

- `ignore_styles` : Textile allows you to set attributes (`id`, `class`, `lang`, and CSS Styles) for inline elements. When set to `true`, this information will not be included in the output (default: `true`)

## Dependencies

- Nokogiri 1.4+

## Note on Patches/Pull Requests

 1. Fork the project.
 2. Make your feature addition or bug fix.
 3. Add tests for it. This is important so I don’t break it in a future version unintentionally.
 4. Commit, do not mess with rakefile, version, or history. (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
 5. Send me a pull request. Bonus points for topic branches.

## License

PriceTag is licensed under the MIT License:

  Copyright (c) 2010 Mattt Thompson (http://mattt.me/)

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in
  all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  THE SOFTWARE.
 
 
[1]: http://daringfireball.net/projects/markdown/ "Markdown, by John Gruber"
[2]: http://textile.thresholdstate.com/ "Textile, by Dean Allen"