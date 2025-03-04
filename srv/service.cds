using { zfull as my } from '../db/schema.cds';

@path : '/service/zfull'
service zfullSrv @(requires: 'authenticated-user')
{
    annotate Stores with @restrict :
    [
        { grant : [ '*' ], to : [ 'Admin' ] },
        { grant : [ 'READ' ], to : [ 'Read' ] }
    ];

    entity Books as
        projection on my.Books
        {
            *,
            author : redirected to zfullSrv.Authors,
            store : redirected to zfullSrv.Stores
        };

    @odata.draft.enabled
    entity Authors as
        projection on my.Authors;

    @odata.draft.enabled
    entity Stores as
        projection on my.Stores;

    entity ListBooksOrder as
        projection on my.ListBooksOrder;
        

    entity FixedValueListEntity as
        projection on my.FixedValueListEntity;
}
