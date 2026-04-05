require './services/apis/urls'

module CheckDirectories
  module_function

  extend self

  ROOT_DIRECTORY       = "#{Dir.pwd}/entrada".freeze
  CHILDREN_DIRECTORIES = Apis::Urls::ALL.freeze

  def execute(log)
    creates_directory(ROOT_DIRECTORY) unless exists_directory?(ROOT_DIRECTORY)

    check_children_directories

    check_grandchildren_directories

    [true, {}]
  rescue Errno::EACCES
    msg = 'Permissão negada'
    log.error(msg)

    [false, { error: msg }]
  rescue StandardError => e
    log.error(e.message)

    [false, { error: e.message }]
  end

  def creates_folders_at_array(origin_array, parent_folder = nil)
    return [] if origin_array.nil?

    origin_array.each do |name_directory|
      check_directory = "#{parent_folder}/#{name_directory}"
      creates_directory(check_directory) unless exists_directory?(check_directory)
    end
  end

  def check_children_directories
    creates_folders_at_array(
      CHILDREN_DIRECTORIES,
      ROOT_DIRECTORY
    )
  end

  def check_grandchildren_directories
    CHILDREN_DIRECTORIES.each do |name_directory|
      grandchildren = "::Apis::Urls::#{name_directory}"
      verify = eval(grandchildren)&.keys

      creates_folders_at_array(
        verify,
        "#{ROOT_DIRECTORY}/#{name_directory}"
      )
    end
  end

  def exists_directory?(directory)
    File.directory?(directory)
  end

  def creates_directory(directory)
    FileUtils.mkdir(directory)
  end
end
