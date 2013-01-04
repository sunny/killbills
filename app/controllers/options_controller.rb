class OptionsController < ApplicationController
  def edit
    @user = current_user_or_guest
  end

  def update
    @user = current_user_or_guest
    respond_to do |format|
      if @user.update_attributes(user_params)
        format.html { redirect_to(edit_options_path, notice: t('options.edit.updated')) }
        format.xml  { head :ok }
        format.json  { head :ok }
      else
        format.html { render action: "edit" }
        format.xml  { render xml: @user.errors, status: :unprocessable_entity }
        format.json  { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def user_params
      params.require(:user).permit(:currency)
    end
end
