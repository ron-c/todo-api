class Tag < ApplicationRecord
  has_and_belongs_to_many :tasks

  scope :with_title, ->(*titles) { where(title: titles) }

  validates :title, presence: true, uniqueness: { case_sensitive: false }

  def self.collection_from_names(names)
    existing = with_title(*names)

    names.map do |name|
      existing.detect { |tag| tag.title == name } || new(title: name)
    end
  end
end
