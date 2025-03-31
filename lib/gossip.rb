require 'bundler'
Bundler.require



class Gossip
  CSV_PATH = File.join(File.dirname(__FILE__), "../db/gossip.csv")
  attr_accessor :author , :content


  def initialize(author_to_save, content_to_save)
    @author = author_to_save
    @content = content_to_save
  end

  def save()
    CSV.open(CSV_PATH, "ab") do |csv|
      csv << [@author, @content]
    end
  end

  def self.all
    all_gossips = []
    CSV.read(CSV_PATH).each do |csv_line|
      all_gossips << Gossip.new(csv_line[0], csv_line[1])
    end
    return all_gossips
  end

  def self.find(id)
    gossips = CSV.read(CSV_PATH)
     puts "Gossips lus dans le CSV : #{gossips.inspect}"
    row = gossips[id.to_i - 1]
      puts "Ligne récupérée pour ID #{id} : #{row.inspect}"

    if row 
      Gossip.new(row[0], row[1])
    else
      nil
    end
  end
end
