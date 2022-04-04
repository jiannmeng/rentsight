CREATE MIGRATION m1gykbyvyk6rbefayzkywgj66empsoxgpojzc2h6h64jdddychncfq
    ONTO initial
{
  CREATE TYPE default::Entity {
      CREATE PROPERTY contact_number -> std::str;
      CREATE PROPERTY email -> std::str;
      CREATE REQUIRED PROPERTY full_name -> std::str;
  };
  CREATE TYPE default::Person EXTENDING default::Entity {
      CREATE PROPERTY test -> std::str;
  };
  CREATE TYPE default::Business EXTENDING default::Entity {
      CREATE LINK contact -> default::Person;
  };
  CREATE SCALAR TYPE default::BasePeriod EXTENDING enum<OneOff, Day, Week, Month, Year>;
  CREATE TYPE default::Contract {
      CREATE REQUIRED LINK contractee -> default::Entity;
      CREATE REQUIRED LINK rentee -> default::Person;
      CREATE REQUIRED PROPERTY end_date -> cal::local_date;
      CREATE REQUIRED PROPERTY rent_cost -> tuple<currency: std::str, amount: std::decimal, base_period: default::BasePeriod>;
      CREATE REQUIRED PROPERTY start_date -> cal::local_date;
  };
  CREATE TYPE default::Property {
      CREATE MULTI LINK owners -> default::Entity {
          CREATE PROPERTY percentage -> std::decimal;
          CREATE CONSTRAINT std::expression ON ((__subject__@percentage <= 100));
          CREATE CONSTRAINT std::expression ON ((__subject__@percentage >= 0));
      };
      CREATE REQUIRED PROPERTY address1 -> std::str;
      CREATE PROPERTY address2 -> std::str;
      CREATE REQUIRED PROPERTY country -> std::str;
      CREATE REQUIRED PROPERTY nickname -> std::str;
      CREATE REQUIRED PROPERTY postcode -> std::str;
      CREATE REQUIRED PROPERTY state -> std::str;
      CREATE REQUIRED PROPERTY town_city -> std::str;
  };
  CREATE SCALAR TYPE default::EntityType EXTENDING enum<Person, Business>;
};
