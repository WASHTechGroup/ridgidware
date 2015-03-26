class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_filter :teir_two, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
    @order.parts_in_order.build
  end

  # GET /orders/1/edit
  def edit
  end

  # GET /reciving
  def recieving
    @orders = Order.all
  end

  # POST /remove_item.json | Removes an item from the database
  def remove_item
    part = Part.find(params[:part_id])
    order = Order.find(params[:order_id])
    respond_to do |format|
      if part && order
        list_item = PartsInOrder.find_by({part_id: part.id, order_id: order.id})
        if list_item
          list_item.destroy!
          msg = { :status => "ok", :message => "Success!"}
          format.json { render json: msg }
        else
          msg = { :status => "error", :message => "This Part is not in this order!"}
        format.json { render json: msg }
        end
      else
        msg = { :status => "error", :message => "Missing Part or Order in the DB!"}
        format.json { render json: msg }
      end
    end
  end

  # Udating the inventory levels 
  def update_values
    part = Part.find(params[:part_id])
    order = Order.find(params[:order_id])
    respond_to do |format|
      if part && order
        list_item = PartsInOrder.find_by({part_id: part.id, order_id: order.id})
        if list_item
          old_qr = list_item.quant_received
          list_item.quant_received = params[:quant_received]
          list_item.quant_backordered = params[:quant_backordered]
          list_item.save!
          d_oro = old_qr - list_item.quant_received
          part.on_order = part.on_order + d_oro 
          part.on_hand = part.on_hand - d_oro
          part.save!
          msg = { :status => "ok", :message => "Success!"}
          format.json { render json: msg }
        else
          msg = { :status => "error", :message => "This Part is not in this order!"}
        format.json { render json: msg }
        end
      else
        msg = { :status => "error", :message => "Missing Part or Order in the DB!"}
        format.json { render json: msg }
      end
    end
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, flash: { sucess: 'Order was successfully created.' } }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, flash: { sucess: 'Order was successfully updated.' } }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, flash: { sucess: 'Order was successfully destroyed.' } }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:order_no, :po_number, :subtotal, :tax, :total, :comment, :parts_in_order_attributes => [:part_id, :amount, :cost, :quant_ordered, :quant_received, :quant_backordered, :id])
    end
end
