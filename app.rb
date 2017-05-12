require('bundler/setup')
Bundler.require(:default)

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each {|file| require file}

get('/') do
  erb(:index)
end

get('/stores') do
  @stores = Store.all()
  erb(:stores)
end

post('/stores') do
  name = params.fetch('store_name')
  @store = Store.new(:name => name)
  if @store.save()
    redirect('/stores')
  else
    erb(:store_errors)
  end
end

get('/stores/:id') do
  @store = Store.find(params.fetch('id').to_i())
  @store_brands = @store.brands()
  @brands = Brand.all().-(@store_brands)
  erb(:store)
end
