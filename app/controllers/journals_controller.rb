class JournalsController < ApplicationController

  def show
    current_journal
  end

  def index
    @journals = Journal.all
  end

  def new
    authorize! :new, Journal
    @journal = Journal.new
  end

  def create
    authorize! :create, Journal
    @journal = Journal.create(journal_params)

    if @journal.save
      redirect_to @journal
    else
      render 'new'
    end
  end

  def edit
    current_journal
  end

  def update
    current_journal

    if @journal.update(journal_params)
      redirect_to @journal
    else
      render 'edit'
    end
  end

  def destroy
    current_journal
    @journal.destroy

    redirect_to journals_path
  end


  private

  def current_journal
    @journal ||= Journal.where(slug: params[:id]).first
    authorize! action_name.to_sym, @journal
  end

  def journal_params
    params.require(:journal).permit(
                                    :name,
                                    :impact_factor,
                                    :url
                                    )
  end


end
