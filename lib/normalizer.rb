class Normalizer
  def self.for_path(path)
    Dir.each_child(path) do |child|
      p "child: #{child}"
      next if child == ".DS_Store"

      Dir.children("#{path}/#{child}").each do |file|
        p "file: #{file}"
        next unless file.include?("index.md")

        filepath = "#{path}/#{child}/#{file}"
        p "Converting #{filepath}"
        self.new(path: filepath).call
      end
    end
  end

  def initialize(path:)
    @path = path
  end

  def call
    contents_array = file.readlines.clone
    closing_frontmatter_index = contents_array.rindex("---\n")
    contents_array.insert(closing_frontmatter_index, frontmatter_path)

    File.write(
      File.join(parent_dir_path, "#{dirname}.md"), contents_array.join
    )
  end

  def frontmatter_path
    "permalink: \"/#{dirname}\"\n"
  end


  private

  def file
    @file ||= File.open(@path, File::RDWR, chomp: true)
  end

  def dirname
    @dirname ||= File.basename(File.dirname(file))
  end

  def parent_dir_path
    parent_path = File.dirname(file).split("/")
    parent_path.pop
    parent_path
  end
end
