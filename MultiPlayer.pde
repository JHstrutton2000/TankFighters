//import hypermedia.net.*;
//import java.net.InetAddress;
//import java.net.UnknownHostException;


//UDP udp;
//String ipAddress;
//boolean networked;
//boolean multiplayer = false;

//ArrayList<String> servers;


//void receive( byte[] data, String ip, int port ) {  // <-- extended handler
//  println("test receive");
//  switch (data[0]){
//    case UDPRequestActive:
//      udp.send(""+UDPSendActive, ipAddress, UDPport);
//      break;
//    case UDPSendActive:
//      boolean pass = true;
//      for(int i=0; i<servers.size(); i++){
//        if(servers.get(i).equals(ip)){
//          pass = false;
//          break;
//        }
//      }
      
//      if(pass){
//        servers.add(ip);
//      }
//      break;
//  }
//}

//class mutltiplayerHandler {
//  mutltiplayerHandler() {
//    servers = new ArrayList<String>();
//    try {
//      InetAddress localhost = InetAddress.getLocalHost();
//      ipAddress = localhost.getHostAddress();
      
//      udp = new UDP( this, UDPport );
//      udp.listen( true );
//      networked = true;
//    }
//    catch (UnknownHostException e) {
//      e.printStackTrace();
//      networked = false;
//    }
//  }

//  void update(){
//    delay(100);
//    if(networked) {
//      udp.send(""+UDPRequestActive, ipAddress, UDPport);
//    }
//  }
//}
