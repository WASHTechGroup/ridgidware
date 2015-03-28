class CartsController < ApplicationController
  before_action :set_cart, only: [:show, :edit, :update, :destroy]
  protect_from_forgery except: [:add_part,:update_part, :remove_part]

  # GET /carts/1
  # GET /carts/1.json
  def show
  end

  # POST /carts
  # POST /carts.json
  def create
    @cart = Cart.new(cart_params)

    respond_to do |format|
      if @cart.save
        format.html { redirect_to @cart, notice: 'Cart was successfully created.' }
        format.json { render :show, status: :created, location: @cart }
      else
        format.html { render :new }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /carts/1
  # PATCH/PUT /carts/1.json
  def update
    respond_to do |format|
      if @cart.update(cart_params)
        format.html { redirect_to @cart, notice: 'Cart was successfully updated.' }
        format.json { render :show, status: :ok, location: @cart }
      else
        format.html { render :edit }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  def part_in_cart 
    respond_to do |format|
      cart = Cart.find_by(params[:cart_id])
      if cart
        
      else 
        msg = { :status => "error", :message => "fail"}
        format { render json: msg }
      end
    end

  end

  def add_part
    part = Part.find(params[:part_id])
    cart = Cart.find(params[:cart_id]) 
    if !cart.parts.include?part
      cart.parts << part 
    else 
      inCart = PartsInCart.find_by({part_id: part.id, cart_id: cart.id})
      inCart.quantity_requested += 1
    end
    respond_to do |format|
      msg = { :status => "ok", :message => "Success!"}
      format.json { render json: msg }
    end
  end

  def update_part
    part = Part.find(params[:part_id])
    cart = Cart.find(params[:cart_id])
    inCart = PartsInCart.find_by({part_id: part.id, cart_id: cart.id})
    quant = params[:quantity_requested].to_i
    inCart.quantity_requested = quant
    if quant == 0
      inCart.destroy
    else
      inCart.save
    end

    respond_to do |format|
      msg = { :status => "ok", :message => "Success!"}
      format.json { render json: msg }
    end
  end

  def update_part_keep
    part = Part.find(params[:part_id])
    cart = Cart.find(params[:cart_id])
    inCart = PartsInCart.find_by({part_id: part.id, cart_id: cart.id})
    quant = params[:quantity_requested].to_i
    inCart.quantity_requested = quant
    inCart.save

    respond_to do |format|
      msg = { :status => "ok", :message => "Success!"}
      format.json { render json: msg }
    end
  end

  def remove_part
    part = Part.find(params[:part_id])
    cart = Cart.find(params[:cart_id])
    inCart = PartsInCart.find_by({part_id: part.id,  cart_id: cart})
    inCart.destroy
    respond_to do |format|
      msg = { :status => "ok", :message => "Success!"}
      format.json { render json: msg }
    end
  end

  def item_count
    cart = Cart.find(params[:cart_id])
    inCart = cart.parts_in_cart
    len = inCart.length
    respond_to do |format|
      msg = { count: len }
      format.json { render json:msg }
    end
  end

  # DELETE /carts/1
  # DELETE /carts/1.json
  def destroy
    @cart.destroy
    respond_to do |format|
      format.html { redirect_to carts_url, notice: 'Cart was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart
      @cart = Cart.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cart_params
      params.require(:cart).permit(:owner)
    end
end
