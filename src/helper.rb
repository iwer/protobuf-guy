require File.dirname(__FILE__) + '/Exceptions/file_not_found_exception'
require 'find'

class Helper
  # Checks the current running os
  # 
  # Returns the current host os as a label
  def self.os
    os ||= (
      host_os = RbConfig::CONFIG['host_os']
      case host_os
      when /mswin|msys|mingw|cygwin|bccwin|wince|emc/
        :windows
      when /darwin|mac os/
        :macosx
      when /linux/
        :linux
      else
        raise Error::WebDriverError, "unknown os: #{host_os.inspect}"
      end
    )
    os
  end

  def self.convertFilePathToWindows(path)
    converted = path.gsub!("/", "\\")
    return converted.nil? ? path : converted
  end

  def self.convertFilePathToUnix(path)
    converted = path.gsub!("\\", "/")
    return converted.nil? ? path : converted
  end

  # Find all proto files in a given folder recursively
  #
  # Returns list of file paths
  def self.recursive_proto_search(folder)
    filePath = File.join(folder, "**", "*.proto")

    Dir.glob(filePath)
  end

  # Cross-platform way of finding a file in a recursive search in the current working directory.
  def  self.getPathForExecutableFileInWorkingDirectory(cmd)
    regex = /.*\/#{cmd}\.exe.*/
    Find.find(Dir.getwd) do |path|
      if path =~ regex
        # We are only interested in executable files...
        if (File.executable?(path))
          return path
        end
      end
    end

    raise FileNotFoundException.new('Failed to find file: A file named ' + cmd + ' could not be found in a recursive search starting in this folder: ' + Dir.getwd)
  end

  # Cross-platform way of finding an executable in the $PATH.
  #
  #   which('ruby') #=> /usr/bin/ruby
  def self.which(cmd)
    exts = ENV['PATHEXT'] ? ENV['PATHEXT'].split(';') : ['']
    ENV['PATH'].split(File::PATH_SEPARATOR).each do |path|
      exts.each { |ext|
        exe = File.join(path, "#{cmd}#{ext}")
        return exe if File.executable? exe
      }
    end
    return nil
  end
end