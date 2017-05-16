require('spec_helper')


describe Store, type: :model do

  it { should have_and_belong_to_many :brands }

  it('restricts the length of the name to 100 characters or less') do
    test_store = Store.new({:name => "a".*(101)})
    expect(test_store.save()).to(eq(false))
  end

  it('validate the presence of name') do
    test_store = Store.new({:name => ""})
    expect(test_store.save()).to(eq(false))
  end

  it('downcases the name') do
    test_store = Store.create({:name => "joNNy"})
    expect(test_store.name).to(eq("Jonny"))
  end

  it('capitalizes the name') do
    test_store = Store.create({:name => "sowmya"})
    expect(test_store.name).to(eq("Sowmya"))
  end
end
