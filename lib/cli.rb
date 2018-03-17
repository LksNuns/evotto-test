require 'slop'

class CLI
  attr_reader :args

  def initialize(args)
    @args = standardize_order_by_args(args)
  end

  #
  # Realiza o `parse` dos argmentos passados
  # com o `opt_parser`
  #
  def parse!
    begin
      result = Slop::Parser.new(opt_parser).parse(@args)
      result.to_hash
    rescue Slop::UnknownOption => e
      raise
    end
  end

  private

  #
  # Opções de parametros para CLI
  #
  def opt_parser
    opts = Slop::Options.new
    opts.banner = "Usage: app.rb --source CSV_FILE [options]"
    opts.separator ""
    opts.separator "Specific options:"

    opts.string "--source",   "CSV_FILE to be imported", required: true
    opts.array  "--order_by", "Order by COLUMN and DIRECTION (asc|desc)"
    opts.string "--find",     "Search user by NAME"
    opts.string "--total",    "Returns total sum of COLUMN"

    opts.separator ""
    opts.separator "Common options:"

    opts.on("-h", "--help", "Show this message") do
      puts opts
      # exit
    end

    opts
  end

  #
  # Padroniza parametros de --order_by
  # transformando em um formato aceito pelo Slop
  #
  # standardize_order_by_args [--order_by age desc] => [--order_by age,desc]
  #
  # @param [Array] Lista de argumentos
  #
  def standardize_order_by_args(args)
    idx = args.index '--order_by'

    return args if idx.nil?

    column_idx = idx + 1
    direction_idx = idx + 2

    new_args = args.dup
    data = "#{args[column_idx]},#{args[direction_idx]}"
    new_args[column_idx] = data

    new_args
  end
end
