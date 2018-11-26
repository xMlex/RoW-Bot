package xmlex.vk.row.model.commands;

import org.json.JSONObject;
import xmlex.vk.row.RowClient;

import java.util.logging.Logger;

public abstract class BaseCmd implements Runnable {
    protected static final Logger _log = Logger.getLogger(BaseCmd.class.getName());
    protected RowClient _client = null;
    protected JSONObject _request = null;
    protected String _method = null;

    public void setClient(RowClient client) {
        _client = client;
    }

    @Override
    public void run() {
        onCreate();
        if (_request == null) {
            _log.warning("_request == null");
            return;
        }
        if (_method == null) {
            _log.warning("_method == null");
            return;
        }
        if (_client == null) {
            _log.warning("_client == null");
            return;
        }
        try {
            onResponce(_client.connection.requestAction(_method, _request));
        } catch (Exception e) {
            _log.warning("Execute cmd " + this.getClass().getName() + " error: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public abstract void onResponce(String data);

    public abstract void onCreate();
}
