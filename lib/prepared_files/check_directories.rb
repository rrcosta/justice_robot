require './lib/prepared_files/tools'
require './services/apis/urls'

module PreparedFiles
  module CheckDirectories
    module_function
    extend self

    include ::PreparedFiles::Tools

    ROOT_DIRECTORY       = "#{Dir.pwd}/entrada".freeze
    CHILDREN_DIRECTORIES = ::Apis::Urls::ALL.freeze

    def execute(log)
      creates_directory(
        ROOT_DIRECTORY
      ) unless exists_files_or_directory?(ROOT_DIRECTORY)

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

    def check_children_directories
      creates_folders_at_array(CHILDREN_DIRECTORIES, ROOT_DIRECTORY)
    end

    def check_grandchildren_directories
      CHILDREN_DIRECTORIES.each do |name_directory|
        grandchildren = "::Apis::Urls::#{name_directory}"
        verify = eval(grandchildren)&.keys

        creates_folders_at_array(verify, "#{ROOT_DIRECTORY}/#{name_directory}")
      end
    end
  end
end
