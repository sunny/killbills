class BillsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :create_new_friends

  # GET /bills
  # GET /bills.xml
  def index
    @bills = current_user.bills \
      .includes(:user, participations: :person) \
      .order("bills.date DESC, bills.created_at DESC")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @bills }
    end
  end

  # GET /bills/1
  # GET /bills/1.xml
  def show
    @bill = current_user.bills \
      .includes(participations: :person) \
      .find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @bill }
    end
  end

  # GET /bills/new
  # GET /bills/new.xml
  def new
    friend = params[:friend] ? current_user.friends.where(name: params[:friend]).first : nil
    @bill = current_user.bills.new
    @bill.participations.build(person: current_user)
    @bill.participations.build(person: friend)

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @bill }
    end
  end

  # GET /bills/1/edit
  def edit
    @bill = current_user.bills.find(params[:id])
  end

  # POST /bills
  # POST /bills.xml
  def create
    @bill = current_user.bills.new(params[:bill])

    respond_to do |format|
      if @bill.save
        format.html { redirect_to(@bill, notice: 'Bill was successfully created.') }
        format.xml  { render xml: @bill, status: :created, location: @bill }
      else
        format.html { render action: "new" }
        format.xml  { render xml: @bill.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /bills/1
  # PUT /bills/1.xml
  def update
    @bill = current_user.bills.find(params[:id])

    respond_to do |format|
      if @bill.update_attributes(params[:bill])
        format.html { redirect_to(@bill, notice: 'Bill was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render action: "edit" }
        format.xml  { render xml: @bill.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bills/1
  # DELETE /bills/1.xml
  def destroy
    @bill = current_user.bills.find(params[:id])
    @bill.destroy

    respond_to do |format|
      format.html { redirect_to(bills_url) }
      format.xml  { head :ok }
    end
  end


private


  def create_new_friends
    if params[:bill] and params[:bill][:participations_attributes]
      params[:bill][:participations_attributes].each do |k, participation|
        person_id = participation[:person_id]
        if !person_id.blank? and person_id !~ /^[0-9]+$/
          friend = current_user.friends.find_or_create_by_name(person_id)
          params[:bill][:participations_attributes][k][:person_id] = friend.id
        end
      end
    end
  end
end

