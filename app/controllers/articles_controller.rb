class ArticlesController < ApplicationController
    
    def show
        @article = Article.find(params[:id])
    end
    
    def index
        @articles = Article.all
    end
    
    def new
        @article = Article.new
    end 
    
    def edit
        @article = Article.find(params[:id])
    end
    
    def create
        @article = Article.new(params.require(:article).permit(:title, :description)) 
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
        @article = Article.find(params[:id])
        if @article.update(params.require(:article).permit(:title, :description))
            flash[:notice] = "Article was updated successfully."
            redirect_to @article
        else
            render 'edit'
        end
    end
end