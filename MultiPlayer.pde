boolean multiplayer = false;
import hypermedia.net.*;
import java.net.InetAddress;
import java.net.UnknownHostException;

class mutltiplayerHandler {
  UDP udp;  // define the UDP object
  String ipAddress;
  boolean networked;

  ArrayList<String> servers;

  mutltiplayerHandler() {

    size(800, 800);
    servers = new ArrayList<String>();

    try {
      InetAddress localhost = InetAddress.getLocalHost();
      ipAddress = localhost.getHostAddress();

      udp = new UDP( this, UDPport );
      udp.listen( true );
      networked = true;
    }
    catch (UnknownHostException e) {
      e.printStackTrace();
      networked = false;
    }
  }

  void requestActiveServers(){
    if (networked) {
      udp.send(""+UDPRequestActive, ipAddress, UDPport);
    }
  }

//  void update() {
//    delay(1000);
//    if (networked) {
//      udp.send(""+UDPRequestActive, ipAddress, UDPport);
//    }
//  }

  void receive( byte[] data, String ip, int port ) {  // <-- extended handler
    switch (data[0]) {
    case UDPRequestActive:
      udp.send(""+UDPSendActive, ipAddress, UDPport);
      break;
    case UDPSendActive:
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
      break;
    }
  }
}
