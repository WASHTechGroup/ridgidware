class TransactionsController < ApplicationController
  protect_from_forgery except: [:get_totals,:get_cart]
  before_action :set_transaction, only: [:show, :edit, :update, :destroy]

  # GET /transactions
  # GET /transactions.json
  def index
    @transactions = Transaction.all
  end

  # POST /transactions
  # POST /transactions.json
  def create
    @transaction = Transaction.new(transaction_params)

    respond_to do |format|
      if @transaction.save
        format.html { redirect_to @transaction, notice: 'Transaction was successfully created.' }
        format.json { render :show, status: :created, location: @transaction }
      else
        format.html { render :new }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  def get_totals
    cart = Cart.find(params[:cart_id])
    @subtotal = 0
    cart.parts_in_cart.each do |inCart|
      part = Part.find(inCart.part_id)
      @subtotal += (inCart.quantity_requested*part.price)
    end
    @tax = @subtotal*0.13
    @total = @subtotal+@tax
    @total = @total.round(2)
    respond_to do |format| # in this logic, going to respond with HTML or JSON  
        format.json{render :tally, status: 200}
    end
  end

  # The checkout api
  def checkout
    @transaction = Transaction.new
    @transaction.cart_id = current_user.cart.id
    @transaction.total = params[:transaction][:total]
    @transaction.subtotal = params[:transaction][:subtotal]
    @transaction.tax = params[:transaction][:tax]
    @transaction.amount_given = params[:transaction][:amount_given]
    @transaction.change = params[:transaction][:change]
    @transaction.save!
    @transaction.checkout
    @cart = current_user.cart
    @cart.owner = params[:owners]
    current_user.cart = Cart.new
    current_user.cart.owner = current_user.username;
    current_user.save!
    respond_to do |format|
      if @transaction.save
        format.html { redirect_to :back, notice: 'Transaction was successfully created.' }
        format.json { render :show, status: :created, location: @transaction }
      else
        format.html { render :new }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end


 ## basically get negative money totals, pulling up a cart
  def return
    @transaction = Transaction.new
    @transaction.cart_id = current_user.cart.id
    @transaction.total = params[:transaction][:total]
    @transaction.subtotal = params[:transaction][:subtotal]
    @transaction.tax = params[:transaction][:tax]
    @transaction.amount_given = params[:transaction][:amount_given]
    @transaction.change = params[:transaction][:change]
    @transaction.save!
    @transaction.return
    @cart_retruning = Cart.find_by({owner: "#{current_user.username}_returns"})
    @cart_retruning.owner = ""
    @cart_retruning = Cart.new
    @cart_retruning.owner = "#{current_user.username}_returns"
    @cart_retruning.save!
    session[:returns_cart] = @cart_retruning.id 
    respond_to do |format|
      if @transaction.save
        format.html { redirect_to :back, notice: 'Transaction was successfully created.' }
        format.json { render :show, status: :created, location: @transaction }
      else
        format.html { render :new }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

 def get_transaction_for_return
    @transaction = Transaction.find_by(params[:transaction_id])
    @cart_id = @transaction.cart_id
    @parts_in_cart = Cart.find_by(@cart_id).parts_in_cart
    respond_to do |format|
      format.json{render :get_cart, status: 200}
    end
 end

  # PATCH/PUT /transactions/1
  # PATCH/PUT /transactions/1.json
  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to @transaction, notice: 'Transaction was successfully updated.' }
        format.json { render :show, status: :ok, location: @transaction }
      else
        format.html { render :edit }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transaction_params
      params.require[:transactions].permit[:transaction_id, :cart_id, :subtotal, :total, :tax, :amount_given, :change]
    end
end
