require 'open-uri'
require 'nokogiri'

class Whatismyip
  
  attr_reader :public_ip
  
  def self.check
    %{
    Public IP:
    ==========
    #{public_ip}
    
    Local IP's:
    ===========
    #{display_locals}
    }.map {|l| (l.strip.empty?) ? l : l.lstrip }
  end
  
  def self.public_ip
    return @public_ip unless @public_ip.nil?
    
    begin
      doc = Nokogiri::HTML(open('http://whatismyip.com/automation/n09230945.asp', 'User-Agent' => "Ruby/#{RUBY_VERSION}"))
      @public_ip = doc.css('p').inner_html
    rescue SocketError => e
      puts "Unable to connect to remote server. Are you sure you're connected to the internet? If not, connect and try again."
      nil
    end
  end
  
  def self.local_ips
    result = `ifconfig`
    
    sections = result.split(/^(?=[^\t])/)
    sections_with_relevant_ip = sections.select{ |i| i =~ /inet/ }
    
    Hash[sections_with_relevant_ip.collect { |section|
      device = section[/[^:]+/]
      ip = section[/inet ([^ ]+)/, 1]
      [device.to_sym, ip]
    }]
  end
  
  def self.display_locals
    local_ips.map { |device, ip| "#{device}: #{ip}\n" }
  end
  
end