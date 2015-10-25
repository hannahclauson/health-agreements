class JournalsController < ApplicationController

  def show
    current_journal
  end

  def index
    @journals = Journal.all
  end

  private

  def current_journal
    @journal ||= Journal.where(slug: params[:id]).first
    authorize! action_name.to_sym, @journal
  end

end
