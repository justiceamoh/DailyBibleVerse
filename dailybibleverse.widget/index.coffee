# command: 'curl -s "http://www.esvapi.org/v2/rest/dailyVerse?key=IP&output-format=crossway-xml-1.0"'
command: 'curl -s "https://www.biblegateway.com/votd/get/?format=xml&version=ESV"'


refreshFrequency: 21000000

style: """
  bottom: 55%
  right: 30%
  color: #fff
  font-family: Helvetica Neue


  .output
    padding: 5px 10px
    width: 520px
    font-size: 21px
    font-weight: lighter
      font-smoothing: antialiased

  .verse
    text-transform: capitalize
    font-size: 16px
    text-align: right
"""

render: (output) -> """
  <div class="output">
    <div class="quote"></div>
    <div class="verse"></div>
  </div>
"""

update: (output, domEl) -> 
  # Define constants, and extract the juicy html.
  dom = $(domEl)
  xml = jQuery.parseXML(output)
  $xml = $(xml)
  description = jQuery.parseHTML($xml.find('copyright').eq(0).text())
  $description = $(description)
  verse = $xml.find('content').eq(0).text().replace(/\d+/g, '')

 # Find the info we need, and inject it into the DOM.
  dom.find('.quote').html verse
  dom.find('.verse').html $xml.find('reference').eq(0)

 