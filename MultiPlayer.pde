import hypermedia.net.*;
import java.net.InetAddress;
import java.net.UnknownHostException;

UDP udp;  // define the UDP object
String ipAddress;
boolean networked;
ArrayList<String> servers;

void receive( byte[] data, String ip, int port ) {  // <-- extended handler
  println("test");
  switch (data[0]) {
  case UDPActive:
    if (data[1] == UDPSend) {
      boolean pass = true;
      for (int i=0; i<servers.size(); i++) {
        if (servers.get(i).equals(ip)) {
          pass = false;
          break;
        }
      }

      if (pass) {
        servers.add(ip);
      }
    } else if (data[1] == UDPRequest) {
      udp.send(""+UDPActive+UDPSend, ipAddress, UDPport);
    }
    break;
  }
}

class mutltiplayerHandler {
  int requestCountdown;
  mutltiplayerHandler() {
    requestCountdown = UDPRequestDelay;
  }

  void update() {
    if(requestCountdown-- < 0){
      if (networked) {
        udp.send(""+UDPActive+UDPRequest, ipAddress, UDPport);
      }
      requestCountdown = UDPRequestDelay;
    }
  }
}
