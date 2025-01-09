import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class GyroscopeWebSocketScreen extends StatefulWidget {
  @override
  _GyroscopeWebSocketScreenState createState() =>
      _GyroscopeWebSocketScreenState();
}

class _GyroscopeWebSocketScreenState extends State<GyroscopeWebSocketScreen> {
  double _x = 0, _y = 0, _z = 0;
  String _currentState = "Estable";
  String _lastState = "Estable";
  final double _threshold = 1.5; // Umbral para detectar cambios
  bool _canUpdate = true;

  late WebSocketChannel _channel;

  @override
  void initState() {
    super.initState();

    // Conectar al servidor WebSocket (usa la IP correcta del servidor)
    _channel = WebSocketChannel.connect(Uri.parse('ws://10.40.14.164:2025'));

    // Escuchar eventos del giroscopio
    gyroscopeEvents.listen((GyroscopeEvent event) {
      setState(() {
        _x = event.x;
        _y = event.y;
        _z = event.z;
        _detectOrientation(_x, _y);
      });
    });
  }

  void _detectOrientation(double x, double y) {
    if (!_canUpdate) return;

    String newState = "Estable";

    if (y > _threshold) {
      newState = "Izquierda";
    } else if (y < -_threshold) {
      newState = "Derecha";
    } else if (x > _threshold) {
      newState = "Arriba";
    } else if (x < -_threshold) {
      newState = "Abajo";
    }

    if (newState != _currentState) {
      _currentState = newState;
      _sendCommand(newState); // Enviar comando al servidor
      _startCooldown();
    }
  }

  void _sendCommand(String command) {
    print("Enviando comando: $command");
    _channel.sink.add(command);
  }

  void _startCooldown() {
    _canUpdate = false;
    Future.delayed(Duration(seconds: 2), () {
      _canUpdate = true;
    });
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Giroscopio con WebSockets'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Última Posición: $_lastState',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Posición Actual: $_currentState',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Eje X: ${_x.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Eje Y: ${_y.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Eje Z: ${_z.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
