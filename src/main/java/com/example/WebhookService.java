import java.util.Random;
import java.util.concurrent.TimeUnit;

public class WebhookService {
    private final Random random = new Random();
    private static final int MAX_BACKOFF = 30000; // 30 seconds
    private static final int BASE_BACKOFF = 1000; // 1 second

    public void sendWebhook() {
        int attempt = 0;
        while (true) {
            try {
                // Your webhook sending logic here
                break; // Exit loop on success
            } catch (Exception e) {
                attempt++;
                int backoff = calculateExponentialBackoff(attempt);
                try {
                    TimeUnit.MILLISECONDS.sleep(backoff);
                } catch (InterruptedException ie) {
                    Thread.currentThread().interrupt();
                }
            }
        }
    }

    private int calculateExponentialBackoff(int attempt) {
        int backoff = (int) (BASE_BACKOFF * Math.pow(2, attempt));
        backoff = Math.min(backoff, MAX_BACKOFF);
        // Add jitter
        return backoff + random.nextInt(1000); // Add up to 1 second of jitter
    }
}