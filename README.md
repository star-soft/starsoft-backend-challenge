# Teste para Desenvolvedor(a) Back-End Node.js/Nest.js

## Introdução

Bem-vindo(a) ao processo seletivo para a posição de **Desenvolvedor(a) Back-End** em nossa equipe! Este teste tem como objetivo avaliar suas habilidades técnicas em Node.js, Nest.js e outras tecnologias mencionadas na descrição da vaga.

## Instruções

- Faça um **fork** deste repositório para o seu GitHub pessoal.
- Desenvolva as soluções solicitadas abaixo, seguindo as **melhores práticas de desenvolvimento**.
- Após a conclusão, envie o link do seu repositório para avaliação.
- Sinta-se à vontade para adicionar qualquer documentação ou comentários que julgar necessário.

## Desafio

### Contexto

Você foi designado para desenvolver um sistema de gerenciamento de pedidos para um e-commerce. O sistema deve permitir que os clientes:

- Criem, visualizem, atualizem e cancelem pedidos.
- Cada pedido deve conter: identificador do pedido, itens (com quantidade e preço), status do pedido (pendente, processando, enviado, entregue, cancelado), data de criação e atualização.
- O sistema deve comunicar eventos de criação e atualização de pedidos via **Kafka** para outros serviços (por exemplo, sistema de estoque, notificações).
- O sistema deve indexar e permitir a busca de pedidos utilizando **Elasticsearch**, proporcionando pesquisas avançadas.

### Requisitos

1. **Configuração do Ambiente**

   - Configure um ambiente de desenvolvimento utilizando **Docker** e **Docker-compose**, incluindo:
     - Aplicação Node.js com **Nest.js**.
     - Banco de dados **PostgreSQL**.
     - Servidor **Kafka** (pode utilizar imagens como `bitnami/kafka` ou similares).
     - **Elasticsearch** para indexação e busca .
   - A aplicação deve ser iniciada com um único comando (`docker-compose up`).

2. **API RESTful**

   - Implemente uma API RESTful para gerenciamento de pedidos.
   - Utilize **Nest.js** seguindo as melhores práticas para estruturação de módulos, controladores e serviços.
   - Utilize **TypeORM** para interação com o banco de dados **PostgreSQL**.
   - Assegure-se de que as operações de CRUD (Create, Read, Update, Delete) estão implementadas.

3. **Comunicação via Kafka**

   - Implemente a publicação de eventos em **Kafka**:
     - Ao criar um novo pedido, publique um evento `order_created`.
     - Ao atualizar o status de um pedido, publique um evento `order_status_updated`.
     - Os eventos devem conter informações relevantes em formato JSON.

4. **Integração com Elasticsearch**

   - Implemente a indexação dos pedidos no **Elasticsearch**:
     - Ao criar ou atualizar um pedido, sincronize os dados com o Elasticsearch.
   - Implemente endpoints na API que permitam a busca e filtragem de pedidos utilizando as capacidades de pesquisa do Elasticsearch.
   - Permita que os usuários realizem pesquisas por:
     - Identificador do pedido.
     - Status do pedido.
     - Intervalo de datas.
     - Itens contidos no pedido.

5. **Clean Code e Boas Práticas**

   - Aplique os princípios de **Clean Code** em toda a sua implementação.
   - Utilize um padrão de código consistente e configure **ESLint** e **Prettier** no projeto.
   - Documente o código quando necessário para melhorar a legibilidade.

6. **Dockerização**

   - Certifique-se de que a aplicação e todos os serviços necessários estejam corretamente containerizados.
   - Utilize **Docker-compose** para orquestrar os contêineres.

7. **Testes**

   - Escreva testes unitários e/ou de integração para as principais funcionalidades da aplicação utilizando **Jest** (test runner padrão do Nest.js).
   - Os testes devem cobrir, no mínimo, os serviços e controladores.

8. **Documentação da API**

   - Forneça documentação da API utilizando **Swagger** (integrado ao Nest.js).
   - A documentação deve estar acessível através de uma rota, por exemplo, `/api-docs`.

9. **Logs e Monitoramento**

   - Implemente logs estruturados utilizando um middleware ou interceptador do Nest.js.
   - Registre informações importantes como erros, acessos às rotas e eventos de negócio.

### Diferenciais (Desejável)

- **Monitoramento e Logging Avançado**

  - Implemente ferramentas de monitoramento como **Prometheus** e **Grafana**.
  - Configure logs centralizados utilizando **Elastic Stack** (ELK).

### Observações

- Caso não seja possível implementar todos os requisitos, explique as razões e descreva como você abordaria a solução.
- Sinta-se à vontade para adicionar funcionalidades extras que julgar relevantes.
- Demonstre criatividade e inovação em sua solução.

## Entrega

- O código deve estar disponível em um repositório Git (preferencialmente GitHub) público.
- Inclua um arquivo `README.md` com:
  - Instruções claras sobre como configurar e executar a aplicação.
  - Descrição das funcionalidades implementadas.
  - Possíveis limitações ou melhorias futuras.

## Avaliação

Os seguintes aspectos serão considerados na avaliação:

- **Funcionalidade**: se a aplicação atende aos requisitos propostos.
- **Qualidade do Código**: organização, legibilidade e aderência às boas práticas.
- **Uso das Tecnologias**: implementação correta e eficaz das ferramentas solicitadas.
- **Boas Práticas**: aplicação de princípios de Clean Code e padrões de projeto.
- **Documentação**: clareza das instruções e documentação fornecidas.
- **Testes**: qualidade e abrangência dos testes implementados.
- **Histórico de Commits**: uso adequado do Git com commits bem descritos.

---

Boa sorte! Estamos ansiosos para conhecer o seu trabalho e potencial.
