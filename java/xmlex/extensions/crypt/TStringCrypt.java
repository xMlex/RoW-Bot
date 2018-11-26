package xmlex.extensions.crypt;

public interface TStringCrypt {
    boolean isDecryptable = false;

    /**
     * Сравнивает строку и ожидаемый хеш
     *
     * @param str
     * @param hash
     * @return совпадает или нет
     */
    public boolean compare(String str, String hash);

    /**
     * Получает строку и возвращает хеш
     *
     * @param str
     * @return hash
     */
    public String encrypt(String str) throws Exception;
}