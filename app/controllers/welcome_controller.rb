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
      :count => Company.all.size,
      :link => companies_path,
      :desc => ""
    }
    @stats[:badges] = {
      :color => "neutral_a",
      :count => BadgeAward.all.size,
      :link => badges_path,
      :desc => "Awarded"
    }
    @stats[:practices] = {
      :color => "neutral_b",
      :count => Practice.all.size,
      :desc => "Distilled from Legal Documents"
    }
    @stats[:articles] = {
      :color => "light",
      :count => Article.all.size,
      :desc => ""
    }
    @stats[:journals] = {
      :color => "dark",
      :count => Journal.all.size,
      :link => journals_path,
      :desc => ""
    }

  end

end
