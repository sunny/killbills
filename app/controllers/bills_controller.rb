class BillsController < ApplicationController
  # TODO respond_with
  before_filter :show_anonymous_warning

  # GET /bills (.xml .json)
  def index
    @bills = current_user_or_guest.bills \
      .includes(:user, participations: :person) \
      .order("bills.date DESC, bills.created_at DESC")

    respond_to do |format|
      format.html { @bills = @bills.decorate }
      format.xml  { render xml: @bills }
      format.json { render json: @bills }
    end
  end

  # GET /bills/1 (.xml .json)
  def show
    @bill = current_user_or_guest.bills \
      .includes(participations: :person) \
      .find(params[:id])

    respond_to do |format|
      format.html { @bill = @bill.decorate }
      format.xml  { render xml: @bill }
      format.json { render json: @bill }
    end
  end

  # GET /bills/new (.xml .json)
  def new
    friend = params[:friend] ? current_user_or_guest.friends.where(name: params[:friend]).first : nil
    @bill = current_user_or_guest.bills.new
    @bill.participations.build(person: current_user_or_guest)
    @bill.participations.build(person: friend)

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @bill }
      format.json { render json: @bill }
    end
  end

  # GET /bills/1/edit
  def edit
    @bill = current_user_or_guest.bills.find(params[:id])
  end

  # POST /bills (.xml .json)
  def create
    @bill = current_user_or_guest.bills.new(bill_params)

    respond_to do |format|
      if @bill.save
        format.html { redirect_to(@bill, notice: t('bill.created')) }
        format.xml  { render xml: @bill, status: :created, location: @bill }
        format.xml  { render json: @bill, status: :created, location: @bill }
      else
        format.html { render action: "new" }
        format.xml  { render xml: @bill.errors, status: :unprocessable_entity }
        format.xml  { render json: @bill.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /bills/1 (.xml .json)
  def update
    @bill = current_user_or_guest.bills.find(params[:id])

    respond_to do |format|
      if @bill.update_attributes(bill_params)
        format.html { redirect_to(@bill, notice: t('bill.updated')) }
        format.xml  { head :ok }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.xml  { render xml: @bill.errors, status: :unprocessable_entity }
        format.json { render json: @bill.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bills/1 (.xml)
  def destroy
    @bill = current_user_or_guest.bills.find(params[:id])
    @bill.destroy

    respond_to do |format|
      format.html { redirect_to(bills_url) }
      format.xml  { head :ok }
      format.json  { head :ok }
    end
  end


private

  def bill_params
    # Strong parameters
    bill_params = params.require(:bill).permit(:title, :date, :genre,
      participations_attributes: [:person_id, :payment, :owed_type, :owed_amount, :owed_percent, :id]
    )

    # Create friends if needed
    participations_attributes_change(bill_params[:participations_attributes])
    bill_params
  end

  # Create friends if given a name instead of a person_id
  def participations_attributes_change(attributes)
    return unless attributes
    attributes.each do |index, participation|
      person_id = participation[:person_id]
      if person_id !~ /^([0-9]+|)$/
        friend = current_user_or_guest.friends.where(name: person_id).first_or_create!
        attributes[index][:person_id] = friend.id
      end
    end
  end
end

