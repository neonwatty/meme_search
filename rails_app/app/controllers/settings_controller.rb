class SettingsController < ApplicationController
  def index
    @tag_names = TagName.order(created_at: :desc)
    @tag_names
  end
end
