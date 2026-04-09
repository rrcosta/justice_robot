require './lib/prepared_files/tools'
require './service/apis/datajud/urls'

module PreparedFiles
  module CheckDirectories
    module_function
    extend self

    include ::PreparedFiles::Tools

    ROOT_DIRECTORY       = "#{Dir.pwd}/entrada".freeze
    CHILDREN_DIRECTORIES = ::Service::Apis::Datajud::Urls::ALL.freeze

    # lambda
    CREATES = -> (directory) do
      return if directory.nil?
      creates_directory(directory) unless exists_files_or_directory?(directory)
    end

    def execute(log)
      CREATES.call(ROOT_DIRECTORY)

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
        grandchildren = "::Service::Apis::Datajud::Urls::#{name_directory}"
        verify = eval(grandchildren)&.keys

        creates_folders_at_array(verify, "#{ROOT_DIRECTORY}/#{name_directory}")
      end
    end
  end
end
