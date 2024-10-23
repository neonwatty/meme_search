# create image_path record for example_memes directory
base_dir = Dir.getwd
example_memes_subdir =  "example_memes_1"
example_dir = base_dir + "/public/" +  example_memes_subdir
puts example_dir
if File.directory?(example_dir)
  examples_path = ImagePath.new({name: example_memes_subdir})
  examples_path.save!
end
