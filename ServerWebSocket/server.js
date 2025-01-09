const WebSocket = require('ws');
const { exec } = require('child_process');

// Diccionario de comandos
const COMMANDS = {
  "Arriba": "start winword",  // Abre Microsoft Word
  "Abajo": "start chrome",    // Abre el navegador Chrome
  "Derecha": "start spotify", // Abre Spotify
  "Izquierda": "start discord" // Abre Discord
};

// Crear servidor WebSocket
const wss = new WebSocket.Server({ port: 2025 });

wss.on('connection', (ws) => {
  console.log("Cliente conectado");

  // Log de las conexiones
  ws.on('open', () => {
    console.log("Conexión abierta con el cliente");
  });

  // Escuchar mensajes enviados por el cliente
  ws.on('message', (message) => {
    console.log(`Comando recibido: ${message}`);  // Ver el mensaje recibido
    if (COMMANDS[message]) {
      console.log(`Ejecutando: ${COMMANDS[message]}`);
      exec(COMMANDS[message], (error, stdout, stderr) => {
        if (error) {
          console.error(`Error ejecutando el comando: ${error.message}`);
          return;
        }
        if (stderr) {
          console.error(`stderr: ${stderr}`);
          return;
        }
        console.log(`stdout: ${stdout}`);
      });
    } else {
      console.log("Comando no reconocido");
    }
  });

  // Ver los cierres de las conexiones
  ws.on('close', () => {
    console.log("Cliente desconectado");
  });

  // Detectar cualquier error en la conexión WebSocket
  ws.on('error', (error) => {
    console.error(`Error de WebSocket: ${error.message}`);
  });
});

console.log('Servidor WebSocket iniciado en ws://localhost:2025');
