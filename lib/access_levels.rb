# Action lists are used:
# - in application_controller to control access via before filters
# - in application_helper in view helpers when presenting links to actions

module AccessLevels

  GLOBAL_ACTIONS = [
    :show,
    :index
  ]

  EDITOR_ACTIONS = [
    :edit,
    :update,
    :new,
    :create
  ]

  ADMIN_ACTIONS = [
    :delete
  ]

end
