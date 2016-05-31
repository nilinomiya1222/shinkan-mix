class Lp::WelcomeController < Lp::BaseController
  before_action :redirect_to_close_page, only: :show
  def index
  end
  def show
  end

  private
  def redirect_to_close_page
    redirect_to :root
  end
end
