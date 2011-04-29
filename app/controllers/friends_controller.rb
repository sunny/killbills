class FriendsController < ApplicationController
  # GET /user/1/friends
  def index
    @user = User.find(params[:user_id])
    @friends = @user.friends

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @friends }
    end
  end

  # GET /user/1/friends/1
  def show
    @user = User.find(params[:user_id])
    @friend = @user.friends.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @friend }
    end
  end

  # GET /user/1/friends/new
  def new
    @user = User.find(params[:user_id])
    @friend = @user.friends.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @friend }
    end
  end

  # GET /user/1/friends/1/edit
  def edit
    @user = User.find(params[:user_id])
    @friend = @user.friends.find(params[:id])
  end

  # POST /user/1/friends
  def create
    @user = User.find(params[:user_id])
    @friend = @user.friends.new(params[:friend])

    respond_to do |format|
      if @friend.save
        format.html { redirect_to([@user, @friend], :notice => 'Friend was successfully created.') }
        format.xml  { render :xml => @friend, :status => :created, :location => [@user, @friend] }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @friend.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /user/1/friends/1
  def update
    @user = User.find(params[:user_id])
    @friend = @user.friends.find(params[:id])

    respond_to do |format|
      if @friend.update_attributes(params[:friend])
        format.html { redirect_to([@user, @friend], :notice => 'Friend was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @friend.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /user/1/friends/1
  def destroy
    @user = User.find(params[:user_id])
    @friend = @user.friends.find(params[:id])
    @friend.destroy

    respond_to do |format|
      format.html { redirect_to(user_friends_url(@user)) }
      format.xml  { head :ok }
    end
  end
end
