# Provides methods for processing text files
class FileHandler
  attr_reader :filename

  def filename=(filename)
    raise SystemCallError.new(filename, Errno::ENOENT::Errno) unless File.exist?(filename)

    @filename = filename
  end

  def initialize(filename)
    self.filename = filename
  end

  def index
    File.foreach(filename) { |item| puts item }
  end

  def find(id)
    File.foreach(filename).with_index do |line, index|
      return line.strip.chomp if index == id
    end
  end

  def where(pattern)
    lines = []
    File.foreach(filename) do |line|
      lines << line.strip.chomp if line.include?(pattern)
    end
    lines
  end

  def update(id, text)
    rewrite { |line, index| id == index ? text : line }
  end

  def delete
    rewrite { |line, index| id == index ? next : line }
  end

  private

  def rewrite(buffer_path = 'buffer.txt')
    File.open(buffer_path, 'w') do |review_file|
      File.foreach(filename).with_index do |line, index|
        review_file.puts(yield(line, index))
      end
    end
    File.write(filename, File.read(buffer_path))
    File.delete(buffer_path) if File.exist?(buffer_path)
  end
end
