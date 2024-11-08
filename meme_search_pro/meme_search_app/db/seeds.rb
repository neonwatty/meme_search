# create image_path record for example_memes_1 directory
base_dir = Dir.getwd
example_memes_subdir =  "example_memes_1"
example_dir = base_dir + "/public/memes/" +  example_memes_subdir
if File.directory?(example_dir)
  examples_path = ImagePath.new({ name: example_memes_subdir })
  examples_path.save!
end

# add description and embedding to both images in example_memes_1 directory
example_1 = ImageCore.find(1)
example_1.update({ description: "This image contains a bald man wearing sunglasses.  The text 'did you just take both pills?' is printed on the image." })
example_1.refresh_description_embeddings

example_2 = ImageCore.find(2)
example_2.update({ description: "In this image a woman dances in a field of flowers.  The text 'look at all the fucks I do not give' is printed on the image." })
example_2.refresh_description_embeddings

# create image_path for memes in example_memes_2 directory
base_dir = Dir.getwd
example_memes_subdir =  "example_memes_2"
example_dir = base_dir + "/public/memes/" +  example_memes_subdir
if File.directory?(example_dir)
  examples_path = ImagePath.new({ name: example_memes_subdir })
  examples_path.save!
end

# add description and embedding to both images in example_memes_2 directory
example_3 = ImageCore.find(3)
example_3.update({ description: "This image contains a bunny rabbit saying the word 'no'." })
example_3.refresh_description_embeddings

example_4 = ImageCore.find(4)
example_4.update({ description: "This image contains a strange looking cat.  The text 'weird knowledge increased' is printed on the image." })
example_4.refresh_description_embeddings

# create two tags
my_tag_name = "tag_one"
tag_one = TagName.new({ name: my_tag_name, color: "#ef4444" })
tag_one.save!

my_tag_name = "tag_two"
tag_two = TagName.new({ name: my_tag_name, color: "#d946ef" })
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
