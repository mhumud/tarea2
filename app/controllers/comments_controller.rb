class CommentsController < ApplicationController
  before_action :set_entry
  before_action :set_comment, only: [:show, :put, :patch, :destroy]

  # GET /comments
  def index
    @comments = @entry.comments

    render json: @comments.as_json(except: [:updated_at, :entry_id])
  end

  # GET /comments/1
  def show
    render json: @comment.as_json(except: [:updated_at, :entry_id])
  end

  # POST /comments
  def create
    @comment = @entry.comments.new(comment_params)

    if @comment.save
      render json: @comment.as_json(except: [:updated_at, :entry_id]), status: :created, 
      location: "/news/#{params[:entry_id]}/comments/#{@comment.id}"
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # PATCH /comments/1
  def patch
    if @comment.update(comment_params)
      render json: @comment.as_json(except: [:updated_at, :entry_id])
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # PUT /comments/1
  def put
    if (params[:author].nil? || !(params[:comment].is_a? String))
      render json: {error: "Missing parameters" }, status: :bad_request
    else
      if @comment.update(comment_params)
        render json: @comment.as_json(except: [:updated_at, :entry_id])
      else
        render json: @comment.errors, status: :unprocessable_entity
      end
    end
  end

  # DELETE /comments/1
  def destroy
    @comment.destroy

    render json: @comment.as_json(except: [:updated_at, :entry_id])
  end

  private
    def set_entry
      @entry = Entry.find(params[:entry_id])
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = @entry.comments.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def comment_params
      params.permit(:entry_id, :author, :comment)
    end
end
