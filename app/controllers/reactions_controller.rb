class ReactionsController < ApplicationController
  def create
    confession = Confession.find(params[:confession_id])
    ip = request.remote_ip

    if confession.reactions.where(ip: ip).exists?
      redirect_to root_path, alert: "You have already reacted to this confession."
    else
      confession.reactions.create(emoji: params[:emoji], ip: ip)
      redirect_to root_path, notice: "Thanks for reacting!"
    end
  end
end
