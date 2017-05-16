require "spec_helper"

describe('create a shoe store route', {:type => :feature}) do
  it('allows a user to save a shoe store in the database') do
    visit('/')
    click_link('See the stores')
    expect(page).to have_content("The database doesn't have any stores")
    fill_in("store_name", :with => "adidas")
    click_button('Add Store')
    expect(page).to have_content("Adidas")
  end
end

describe('list all shoe stores route', {:type => :feature}) do
  it('allows a user to see all of the stores in the database') do
    test_store = Store.create({:name => "puma"})
    test_store2 = Store.create({:name => "adidas"})
    visit('/stores')
    expect(page).to have_content(test_store.name)
  end
end

describe('see store details path', {:type => :feature}) do
  it('allows a user to view the stores details') do
    test_store = Store.create({:name => "adidas"})
    visit('/stores')
    click_link('Adidas')
    expect(page).to have_content("Current Store Name: Adidas")
  end
end

describe('update store path', {:type => :feature}) do
  it('allows a user to rename the store') do
    test_store = Store.create({:name => "adidas", :id => nil})
  visit('/stores')
    click_link('Adidas')
    fill_in('new_name', :with => "sowmya")
    click_button('Update')
    expect(page).to have_content("Sowmya")
  end
end

describe('delete store path', {:type => :feature}) do
  it('allows a user to delete a store from the database') do
    test_store = Store.create({:name => "adidas",:id => nil})
    visit('/stores')
    click_link('Adidas')
    click_button('Delete')
    expect(page).to have_no_content('Adidas')
  end
end
