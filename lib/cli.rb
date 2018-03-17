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
      result = Slop::Parser.new(opt_parser).parse(@args).to_hash
      ensure_one_option(result)
      result
    rescue Exception => e
      raise
    end
  end

  private
  #
  # Recebe resultado de `parse` e garante que existe
  # apenas uma _flag_ de `option`
  #
  # @param [Hash] Hash com resultados de parse
  #
  def ensure_one_option(result)
    options = %i[order_by total find]
    result.delete_if { |k, v| v.nil? || (v == []) }
    result[:option] = nil

    # Cria um array com todos os `options` que `result` tem
    options_keys = result.keys.reject { |k| !options.include? k }

    # Caso exista mais de uma opção setada
    raise ArgumentError, "More than one option" if options_keys.size > 1

    option = options_keys.first
    result[:option] = { method: option, args: result[option] } if options_keys.any?

    result
  end

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
