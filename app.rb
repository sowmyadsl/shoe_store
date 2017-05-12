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
  @brand = Brand.new(:name => name)
  if @brand.save()
    redirect('/brands')
  else
    erb(:brand_errors)
  end
end
