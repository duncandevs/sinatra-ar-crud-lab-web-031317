# Blog Post App
#   Create Action
#     creates a new blog post (FAILED - 1)
#     redirects to '/posts' (FAILED - 2)
#   Read Action
#     index action
#       responds with a 200 status code
#       displays all the blog posts
#     show action
#       show page responds with a 200 status code
#       show page displays the post's name
#       show page displays the post's content
#   update action
#     responds with a 200 status code (FAILED - 3)
#     displays the existing object in the edit form (FAILED - 4)
#     saves edits to a blog post (FAILED - 5)
#     redirects to '/posts/:id' (FAILED - 6)
#     submits the form via a patch request (FAILED - 7)
#   delete action
#     responds with a 200 status code
#     deletes a blog post from the database (FAILED - 8)
#     displays a view telling us which post was deleted (FAILED - 9)
#     submits the form via a delete request (FAILED - 10)

require_relative '../../config/environment'
require 'pry'
class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do

  end

  get '/posts' do
    @posts = Post.all
    erb :index
  end

  #TO CREATE A POST REQUIRES TWO ACTIONS RENDERING A FORM FOR THE POST(get route) AND THEN GRABBING DATA(post route)
  get '/posts/new' do
    #grab a new form
    erb :new
  end

  post '/posts' do
    #will create a new instance of post and save it to the database
    Post.create(name: params[:name], content: params[:content])
    @posts = Post.all
    erb :index
  end

  get '/posts/:id' do
    # Create the get '/posts/:id' controller action. This action should use Active Record to grab the post with the id that is in the params and set it equal to @post. Then, it should render the show.erb view page. That view should use erb to render the @post's title and content.
    @post = Post.find(params[:id])
    erb :show
  end

  get '/posts/:id/edit' do
    @post = Post.find(params[:id])
    erb :edit
  end

  patch '/posts/:id' do
    #grab existing Record with id = :id
    #update with form info
    #redirect to the post/id
    post = Post.find(params[:id])
    post.update(name: params[:name] , content: params[:content])
    redirect to("/posts/#{post.id}")
  end

  delete '/posts/:id/delete' do
    # The Delete CRUD action corresponds to the delete controller action, delete '/posts/:id/delete'. To initiate this action, we'll just add a "delete button" to the show page. This "button" will actually be a form, disguised as a button (intriguing, I know). The form will send a POST request to the delete controller action, where we will identify the post to delete and delete it. Then, the action should render a delete.erb view which confirms that the post has been deleted.
    @post = Post.find(params[:id])
    @post.destroy
    erb :delete
    
  end




end
