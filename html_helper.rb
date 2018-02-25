
require 'nokogiri'

class String
  def to_html(hsh = {}, doc=nil)
    doc = Nokogiri::HTML::Document.new() if doc.nil?
    node_tag = Nokogiri::XML::Node.new self, doc
    node_tag.content = hsh['content']
    if ! hsh.nil? and hsh.has_key?('attributes')
      hsh['attributes'].each do |k,v|
        node_tag[k] = v 
      end
    end
    node_tag
  end
  def link_to(url, doc=nil)
    doc = Nokogiri::HTML::Document.new() if doc.nil?
    node_tag = Nokogiri::XML::Node.new 'a', doc
    node_tag.content = self
    node_tag['href'] = url
    node_tag
  end

  def bitbucket_link_to(doc=nil)
    doc = Nokogiri::HTML::Document.new() if doc.nil?
    node_tag = Nokogiri::XML::Node.new 'a', doc
    node_tag.content = self
    node_tag['href'] = "https://bitbucket.sw.nxp.com/projects/MCUCORE/repos/#{self}/browse"
    node_tag
  end

end

class Array
   def to_html_table(hsh = {},doc=nil)
    doc = Nokogiri::HTML::Document.new() if doc.nil?
    table = "table".to_html({'attributes' => {'border' => '1'}}, doc)
    count = self.count
    tr = Nokogiri::XML::Node.new 'tr', table
    self.each do |column|
      th = Nokogiri::XML::Node.new 'th', tr
      if column.class == Nokogiri::XML::Element
        column.parent = th
      else
        th.content = column
      end
      th['width'] = (100/count).to_s + '%' if count != 0
      if hsh.has_key?('attributes')
        hsh['attributes'].each do |k,v|
          th[k] = v 
        end
      end
      th.parent = tr
    end
    tr.parent = table
    table
  end
  def add_row_to_table(table, hsh = {})
    count = self.count
    tr = Nokogiri::XML::Node.new 'tr', table
    self.each do |column|
      td = Nokogiri::XML::Node.new 'td', tr
      if column.class == Nokogiri::XML::Element
        column.parent = td
      else
        td.content = column
      end
      td['width'] = (100/count).to_s + '%' if count != 0
      if hsh.has_key?('attributes')
        hsh['attributes'].each do |k,v|
          td[k] = v 
        end
        if hsh.has_key?(column)
          hsh[column]['attributes'].each do |k,v|
            td[k] = v 
          end
        end
      end
      td.parent = tr
    end
    tr.parent = table
    table
  end
end

=begin
doc = nil
#h1 = "h1".to_html({'attributes' => { 'length' => 10, 'width' => 20 }, 'content' => "test"}, doc)
#puts h1.to_html 


tb = ["a".link_to("http://www.google.com"), "b", "c"].to_html_table({'attributes' => {'colspan' => 2 }})
tb = ["a".link_to("http://www.google.com"), "b", "c"].add_row_to_table( tb,
  {
  'attributes' => 
    {
      'colspan' => 2, 'valign' => 'top' 
    }, 
    'a' => 
    {
      'attributes' => 
      {
        'href' => '#' 
      }
    }
  }
)
puts tb.to_html
=end





