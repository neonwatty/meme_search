# create image_path record for example_memes_1 directory
base_dir = Dir.getwd
example_memes_subdir =  "example_memes_1"
example_dir = base_dir + "/public/memes/" +  example_memes_subdir
puts example_dir
if File.directory?(example_dir)
  examples_path = ImagePath.new({ name: example_memes_subdir })
  examples_path.save!
end

# create image_path for memes in example_memes_2 directory
base_dir = Dir.getwd
example_memes_subdir =  "example_memes_2"
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
current_imgs = ImageCore.order(created_at: :desc)
first_meme = current_imgs[0]
second_meme = current_imgs[1]
third_meme = current_imgs[2]
fourth_meme = current_imgs[3]

first_meme.update({ image_tags_attributes: [ { tag_name: tag_one } ] })
second_meme.update({ image_tags_attributes: [ { tag_name: tag_one }, { tag_name: tag_two } ] })
third_meme.update({ image_tags_attributes: [ { tag_name: tag_two } ] })


