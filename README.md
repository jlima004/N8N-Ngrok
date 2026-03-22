# N8N Selfhosted com Ngrok Tunnel

Automacao de workflows N8N com acesso externo via Ngrok e certificado SSL.

## Tecnologias

- **N8N**: Plataforma de automacao de workflows (nightly)
- **Ngrok**: Tunnel HTTP com SSL para acesso externo
- **Docker Compose**: Orquestracao dos containers
- **Task Runners**: Execucao de tarefas em containers separados

## Estrutura

```
.
├── .env                 # Variaveis de ambiente (nao commitar)
├── .env.example         # Template de variaveis
├── docker-compose.yaml  # Orquestracao dos containers
├── ngrok.yml            # Configuracao do tunnel Ngrok
├── Makefile             # Comandos uteis para gerenciamento
└── n8n_data/            # Persistencia de dados N8N
```

## Variaveis de Ambiente

| Variavel             | Descricao                                   |
| -------------------- | ------------------------------------------- |
| `TIMEZONE`           | Timezone do sistema (ex: America/Sao_Paulo) |
| `NGROK_TOKEN`        | Token de autenticacao do Ngrok              |
| `RUNNERS_AUTH_TOKEN` | Token de autenticacao dos runners           |
| `URL`                | URL publica do Ngrok                        |

## Instalacao

### 1. Clone o repositorio

```bash
git clone <repo-url>
cd ngrok-n8n
```

### 2. Configure as variaveis de ambiente

```bash
cp .env.example .env
```

Edite o `.env` com seus valores:

```env
TIMEZONE=America/Sao_Paulo
NGROK_TOKEN=seu_token_ngrok
RUNNERS_AUTH_TOKEN=seu_token_runners
URL=https://seu-subdomain.ngrok-free.app
```

### 3. Obtenha o token Ngrok

1. Crie uma conta em [ngrok.com](https://ngrok.com)
2. Copie seu authtoken do dashboard
3. Adicione no `NGROK_TOKEN` do `.env`

### 4. Configure o dominio Ngrok (opcional)

Edite `ngrok.yml` para usar seu dominio personalizado:

```yaml
tunnels:
  n8n-ngrok:
    proto: http
    addr: n8n-ngrok:5678
    domain: seu-dominio.ngrok-free.dev
```

## Como Rodar

### Usando Docker Compose

```bash
docker-compose up -d
```

### Usando Makefile

```bash
make up        # Iniciar containers
make down      # Parar containers
make logs      # Ver logs
make restart   # Reiniciar
```

## Acessos

| Servico         | URL                                    |
| --------------- | -------------------------------------- |
| N8N             | http://localhost:5678                  |
| Ngrok Dashboard | http://localhost:4040                  |
| URL Externa     | `https://seu-subdomain.ngrok-free.app` |

## Comandos Uteis

```bash
# Ver status dos containers
docker-compose ps

# Ver logs
docker-compose logs -f

# Reiniciar servicos
docker-compose restart

# Parar e remover containers
docker-compose down
```

## Solucao de Problemas

### Ngrok nao conecta

- Verifique se o `NGROK_TOKEN` esta correto
- Confirme que o dominio esta disponivel na sua conta Ngrok

### N8N nao carrega

- Verifique se a porta 5678 esta livre
- Cheque os logs: `docker-compose logs n8n-ngrok`

### Task runners nao funcionam

- Confirme que o `RUNNERS_AUTH_TOKEN` e igual em todos os containers
- Verifique logs: `docker-compose logs task-runners`
