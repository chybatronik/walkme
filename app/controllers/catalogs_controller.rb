class CatalogsController < ApplicationController

  before_filter :authenticate_user!

  # GET /catalogs
  # GET /catalogs.json
  def index
    @catalogs = current_user.catalogs.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @catalogs }
    end
  end

  # GET /catalogs/1
  # GET /catalogs/1.json
  def show
    @catalog = current_user.catalogs.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @catalog }
    end
  end

  # GET /catalogs/new
  # GET /catalogs/new.json
  def new
    @catalog = current_user.catalogs.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @catalog }
    end
  end

  # GET /catalogs/1/edit
  def edit
    @catalog = current_user.catalogs.find(params[:id])
  end

  # POST /catalogs
  # POST /catalogs.json
  def create
    @catalog = current_user.catalogs.new(params[:catalog])

    respond_to do |format|
      if @catalog.save
        format.html { redirect_to @catalog, notice: 'Catalog was successfully created.' }
        format.json { render json: @catalog, status: :created, location: @catalog }
      else
        format.html { render action: "new" }
        format.json { render json: @catalog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /catalogs/1
  # PUT /catalogs/1.json
  def update
    @catalog = current_user.catalogs.find(params[:id])

    respond_to do |format|
      if @catalog.update_attributes(params[:catalog])
        format.html { redirect_to @catalog, notice: 'Catalog was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @catalog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /catalogs/1
  # DELETE /catalogs/1.json
  def destroy
    @catalog = current_user.catalogs.find(params[:id])
    @catalog.destroy

    respond_to do |format|
      format.html { redirect_to catalogs_url }
      format.json { head :no_content }
    end
  end
end
