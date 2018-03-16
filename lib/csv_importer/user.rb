require 'csv'
require './lib/database'

#
# Classe para importação de dados de `users`
#
module CsvImporter
  class User
    def self.to_database(file, **opts)
      csv_opts = { headers: true }.merge(opts)

      users = Database.instance.users

      CSV.foreach(file, csv_opts) do |row|

        users.insert(
          name:          row[0],
          age:           row[1],
          project_count: row[2],
          total_value:   row[3]
        )
      end
    end
  end
end
