require_relative '../../config/environment'
require 'pry'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do

  end

  # Create
  get '/posts/new' do
    erb :new # This takes us to the form where we can create a new post
  end

  # Read
  get '/posts/:id' do
    @post = Post.find(params["id"]) # the params are sent over with some premade fields including id
    erb :show
  end

  # Read
  get '/posts' do
    @posts = Post.all
    erb :index # Shows us all of the posts
  end

  # Create
  post '/posts' do # The new post form takes us here where we create a new post instance from the info entered
    post = Post.new
    post.name = params["name"]
    post.content = params["content"]
    post.save

    redirect "/posts" # to the specific page for that post that was just created
  end

  # Update
  get '/posts/:id/edit' do
    @post = Post.find(params["id"])
    erb :edit
  end

  # Update
  patch '/posts/:id' do
    post = Post.find(params["id"])
    post.name = params["name"]
    post.content = params["content"]
    post.save
    redirect "/posts/#{post.id}"
  end

  get '/posts/:id/delete' do
    @post = Post.find(params["id"])
    @post.destroy
    erb :delete
  end

  delete '/posts/:id' do
    redirect "/posts/#{params["id"]}/delete"
  end
end
