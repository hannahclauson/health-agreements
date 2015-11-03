class WelcomeController < ApplicationController
  def index
    @badges = []
    @badges << Badge.where(name: "Research")
    @badges << Badge.where(name: "Multi-state Hosted")
    @badges << Badge.where(name: "HIPAA")

  end
end
