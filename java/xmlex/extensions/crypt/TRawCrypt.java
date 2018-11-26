package xmlex.extensions.crypt;

import java.io.IOException;

public interface TRawCrypt {

    /**
     * делает копию данных, расшифрует и отдает
     */
    public byte[] decrypt(byte[] raw) throws IOException;

    /**
     * @param raw    указатель на данные
     * @param offset начало откуда шифровать
     * @param size   размер
     * @throws IOException ошибка в работе
     */
    public void decrypt(byte[] raw, final int offset, final int size) throws IOException;

    /**
     * делает копию данных, шифрует и отдает
     */
    public byte[] encrypt(byte[] raw) throws IOException;

    /**
     * @param raw    указатель на данные
     * @param offset начало откуда шифровать
     * @param size   размер
     * @throws IOException ошибка в работе
     */
    public void encrypt(byte[] raw, final int offset, final int size) throws IOException;
}