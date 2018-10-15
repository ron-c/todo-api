class Task < ApplicationRecord
  has_and_belongs_to_many :tags

  validates :title, presence: true

  def tags=(tag_array)
    if tag_array.all? { |tag| tag.is_a?(String) }
      collection = Tag.collection_from_names(tag_array)
      super(collection)
    else
      super
    end
  rescue ActiveRecord::RecordInvalid
    errors.add(:tags, :invalid)
  end
end
