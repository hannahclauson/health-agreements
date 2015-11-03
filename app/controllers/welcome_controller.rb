class WelcomeController < ApplicationController
  def index
    @badges = {}
    ["Research", "Single State Hosted", "HIPAA Compliance"].each do |name|
      @badges[name] = Badge.where(name: name).first
    end

  end
end
