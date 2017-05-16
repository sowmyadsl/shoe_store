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

patch('/stores/:id') do
  if params.fetch("form_id").==("update_name")
    @store = Store.find(params.fetch('id').to_i())
    name = params.fetch('new_name')
    if @store.update(:name => name)
      redirect('/stores/#{@store.id}')
    else
      erb(:store_errors)
    end
  elsif params.fetch("form_id").==("update_brands")
    @store = Store.find(params.fetch('id').to_i())
    new_brand_ids = params[:brand_ids]
    brand_ids_array = []
    @store.brands().each() do |brand|
     brand_ids_array.push(brand.id())
    end
    new_brand_ids.each() do |id|
      brand_ids_array.push(id)
    end
    @store.update({:brand_ids => brand_ids_array})
    rredirect('/stores/#{@store.id}')
    erb(:store)
  elsif params.fetch("form_id").==("add_brand")
    @store = Store.find(params.fetch("id").to_i())
    name = params.fetch('brand_name')
    @brand = @store.brands.new({:name => name})
    @store.brands.push(@brand)
    redirect('/stores/#{@store.id}')
    erb(:store)
  end
end


delete('/stores/:id') do
  store_id = params.fetch('id').to_i()
  @store = Store.find(store_id)
  @store.destroy()
  redirect('/stores')
end

delete('/stores/:id/remove_brand') do
  store = Store.find(params.fetch("id").to_i)
  brand_id = params.fetch("brand_id").to_i
  store.brands.destroy(Brand.find(brand_id))
  redirect('/stores/'.concat(store.id.to_s))
end

get('/brands') do
  @brands = Brand.all()
  erb(:brands)
end

post('/brands') do
  name = params.fetch('brand_name')
  price = params.fetch('price')
  @brand = Brand.new(:name => name, :price => price)
  if @brand.save()
    redirect('/brands')
  else
    erb(:brand_errors)
  end
end

get('/brands/:id') do
  @brand = Brand.find(params.fetch('id').to_i())
  @brand_stores = @brand.stores()
  @stores = Store.all().-(@brand_stores)
  erb(:brand)
end


patch('/stores/:id/edit') do
  if params.fetch("form_id").==("update_name")
    @store = Store.find(params.fetch('id').to_i())
    name = params.fetch('new_name')
    if @store.update(:name => name)
      redirect('/stores/'.concat(@store.id().to_s()))
      erb(:store)
    else
      erb(:store_errors)
    end
  elsif params.fetch("form_id").==("update_brands")
    @store = Store.find(params.fetch('id').to_i())
    new_brand_ids = params[:brand_ids]
    brand_ids_array = []
    @store.brands().each() do |brand|
     brand_ids_array.push(brand.id())
    end
    new_brand_ids.each() do |id|
      brand_ids_array.push(id)
    end
    @store.update({:brand_ids => brand_ids_array})
    redirect('/stores/'.concat(@store.id().to_s()))
    erb(:store)
  elsif params.fetch("form_id").==("add_brand")
    @store = Store.find(params.fetch("id").to_i())
    name = params.fetch('brand_name')
    @brand = @store.brands.new({:name => name})
    @store.brands.push(@brand)
    redirect('/stores/'.concat(@store.id().to_s()))
    erb(:store)
  end
end

patch('/brands/:id/edit') do
  if params.fetch("form_id").==("update_name")
    brand_id = params.fetch('id').to_i()
    @brand = Brand.find(brand_id)
    name = params.fetch('new_name')
    if @brand.update(:name => name)
      redirect('/brands/'.concat(@brand.id().to_s()))
    else
      erb(:brand_errors)
    end
  elsif params.fetch("form_id").==("update_stores")
    @brand = Brand.find(params.fetch('id').to_i())
    new_store_ids = params[:store_ids]
    store_ids_array = []
    @brand.stores().each() do |store|
     store_ids_array.push(store.id())
    end
    new_store_ids.each() do |id|
      store_ids_array.push(id)
    end
    @brand.update({:store_ids => store_ids_array})
    redirect('/brands/'.concat(@brand.id().to_s()))
    erb(:brand)
  end
end

delete('/brands/:id') do
  brand_id = params.fetch('id').to_i()
  @brand = Brand.find(brand_id)
  @brand.destroy()
  redirect('/brands')
end

delete('/brands/:id/remove_store') do
  brand = Brand.find(params.fetch("id").to_i)
  store_id = params.fetch("store_id").to_i
  brand.stores.destroy(Store.find(store_id))
  redirect('/brands/'.concat(brand.id.to_s))
end
