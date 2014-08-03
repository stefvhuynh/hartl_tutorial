class StaticPagesController < ApplicationController
  def home
    render :home
  end

  def help
    render :help
  end

  def about
    render :about
  end

  def contact
    render :contact
  end
end
