package xmlex.extensions.crypt;

import java.io.IOException;

public class CryptL2Game implements TRawCrypt {
    private final byte[] _inKey = new byte[16];
    private final byte[] _outKey = new byte[16];
    boolean _isEnabled = false;

    /**
     * @param key - ключ размером 16 byte
     */
    public void setKey(byte[] key) {
        System.arraycopy(key, 0, _inKey, 0, 16);
        System.arraycopy(key, 0, _outKey, 0, 16);
    }

    public void decrypt(byte[] raw, final int offset, final int size) {
        if (!_isEnabled)
            return;

        int temp = 0;
        for (int i = 0; i < size; i++) {
            int temp2 = raw[offset + i] & 0xFF;
            raw[offset + i] = (byte) (temp2 ^ _inKey[i & 15] ^ temp);
            temp = temp2;
        }

        int old = _inKey[8] & 0xff;
        old |= _inKey[9] << 8 & 0xff00;
        old |= _inKey[10] << 0x10 & 0xff0000;
        old |= _inKey[11] << 0x18 & 0xff000000;

        old += size;

        _inKey[8] = (byte) (old & 0xff);
        _inKey[9] = (byte) (old >> 0x08 & 0xff);
        _inKey[10] = (byte) (old >> 0x10 & 0xff);
        _inKey[11] = (byte) (old >> 0x18 & 0xff);
    }

    public void encrypt(byte[] raw, final int offset, final int size) {
        if (!_isEnabled) {
            _isEnabled = true;
            return;
        }

        int temp = 0;
        for (int i = 0; i < size; i++) {
            int temp2 = raw[offset + i] & 0xFF;
            temp = temp2 ^ _outKey[i & 15] ^ temp;
            raw[offset + i] = (byte) temp;
        }

        int old = _outKey[8] & 0xff;
        old |= _outKey[9] << 8 & 0xff00;
        old |= _outKey[10] << 0x10 & 0xff0000;
        old |= _outKey[11] << 0x18 & 0xff000000;

        old += size;

        _outKey[8] = (byte) (old & 0xff);
        _outKey[9] = (byte) (old >> 0x08 & 0xff);
        _outKey[10] = (byte) (old >> 0x10 & 0xff);
        _outKey[11] = (byte) (old >> 0x18 & 0xff);
    }

    @Override
    public byte[] decrypt(byte[] raw) throws IOException {
        byte[] _res = new byte[raw.length];
        System.arraycopy(raw, 0, _res, 0, raw.length);
        decrypt(_res, 0, raw.length);
        return _res;
    }

    @Override
    public byte[] encrypt(byte[] raw) throws IOException {
        byte[] _res = new byte[raw.length];
        System.arraycopy(raw, 0, _res, 0, raw.length);
        encrypt(_res, 0, raw.length);
        return _res;
    }

    /**
     * Флаг активности шифрования
     */
    public void setStatus(boolean enabled) {
        _isEnabled = enabled;
    }
}