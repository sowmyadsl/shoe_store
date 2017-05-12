require "spec_helper"


describe Brand, type: :model do

  it { should have_and_belong_to_many :stores }

  it('validate the presence of name') do
    test_brand = Brand.new({:name => ""})
    expect(test_brand.save()).to(eq(false))
  end

  describe "#price" do
    it "returns the brand's price" do
      brand = Brand.create({:name => "Adidas", :price => 20})
      expect(brand.price).to eq 20.00
    end
  end

  it('restricts the length of the name to 100 characters or less') do
    test_brand = Brand.new({:name => "a".*(101)})
    expect(test_brand.save()).to(eq(false))
  end


  it('capitalizes the name') do
    test_brand = Brand.create(:name => "bata")
    expect(test_brand.name()).to(eq("Bata"))
  end
end
