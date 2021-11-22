import ch.unisg.ics.interactions.wot.td.ThingDescription;
import ch.unisg.ics.interactions.wot.td.io.TDGraphReader;
import ch.unisg.ics.interactions.wot.td.vocabularies.JSONSchema;
import ch.unisg.ics.interactions.wot.td.vocabularies.TD;
import org.eclipse.californium.core.coap.MessageObserverAdapter;
import org.eclipse.californium.core.coap.Request;
import vocabulary.MINES;
import vocabulary.MIRO;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;

public class App {

    public static final String MIROGATE_TD_URL = "https://raw.githubusercontent.com/Interactions-HSG/example-tds/main/tds/mirogate.ttl";
    public static final String LEUBOT_TD_URL = "https://raw.githubusercontent.com/Interactions-HSG/example-tds/main/tds/leubot1.ttl";

    public static void main(String[] args) throws IOException {

        // Get TD

        ThingDescription mirogate_td = TDGraphReader.readFromURL(ThingDescription.TDFormat.RDF_TURTLE,
                MIROGATE_TD_URL);
        ThingDescription leubot_td = TDGraphReader.readFromURL(ThingDescription.TDFormat.RDF_TURTLE, LEUBOT_TD_URL);

        // Instantiate consumed things
        MirogateThing mirogate = new MirogateThing(mirogate_td);
        LeubotThing leubot = new LeubotThing(leubot_td);

        // Set leubot API key
        if (args.length != 0) {
            leubot.setApiKey(args[0]);
        }

        // Subscribe for humidity notifications
        System.out.println("Invoking " + MIRO.readHumidity + "," + TD.observeProperty);
        mirogate.exploit(TD.observeProperty, MIRO.readHumidity, humValue -> {

            System.out.println("Read " + MIRO.humidityValue + ": " + humValue.get(MIRO.humidityValue));
            if ((Double) humValue.get(MIRO.humidityValue) >= 35) {

                // Unsubscribe from humidity notifications
                mirogate.removeObserveRelation(MIRO.readHumidity);

                // Set leubot gripper to 0
                Map<String, Integer> gripperValue = new HashMap<>();
                gripperValue.put(JSONSchema.IntegerSchema, 0);
                leubot.exploit(TD.invokeAction, MINES.setGripper, gripperValue);
            }
        });

    }

    public static Future<Integer> calculate(Request input, MessageObserverAdapter a) {
        return Executors.newSingleThreadExecutor().submit(() -> {
            Thread.sleep(100000);
            input.removeMessageObserver(a);
            return 4;
        });
    }

    public interface Observation {
        void observed(Map<String, Object> value);
    }


}
