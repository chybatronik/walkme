class TasksController < ApplicationController

  before_filter :authenticate_user!

  # GET /tasks
  # GET /tasks.json
  def index
    @user=User.find_by_authentication_token(params[:auth_token])
    if not @user
      render :status=>404, :json=>{:message=>'Invalid user.'}
      return 
    end
    @tasks = Catalog.find(params[:catalog_id]).tasks.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tasks }
    end
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    @user=User.find_by_authentication_token(params[:auth_token])
    @task = @user.catalogs.find(params[:catalog_id]).tasks.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @task }
    end
  end

  # GET /tasks/new
  # GET /tasks/new.json
  def new
    @user=User.find_by_authentication_token(params[:auth_token])
    @task = @user.catalogs.find(params[:catalog_id]).tasks.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @task }
    end
  end

  # GET /tasks/1/edit
  def edit
    @user=User.find_by_authentication_token(params[:auth_token])
    @task = @user.catalogs.find(params[:catalog_id]).tasks.find(params[:id])
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @user=User.find_by_authentication_token(params[:auth_token])
    if not @user
      render :status=>404, :json=>{:message=>'Invalid user.'}
      return 
    end
    @task = Catalog.find(params[:catalog_id]).tasks.new(params[:task])
    @task.catalog_id = params[:catalog_id]

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: 'Task was successfully created.' }
        format.json { render json: @task, status: :created, location: @task }
      else
        format.html { render action: "new" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tasks/1
  # PUT /tasks/1.json
  def update
    @user=User.find_by_authentication_token(params[:auth_token])
    @task = @user.catalogs.find(params[:catalog_id]).tasks.find(params[:id])

    respond_to do |format|
      if @task.update_attributes(params[:task])
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @user=User.find_by_authentication_token(params[:auth_token])
    @task = @user.catalogs.find(params[:catalog_id]).tasks.find(params[:id])
    @task.destroy

    respond_to do |format|
      format.html { redirect_to tasks_url }
      format.json { head :no_content }
    end
  end
end
