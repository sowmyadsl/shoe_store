require('spec_helper')


describe('add a brand to a store route', {:type => :feature}) do
  it('allows a user to add a specific brand to a store') do
    visit('/brands')
    fill_in('brand_name', :with => "puma")
    fill_in('price', :with => 50)
    click_button('Add Brand')
    expect(page).to have_content("Puma")
  end
end

describe('list all brands route', {:type => :feature}) do
  it('allows a user to see all of the brands in the database') do
    test_store = Brand.create({:name => "puma"})
    test_store2 = Brand.create({:name => "adidas"})
    visit('/brands')
    expect(page).to have_content(test_store.name)
  end
end

describe('see brand details path', {:type => :feature}) do
  it('allows a user to view the brands details') do
    test_brand = Brand.create({:name => "puma", :price => 50})
    visit('/brands')
    click_link('Puma')
    expect(page).to have_content("Current Brand Name: Puma")
  end
end
