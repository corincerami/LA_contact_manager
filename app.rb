require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

require_relative 'models/contact'

# Client.where("orders_count = ?", params[:orders])

get "/" do
  redirect "/contacts"
end

get '/contacts' do
  # if query param exists, set @search, else @search is empty
  @search = params[:query] || ""
  # if the page param exists, set @page, else @page is 1
  @page = params[:page] || 1
  @page = @page.to_i
  @page_offset = (@page.to_i - 1) * 3
  if !@search.empty?
    @contacts = Contact.where("first_name = ? OR last_name = ?",
                @search.capitalize, @search.capitalize).limit(3).offset(@page_offset)
  else
    @contacts = Contact.all.limit(3).offset(@page_offset)
  end
  erb :index
end

get "/contacts/new" do
  erb :new
end

get "/contacts/:id" do
  @contact = Contact.find(params[:id])
  erb :show
end

post "/contacts" do
  first_name = params[:first_name]
  last_name = params[:last_name]
  phone_number = params[:phone_number]
  Contact.create(first_name: first_name, last_name: last_name, phone_number: phone_number)
  redirect "/"
end
