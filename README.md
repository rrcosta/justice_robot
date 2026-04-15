
<img width="1024" height="1024" alt="Logo" src="https://github.com/user-attachments/assets/cf5564c1-c544-4ae2-8d5c-b653029dee27" />


# Justice Robot

Pequena solução com foco em pequenos e médios advogados para obter detalhes de um e/ou vários processo(s)

Solução efetuada totalmente em Ruby e em progresso

### Exemplo do arquivo XLSX gerado para os advogados

<img width="1212" height="519" alt="Screenshot_2026-04-15_13-16-13" src="https://github.com/user-attachments/assets/2409d77d-6c39-40c4-bd54-225b73284f93" />


### Passos necessários necessários 

- Ruby na versão. 4.0 (ou superior)
- Instalação da gem Bundler
- Renomear o arquivo **.env.sample** para **.env**
- Abrir o arquivo **.env** e alterar a chave **TOKEN_API** com o valor do token fornecedido pela API **DataJud**


### Como rodar a solução?

Atualmente, basta rodar o comando abaixo:

``` 
ruby app.rb
```

Apos rodar o comando acima, a solução criará a pasta: *Entrada*, com sub pastas (Diretórios), conforme o exemplo abaixo:

<img width="307" height="316" alt="Screenshot_2026-04-15_13-54-12" src="https://github.com/user-attachments/assets/d3e0dc4e-8d44-46f7-81cc-a19b436c754c" />

<img width="145" height="685" alt="Screenshot_2026-04-15_13-55-12" src="https://github.com/user-attachments/assets/9fdd11a3-6d78-45b0-989c-1511246f9759" />

O Advogado poderá inserir o arquixo **.xlsx** (com qualquer nomeclatura) na sub-pasta, conforme a origem do processo que deseja obter os andamentos/movimentações do mesmo:

<img width="839" height="129" alt="Screenshot_2026-04-15_13-57-40" src="https://github.com/user-attachments/assets/8da9a2cc-2733-450b-bcbb-d9f2814483bc" />

Após inserir o arquivo suprcitado, basta rodarmos a solução:

``` 
ruby app.rb
```

Após o processo, será criado o diretório **Saida** com o arquivo **xlsx** gerado com os movimentos / Andamentos do processo:

<img width="923" height="140" alt="Screenshot_2026-04-15_14-05-24" src="https://github.com/user-attachments/assets/706b7ec6-189a-41b2-b3e5-5afd254b2f81" />
