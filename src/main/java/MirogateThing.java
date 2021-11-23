import ch.unisg.ics.interactions.wot.td.ThingDescription;
import ch.unisg.ics.interactions.wot.td.affordances.Form;
import ch.unisg.ics.interactions.wot.td.affordances.PropertyAffordance;
import ch.unisg.ics.interactions.wot.td.clients.TDCoapHandler;
import ch.unisg.ics.interactions.wot.td.clients.TDCoapObserveRelation;
import ch.unisg.ics.interactions.wot.td.clients.TDCoapRequest;
import ch.unisg.ics.interactions.wot.td.clients.TDCoapResponse;
import ch.unisg.ics.interactions.wot.td.schemas.DataSchema;
import ch.unisg.ics.interactions.wot.td.schemas.ObjectSchema;
import ch.unisg.ics.interactions.wot.td.vocabularies.COV;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;
import java.util.concurrent.locks.ReentrantLock;
import java.util.logging.Logger;

// A consumed Mirogate Thing
class MirogateThing {

    private static ThingDescription td;
    Map<String, TDCoapObserveRelation> observeRelations = new HashMap<>();
    ReentrantLock observeRelationsLock = new ReentrantLock();

    static Logger LOG = Logger.getLogger(MirogateThing.class.getName());

    public MirogateThing(ThingDescription td) {
        MirogateThing.td = td;
    }

    public void exploit(String operationType, String affordanceType, App.Observation callback) {
        //Get affordance
        Optional<PropertyAffordance> affordance = td.getFirstPropertyBySemanticType(affordanceType);

        //Get form
        if (affordance.isPresent()) {
            Optional<Form> form = affordance.get().getFirstFormForOperationType(operationType);

            //Get subprotocol
            if (form.isPresent() && form.get().getSubprotocol().isPresent()) {
                Optional<String> subprotocol = form.get().getSubprotocol();

                //Execute async request
                if (subprotocol.get().equals(COV.observe)) {
                    TDCoapRequest request = new TDCoapRequest(form.get(), operationType);
                    TDCoapObserveRelation observeRelation = request.establishRelation(new TDCoapHandler() {
                        @Override
                        public void handleLoad(TDCoapResponse response) {
                            DataSchema schema = affordance.get().getDataSchema();
                            callback.observed(response.getPayloadAsObject((ObjectSchema) schema));
                        }

                        @Override
                        public void handleError() {
                            LOG.info("Failed.");
                        }
                    });

                    addObserveRelation(affordanceType, observeRelation);

                    // Wait for establishment of observation relation
                    try {
                        Thread.sleep(6 * 1000);
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                }
            }
        }
    }

    private void addObserveRelation(String affordanceType, TDCoapObserveRelation observeRelation) {
        try {
            observeRelationsLock.lock();
            if (observeRelation != null && !observeRelations.containsKey(affordanceType)) {
                observeRelations.put(affordanceType, observeRelation);
            }
        } finally {
            observeRelationsLock.unlock();
        }
    }

    public void removeObserveRelation(String affordanceType) {
        try {
            observeRelationsLock.lock();
            if (!observeRelations.isEmpty()) {
                observeRelations.get(affordanceType).proactiveCancel();
                observeRelations.clear();
            }
        } finally {
            observeRelationsLock.unlock();
        }
    }

}