# Teste para Desenvolvedor(a) Back-End Node.js/NestJS - Sistemas Distribuídos

## Introdução

Bem-vindo(a) ao processo seletivo para a posição de **Desenvolvedor(a) Back-End** em nossa equipe! Este teste tem como objetivo avaliar suas habilidades técnicas em sistemas distribuídos, alta concorrência, e arquiteturas escaláveis utilizando Node.js e NestJS.

## Instruções

- Faça um **fork** deste repositório para o seu GitHub pessoal.
- Desenvolva as soluções solicitadas abaixo, seguindo as **melhores práticas de desenvolvimento**.
- Após a conclusão, envie o link do seu repositório para avaliação.
- Sinta-se à vontade para adicionar qualquer documentação ou comentários que julgar necessário.
- **IMPORTANTE**: Documente profundamente seu código usando JSDoc/TSDoc com explicações detalhadas de algoritmos críticos.

## Desafio

### Contexto

Você foi designado para desenvolver o sistema de venda de ingressos para o **Rock in Rio 2026**. O evento terá múltiplos shows e setores (Pista, Cadeira Superior, Cadeira Inferior, VIP). O sistema precisa lidar com **extrema concorrência**: dezenas de milhares de usuários tentando comprar ingressos simultaneamente no momento da abertura das vendas.

### O Problema Real

No momento da abertura das vendas às **10:00:00**, você terá:

- **100 ingressos VIP** disponíveis
- **50.000+ usuários** tentando comprar no exato mesmo segundo
- Múltiplas instâncias da aplicação rodando (5+ pods/containers)
- Necessidade de garantir que nenhum ingresso seja vendido duas vezes
- Reservas temporárias enquanto o pagamento é processado (30 segundos)
- Cancelamento automático se o pagamento não for confirmado
- Fila de espera para ingressos que voltam ao estoque

### Requisitos Obrigatórios

#### 1. **Configuração do Ambiente**

Configure um ambiente de desenvolvimento utilizando **Docker** e **Docker Compose**, incluindo:

- Aplicação Node.js com **NestJS**
- Banco de dados **PostgreSQL**
- **Redis**
- Servidor **Kafka**
- A aplicação deve ser iniciada com um único comando (`docker-compose up`)

#### 2. **API RESTful - Gestão de Ingressos**

Implemente uma API RESTful com as seguintes operações:

**2.1. Gestão de Eventos e Setores**

- Criar eventos (nome, data, local, capacidade total)
- Criar setores dentro de eventos (VIP, Pista, Cadeira, etc.)
- Definir quantidade de ingressos por setor
- Definir preço por setor

**2.2. Reserva de Ingressos (CRÍTICO - Alta Concorrência)**

- Endpoint para reservar ingresso(s)
- Deve prevenir que múltiplos usuários consigam reservar o mesmo ingresso
- Reserva tem validade de 30 segundos
- Retornar ID da reserva e timestamp de expiração
- Considere que teremos múltiplas instâncias da aplicação rodando simultaneamente

**2.3. Confirmação de Pagamento**

- Endpoint para confirmar pagamento de uma reserva
- Converter reserva em venda definitiva
- Publicar evento de venda confirmada

**2.4. Cancelamento e Liberação**

- Cancelar reserva manualmente
- Cancelamento automático após 30 segundos sem confirmação
- Liberar ingresso de volta ao pool disponível
- Implementar fila de espera (FIFO) para ingressos liberados

**2.5. Consultas e Métricas**

- Buscar disponibilidade de ingressos por evento/setor (tempo real)
- Histórico de compras por usuário
- **Endpoint de métricas diárias** por evento (vendas do dia, reservas do dia, etc.)
- **Endpoint de métricas lifetime** por evento (total de vendas, receita acumulada, etc.)
- **Endpoint de métricas globais** (todos os eventos agregados)

#### 3. **Controle de Concorrência com Redis** ⭐ **CRÍTICO**

- Usar **Redis** para coordenação entre múltiplas instâncias
- Garantir que apenas UMA instância/pod consiga processar uma reserva específica por vez
- Prevenir processamento duplicado da mesma requisição
- Tratar conflitos de atualização concorrente
- Sistema deve ser resiliente a falhas (processos que morrem, timeouts, etc.)
- **Desafio**: Como garantir atomicidade e coordenação em um ambiente distribuído?

#### 4. **Processamento Assíncrono com Kafka** ⭐ **CRÍTICO**

- Usar **Kafka** para comunicação assíncrona entre componentes do sistema
- Publicar eventos quando: reserva criada, pagamento confirmado, reserva expirada, ingresso liberado
- Consumir e processar esses eventos de forma confiável
- **Desafio**: Como garantir que cada evento seja processado exatamente uma vez, sem duplicações ou perda de mensagens?
- Considere ordem de processamento quando necessário

#### 5. **Workers e Consumers** ⭐ **CRÍTICO**

**5.1. Consumer de Métricas**

- Consumir eventos do **Kafka** para calcular e armazenar métricas
- **Métricas Diárias por Evento** (deve ser calculada nos consumers):
  - Total de ingressos vendidos no dia
  - Total de reservas criadas no dia
  - Taxa de conversão (reservas → vendas confirmadas)
  - Receita total do dia
- **Métricas Lifetime por Evento** (acumulado desde o início):
  - Total de ingressos vendidos (all time)
  - Total de reservas criadas (all time)
  - Receita total acumulada
- **Métricas Globais Lifetime** (todos os eventos):
  - Total geral de vendas
  - Receita total acumulada
  - Eventos mais populares
- As métricas devem ser atualizadas em tempo real conforme eventos são processados

#### 6. **Prevenção de Deadlocks** ⭐ **CRÍTICO**

- Como você vai prevenir que o sistema entre em deadlock?
- Como vai detectar e recuperar de situações de deadlock?
- Documentar claramente a estratégia utilizada

#### 7. **Observabilidade e Monitoramento**

- Implementar logging estruturado (níveis: DEBUG, INFO, WARN, ERROR)
- Endpoint de health check verificando estado dos serviços (PostgreSQL, Redis, Kafka)
- (Opcional) Métricas com Prometheus

#### 8. **Testes**

- **Testes de Unidade**: Cobertura mínima de 60-70%, testar serviços e casos de uso críticos
- Mockar dependências externas (banco de dados, Redis, Kafka)

#### 9. **Documentação da API**

- Implementar Swagger/OpenAPI acessível em `/api-docs`
- Documentar todos os endpoints com exemplos de request/response

#### 10. **Clean Code e Boas Práticas**

- Aplicar princípios SOLID
- Separação clara de responsabilidades (Controllers, Services, Repositories/Use Cases)
- Tratamento adequado de erros
- Configurar ESLint e Prettier
- Commits organizados e descritivos

### Requisitos Técnicos Específicos

#### Estrutura de Banco de Dados Sugerida

Você deve projetar um schema que suporte:

- **Eventos**: informações do show
- **Setores**: áreas dentro do evento (VIP, Pista, etc.)
- **Ingressos**: registros individuais de cada ingresso
- **Reservas**: reservas temporárias com expiração
- **Vendas**: vendas confirmadas
- **Fila de Espera** (opcional): usuários aguardando liberação de ingressos

#### Fluxo de Reserva Esperado

```
1. Cliente faz POST /tickets/reserve
2. Sistema verifica disponibilidade com proteção contra concorrência
3. Cria reserva temporária (válida por 30 segundos)
4. Publica evento no Kafka
5. Retorna ID da reserva

6. Cliente faz POST /tickets/confirm-payment
7. Sistema valida reserva (ainda não expirou?)
8. Converte reserva em venda definitiva
9. Publica evento de confirmação no Kafka
```

**Desafio**: Como garantir que 2 usuários não consigam reservar o mesmo ingresso ao mesmo tempo?

#### Edge Cases a Considerar

1. **Race Condition**: 2 usuários clicam no último ingresso VIP no mesmo milissegundo
2. **Deadlock**: Usuário A reserva ingresso 1, Usuário B reserva ingresso 2, ambos tentam reservar o outro
3. **Idempotência**: Cliente reenvia mesma requisição por timeout

### Diferenciais (Desejável - Pontos Extra)

#### Processamento e Resiliência

- **Dead Letter Queue (DLQ)**: Mensagens que falharam após N tentativas vão para fila separada
- **Retry Inteligente**: Sistema de retry com backoff exponencial para falhas transientes
- **Processamento em Batch**: Processar mensagens do Kafka em lotes para melhor performance
- **Testes de Integração/Concorrência**: Simular múltiplos usuários e validar que nenhum ingresso é vendido duas vezes

#### Busca e Analytics

- **Métricas Avançadas**: Dashboard com Grafana/Prometheus mostrando métricas em tempo real

#### Performance e Escalabilidade

- **Rate Limiting**: Limitar requisições por IP/usuário
- **Cache Warming**: Pre-aquecer cache antes da abertura de vendas
- **Distributed Tracing**: Implementar OpenTelemetry ou Jaeger para rastreamento

### Critérios de Avaliação

Os seguintes aspectos serão considerados (em ordem de importância):

1. **Funcionalidade Correta (30%)**: O sistema garante que nenhum ingresso é vendido duas vezes?
2. **Controle de Concorrência (25%)**: Locks distribuídos estão implementados corretamente?
3. **Qualidade de Código (15%)**: Clean code, SOLID, padrões de projeto?
4. **Documentação (10%)**: Código bem documentado e README completo?
5. **Testes (10%)**: Cobertura e qualidade dos testes?
6. **Observabilidade (5%)**: Logs, métricas e rastreabilidade?
7. **Performance (5%)**: Sistema suporta alta carga sem degradação?

### Entrega

#### Repositório Git

- Código disponível em repositório público (GitHub/GitLab)
- Histórico de commits bem organizado e descritivo
- Branch `main` deve ser a versão final

#### README.md Obrigatório

Deve conter:

1. **Visão Geral**: Breve descrição da solução
2. **Como Executar**:
   - Pré-requisitos
   - Comandos para subir o ambiente
   - Como popular dados iniciais
   - Como executar testes
3. **Estratégias Implementadas**:
   - Como você resolveu race conditions?
   - Como implementou locks distribuídos?
   - Como garantiu exactly-once no Kafka?
   - Como preveniu deadlocks?
4. **Endpoints da API**: Lista completa com exemplos de uso
5. **Decisões Técnicas**: Justifique escolhas importantes de design
6. **Limitações Conhecidas**: O que ficou faltando? Por quê?
7. **Melhorias Futuras**: O que você faria com mais tempo?

### Exemplo de Fluxo para Testar

Para facilitar a avaliação, crie um script ou documento mostrando:

```
1. Criar evento "Rock in Rio 2026"
2. Criar setor "VIP" com 100 ingressos a R$ 1.500,00
3. Simular 1000 usuários tentando reservar simultaneamente
4. Verificar que apenas 100 reservas foram criadas
5. Confirmar 50 pagamentos
6. Verificar métricas diárias do evento (50 vendas, 100 reservas, taxa de conversão 50%)
7. Verificar métricas lifetime do evento
8. Verificar métricas globais de todos os eventos
```

### Prazo

- **Prazo sugerido**: 7 dias corridos a partir do recebimento do desafio

### Dúvidas e Suporte

- Abra uma **Issue** neste repositório caso tenha dúvidas sobre requisitos
- Não fornecemos suporte para problemas de configuração de ambiente
- Assuma premissas razoáveis quando informações estiverem ambíguas e documente-as

---

## Observações Finais

Este é um desafio complexo que reflete problemas reais enfrentados em produção. **Não esperamos que você implemente 100% dos requisitos**, especialmente os diferenciais. Priorize:

1. ✅ Controle de concorrência correto
2. ✅ Locks distribuídos funcionando
3. ✅ Kafka com exactly-once
4. ✅ Testes demonstrando cenários de concorrência
5. ✅ Documentação clara

Se você tiver que escolher entre implementar muitas funcionalidades superficialmente ou poucas funcionalidades profundamente, **escolha a segunda opção**. Queremos ver qualidade, não quantidade.

**Boa sorte! Estamos ansiosos para conhecer sua solução e discutir suas decisões técnicas na entrevista técnica.**
