require_relative './output/user'
require_relative '../ext/string'
require_relative '../database'

class User < Sequel::Model(Database.instance.users)
  extend Output::User

  #
  # Ordena `users` de acordo com a direção e tabela,
  # e imprime na tela os dados retornados
  #
  # @param [Symbol, String] column Coluna que será ordenada
  # @param [Symbol, String] direction Tipo de ordenação (asc/desc)
  #
  def self.order_by(column, direction)
    col = sanakeize!(column)
    show send(direction(direction), col)
  end

  #
  # Busca usuários que possuem parte do parametro no `name`,
  # e imprime na tela os dados retornados.
  #
  # @param [String] name Texto usado para realizar busca de usuários
  #
  def self.find(name)
    show where(Sequel.like(:name, "%#{name}%", case_insensitive: true))
  end

  #
  # Soma o total de uma determinada coluna,
  # e imprime na tela os dados retornados.
  #
  # @param [Symbol, String] column Coluna que será somada
  #
  def self.total(column)
    col = sanakeize!(column)
    show_total(label: column, total: sum(col))
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
