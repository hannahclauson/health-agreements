class DocumentsController < ApplicationController
  def terms_of_service
  end
  def glossary
  end
  def contribute
  end
  def icv
    render 'inform-comprehend-volunteer.html.haml'
  end
  def about_us
    render 'about_us.html.haml'
  end
end
