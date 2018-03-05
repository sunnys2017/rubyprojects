class ArticlesController < ApplicationController
  # simple test only, username/password should move to file that not be commited.
  # http_basic_authenticate_with name: "sunny", password: "password", except: [:index, :show]

  def index
    @articles = Article.all
  end

  def new
  	@article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
 
    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def show
  	#We also use an instance variable (prefixed with @) to hold a reference 
  	# to the article object. We do this because Rails will pass all 
  	# instance variables to the view.
    @article = Article.find(params[:id])
  end

  def create
  	#The render method here is taking a very simple hash with a key of 
  	# :plain and value of params[:article].inspect. 
  	# The params method is the object which represents the parameters 
  	# (or fields) coming in from the form. The params method returns 
  	# an ActionController::Parameters object, which allows you to 
  	# access the keys of the hash using either strings or symbols. 
  	# In this situation, the only parameters that matter are the ones 
  	# from the form.
  	#render plain: params[:article].inspect

  	#every Rails model can be initialized with its respective attributes, 
  	# which are automatically mapped to the respective database columns
  	@article = Article.new(article_params)
    #Class names in Ruby must begin with a capital letter.
    @article.save
    #security features: strong parameters,which requires us to tell Rails 
    # exactly which parameters are allowed into our controller actions.
    # to prevent mass assignment issues.
    if @article.save
      flash[:notice] = 'Article was successfully created.'
      redirect_to @article
    else
      # use render instead of redirect, so @article object is passed back 
      # to the 'new' template
      render 'new'
    end
  end

  def destroy
	@article = Article.find(params[:id])
	@article.destroy
	 
	redirect_to articles_path
  end

  private
  # This is factored out into its own method so it can be reused by multiple 
  # actions in the same controller.
  def article_params
    params.require(:article).permit(:title, :text)
  end

end
