/**
 * 
 * @Before(event = { "READ","UPDATE" }, entity = "zfullSrv.Stores")
 * @param {cds.Request} request - User information, tenant-specific CDS model, headers and query parameters
*/
module.exports = async function(request) {
    const { Stores, FixedValueListEntity } = cds.entities;

    // Check if the request is for a specific store
    if (request.data && request.data.ID) {
        // Fetch the store details including the edit_addr
        const store = await SELECT.one.from(Stores).where({ ID: request.data.ID });

        if (store && store.edit_addr) {
            // Fetch the corresponding FixedValueListEntity
            const fixedValue = await SELECT.one.from(FixedValueListEntity).where({ ID: store.edit_addr });

            if (fixedValue) {
                // Perform any necessary logic with the fixedValue
                // For example, you might want to log it or modify the request data
                console.log(`Store edit address description: ${fixedValue.Description}`);
                
                // Example: Modify request data if needed
                // request.data.someField = someValueBasedOnFixedValue;
            }
        }
    }
}