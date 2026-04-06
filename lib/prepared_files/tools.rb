
module PreparedFiles
  module Tools
    extend self

    VALID_EXTENSIONS_FILE = %w[.xls .xlsx .ods .csv].freeze

    def extension_file_valid?(extension_file)
      VALID_EXTENSIONS_FILE.include?(extension_file)
    end

    def msg_date_now
      Time.now.strftime('%F_%H%m%S_')
    end

    def exists_files_or_directory?(origin)
      File&.directory?(origin)
    end

    def creates_directory(directory)
      FileUtils&.mkdir(directory)
    end

    def check_files(directory_files)
      Dir&.glob(directory_files)
    end

    def basename_of_file(file)
      File&.basename(file)
    end

    def extension_of_file(file)
      File&.extname(file)
    end

    def creates_folders_at_array(origin_array, parent_folder = nil)
      return [] if origin_array.nil?

      origin_array.each do |name_directory|
        check_directory = "#{parent_folder}/#{name_directory}"
        creates_directory(check_directory) unless exists_files_or_directory?(check_directory)
      end
    end

    def court_name_by_directory(file_name, removes_chars)
      fl = file_name&.gsub(removes_chars, '')&.gsub(basename_of_file(file_name), '')
      # Remove o ultimo '/'
      fl&.rstrip!('/')
    end

    def get_court_and_sub_court_by_origin_name(origin_name)
      return ['', ''] if origin_name.nil?

      tmp_court = origin_name&.lstrip('/')&.rpartition('/')

      court     = tmp_court[0].nil? ? origin_name : tmp_court[0]
      sub_court = tmp_court[2].nil? ? '' : tmp_court[2]

      [court, sub_court]
    end

    def removes_invalid_chars(str)
      str&.gsub('-','')&.gsub('.','')&.gsub('/','')&.gsub('?','')&.gsub('!','')
    rescue
      str
    end

    # Retona o numero do processo com zeros a esquerda ate completar 20 digitos
    def adds_left_zero_chars_at_process_number(num_proces, limit_chars_number)
      size_complement_size = num_proces&.size || 0

      return num_proces if size_complement_size >= limit_chars_number

      complement_char = (limit_chars_number - size_complement_size)
      complement_char = complement_char.negative? ? complement_char&.abs : complement_char

      new_num_proces = "0" * complement_char + num_proces

      new_num_proces
    rescue
      num_proces
    end
  end
end