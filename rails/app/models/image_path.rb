class ImagePath < ApplicationRecord
  validates_uniqueness_of :name
  validates_length_of :name, minimum: 1, maximum: 300
  has_many :image_cores, dependent: :destroy
  has_many :image_tags, through: :image_cores

  validate :valid_dir
  after_save :list_files_in_directory

  private

    def valid_dir
      unless File.directory?(self.name) && self.name > 0
        self.errors.add(:base, "The input path - #{self.name} - is not valid.")
      end
    end

    def count_images
      
    end

  def list_files_in_directory
    if File.directory?(self.name)
      # allowed extensions
      allowed_extensions = ['.jpg', '.jpeg', '.png', '.webp']

      # get images
      image_names = Dir.entries(self.name).select do |f|
        file_path = File.join(self.name, f)
        File.file?(file_path) && allowed_extensions.include?(File.extname(f).downcase)
      end

      # save each image
      image_names.each do |f|
        image_core = ImageCore.new({image_path: self, name: f})
        image_core.save!
      end

      # map result to complete path
      image_paths = image_names.map do |f|
        File.join(self.name, f)
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
