sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'zfull/stores/test/integration/FirstJourney',
		'zfull/stores/test/integration/pages/StoresList',
		'zfull/stores/test/integration/pages/StoresObjectPage'
    ],
    function(JourneyRunner, opaJourney, StoresList, StoresObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('zfull/stores') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheStoresList: StoresList,
					onTheStoresObjectPage: StoresObjectPage
                }
            },
            opaJourney.run
        );
    }
);