class WelcomeController < ApplicationController
  def index
    @badges = {}
    ["Research", "Single State Hosted", "HIPAA Compliance"].each do |name|
      @badges[name] = Badge.where(name: name).first
      puts "#{name} nil? #{@badges[name].nil?}"
    end

    @stats = {}

    @stats[:companies] = {
      :color => "dark",
      :count => Company.all.size
    }
    @stats[:articles] = {
      :color => "neutral_a",
      :count => Article.all.size
    }
    @stats[:journals] = {
      :color => "neutral_b",
      :count => Journal.all.size
    }
    @stats[:badges] = {
      :color => "light",
      :count => BadgeAward.all.size
    }

  end
end
