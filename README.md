# Grocy Inventering – Docker

Smidigt inventeringsgränssnitt för [Grocy](https://grocy.info), serverat via nginx i en Docker-container.

## Snabbstart

```bash
# Bygg och starta
docker compose up -d

# Öppna i webbläsaren
open http://localhost:8090
```

Första gången visas ett inställningsfönster — ange din Grocy-URL och API-nyckel.
Uppgifterna sparas i webbläsarens localStorage och behöver bara anges en gång per enhet.

---

## Krav

- Docker >= 20.x
- Docker Compose >= 2.x

---

## Konfiguration

### Port
Standardporten är **8090**. Ändra i `docker-compose.yml`:

```yaml
ports:
  - "3000:80"   # Byt 8090 mot valfri port
```

### Om Grocy också körs som Docker-container

Om Grocy körs på samma host kan du undvika CORS-problem helt genom att köra båda på samma Docker-nätverk. Ta reda på nätverksnamnet:

```bash
docker inspect <ditt-grocy-container-namn> | grep NetworkMode
# eller
docker network ls
```

Avkommentera sedan `networks`-sektionen i `docker-compose.yml` och fyll i rätt nätverksnamn. Därefter kan du använda `http://grocy` (containernamnet) som URL i appen.

---

## Vanliga kommandon

```bash
# Starta
docker compose up -d

# Stoppa
docker compose down

# Bygg om efter ändringar i HTML-filen
docker compose up -d --build

# Se loggar
docker compose logs -f
```

---

## CORS

Appen anropar Grocy API direkt från webbläsaren. Om du får CORS-fel behöver du tillåta din apps origin i Grocy-serverns reverse proxy (nginx/Caddy/Traefik):

**nginx exempel:**
```nginx
add_header Access-Control-Allow-Origin "http://din-server:8090";
add_header Access-Control-Allow-Headers "GROCY-API-KEY, Content-Type";
add_header Access-Control-Allow-Methods "GET, POST";
```

Alternativt: kör appen och Grocy på samma domän/port bakom en gemensam reverse proxy.

---

## Filstruktur

```
.
├── Dockerfile              # nginx:alpine + kopierar appen
├── docker-compose.yml      # Enkel deploy med en port-mapping
├── nginx.conf              # Nginx-konfiguration
├── grocy-inventory.html    # Själva appen (single-page)
└── README.md
```
