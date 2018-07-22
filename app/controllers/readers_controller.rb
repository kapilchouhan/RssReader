class ReadersController < ApplicationController

  def index
    @posts = Reader.all.order('published DESC')
  end
end
