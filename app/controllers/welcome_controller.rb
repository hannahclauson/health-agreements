class WelcomeController < ApplicationController
  def index
    @badges = {}
    ["Research", "Single State Hosted", "HIPAA Compliance"].each do |name|
      @badges[name] = Badge.where(name: name).first
      puts "#{name} nil? #{@badges[name].nil?}"
    end

  end
end
