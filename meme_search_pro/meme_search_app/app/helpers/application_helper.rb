module ApplicationHelper
  include Pagy::Frontend

  def tailwind_classes_for(flash_type)
    {
      notice: "bg-green-400 border-l-4 border-green-700 text-white",
      error:   "bg-red-400 border-l-4 border-red-700 text-black"
    }.stringify_keys[flash_type.to_s] || flash_type.to_s
  end

  def feature_unavailable_alert
      <<-HTML
      <strong>Feature Unavailable:</strong> This feature is not available in the demo version. 
      <br>
      Download the full version to try it out: 
      <br>
      <a href="https://github.com/neonwatty/meme_search" target="_blank">https://github.com/neonwatty/meme_search</a>
      HTML
  end
end
