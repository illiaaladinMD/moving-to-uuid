class DataController < ApplicationController
  def index
  end

  def generate
    users = (1..50).map do
      User.create(
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name
      )
    end
    users.first(25).each do |user|
      post = user.posts.create(
        title: Faker::GreekPhilosophers.name,
        content: Faker::GreekPhilosophers.quote
      )
      post.reactions.create(user_id: user.id + 25)
      user.followers.create(follower_id: user.id + 25)
    end
    respond_to do |format|
      flash[:notice] = "Test data generated successfully"
      format.turbo_stream do
        render turbo_stream: turbo_stream.update("flash", partial: "data/flash")
      end
    end
  end
end