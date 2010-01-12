require 'open-uri'
require 'nokogiri'

class Whatismyip
  
  def self.check
    %{
    Public IP:
    ==========
    #{check_public}
    
    Local IP's:
    ===========
    #{check_local}
    }.map {|l| (l.strip.empty?) ? l : l.lstrip }
  end
  
  def self.check_public
    doc = Nokogiri::HTML(open('http://whatismyip.com/automation/n09230945.asp', 'User-Agent' => "Ruby/#{RUBY_VERSION}"))
    doc.css('p').inner_html
  end
  
  def self.check_local
    result = `ifconfig`
    
    sections = result.split(/^(?=[^\t])/)
    sections_with_relevant_ip = sections.select{ |i| i =~ /inet/ }
    
    sections_with_relevant_ip.map { |section|
      device = section[/[^:]+/]
      ip = section[/inet ([^ ]+)/, 1]
      "#{device}: #{ip}\n"
    }.compact
  end
  
end