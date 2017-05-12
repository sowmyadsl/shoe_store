class Brand < ActiveRecord::Base
  has_and_belongs_to_many(:stores)
   validates(:name, {:presence => true, uniqueness: true, :length => { :maximum => 100 }})
   before_save(:capitalize_brand_name)

   def currency_format
    currency_price = nil
    if price == 0
      currency_price = "$0.00"
    else
      currency_price = price.to_s
      currency_price = "$#{currency_price}0"
    end
    currency_price
  end

   private

  define_method(:capitalize_brand_name) do
    self.name=(name().capitalize())
  end
end
