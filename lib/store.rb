class Store < ActiveRecord::Base

  has_and_belongs_to_many(:brands)
  before_save (:capitalize_store_name)
  validates :name, presence: true, uniqueness: true, length: { maximum: 100 }

private
  define_method(:capitalize_store_name) do
    self.name=(name().capitalize())
  end

end
