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
