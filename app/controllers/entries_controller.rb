class EntriesController < ApplicationController
  before_action :set_entry, only: [:show, :put, :patch, :destroy]

  # GET /entries
  def index
    @entries = Entry.all
    @entries.map{ |entry| entry["body"] = entry["body"].truncate(500) }

    render json: @entries.as_json(except: [:updated_at])
  end

  # GET /entries/1
  def show
    render json: @entry.as_json(except: [:updated_at])
  end

  # POST /entries
  def create
    @entry = Entry.new(entry_params)

    if @entry.save
      render json: @entry.as_json(except: [:updated_at]), status: :created, location: @entry
    else
      render json: @entry.errors, status: :unprocessable_entity
    end
  end

  # PATCH /entries/1
  def patch
    if @entry.update(entry_params)
      render json: @entry.as_json(except: [:updated_at])
    else
      render json: @entry.errors, status: :unprocessable_entity
    end
  end

  # PUT /entries/1
  def put
    if (params[:body].nil? || params[:title].nil?)
      render json: {error: "Missing parameters" }, status: :bad_request
    else    
      if @entry.update(entry_params)
        render json: @entry.as_json(except: [:updated_at])
      else
        render json: @entry.errors, status: :unprocessable_entity
      end
    end
  end

  # DELETE /entries/1
  def destroy
    @entry.destroy

    render json: @entry.as_json(except: [:updated_at])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_entry
      @entry = Entry.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def entry_params
      params.permit(:title, :body, :subtitle)
    end
end
