module default {
  scalar type BasePeriod extending enum<OneOff, Day, Week, Month, Year>;
  scalar type EntityType extending enum<Person, Business>;
  
  type Property {
    required property nickname -> str;
    multi link owners -> Entity {
      property percentage -> decimal;
      constraint expression on (
        __subject__@percentage >= 0
      );
      constraint expression on (
        __subject__@percentage <= 100
      );
    }

    # Address
    required property address1 -> str;
    property address2 -> str;
    required property postcode -> str;
    required property town_city -> str;
    required property state -> str;
    required property country -> str;
  }

  type Contract {
    required link contractee -> Entity;
    required link rentee -> Person;
    required property rent_cost -> tuple<currency: str, amount: decimal, base_period: BasePeriod>;
    required property start_date -> cal::local_date;
    required property end_date -> cal::local_date;
  }

  type Entity {
    required property full_name -> str;
    property contact_number -> str;
    property email -> str;
  }

  type Person extending Entity {
    property test -> str;
  }

  type Business extending Entity {
    link contact -> Person;
  }
}
