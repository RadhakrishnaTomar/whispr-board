class ConfessionsController < ApplicationController
  def index
    @confessions = Confession.order(created_at: :desc)
    @confession = Confession.new
  end

  def create
    ip = request.remote_ip
    count_today = Confession.where(ip: ip).where("created_at >= ?", Time.zone.now.beginning_of_day).count

    if count_today >= 3
      redirect_to root_path, alert: "You have reached your daily confession limit (3 per day)."
    else
      @confession = Confession.new(confession_params.merge(ip: ip))
      if @confession.save
        redirect_to root_path, notice: "Confession posted!"
      else
        @confessions = Confession.order(created_at: :desc)
        render :index
      end
    end
  end

  private

  def confession_params
    params.require(:confession).permit(:body)
  end
end
