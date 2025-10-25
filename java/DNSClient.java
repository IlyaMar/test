import java.net.InetAddress;
import java.net.UnknownHostException;

public class DNSClient {
    public static void main(String[] args) {
        InetAddress address = null;
        try {
            address = InetAddress.getByName(args[0]);
            System.out.println("host address: "+address.getHostAddress());
        } catch (UnknownHostException e) {
            throw new RuntimeException(e);
        }

    }
}