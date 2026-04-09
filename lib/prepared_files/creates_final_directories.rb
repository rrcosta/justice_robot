require './lib/prepared_files/tools'

module PreparedFiles
  module CreatesFinalDirectories
    module_function
    extend self

    include ::PreparedFiles::Tools

    FINAL_DIRECTORY  = "#{Dir.pwd}/saida".freeze

    # lambda
    CREATES = -> (directory) do
      return if directory.nil?
      creates_directory(directory) unless exists_files_or_directory?(directory)
    end

    # Sample of Struct
    #{ court: "TRIBUNAL_JUSTICA_ESTADUAL", sub_court: "SP", number_process: "10128167420228260309" }
    def execute(log = nil, struct)
      CREATES.call(FINAL_DIRECTORY)

      CREATES.call(court_name(struct))

      if struct[:sub_court].nil?
        CREATES.call(number_process_without_sub_court(struct))
      else
        CREATES.call(sub_court_name(struct))
        CREATES.call(number_process_with_sub_court(struct))
      end

      [true, { }]
    rescue Errno::EACCES => e
      msg = "Permissão negada. Detalhes: #{e.message}"
      log.error(msg)

      [false, { error: msg }]
    rescue StandardError => e
      log.error(e.message)

      [false, { error: e.message }]
    end

    def court_name(struct)
      "#{FINAL_DIRECTORY}/#{struct[:court]}"
    end

    def sub_court_name(struct)
      "#{FINAL_DIRECTORY}/#{struct[:court]}/#{struct[:sub_court]}"
    end

    def number_process_without_sub_court(struct)
      "#{FINAL_DIRECTORY}/#{struct[:court]}/#{struct[:number_process]}"
    end

    def number_process_with_sub_court(struct)
      "#{FINAL_DIRECTORY}/#{struct[:court]}/#{struct[:sub_court]}/#{struct[:number_process]}"
    end
  end
end
