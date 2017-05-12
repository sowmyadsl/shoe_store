class Brand < ActiveRecord::Base
  has_and_belongs_to_many(:stores)
   validates(:name, {:presence => true, :length => { :maximum => 20 }})
   before_save(:capitalize_brand_name)

   private

  define_method(:capitalize_brand_name) do
    self.name=(name().capitalize())
  end
end
