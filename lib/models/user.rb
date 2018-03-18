require_relative '../ext/string'
require_relative '../database'

class User < Sequel::Model(Database.instance.users)
  #
  # Ordena `users` de acordo com a direção e tabela,
  # e imprime na tela os dados retornados
  #
  # @param [Symbol, String] column Coluna que será ordenada
  # @param [Symbol, String] direction Tipo de ordenação (asc/desc)
  #
  def self.order_by(column, direction)
    col = sanakeize!(column)
    send(direction(direction), col)
  end

  #
  # Busca usuários que possuem parte do parametro no `name`,
  # e imprime na tela os dados retornados.
  #
  # @param [String] name Texto usado para realizar busca de usuários
  #
  def self.find(name)
    where(Sequel.like(:name, "%#{name}%", case_insensitive: true))
  end

  #
  # Soma o total de uma determinada coluna
  #
  # @param [Symbol, String] column Coluna que será somada
  #
  def self.total(column)
    col = sanakeize!(column)
    sum(col)
  end

  #
  # Transforma texto em snake_case
  #
  # @param [Symbol, String] val Valor a ser transformado
  #
  def self.sanakeize!(val)
    val.to_s.underscore.to_sym
  end

  #
  # Transforma asc -> :order e desc -> :reverse,
  # métodos de ordenação do Sequel
  # Caso um valor qualquer seja passado é definido :order
  # como _default_
  #
  # @param [Symbol, String] direction Valor a ser transformado
  #
  def self.direction(direction)
    direction.to_s.downcase == 'desc' ? :reverse : :order
  end
end
