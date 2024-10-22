# create image_path record for example_memes directory
base_dir = Dir.getwd
examples_path = ImagePath.new({path:base_dir + '/example_memes'})
examples_path.save!