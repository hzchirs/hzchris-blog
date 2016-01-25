class BasicPagesController < ApplicationController
  def about
  end

  def resume
    render layout: 'resume'
  end
end
