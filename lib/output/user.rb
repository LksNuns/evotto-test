module Output
  module User
    def show_total(label:, total:)
      puts "#{label}: #{total}"
    end

    def show(users)
      return show_empty_msg if users.empty?
      puts "NAME | Age | ProjectCount | TotalValue"
      users.each do |user|
        puts "#{user[:name]} | #{user[:age]} | #{user[:project_count]} | #{user[:total_value]}"
      end
    end

    def show_empty_msg
      puts "Nenhum usuário encontrado."
    end
  end
end
