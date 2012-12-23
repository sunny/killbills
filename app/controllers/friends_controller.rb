class FriendsController < ApplicationController
  before_filter :show_anonymous_warning

  def index
    @friends = current_user_or_guest.friends.order(:name) \
      .includes(bills: :participations)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render xml: @friends }
    end
  end

  # GET /friends/1
  def show
    @friend = current_user_or_guest.friends \
      .includes(bills: :participations) \
      .find(params[:id])
    @bills = current_user_or_guest.bills_with_friend(@friend)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render xml: @friend }
    end
  end

  # GET /friends/new
  def new
    @friend = current_user_or_guest.friends.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render xml: @friend }
    end
  end

  # GET /friends/1/edit
  def edit
    @friend = current_user_or_guest.friends.find(params[:id])
  end

  # POST /friends
  def create
    @friend = current_user_or_guest.friends.new(params[:friend])

    respond_to do |format|
      if @friend.save
        format.html { redirect_to(@friend, notice: t('friend.created')) }
        format.xml  { render xml: @friend, status: :created, location: @friend }
      else
        format.html { render action: "new" }
        format.xml  { render xml: @friend.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /friends/1
  def update
    @friend = current_user_or_guest.friends.find(params[:id])

    respond_to do |format|
      if @friend.update_attributes(params[:friend])
        format.html { redirect_to(@friend, notice: t('friend.updated')) }
        format.xml  { head :ok }
      else
        format.html { render action: "edit" }
        format.xml  { render xml: @friend.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /friends/1
  def destroy
    @friend = current_user_or_guest.friends.find(params[:id])
    @friend.destroy

    respond_to do |format|
      format.html { redirect_to(friends_url) }
      format.xml  { head :ok }
    end
  end
end
