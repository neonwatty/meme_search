# create image_path record for example_memes_1 directory
base_dir = Dir.getwd
example_memes_subdir =  "example_memes_1"
example_dir = base_dir + "/public/memes/" +  example_memes_subdir
puts example_dir
if File.directory?(example_dir)
  examples_path = ImagePath.new({ name: example_memes_subdir })
  examples_path.save!
end

# create two tags
my_tag_name = "one"
tag_one = TagName.new({ name: my_tag_name, color: "black" })
tag_one.save!

my_tag_name = "two"
tag_two = TagName.new({ name: my_tag_name, color: "red" })
tag_two.save!

# tag a few images with these tags
first_example_meme = ImageCore.first
first_example_meme.update({ image_tags_attributes: [ { tag_name: tag_one } ] })

second_example_meme = ImageCore.last
second_example_meme.update({ image_tags_attributes: [ { tag_name: tag_one }, { tag_name: tag_two } ] })
