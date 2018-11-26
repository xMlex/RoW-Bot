package ru.xmlex.common;

import com.pengrad.telegrambot.Callback;
import com.pengrad.telegrambot.TelegramBot;
import com.pengrad.telegrambot.model.request.ForceReply;
import com.pengrad.telegrambot.model.request.ParseMode;
import com.pengrad.telegrambot.request.SendMessage;
import com.pengrad.telegrambot.response.SendResponse;
import okhttp3.OkHttpClient;

import java.io.IOException;

/**
 * Created by mlex on 26.12.16.
 */
public class MessageNotifier {
    private static MessageNotifier instance;

    private TelegramBot bot;
    private OkHttpClient client;
    private String chatId;

    public MessageNotifier() {
        chatId = ConfigSystem.get("telegram_chat_id");
        client = new OkHttpClient();
        bot = new TelegramBot.Builder(ConfigSystem.get("telegram_token")).okHttpClient(client).build();
    }

    public static MessageNotifier getInstance() {
        if (instance == null) {
            instance = new MessageNotifier();
            instance.log("Ok, startup");
        }
        return instance;
    }

    public void log(String message) {
        SendMessage request = new SendMessage(chatId, message)
                .parseMode(ParseMode.Markdown)
                .disableWebPagePreview(true)
                .disableNotification(true)
                .replyToMessageId(1)
                .replyMarkup(new ForceReply());

        bot.execute(request, new Callback<SendMessage, SendResponse>() {
            @Override
            public void onResponse(SendMessage request, SendResponse response) {

            }

            @Override
            public void onFailure(SendMessage request, IOException e) {

            }
        });
    }
}
