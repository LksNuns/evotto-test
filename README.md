# Evotto - Ruby Test

### Como Usar
_Help_ da aplicação:
```
Usage: app.rb --source CSV_FILE [options]

Specific options:
    --source    CSV_FILE to be imported
    --order_by  Order by COLUMN and DIRECTION (asc|desc)
    --find      Search user by NAME
    --total     Returns total sum of COLUMN

Common options:
    -h, --help  Show this message
```

## Acessando fora do CLI
É possível acessar a aplicação (para testes) através do comando:

```
irb -r ./console.rb
```

### Objetivo
- [x] Listar os usuários
- [x] Classificar os usuários pelos parâmetros
- [x] Mostrar o total de um parâmetro por comando
- [x] Exibir dados de um usuário especifico

## Ordenação (order_by)
É possível ordernar por qualquer coluna disponível na tabela de `users`.

## Total (total)
É possível encontrar o `total` de todas as colunas de tipo Inteiro.


## Buscar (find)
É possível realizar buscas pelo nome de usuário, sendo indiferente maiusculas e minusculas (_case insensitive_).

Para o _edge case_ citado, ao buscar por um determinado nome é exibido todos os usuários que derem _match_.

### TODO
Tarefas para melhoramento do código.

- [ ] Validar arquivo .csv passado por parametro
- [ ] Tratar erros de forma mais precisa (analisando cada tipo de erro)
- [ ] Refatorar `CLI#ensure_one_option`
- [ ] Tratar destruição do banco de dados a cada interação do Rspec
- [ ] Adicionar _factories_ para melhorar qualidade dos testes
- [ ] Analisar motivo de erro no uso da flag `-h` ou `--help` (Deveria impedir de continuar a aplicação)
