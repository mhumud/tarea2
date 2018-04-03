class EntriesController < ApplicationController
  before_action :set_entry, only: [:show, :update, :destroy]

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

  # PATCH/PUT /entries/1
  def update
    if @entry.update(entry_params)
      render json: @entry.as_json(except: [:updated_at])
    else
      render json: @entry.errors, status: :unprocessable_entity
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
