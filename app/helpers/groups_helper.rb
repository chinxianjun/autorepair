#coding: utf-8
module GroupsHelper
  def group_settings_tabs
    tabs = [{name:  'general', partial:  'groups/general', label:  I18n.t("views.groups.edit")},
            {name:  'users', partial:  'groups/users', label:  I18n.t("views.groups.users")},
            {name:  'memberships', partial:  'groups/memberships', label:  I18n.t("views.groups.roles")}
    ]
  end
end
