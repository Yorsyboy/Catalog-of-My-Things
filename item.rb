require 'date'

class Item
  attr_reader :publish_date, :archived, :id, :author, :label, :genre

  def initialize(publish_date, id = nil, archived: false)
    @publish_date = Date.parse(publish_date)
    @archived = archived
    @id = id || Random.rand(1..1000)
  end

  # rubocop:disable Style/TrivialAccessors
  def genre=(genre)
    @genre = genre
  end

  def author=(author)
    @author = {first_name: author.first_name, last_name: author.first_name}
    author.items << self unless author.items.include?(self)
  end

  def label=(label)
    @label = label
  end
  # rubocop:enable Style/TrivialAccessors

  def can_be_archived?
    (Date.today.year - @publish_date.year) > 10
  end

  def move_to_archive
    @archived = true if can_be_archived?
  end
end

# item = Item.new('08-08-2021')
# p item