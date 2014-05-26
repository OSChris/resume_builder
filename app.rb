require 'sinatra'
require 'data_mapper'


DataMapper.setup(:default, ENV["DATABASE_URL"] || "sqlite3://#{Dir.pwd}/contractor.db")

class Resume


  include DataMapper::Resource

  property :id,       Serial

  property :name,      String
  property :address,   String
  property :url,       String
  property :image,     Text
  property :linkedin,  Text
  property :education, Text
  property :work,      Text

end

DataMapper.finalize

Resume.auto_upgrade!

get '/' do 
  erb :index, layout: :default_layout
end

get '/create' do 
  erb :create, layout: :default_layout
end

post '/create' do
  @name = params[:name]
  @url = params[:url]

  Resume.create(params)

  erb :reminder, layout: :default_layout
end

get '/resume/:url' do |custom|
  
  Resume.all.each do |chosen|
    if chosen.url == custom.to_s
      @name =      chosen.name
      @address =   chosen.address
      @image =     chosen.image
      @linkedin =  chosen.linkedin
      @education = chosen.education
      @work =      chosen.work
    end
  end
  erb :resume, layout: :default_layout
end


















