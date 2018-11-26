package xmlex.extensions.util;

public class HWID {

    private String HDDModel, HDDSerialNumber, CPUModel, CPUId, LANName, LANMac;


    public String getLANName() {
        return LANName;
    }

    public void setLANName(String lANName) {
        LANName = lANName;
    }

    public String getLANMac() {
        return LANMac;
    }

    public void setLANMac(String lANMac) {
        LANMac = lANMac;
    }

    public String getHDDSerialNumber() {
        return HDDSerialNumber;
    }

    public void setHDDSerialNumber(String hDDSerialNumber) {
        HDDSerialNumber = hDDSerialNumber;
    }


    public String getCPUId() {
        return CPUId;
    }

    public void setCPUId(String cPUId) {
        CPUId = cPUId;
    }


    public String getCPUModel() {
        return CPUModel;
    }

    public void setCPUModel(String cPUModel) {
        CPUModel = cPUModel;
    }


    public String getHDDModel() {
        return HDDModel;
    }

    public void setHDDModel(String hDDModel) {
        HDDModel = hDDModel;
    }


    @Override
    public String toString() {
        StringBuilder ret = new StringBuilder();
        ret.append("HDDModel: " + HDDModel);
        ret.append("\nHDDSerialNumber: " + HDDSerialNumber);


        ret.append("\n\nCPUModel: " + CPUModel);
        ret.append("\nCPUId: " + CPUId);
        ret.append("\n\nLAN Name: " + LANName);
        ret.append("\nMAC: " + LANMac);

        return ret.toString();
    }
}
