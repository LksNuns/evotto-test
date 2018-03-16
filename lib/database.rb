require 'singleton'
require 'sequel'

#
# Classe Singleton para acesso aos dados.
# Dados armazenados na memória através do sqlite3
#
class Database
  include Singleton

  def initialize
    # Inicializando banco de dados na memória
    @db = Sequel.sqlite
    create_table_user
  end

  #
  # Alias para acessar tabela de usuários
  #
  def users
    @db[:users]
  end

  private

  #
  # Método auxiliar para a criação da tabela de users
  #
  def create_table_user
    @db.create_table :users do
      primary_key :id
      String  :name
      Integer :age
      Integer :project_count
      Integer :total_value
    end
  end
end
