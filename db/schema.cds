namespace zfull;

using {
    cuid,
    Currency
} from '@sap/cds/common';

entity Books : cuid {
    title         : Association to one ListBooksOrder;
    genre         : String(50);
    publishedDate : Date;
    price         : Decimal(10, 2);
    Currency      : Currency;
    quantity      : Integer;
    author        : Association to one Authors;
    store         : Association to one Stores;
}

annotate Books with @assert.unique: {title: [
    title,
    store
]};

entity Authors : cuid {
    name  : String(100)
    @mandatory;
    bio   : String(500);
    books : Association to many Books
                on books.author = $self;
}

annotate Authors with @assert.unique: {name: [name], };

entity Stores : cuid {
    storename : String(100)
    @mandatory;
    address   : String(100);
    edit_addr : Association to one FixedValueListEntity;
    books     : Composition of many Books
                    on books.store = $self;
}

annotate Stores with @assert.unique: {storename: [storename], };

entity ListBooksOrder {
    key ID    : UUID;
        title : String(100);
        books : Association to many Books
                    on books.title = $self;
}

entity FixedValueListEntity : cuid {
    edit_addr : Integer;
    Description : String;
    edit_addrs : Association to many Stores
                    on edit_addrs.edit_addr = $self;
}
