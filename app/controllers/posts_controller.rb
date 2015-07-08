class PostsController < ApplicationController
  before_action :set_post, only: [:edit, :update, :destroy]
  #before_action :authenticate_user!

  # GET /posts
  # GET /posts.json
  def index
    offset = params[:page].nil? ? 0 : (params[:page].to_i - 1) * 5

    @tags = tags
    @dates = dates

    @posts = Post
                 .where(:published => true)
                 .order(release_date: :desc)
                 .limit(5)
                 .offset(offset) unless user_signed_in?
    @posts = Post
                 .all
                 .order(release_date: :desc)
                 .limit(5)
                 .offset(offset) if user_signed_in?
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find_by_seo_name(params[:seo_name])
  end

  # GET /posts/new
  def new
    session_valid?
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    session_valid?
  end

  # POST /posts
  # POST /posts.json
  def create
    if session_valid?
      @post = Post.new(post_params)
      post_defaults @post

      respond_to do |format|
        if @post.save
          format.html { redirect_to post_path(@post.seo_name), notice: 'Post was successfully created.' }
          format.json { render :show, status: :created, location: @post }
        else
          format.html { render :new }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    if session_valid?
      respond_to do |format|
        if @post.update(post_params)
          format.html { redirect_to post_path(@post.seo_name), notice: 'Post was successfully updated.' }
          format.json { render :show, status: :ok, location: @post }
        else
          format.html { render :edit }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    if session_valid?
      @post.destroy
      respond_to do |format|
        format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  private
    def tags
      post_select = Post.select("GROUP_CONCAT(tags) as alltags")
      post_select.nil? ? [] : post_select[0].alltags.split(",").select {|x| x!=""}
    end

    def dates
      posts = Post.select('DATE(created_at) as date').order(created_at: :desc).group('date')
      posts.nil? ? [] : posts.map {|p| p.date}
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:subject, :content, :release_date, :tags, :user_id, :published)
    end

    def post_defaults(post)
      post.seo_name ||= post.subject.parameterize
      post.user ||= current_user
      post.release_date ||= DateTime.now
    end
end
