class RedirectsController < ApplicationController
  before_action :set_redirect, only: [:show, :edit, :update, :destroy, :up, :down]

  # GET /redirects
  # GET /redirects.json
  def index
    @redirects = Redirect.user_ordered
  end

  # GET /redirects/1
  # GET /redirects/1.json
  def show
  end

  # GET /redirects/new
  def new
    @redirect = Redirect.new
  end

  # GET /redirects/1/edit
  def edit
  end

  # POST /redirects
  # POST /redirects.json
  def create
    # TODO: Integrate picking next order number into model creation
    max_order = Redirect.max_order
    @redirect = Redirect.new(redirect_params.merge(order: max_order + 1))

    respond_to do |format|
      if @redirect.save
        format.html { redirect_to @redirect, notice: 'Redirect was successfully created.' }
        format.json { render :show, status: :created, location: @redirect }
      else
        format.html { render :new }
        format.json { render json: @redirect.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /redirects/1
  # PATCH/PUT /redirects/1.json
  def update
    respond_to do |format|
      if @redirect.update(redirect_params)
        format.html { redirect_to @redirect, notice: 'Redirect was successfully updated.' }
        format.json { render :show, status: :ok, location: @redirect }
      else
        format.html { render :edit }
        format.json { render json: @redirect.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /redirects/1
  # DELETE /redirects/1.json
  def destroy
    @redirect.destroy
    respond_to do |format|
      format.html { redirect_to redirects_url, notice: 'Redirect was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # POST /redirects/1/up
  # POST /redirects/1/up.json
  def up
    respond_to do |format|
      if @redirect.reorder_up
        format.html { redirect_to redirects_url, notice: 'Redirect was successfully updated.' }
        format.json { render :show, status: :ok, location: @redirect }
      else
        format.html { redirect_to redirects_url, notice: 'Could not reorder redirect' }
        format.json { head :no_content }
      end
    end
  end

  # POST /redirects/1/down
  # POST /redirects/1/down.json
  def down
    respond_to do |format|
      if @redirect.reorder_down
        format.html { redirect_to redirects_url, notice: 'Redirect was successfully updated.' }
        format.json { render :show, status: :ok, location: @redirect }
      else
        format.html { redirect_to redirects_url, notice: 'Could not reorder redirect' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_redirect
      @redirect = Redirect.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def redirect_params
      params.require(:redirect).permit(:regex, :result, :code)
    end
end
