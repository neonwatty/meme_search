# create image_path record for example_memes directory
base_dir = Dir.getwd
example_dir = base_dir + '/example_memes'

if File.directory?(example_dir)
  examples_path = ImagePath.new({name: example_dir})
  examples_path.save!
end


# test = {"name": "/Users/jeremywatt/Desktop/memes"}
# puts test[:name]
# if File.directory?(test[:name])
#   puts "FUCK"
#   examples_path = ImagePath.new(test)
#   examples_path.save!
# end