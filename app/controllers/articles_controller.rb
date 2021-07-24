class ArticlesController < ApplicationController
    
    before_action :set_article, only: [:show, :edit, :update, :destroy]
    before_action :require_user, except: [:show, :index]
    before_action :require_same_user, only: [:edit, :update, :destroy]
    
    def show
    end
    
    def index
        @articles = Article.paginate(page: params[:page], per_page: 3)
    end
    
    def new
        @article = Article.new
    end 

    def edit
    end

    def create
        @article = Article.new(article_params)
        @article.user = current_user
        if @article.save
        #需要白名單可submit的內容，rails有保護機制
            flash[:notice] = "Article was created successfully."
            redirect_to @article
        #意思等同redirect_to article_path(@article) ※可參考routes
        else
            render 'new'
        end
    end
    
    def update
        if @article.update(article_params)
            flash[:notice] = "Article was updated successfully."
            redirect_to @article
        else
            render 'edit'
        end
    end
    
    def destroy
        @article.destroy
        redirect_to articles_url
    end
    
    private #僅有在本controller才可使用下列method
    
    def set_article
        @article = Article.find(params[:id])
    end
    
    def article_params
        params.require(:article).permit(:title, :description)
    end

    def require_same_user
        redirect_to @article if current_user != @article.user && !current_user.admin?
    end
end