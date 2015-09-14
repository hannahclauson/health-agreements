require 'access_levels'

class ProtectedController < ApplicationController

  before_action :editor_only, :except => AccessLevels::GLOBAL_ACTIONS
  before_action :admin_only, :except => [AccessLevels::GLOBAL_ACTIONS, AccessLevels::EDITOR_ACTIONS].flatten

  def editor_only
    if !self.view_context.editor_access_level?
      redirect_to :back, :alert => "Access Denied"
    end
  end

  def admin_only
    if !self.view_context.admin_access_level?
      redirect_to :back, :alert => "Access Denied"
    end
  end

end
