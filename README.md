# Teste para Desenvolvedor(a) Back-End Node.js/NestJS - Sistemas Distribuídos

## Introdução

Bem-vindo(a) ao processo seletivo para a posição de **Desenvolvedor(a) Back-End** em nossa equipe! Este teste tem como objetivo avaliar suas habilidades técnicas em sistemas distribuídos, alta concorrência, e arquiteturas escaláveis utilizando Node.js e NestJS.

## Instruções

- Faça um **fork** deste repositório para o seu GitHub pessoal.
- Desenvolva as soluções solicitadas abaixo, seguindo as **melhores práticas de desenvolvimento**.
- Após a conclusão, envie o link do seu repositório para avaliação.
- Sinta-se à vontade para adicionar qualquer documentação ou comentários que julgar necessário.

## Desafio

### Contexto

Você foi designado para desenvolver o sistema de venda de ingressos para uma **rede de cinemas**. O sistema precisa lidar com **concorrência**: múltiplos usuários tentando comprar os mesmos assentos simultaneamente.

### O Problema Real

Imagine a seguinte situação:

- Uma sala de cinema com **2 assentos disponíveis**
- **10 usuários** tentando comprar no mesmo momento
- **Múltiplas instâncias** da aplicação rodando simultaneamente
- Necessidade de garantir que **nenhum assento seja vendido duas vezes**
- **Reservas temporárias** enquanto o pagamento é processado (30 segundos)
- **Cancelamento automático** se o pagamento não for confirmado

### Requisitos Obrigatórios

#### 1. **Configuração do Ambiente**

Configure um ambiente de desenvolvimento utilizando **Docker** e **Docker Compose**, incluindo:

- Aplicação Node.js com **NestJS**
- **Banco de dados relacional** (PostgreSQL, MySQL, etc.)
- **Sistema de mensageria** (Kafka, RabbitMQ, etc.)
- **Banco de dados distribuído** para cache (Redis, Memcached, etc.)
- A aplicação deve ser iniciada com um único comando (`docker-compose up`)

#### 2. **API RESTful - Gestão de Ingressos**

Implemente uma API RESTful com as seguintes operações:

**2.1. Gestão de Sessões**

- Criar sessões de cinema (filme, horário, sala)
- Definir assentos disponíveis por sessão (Mínimo 16 assentos)
- Definir preço do ingresso

**2.2. Reserva de Assentos**

- Endpoint para reservar assento(s)
- Reserva tem validade de 30 segundos
- Retornar ID da reserva e timestamp de expiração

**2.3. Confirmação de Pagamento**

- Endpoint para confirmar pagamento de uma reserva, e assim converter reserva em venda definitiva
- Publicar evento de venda confirmada

**2.4. Consultas**

- Buscar disponibilidade de assentos por sessão (tempo real)
- Histórico de compras por usuário

#### 3. **Processamento Assíncrono com Mensageria**

- Usar **sistema de mensageria** para comunicação assíncrona entre componentes
- Publicar eventos quando: reserva criada, pagamento confirmado, reserva expirada, assento liberado
- Consumir e processar esses eventos de forma confiável

#### 4. **Logging**

- Implementar logging estruturado (níveis: DEBUG, INFO, WARN, ERROR)

#### 5. **Clean Code e Boas Práticas**

- Aplicar princípios SOLID
- Separação clara de responsabilidades (Controllers, Services, Repositories/Use Cases)
- Tratamento adequado de erros
- Configurar ESLint e Prettier
- Commits organizados e descritivos

### Requisitos Técnicos Específicos

#### Estrutura de Banco de Dados Sugerida

Você deve projetar um schema que suporte:

- **Sessões**: informações da sessão (filme, horário, sala)
- **Assentos**: assentos disponíveis por sessão
- **Reservas**: reservas temporárias com expiração
- **Vendas**: vendas confirmadas

#### Fluxo de Reserva Esperado

```
1. Cliente solicita uma reserva
2. Sistema verifica disponibilidade com proteção contra concorrência
3. Cria reserva temporária (válida por 30 segundos)
4. Publica evento no sistema de mensageria
5. Retorna ID da reserva

6. Cliente confirma o pagamento
7. Sistema valida reserva (ainda não expirou?)
8. Converte reserva em venda definitiva
9. Publica evento de confirmação no sistema de mensageria
```

#### Edge Cases a Considerar

1. **Race Condition**: 2 usuários clicam no último assento disponível no mesmo milissegundo
2. **Deadlock**: Usuário A reserva assentos 1 e 3, Usuário B reserva assentos 3 e 1, ambos tentam reservar o assento do outro
3. **Idempotência**: Cliente reenvia mesma requisição por timeout
4. **Expiração**: Reservas não confirmadas devem liberar o assento automaticamente após 30 segundos

### Diferenciais (Opcional - Pontos Extra)

Os itens abaixo são opcionais e darão pontos extras na avaliação:

- **Documentação da API**: Swagger/OpenAPI acessível em `/api-docs`
- **Testes de Unidade**: Cobertura de 60-70%, mockar dependências externas
- **Dead Letter Queue (DLQ)**: Mensagens que falharam vão para fila separada
- **Retry Inteligente**: Sistema de retry com backoff exponencial
- **Processamento em Batch**: Processar mensagens em lotes
- **Testes de Integração/Concorrência**: Simular múltiplos usuários simultaneamente
- **Rate Limiting**: Limitar requisições por IP/usuário

### Critérios de Avaliação

Os seguintes aspectos serão considerados (em ordem de importância):

1. **Funcionalidade Correta**: O sistema garante que nenhum assento é vendido duas vezes?
2. **Controle de Concorrência**: Coordenação distribuída implementada corretamente?
3. **Qualidade de Código**: Clean code, SOLID, padrões de projeto?
4. **Documentação**: README claro e código bem estruturado?

### Entrega

#### Repositório Git

- Código disponível em repositório público (GitHub/GitLab)
- Histórico de commits bem organizado e descritivo
- Branch `main` deve ser a versão final

#### README.md Obrigatório

Deve conter:

1. **Visão Geral**: Breve descrição da solução
2. **Tecnologias Escolhidas**: Qual banco de dados, sistema de mensageria e cache você escolheu e por quê?
3. **Como Executar**:
   - Pré-requisitos
   - Comandos para subir o ambiente
   - Como popular dados iniciais
   - Como executar testes (se houver)
4. **Estratégias Implementadas**:
   - Como você resolveu race conditions?
   - Como garantiu coordenação entre múltiplas instâncias?
   - Como preveniu deadlocks?
5. **Endpoints da API**: Lista com exemplos de uso
6. **Decisões Técnicas**: Justifique escolhas importantes de design
7. **Limitações Conhecidas**: O que ficou faltando? Por quê?
8. **Melhorias Futuras**: O que você faria com mais tempo?

### Exemplo de Fluxo para Testar

Para facilitar a avaliação, inclua instruções ou script mostrando:

```
1. Criar sessão "Filme X - 19:00"
2. Criar sala com no mínimo 16 assentos, a R$ 25,00 cada
3. Simular
 3.1. 2 usuários tentando reservar o mesmo assento simultaneamente
4. Verificar quantidade de reservas geradas
5. Comprovar o funcionamento do fluxo de pagamento do assento
```

### Prazo

- **Prazo sugerido**: 5 dias corridos a partir do recebimento do desafio

### Dúvidas e Suporte

- Abra uma **Issue** neste repositório caso tenha dúvidas sobre requisitos
- Não fornecemos suporte para problemas de configuração de ambiente
- Assuma premissas razoáveis quando informações estiverem ambíguas e documente-as

---

## Observações Finais

Este é um desafio que reflete problemas reais enfrentados em produção. **Não esperamos que você implemente 100% dos requisitos**, especialmente os diferenciais. Priorize:

1. ✅ Garantir que nenhum assento seja vendido duas vezes
2. ✅ Sistema de mensageria confiável
3. ✅ Código limpo e bem estruturado
4. ✅ Documentação clara

**Qualidade > Quantidade**. É melhor implementar poucas funcionalidades muito bem feitas do que muitas de forma superficial.

**Boa sorte! Estamos ansiosos para conhecer sua solução e discutir suas decisões técnicas na entrevista.**
