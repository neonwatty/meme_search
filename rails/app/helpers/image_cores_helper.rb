module ImageCoresHelper
  def absolute_image_path(image_path)
    "#{request.protocol}#{request.host_with_port}/#{image_path}"
  end
end
