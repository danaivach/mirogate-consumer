import ch.unisg.ics.interactions.wot.td.ThingDescription;
import ch.unisg.ics.interactions.wot.td.affordances.ActionAffordance;
import ch.unisg.ics.interactions.wot.td.affordances.Form;
import ch.unisg.ics.interactions.wot.td.clients.TDHttpRequest;
import ch.unisg.ics.interactions.wot.td.schemas.DataSchema;
import ch.unisg.ics.interactions.wot.td.schemas.ObjectSchema;
import ch.unisg.ics.interactions.wot.td.security.APIKeySecurityScheme;
import ch.unisg.ics.interactions.wot.td.security.SecurityScheme;
import ch.unisg.ics.interactions.wot.td.vocabularies.WoTSec;

import java.io.IOException;
import java.util.Map;
import java.util.Optional;

// A consumed Leubot Thing
public class LeubotThing {

    private static ThingDescription td;
    private static String apiKey;

    public LeubotThing(ThingDescription td) {
        LeubotThing.td = td;
    }

    private static TDHttpRequest setAPIKey(TDHttpRequest request) {
        Optional<SecurityScheme> scheme = td.getFirstSecuritySchemeByType(WoTSec.APIKeySecurityScheme);

        if (scheme.isPresent() && apiKey != null) {
            request.setAPIKey((APIKeySecurityScheme) scheme.get(), apiKey);
        }

        return request;
    }

    public void exploit(String operationType, String affordanceType, Object payload) {
        //Get affordance
        Optional<ActionAffordance> affordance = td.getFirstActionBySemanticType(affordanceType);

        //Get form
        if (affordance.isPresent()) {
            Optional<Form> form = affordance.get().getFirstFormForOperationType(operationType);
            if (form.isPresent()) {

                // Set input
                TDHttpRequest request = new TDHttpRequest(form.get(), operationType);
                if (affordance.get().getInputSchema().isPresent()) {
                    DataSchema inputSchema = affordance.get().getInputSchema().get();
                    if (inputSchema.getDatatype()
                            .equals(DataSchema.OBJECT)) {
                        request.setObjectPayload((ObjectSchema) inputSchema, (Map) payload);
                    }
                }
                // Execute request
                if (apiKey != null) {
                    setAPIKey(request);
                    try {
                        request.execute();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                } else {
                    System.out.println(request.toString());
                }
            }
        }

    }

    public void setApiKey(String apiKey) {
        LeubotThing.apiKey = apiKey;
    }
}
