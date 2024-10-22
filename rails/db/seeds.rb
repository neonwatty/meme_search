# create image_path record for example_memes directory
base_dir = Dir.getwd
example_dir = base_dir + '/example_memes'

if File.directory?(example_dir)
  examples_path = ImagePath.new({name: example_dir})
  examples_path.save!
end