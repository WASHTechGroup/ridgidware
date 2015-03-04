class CartsController < ApplicationController
  before_action :set_cart, only: [:show, :edit, :update, :destroy]

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

def add_item_to_cart
  part = Part.find_by(params[:part_id])
  cart = Cart.find_by(params[:cart_id])
  cart.Parts << part.save
  cart.save 
end

def update_item_count
  part = Part.find_by(params[:part_id])
  cart = Cart.find_by(params[:cart_id])
  inCart = PartsInCart.where("part_id = ?, cart_id = ?", part.id, cart.id)
  inCart.quantity_requested = (params[:quantity_requested].2_i)
  if quantity_requested == 0
    inCart.destroy
  else
    inCart.save
  end
  cart.save
end

def delete_item_from_cart
  part = Part.find_by(params[:part_id])
  cart = Cart.find_by(params[:cart_id])
  inCart = PartsInCart.where("part_id = ?, cart_id = ?", part.id, cart)
  inCart.destroy
  cart.save
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
