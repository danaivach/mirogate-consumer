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
import java.util.logging.Logger;

public class App {

    public static final String MIROGATE_TD_URL = "https://raw.githubusercontent.com/Interactions-HSG/example-tds/main/tds/mirogate.ttl";
    public static final String LEUBOT_TD_URL = "https://raw.githubusercontent.com/Interactions-HSG/example-tds/main/tds/leubot1.ttl";

    static Logger LOG = Logger.getLogger(App.class.getName());

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
        LOG.info("Invoking " + MIRO.readHumidity);
        mirogate.exploit(TD.observeProperty, MIRO.readHumidity, humValue -> {

            LOG.info("Read " + MIRO.humidityValue + ": " + humValue.get(MIRO.humidityValue));
            if ((Double) humValue.get(MIRO.humidityValue) >= 35) {

                // Unsubscribe from humidity notifications
                mirogate.removeObserveRelation(MIRO.readHumidity);

                // Set leubot gripper to 0
                LOG.info("Invoking " + MINES.setGripper + " 0");
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
