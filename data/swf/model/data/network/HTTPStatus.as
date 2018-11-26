package model.data.network {
public class HTTPStatus {

    public static const OK:int = 200;

    public static const BAD_REQUEST:int = 400;

    public static const NOT_FOUND:int = 404;

    public static const REQUEST_TIMEOUT:int = 408;

    public static const INTERNAL_SERVER_ERROR:int = 500;

    public static const BAD_GATEWAY:int = 502;

    public static const SERVICE_UNAVAILABLE:int = 503;

    public static const NETWORK_CONNECT_TIMEOUT:int = 599;


    public function HTTPStatus() {
        super();
    }
}
}
