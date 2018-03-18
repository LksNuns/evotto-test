require_relative './output/user'
require_relative './cli'
require_relative './csv_importer/user'
require_relative './models/user'


require 'pry'

class Application
  include Output::User

  def start(args)
    cli = CLI.new(args)
    begin
      result = cli.parse!
      CsvImporter::User.to_database(result[:source])
    rescue Exception => err
      puts "Ops... Something went wrong"
      puts "ERROR => #{err}\n\n"

      puts cli.help
      exit
    end

    opt = result[:option]
    (opt.nil?) ? show(User.all) : filter_user_with_option(opt)
  end

  def filter_user_with_option(opt)
    result = User.send(opt[:method], *opt[:args])
    return show_empty_msg if result.class == NilClass

    if result.class == Integer
      show_total label: opt[:args], total: result
    else
      show result
    end
  end
end
