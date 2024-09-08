class HomeController < ApplicationController
  def index
    @lps = Lp.includes(songs: :authors).all
  end
end
