module ApplicationHelper

  def root_path_tag
    current_user.present? ? home_index_path : root_path
  end
end
