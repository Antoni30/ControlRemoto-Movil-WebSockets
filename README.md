# **Sistema de Control con Giroscopio y WebSockets**

Este proyecto permite controlar aplicaciones de escritorio desde un dispositivo móvil mediante movimientos detectados por el giroscopio y comandos enviados a través de WebSockets.

## **Descripción General**
- La aplicación móvil detecta movimientos en las direcciones: arriba, abajo, izquierda y derecha.
- Los movimientos generan comandos que se envían a un servidor WebSocket.
- El servidor interpreta los comandos y ejecuta aplicaciones en el equipo anfitrión.

## **Tecnologías Utilizadas**
- **Flutter**: Para la aplicación móvil.
- **Node.js**: Para el servidor WebSocket.
- **WebSocket**: Comunicación en tiempo real entre el dispositivo móvil y el servidor.
- **Sensors Plus**: Librería Flutter para acceder al giroscopio.

## **Requisitos**
### **Servidor**
- Node.js (v14 o superior).
- Dependencias de Node.js:
  - `ws`: Para manejar WebSockets.
  - `cors`: Para habilitar conexiones desde cualquier origen.

### **Cliente (Aplicación Flutter)**
- Flutter SDK.
- Dependencias:
  - `sensors_plus`: Para acceder al giroscopio.
  - `web_socket_channel`: Para establecer conexión con el servidor WebSocket.

## **Funciones del Sistema**
1. **Movimientos Detectados**:
   - **Arriba**: Abre Microsoft Word.
   - **Abajo**: Abre el navegador web (Google Chrome).
   - **Derecha**: Abre Spotify.
   - **Izquierda**: Abre Discord.

2. **Conexión en Tiempo Real**:
   - Los comandos se envían a través de WebSockets en tiempo real.
   - Se confirma la conexión y se manejan posibles errores.

3. **Cooldown**:
   - Implementación de un tiempo de espera entre comandos para evitar saturar el servidor.

## **Instrucciones de Uso**
1. **Configurar el Servidor**:
   - Clona este repositorio.
   - Instala las dependencias con `npm install`.
   - Inicia el servidor con `node server.js`.

2. **Configurar la Aplicación Flutter**:
   - Clona el proyecto de Flutter.
   - Instala las dependencias con `flutter pub get`.
   - Modifica la URL del servidor WebSocket en el código de Flutter para apuntar a tu servidor (`ws://<IP_DEL_SERVIDOR>:2025`).
   - Ejecuta la aplicación en un dispositivo físico (el giroscopio no funciona en emuladores).

3. **Pruebas**:
   - Mueve el dispositivo en las direcciones especificadas.
   - Verifica que las aplicaciones configuradas se abran en el equipo anfitrión.

## **Notas**
- Asegúrate de que tanto el servidor como el dispositivo móvil estén en la misma red para que puedan comunicarse.
- Revisa las configuraciones de firewall o permisos en tu equipo anfitrión para permitir conexiones WebSocket.
- Los comandos configurados en el servidor pueden personalizarse en el archivo `server.js`.

## **Mejoras Futuras**
- Añadir autenticación para conexiones seguras.
- Implementar más comandos y personalizaciones.
- Crear una interfaz gráfica en el servidor para gestionar conexiones y acciones.

---

**Autor**: Proyecto desarrollado en colaboración.  
**Licencia**: Este proyecto está bajo la licencia MIT.
