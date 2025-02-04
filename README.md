Esto es un ejemplo para generar 1 imagen que exponse un servicio we y sera usado SOLO para pruebas.
Se ha colocado el "mismo" dockerfile en 2 rutas diferentes.

```bash
#Ir al directorio de contexto (o worker directory)
cd ~/code/lucianoepc_gmail/poc/net/webservice/testwsrv1

#Crear la imagen usando el docker file en "webservices/Dockerfile"

podman build -f webservices/Dockerfile -t lucianoepc/testwsrv:1.0-net8_t01 .

#Crear la imagen usando el docker file en la raiz de directorio de trabajo
podman build -t lucianoepc/testwsrv:1.0-net8_t01 .
podman build -f Dockerfile -t lucianoepc/testwsrv:1.0-net8_01 .

#Subir la imagen al DockerHub
podman login -u lucianoepc
podman push lucianoepc/testwsrv:1.0-net8_t01
```



Esta imagen expone los servicios

`GET http://localhost:5000/api/weather`
`GET http://localhost:8080/api/weather/id=1`
`GET http://localhost:5000/swagger/v1/swagger.json`
`GET http://localhost:5000/swagger/index.html`

Por ejemplo

```bash
curl -H 'ApiKey: 6bd4da79-7408-44e5-93fd-5da461a97873' -H 'Content-Type: application/json' -H 'my-header: my-value' \
http://localhost:8080/api/weather
```

Se ofrece 3 versiones
