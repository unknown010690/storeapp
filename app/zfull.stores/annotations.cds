using zfullSrv as service from '../../srv/service';

annotate service.Stores with @(
    UI.HeaderInfo                : {
        Title         : {
            $Type: 'UI.DataField',
            Value: storename,
        },
        TypeName      : '',
        TypeNamePlural: '',
    },
    UI.Facets                    : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Inform',
            ID    : 'Inform',
            Target: '@UI.FieldGroup#Inform',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>Books}',
            ID    : 'i18nBooks',
            Target: 'books/@UI.LineItem#i18nBooks',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'ChartBook',
            ID    : 'ChartBook',
            Target: 'books/@UI.PresentationVariant#chartSection',
        },
    ],
    UI.FieldGroup #Inform        : {
        $Type: 'UI.FieldGroupType',
        Data : [{
            $Type                  : 'UI.DataField',
            Value                  : address,
            Label                  : 'address',
            ![@Common.FieldControl] : edit_addr.edit_addr,
        },
            {
                $Type : 'UI.DataField',
                Value : edit_addr_ID,
                Label : 'edit_addr_ID',
            }, ],
    },
    UI.LineItem                  : [
        {
            $Type: 'UI.DataField',
            Value: storename,
            Label: 'storename',
        },
        {
            $Type: 'UI.DataField',
            Value: address,
            Label: 'address',
        },
    ]
);

annotate service.Books with @(
    UI.LineItem #i18nBooks              : [
        {
            $Type: 'UI.DataField',
            Value: title_ID,
            Label: 'title_ID',
        },
        {
            $Type: 'UI.DataField',
            Value: price,
            Label: 'price',
        },
        {
            $Type: 'UI.DataField',
            Value: quantity,
            Label: 'quantity',
        },
    ],
    UI.LineItem #Books                  : [],
    UI.Chart #chartSection              : {
        $Type          : 'UI.ChartDefinitionType',
        ChartType      : #Column,
        Dimensions     : [title_ID, ],
        DynamicMeasures: ['@Analytics.AggregatedProperty#totalQuantity', ],
        Title          : 'Quantity Book',
    },

    UI.PresentationVariant #chartSection: {
        $Type         : 'UI.PresentationVariantType',
        Visualizations: ['@UI.Chart#chartSection', ],
    },
);

annotate service.Books with {
    title @(
        Common.Text                    : {
            $value                : title.title,
            ![@UI.TextArrangement]: #TextOnly
        },
        Common.ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'ListBooksOrder',
            Parameters    : [{
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: title_ID,
                ValueListProperty: 'ID',
            }, ],
            Label         : 'Books',
        },
        Common.ValueListWithFixedValues: true,
        Common.Label                   : 'Text',
    )
};

annotate service.ListBooksOrder with {
    ID @Common.Text: {
        $value                : title,
        ![@UI.TextArrangement]: #TextOnly,
    }
};

annotate service.Books with {
    price @(Measures.ISOCurrency: Currency_code, )
};

annotate service.Books with @(

    Aggregation.ApplySupported                 : {
        Transformations       : ['aggregate', ],
        GroupableProperties   : [title_ID],

        AggregatableProperties: [{
            $Type   : 'Aggregation.AggregatablePropertyType',
            Property: quantity
        }]
    },

    Analytics.AggregatedProperty #totalQuantity: {
        $Type               : 'Analytics.AggregatedPropertyType',
        AggregatableProperty: quantity,
        AggregationMethod   : 'sum',
        Name                : 'totalQuantity',
        ![@Common.Label]    : 'Total Quantity'
    },
);

annotate service.FixedValueListEntity with {
    KeyProp @Common.Text: {
        $value                : Description,
        ![@UI.TextArrangement]: #TextOnly,
    }
};


annotate service.Stores with {
    edit_addr @(
        Common.ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'FixedValueListEntity',
            Parameters    : [{
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: edit_addr_ID,
                ValueListProperty: 'ID',
            }, ],
            Label         : 'Drop',
        },
        Common.ValueListWithFixedValues: true,
        Common.Text : {
            $value : edit_addr.Description,
            ![@UI.TextArrangement] : #TextOnly,
        },
    )
};

annotate service.Stores @(Common : {
    SideEffects #CustomerChanged : {
        SourceProperties : ['edit_addr_ID'],
        TargetEntities   : [ edit_addr]
    }
});

annotate service.FixedValueListEntity with {
    ID @Common.Text: {
        $value                : Description,
        ![@UI.TextArrangement]: #TextOnly,
    }
};
annotate service.FixedValueListEntity with {
    edit_addr @(Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'FixedValueListEntity',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : edit_addr,
                    ValueListProperty : 'edit_addr',
                },
            ],
        },
        Common.ValueListWithFixedValues : true
)};

