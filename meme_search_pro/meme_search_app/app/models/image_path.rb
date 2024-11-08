class ImagePath < ApplicationRecord
  validates :name, presence: true, uniqueness: { message: "path already used" }
  validates :name, length: {
    minimum: 1,
    maximum: 300,
    too_short: "Path name must have at least %{count} characters.",
    too_long: "Path name must have no more than %{count} characters."
  }
  has_many :image_cores, dependent: :destroy
  has_many :image_tags, through: :image_cores

  validate :valid_dir
  after_save :list_files_in_directory

  private

    def valid_dir
      base_dir = Dir.getwd
      full_path = base_dir + "/public/memes/" + self.name
      puts full_path
      unless self.name.length > 0 && File.directory?(full_path)
        self.errors.add :name, message: "The input path - #{self.name} - is not a valid subdirectory in /public/memes"
      end
    end

    def count_images
    end

  def list_files_in_directory
    base_dir = Dir.getwd
    full_path = base_dir + "/public/memes/" + self.name

    if File.directory?(full_path)
      # allowed extensions
      allowed_extensions = [ ".jpg", ".jpeg", ".png", ".webp" ]

      # get images
      image_names = Dir.entries(full_path).select do |f|
        file_path = File.join(full_path, f)
        File.file?(file_path) && allowed_extensions.include?(File.extname(f).downcase)
      end

      # save each image
      image_names.each do |f|
        image_core = ImageCore.new({ image_path: self, name: f })
        image_core.save!
      end

      # map result to complete path
      image_paths = image_names.map do |f|
        File.join(full_path, f)
      end

      # Print the filtered files
      if image_names.empty?
        puts "No image files found."
      else
        puts "Image files in directory:"
        image_names.each { |file| puts file }
        image_paths.each { |file| puts file }

      end
    else
      puts "Directory does not exist."
    end
  end
end
