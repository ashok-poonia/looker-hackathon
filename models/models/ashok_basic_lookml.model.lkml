# Define the database connection to be used for this model.
connection: "lookerdata"

# include all the views
include: "/views/**/*.view.lkml"

# Datagroups define a caching policy for an Explore. To learn more,
# use the Quick Help panel on the right to see documentation.

datagroup: ashok_basic_lookml_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: ashok_basic_lookml_default_datagroup

# Explores allow you to join together different views (database tables) based on the
# relationships between fields. By joining a view into an Explore, you make those
# fields available to users for data analysis.
# Explores should be purpose-built for specific use cases.

# To see the Explore you’re building, navigate to the Explore menu and select an Explore under "Ashok Basic Lookml"

explore: inventory_items {
  label: "Inventory"
  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }
}

explore: orders {
  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

# To create more sophisticated Explores that involve multiple views, you can use the join parameter.
# Typically, join parameters require that you define the join type, join relationship, and a sql_on clause.
# Each joined view also needs to define a primary key.

explore: products {}

explore: product_sheets {
  join: products {
    type: left_outer
    sql_on: ${product_sheets.product_id} = ${products.id} ;;
    relationship: many_to_one
  }
}

explore: order_items {
  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: orders {
    type: left_outer
    sql_on: ${order_items.order_id} = ${orders.id} ;;
    relationship: many_to_one
  }

  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: users {}



view: product {
  derived_table: {
    sql:  select "1" as product_id,  "Back Truck" as product_name,  "Medium" as product_category,  1238 as product_hourly_price, union all
      select "2" as product_id,  "Bulldozer" as product_name,  "Medium" as product_category,  1583 as product_hourly_price, union all
      select "3" as product_id,  "Compactor" as product_name,  "Light" as product_category,  1904 as product_hourly_price, union all
      select "4" as product_id,  "Crawler" as product_name,  "Light" as product_category,  1735 as product_hourly_price, union all
      select "5" as product_id,  "Dragline" as product_name,  "Light" as product_category,  1633 as product_hourly_price, union all
      select "6" as product_id,  "Dump Truck" as product_name,  "Heavy" as product_category,  1948 as product_hourly_price, union all
      select "7" as product_id,  "Excavator" as product_name,  "Heavy" as product_category,  1979 as product_hourly_price, union all
      select "8" as product_id,  "Grader" as product_name,  "Heavy" as product_category,  1325 as product_hourly_price, union all
      select "9" as product_id,  "Scraper" as product_name,  "Heavy" as product_category,  1894 as product_hourly_price, union all
      select "10" as product_id,  "Skid-Steer" as product_name,  "Medium" as product_category,  1506 as product_hourly_price, union all
      select "11" as product_id,  "Trencher" as product_name,  "Medium" as product_category,  1217 as product_hourly_price;;
  }

  dimension: product_id {
    type:  string
    sql: ${TABLE}.product_id ;;
  }

  dimension: product_name {
    type: string
    sql: ${TABLE}.product_name ;;
  }

  dimension: product_hourly_price {
    type: string
    value_format_name: usd_0
    sql: ${TABLE}.product_hourly_price ;;
  }

  measure: count {
    type:  count
  }


}

view: salesperson_staging {
  derived_table: {
    sql: select "1" as salesperson_id,  "Jaime" as salesperson_first_name,  "Elcocks" as salesperson_last_name,  "Senior" as salesperson_level,  38 as salesperson_age,  "Closer" as salespersion_function,  "4" as office_id, union all
      select "2" as salesperson_id,  "Tudor" as salesperson_first_name,  "Spenceley" as salesperson_last_name,  "Senior" as salesperson_level,  33 as salesperson_age,  "Indirect" as salespersion_function,  "10" as office_id, union all
      select "3" as salesperson_id,  "Perle" as salesperson_first_name,  "Bwye" as salesperson_last_name,  "Senior" as salesperson_level,  32 as salesperson_age,  "Executer" as salespersion_function,  "4" as office_id, union all
      select "4" as salesperson_id,  "Terri-jo" as salesperson_first_name,  "Hedden" as salesperson_last_name,  "Senior" as salesperson_level,  26 as salesperson_age,  "Direct" as salespersion_function,  "2" as office_id, union all
      select "5" as salesperson_id,  "Rosamund" as salesperson_first_name,  "Story" as salesperson_last_name,  "Senior" as salesperson_level,  26 as salesperson_age,  "Executer" as salespersion_function,  "8" as office_id, union all
      select "6" as salesperson_id,  "Fletcher" as salesperson_first_name,  "MacKessock" as salesperson_last_name,  "Senior" as salesperson_level,  29 as salesperson_age,  "Lead" as salespersion_function,  "10" as office_id, union all
      select "7" as salesperson_id,  "Avrom" as salesperson_first_name,  "Sommers" as salesperson_last_name,  "Senior" as salesperson_level,  32 as salesperson_age,  "Lead" as salespersion_function,  "7" as office_id, union all
      select "8" as salesperson_id,  "Giacobo" as salesperson_first_name,  "Haug" as salesperson_last_name,  "Senior" as salesperson_level,  26 as salesperson_age,  "Closer" as salespersion_function,  "1" as office_id, union all
      select "9" as salesperson_id,  "Gaspar" as salesperson_first_name,  "Ogilvy" as salesperson_last_name,  "Senior" as salesperson_level,  28 as salesperson_age,  "Lead" as salespersion_function,  "4" as office_id, union all
      select "10" as salesperson_id,  "Quintina" as salesperson_first_name,  "Charte" as salesperson_last_name,  "Senior" as salesperson_level,  27 as salesperson_age,  "Lead" as salespersion_function,  "4" as office_id, union all
      select "11" as salesperson_id,  "Silvester" as salesperson_first_name,  "Bastock" as salesperson_last_name,  "Junior" as salesperson_level,  36 as salesperson_age,  "Closer" as salespersion_function,  "10" as office_id, union all
      select "12" as salesperson_id,  "Sayer" as salesperson_first_name,  "Labern" as salesperson_last_name,  "Junior" as salesperson_level,  40 as salesperson_age,  "Closer" as salespersion_function,  "7" as office_id, union all
      select "13" as salesperson_id,  "Obadias" as salesperson_first_name,  "Tomaini" as salesperson_last_name,  "Junior" as salesperson_level,  36 as salesperson_age,  "Closer" as salespersion_function,  "5" as office_id, union all
      select "14" as salesperson_id,  "Remington" as salesperson_first_name,  "Dubois" as salesperson_last_name,  "Junior" as salesperson_level,  37 as salesperson_age,  "Lead" as salespersion_function,  "1" as office_id, union all
      select "15" as salesperson_id,  "Fanechka" as salesperson_first_name,  "Fearnall" as salesperson_last_name,  "Junior" as salesperson_level,  27 as salesperson_age,  "Executer" as salespersion_function,  "9" as office_id, union all
      select "16" as salesperson_id,  "Auroora" as salesperson_first_name,  "Cromly" as salesperson_last_name,  "Junior" as salesperson_level,  29 as salesperson_age,  "Closer" as salespersion_function,  "2" as office_id, union all
      select "17" as salesperson_id,  "Paige" as salesperson_first_name,  "Carmont" as salesperson_last_name,  "Junior" as salesperson_level,  28 as salesperson_age,  "Direct" as salespersion_function,  "1" as office_id, union all
      select "18" as salesperson_id,  "Gradey" as salesperson_first_name,  "Cruce" as salesperson_last_name,  "Junior" as salesperson_level,  31 as salesperson_age,  "Lead" as salespersion_function,  "3" as office_id, union all
      select "19" as salesperson_id,  "Verine" as salesperson_first_name,  "Dines" as salesperson_last_name,  "Junior" as salesperson_level,  40 as salesperson_age,  "Direct" as salespersion_function,  "1" as office_id, union all
      select "20" as salesperson_id,  "Martina" as salesperson_first_name,  "Lynes" as salesperson_last_name,  "Junior" as salesperson_level,  35 as salesperson_age,  "Executer" as salespersion_function,  "4" as office_id, union all
      select "21" as salesperson_id,  "Ardelia" as salesperson_first_name,  "Edelheit" as salesperson_last_name,  "Junior" as salesperson_level,  31 as salesperson_age,  "Indirect" as salespersion_function,  "6" as office_id, union all
      select "22" as salesperson_id,  "Nike" as salesperson_first_name,  "Menhenitt" as salesperson_last_name,  "Junior" as salesperson_level,  22 as salesperson_age,  "Closer" as salespersion_function,  "1" as office_id, union all
      select "23" as salesperson_id,  "Colleen" as salesperson_first_name,  "Shearmur" as salesperson_last_name,  "Junior" as salesperson_level,  39 as salesperson_age,  "Closer" as salespersion_function,  "4" as office_id, union all
      select "24" as salesperson_id,  "Rochella" as salesperson_first_name,  "Panswick" as salesperson_last_name,  "Junior" as salesperson_level,  24 as salesperson_age,  "Indirect" as salespersion_function,  "8" as office_id, union all
      select "25" as salesperson_id,  "Philly" as salesperson_first_name,  "Gounin" as salesperson_last_name,  "Junior" as salesperson_level,  32 as salesperson_age,  "Direct" as salespersion_function,  "8" as office_id, union all
      select "26" as salesperson_id,  "Dynah" as salesperson_first_name,  "McMennum" as salesperson_last_name,  "Junior" as salesperson_level,  38 as salesperson_age,  "Lead" as salespersion_function,  "2" as office_id, union all
      select "27" as salesperson_id,  "Paige" as salesperson_first_name,  "Connerly" as salesperson_last_name,  "Junior" as salesperson_level,  27 as salesperson_age,  "Closer" as salespersion_function,  "2" as office_id, union all
      select "28" as salesperson_id,  "Pancho" as salesperson_first_name,  "Flaverty" as salesperson_last_name,  "Junior" as salesperson_level,  22 as salesperson_age,  "Executer" as salespersion_function,  "6" as office_id, union all
      select "29" as salesperson_id,  "Silvie" as salesperson_first_name,  "Lukas" as salesperson_last_name,  "Junior" as salesperson_level,  22 as salesperson_age,  "Lead" as salespersion_function,  "3" as office_id, union all
      select "30" as salesperson_id,  "Trueman" as salesperson_first_name,  "Greenan" as salesperson_last_name,  "Junior" as salesperson_level,  33 as salesperson_age,  "Closer" as salespersion_function,  "6" as office_id, union all
      select "31" as salesperson_id,  "Adriena" as salesperson_first_name,  "Cumes" as salesperson_last_name,  "Junior" as salesperson_level,  21 as salesperson_age,  "Closer" as salespersion_function,  "3" as office_id, union all
      select "32" as salesperson_id,  "Joseito" as salesperson_first_name,  "Drife" as salesperson_last_name,  "Junior" as salesperson_level,  36 as salesperson_age,  "Closer" as salespersion_function,  "3" as office_id, union all
      select "33" as salesperson_id,  "Jeth" as salesperson_first_name,  "Wain" as salesperson_last_name,  "Junior" as salesperson_level,  32 as salesperson_age,  "Executer" as salespersion_function,  "4" as office_id, union all
      select "34" as salesperson_id,  "Willie" as salesperson_first_name,  "Hanscom" as salesperson_last_name,  "Junior" as salesperson_level,  30 as salesperson_age,  "Executer" as salespersion_function,  "10" as office_id, union all
      select "35" as salesperson_id,  "Aymer" as salesperson_first_name,  "Mereweather" as salesperson_last_name,  "Junior" as salesperson_level,  32 as salesperson_age,  "Executer" as salespersion_function,  "3" as office_id, union all
      select "36" as salesperson_id,  "Millisent" as salesperson_first_name,  "Buxey" as salesperson_last_name,  "Junior" as salesperson_level,  40 as salesperson_age,  "Direct" as salespersion_function,  "4" as office_id, union all
      select "37" as salesperson_id,  "Odie" as salesperson_first_name,  "Pauletti" as salesperson_last_name,  "Junior" as salesperson_level,  40 as salesperson_age,  "Direct" as salespersion_function,  "2" as office_id, union all
      select "38" as salesperson_id,  "Vail" as salesperson_first_name,  "Akam" as salesperson_last_name,  "Junior" as salesperson_level,  35 as salesperson_age,  "Lead" as salespersion_function,  "1" as office_id, union all
      select "39" as salesperson_id,  "Catherin" as salesperson_first_name,  "Hulse" as salesperson_last_name,  "Junior" as salesperson_level,  23 as salesperson_age,  "Lead" as salespersion_function,  "9" as office_id, union all
      select "40" as salesperson_id,  "Cicily" as salesperson_first_name,  "Hurt" as salesperson_last_name,  "Junior" as salesperson_level,  32 as salesperson_age,  "Lead" as salespersion_function,  "6" as office_id, union all
      select "41" as salesperson_id,  "Vally" as salesperson_first_name,  "Learoid" as salesperson_last_name,  "Junior" as salesperson_level,  24 as salesperson_age,  "Executer" as salespersion_function,  "7" as office_id, union all
      select "42" as salesperson_id,  "Clyve" as salesperson_first_name,  "Houson" as salesperson_last_name,  "Junior" as salesperson_level,  27 as salesperson_age,  "Direct" as salespersion_function,  "3" as office_id, union all
      select "43" as salesperson_id,  "Robbie" as salesperson_first_name,  "Jarman" as salesperson_last_name,  "Junior" as salesperson_level,  33 as salesperson_age,  "Direct" as salespersion_function,  "9" as office_id, union all
      select "44" as salesperson_id,  "Joey" as salesperson_first_name,  "Hawking" as salesperson_last_name,  "Junior" as salesperson_level,  34 as salesperson_age,  "Indirect" as salespersion_function,  "5" as office_id, union all
      select "45" as salesperson_id,  "Tamarra" as salesperson_first_name,  "Bedham" as salesperson_last_name,  "Junior" as salesperson_level,  35 as salesperson_age,  "Direct" as salespersion_function,  "9" as office_id, union all
      select "46" as salesperson_id,  "Jonathan" as salesperson_first_name,  "Goodbur" as salesperson_last_name,  "Junior" as salesperson_level,  26 as salesperson_age,  "Lead" as salespersion_function,  "2" as office_id, union all
      select "47" as salesperson_id,  "Roddy" as salesperson_first_name,  "Gellion" as salesperson_last_name,  "Junior" as salesperson_level,  34 as salesperson_age,  "Executer" as salespersion_function,  "4" as office_id, union all
      select "48" as salesperson_id,  "Ollie" as salesperson_first_name,  "Flint" as salesperson_last_name,  "Junior" as salesperson_level,  29 as salesperson_age,  "Lead" as salespersion_function,  "3" as office_id, union all
      select "49" as salesperson_id,  "Yvette" as salesperson_first_name,  "Reames" as salesperson_last_name,  "Junior" as salesperson_level,  37 as salesperson_age,  "Direct" as salespersion_function,  "1" as office_id, union all
      select "50" as salesperson_id,  "Blakeley" as salesperson_first_name,  "Oakhill" as salesperson_last_name,  "Junior" as salesperson_level,  39 as salesperson_age,  "Indirect" as salespersion_function,  "2" as office_id, union all
      select "51" as salesperson_id,  "Cleopatra" as salesperson_first_name,  "Beese" as salesperson_last_name,  "Junior" as salesperson_level,  37 as salesperson_age,  "Direct" as salespersion_function,  "8" as office_id, union all
      select "52" as salesperson_id,  "Smith" as salesperson_first_name,  "Pizzey" as salesperson_last_name,  "Junior" as salesperson_level,  20 as salesperson_age,  "Lead" as salespersion_function,  "7" as office_id, union all
      select "53" as salesperson_id,  "Clem" as salesperson_first_name,  "Radenhurst" as salesperson_last_name,  "Junior" as salesperson_level,  38 as salesperson_age,  "Lead" as salespersion_function,  "6" as office_id, union all
      select "54" as salesperson_id,  "Doe" as salesperson_first_name,  "Vasler" as salesperson_last_name,  "Junior" as salesperson_level,  26 as salesperson_age,  "Direct" as salespersion_function,  "10" as office_id, union all
      select "55" as salesperson_id,  "Flossy" as salesperson_first_name,  "Coolbear" as salesperson_last_name,  "Junior" as salesperson_level,  38 as salesperson_age,  "Closer" as salespersion_function,  "2" as office_id, union all
      select "56" as salesperson_id,  "Helga" as salesperson_first_name,  "Nelsen" as salesperson_last_name,  "Junior" as salesperson_level,  29 as salesperson_age,  "Executer" as salespersion_function,  "7" as office_id, union all
      select "57" as salesperson_id,  "Phylis" as salesperson_first_name,  "Kun" as salesperson_last_name,  "Junior" as salesperson_level,  24 as salesperson_age,  "Indirect" as salespersion_function,  "1" as office_id, union all
      select "58" as salesperson_id,  "Grace" as salesperson_first_name,  "Eltringham" as salesperson_last_name,  "Junior" as salesperson_level,  21 as salesperson_age,  "Indirect" as salespersion_function,  "1" as office_id, union all
      select "59" as salesperson_id,  "Ambros" as salesperson_first_name,  "Scholz" as salesperson_last_name,  "Junior" as salesperson_level,  29 as salesperson_age,  "Lead" as salespersion_function,  "6" as office_id, union all
      select "60" as salesperson_id,  "Israel" as salesperson_first_name,  "Delgadillo" as salesperson_last_name,  "Junior" as salesperson_level,  39 as salesperson_age,  "Closer" as salespersion_function,  "7" as office_id, union all
      select "61" as salesperson_id,  "Cristina" as salesperson_first_name,  "Vedekhov" as salesperson_last_name,  "Junior" as salesperson_level,  21 as salesperson_age,  "Lead" as salespersion_function,  "9" as office_id, union all
      select "62" as salesperson_id,  "Melesa" as salesperson_first_name,  "Voisey" as salesperson_last_name,  "Junior" as salesperson_level,  31 as salesperson_age,  "Indirect" as salespersion_function,  "7" as office_id, union all
      select "63" as salesperson_id,  "Shirley" as salesperson_first_name,  "Bailiss" as salesperson_last_name,  "Junior" as salesperson_level,  23 as salesperson_age,  "Indirect" as salespersion_function,  "4" as office_id, union all
      select "64" as salesperson_id,  "Marj" as salesperson_first_name,  "Gunstone" as salesperson_last_name,  "Junior" as salesperson_level,  22 as salesperson_age,  "Executer" as salespersion_function,  "10" as office_id, union all
      select "65" as salesperson_id,  "Eada" as salesperson_first_name,  "Branford" as salesperson_last_name,  "Junior" as salesperson_level,  37 as salesperson_age,  "Indirect" as salespersion_function,  "5" as office_id, union all
      select "66" as salesperson_id,  "Chevalier" as salesperson_first_name,  "Goude" as salesperson_last_name,  "Junior" as salesperson_level,  39 as salesperson_age,  "Indirect" as salespersion_function,  "4" as office_id, union all
      select "67" as salesperson_id,  "Viki" as salesperson_first_name,  "Farny" as salesperson_last_name,  "Junior" as salesperson_level,  28 as salesperson_age,  "Executer" as salespersion_function,  "7" as office_id, union all
      select "68" as salesperson_id,  "Matteo" as salesperson_first_name,  "Puttrell" as salesperson_last_name,  "Junior" as salesperson_level,  31 as salesperson_age,  "Executer" as salespersion_function,  "6" as office_id, union all
      select "69" as salesperson_id,  "Katheryn" as salesperson_first_name,  "Idill" as salesperson_last_name,  "Junior" as salesperson_level,  28 as salesperson_age,  "Indirect" as salespersion_function,  "10" as office_id, union all
      select "70" as salesperson_id,  "Keefe" as salesperson_first_name,  "Guidera" as salesperson_last_name,  "Junior" as salesperson_level,  33 as salesperson_age,  "Indirect" as salespersion_function,  "2" as office_id, union all
      select "71" as salesperson_id,  "Grethel" as salesperson_first_name,  "Creigan" as salesperson_last_name,  "Junior" as salesperson_level,  38 as salesperson_age,  "Lead" as salespersion_function,  "3" as office_id, union all
      select "72" as salesperson_id,  "Mathew" as salesperson_first_name,  "Fley" as salesperson_last_name,  "Junior" as salesperson_level,  24 as salesperson_age,  "Indirect" as salespersion_function,  "2" as office_id, union all
      select "73" as salesperson_id,  "Devin" as salesperson_first_name,  "Ricioppo" as salesperson_last_name,  "Junior" as salesperson_level,  35 as salesperson_age,  "Lead" as salespersion_function,  "3" as office_id, union all
      select "74" as salesperson_id,  "Wynn" as salesperson_first_name,  "Ellse" as salesperson_last_name,  "Junior" as salesperson_level,  33 as salesperson_age,  "Executer" as salespersion_function,  "4" as office_id, union all
      select "75" as salesperson_id,  "Candis" as salesperson_first_name,  "Avery" as salesperson_last_name,  "Junior" as salesperson_level,  38 as salesperson_age,  "Closer" as salespersion_function,  "10" as office_id, union all
      select "76" as salesperson_id,  "Walliw" as salesperson_first_name,  "Lelande" as salesperson_last_name,  "Junior" as salesperson_level,  39 as salesperson_age,  "Executer" as salespersion_function,  "3" as office_id, union all
      select "77" as salesperson_id,  "Perrine" as salesperson_first_name,  "Morfield" as salesperson_last_name,  "Junior" as salesperson_level,  36 as salesperson_age,  "Closer" as salespersion_function,  "5" as office_id, union all
      select "78" as salesperson_id,  "Giovanna" as salesperson_first_name,  "Kielt" as salesperson_last_name,  "Junior" as salesperson_level,  36 as salesperson_age,  "Closer" as salespersion_function,  "6" as office_id, union all
      select "79" as salesperson_id,  "Alina" as salesperson_first_name,  "Tilmouth" as salesperson_last_name,  "Junior" as salesperson_level,  27 as salesperson_age,  "Lead" as salespersion_function,  "6" as office_id, union all
      select "80" as salesperson_id,  "Gunther" as salesperson_first_name,  "Franceschelli" as salesperson_last_name,  "Junior" as salesperson_level,  37 as salesperson_age,  "Indirect" as salespersion_function,  "5" as office_id, union all
      select "81" as salesperson_id,  "Erin" as salesperson_first_name,  "Salmoni" as salesperson_last_name,  "Junior" as salesperson_level,  34 as salesperson_age,  "Direct" as salespersion_function,  "1" as office_id, union all
      select "82" as salesperson_id,  "Christy" as salesperson_first_name,  "Penas" as salesperson_last_name,  "Junior" as salesperson_level,  31 as salesperson_age,  "Lead" as salespersion_function,  "9" as office_id, union all
      select "83" as salesperson_id,  "Hy" as salesperson_first_name,  "Brayshay" as salesperson_last_name,  "Junior" as salesperson_level,  38 as salesperson_age,  "Direct" as salespersion_function,  "7" as office_id, union all
      select "84" as salesperson_id,  "Dall" as salesperson_first_name,  "Cosham" as salesperson_last_name,  "Junior" as salesperson_level,  30 as salesperson_age,  "Direct" as salespersion_function,  "3" as office_id, union all
      select "85" as salesperson_id,  "Avictor" as salesperson_first_name,  "Sellstrom" as salesperson_last_name,  "Junior" as salesperson_level,  23 as salesperson_age,  "Direct" as salespersion_function,  "2" as office_id, union all
      select "86" as salesperson_id,  "Kin" as salesperson_first_name,  "Cankett" as salesperson_last_name,  "Junior" as salesperson_level,  23 as salesperson_age,  "Indirect" as salespersion_function,  "2" as office_id, union all
      select "87" as salesperson_id,  "Eyde" as salesperson_first_name,  "Oates" as salesperson_last_name,  "Junior" as salesperson_level,  34 as salesperson_age,  "Closer" as salespersion_function,  "6" as office_id, union all
      select "88" as salesperson_id,  "Alyssa" as salesperson_first_name,  "Antonutti" as salesperson_last_name,  "Junior" as salesperson_level,  26 as salesperson_age,  "Lead" as salespersion_function,  "8" as office_id, union all
      select "89" as salesperson_id,  "Sherrie" as salesperson_first_name,  "Kaiser" as salesperson_last_name,  "Junior" as salesperson_level,  40 as salesperson_age,  "Indirect" as salespersion_function,  "7" as office_id, union all
      select "90" as salesperson_id,  "Theodosia" as salesperson_first_name,  "Jopling" as salesperson_last_name,  "Junior" as salesperson_level,  20 as salesperson_age,  "Indirect" as salespersion_function,  "10" as office_id, union all
      select "91" as salesperson_id,  "Rene" as salesperson_first_name,  "De Anesy" as salesperson_last_name,  "Junior" as salesperson_level,  22 as salesperson_age,  "Lead" as salespersion_function,  "10" as office_id, union all
      select "92" as salesperson_id,  "Maurits" as salesperson_first_name,  "Shee" as salesperson_last_name,  "Junior" as salesperson_level,  30 as salesperson_age,  "Closer" as salespersion_function,  "7" as office_id, union all
      select "93" as salesperson_id,  "Carolina" as salesperson_first_name,  "Rosengren" as salesperson_last_name,  "Junior" as salesperson_level,  39 as salesperson_age,  "Lead" as salespersion_function,  "7" as office_id, union all
      select "94" as salesperson_id,  "Antonin" as salesperson_first_name,  "Kensall" as salesperson_last_name,  "Junior" as salesperson_level,  33 as salesperson_age,  "Lead" as salespersion_function,  "8" as office_id, union all
      select "95" as salesperson_id,  "Dorthy" as salesperson_first_name,  "Fludgate" as salesperson_last_name,  "Junior" as salesperson_level,  26 as salesperson_age,  "Lead" as salespersion_function,  "2" as office_id, union all
      select "96" as salesperson_id,  "Maridel" as salesperson_first_name,  "Geary" as salesperson_last_name,  "Junior" as salesperson_level,  39 as salesperson_age,  "Closer" as salespersion_function,  "10" as office_id, union all
      select "97" as salesperson_id,  "Burt" as salesperson_first_name,  "Armor" as salesperson_last_name,  "Junior" as salesperson_level,  25 as salesperson_age,  "Indirect" as salespersion_function,  "1" as office_id, union all
      select "98" as salesperson_id,  "Ddene" as salesperson_first_name,  "Serraillier" as salesperson_last_name,  "Junior" as salesperson_level,  36 as salesperson_age,  "Indirect" as salespersion_function,  "1" as office_id, union all
      select "99" as salesperson_id,  "Basia" as salesperson_first_name,  "Bust" as salesperson_last_name,  "Junior" as salesperson_level,  36 as salesperson_age,  "Direct" as salespersion_function,  "3" as office_id, union all
      select "100" as salesperson_id,  "Germana" as salesperson_first_name,  "Renehan" as salesperson_last_name,  "Junior" as salesperson_level,  36 as salesperson_age,  "Direct" as salespersion_function,  "1" as office_id;;
  }



  dimension: salesperson_id  {
    type:  string
    sql: ${TABLE}.salesperson_id ;;
  }

  dimension: salesperson_first_name  {
    type:  string
    sql: ${TABLE}.salesperson_first_name ;;
  }

  dimension: salesperson_last_name  {
    type:  string
    sql: ${TABLE}.salesperson_last_name ;;
  }

  dimension: salesperson_level  {
    type:  string
    sql: ${TABLE}.salesperson_level ;;
  }

  dimension: salesperson_age  {
    type:  number
    value_format_name: decimal_0
    sql: ${TABLE}.salesperson_age ;;
  }

  dimension: salesperson_function {
    type: string
    sql: ${TABLE}.salespersion_function ;;
  }

  dimension:  office_id {
    type:  string
    sql: ${TABLE}.office_id ;;
  }


}

explore: salesperson_staging {
  view_name: salesperson_staging
  join: office {
    sql_on: ${office.office_id} = ${salesperson_staging.office_id} ;;
    type: left_outer
    relationship: many_to_one
  }
}

view: salesperson {
  derived_table: {
    explore_source: salesperson_staging {
      column: salesperson_id {field: salesperson_staging.salesperson_id}
      column: salesperson_first_name {field: salesperson_staging.salesperson_first_name}
      column: salesperson_last_name {field: salesperson_staging.salesperson_last_name}
      column: salesperson_level {field: salesperson_staging.salesperson_level}
      column: salesperson_age {field: salesperson_staging.salesperson_age}
      column: salesperson_function {field: salesperson_staging.salesperson_function}
      column: office_id {field: salesperson_staging.office_id}
      column: salesperson_office_name {field: office.office_name}
    }
  }

  dimension: salesperson_id  {
    type:  string
    sql: ${TABLE}.salesperson_id ;;
  }

  dimension: salesperson_first_name  {
    type:  string
    sql: ${TABLE}.salesperson_first_name ;;
  }

  dimension: salesperson_last_name  {
    type:  string
    sql: ${TABLE}.salesperson_last_name ;;
  }

  dimension: salesperson_level  {
    type:  string
    sql: ${TABLE}.salesperson_level ;;
  }

  dimension: salesperson_age  {
    type:  number
    value_format_name: decimal_0
    sql: ${TABLE}.salesperson_age ;;
  }

  dimension: salesperson_function {
    type: string
    sql: ${TABLE}.salesperson_function ;;
  }

  dimension:  office_id {
    type:  string
    sql: ${TABLE}.office_id ;;
  }

  dimension: salesperson_office_name {
    type:  string
    sql: ${TABLE}.salesperson_office_name ;;
  }

  measure: count {
    type:  count
  }


}

explore: salesperson {

}

view: customer {
  derived_table: {
    sql:  select "1" as customer_id,  "Trashly" as customer_company_name,  "Long Haul" as customer_type, union all
      select "2" as customer_id,  "FreightPark" as customer_company_name,  "Short Haul" as customer_type, union all
      select "3" as customer_id,  "BumperTruck" as customer_company_name,  "Medium Haul" as customer_type, union all
      select "4" as customer_id,  "SuperRig" as customer_company_name,  "Medium Haul" as customer_type, union all
      select "5" as customer_id,  "Sucket" as customer_company_name,  "Long Haul" as customer_type, union all
      select "6" as customer_id,  "Tractore" as customer_company_name,  "Short Haul" as customer_type, union all
      select "7" as customer_id,  "Pdump" as customer_company_name,  "Long Haul" as customer_type, union all
      select "8" as customer_id,  "Motore" as customer_company_name,  "Short Haul" as customer_type, union all
      select "9" as customer_id,  "Fliner" as customer_company_name,  "Long Haul" as customer_type, union all
      select "10" as customer_id,  "Mudcab" as customer_company_name,  "Long Haul" as customer_type, union all
      select "11" as customer_id,  "Stacket" as customer_company_name,  "Medium Haul" as customer_type, union all
      select "12" as customer_id,  "BullHome" as customer_company_name,  "Long Haul" as customer_type, union all
      select "13" as customer_id,  "Shover" as customer_company_name,  "Long Haul" as customer_type, union all
      select "14" as customer_id,  "Bucker" as customer_company_name,  "Medium Haul" as customer_type, union all
      select "15" as customer_id,  "Suppler" as customer_company_name,  "Short Haul" as customer_type, union all
      select "16" as customer_id,  "DriveDock" as customer_company_name,  "Medium Haul" as customer_type, union all
      select "17" as customer_id,  "GoHaul" as customer_company_name,  "Long Haul" as customer_type, union all
      select "18" as customer_id,  "SandHaul" as customer_company_name,  "Long Haul" as customer_type, union all
      select "19" as customer_id,  "DumpSpot" as customer_company_name,  "Medium Haul" as customer_type, union all
      select "20" as customer_id,  "Blastine" as customer_company_name,  "Short Haul" as customer_type

      ;;
  }

  dimension: customer_id {
    type:  string
    sql: ${TABLE}.customer_id ;;
  }

  dimension: customer_company_name {
    type:  string
    sql: ${TABLE}.customer_company_name ;;
  }

  dimension: customer_type {
    type:  string
    sql: ${TABLE}.customer_type ;;
  }

  measure: count {
    type:  count
  }


}

view: office {
  derived_table: {
    sql:  select "1" as office_id,  "New York City" as office_name,  "10009" as office_zipcode,  "1" as head_salesperson_id, union all
      select "2" as office_id,  "Dallas" as office_name,  "75001" as office_zipcode,  "2" as head_salesperson_id, union all
      select "3" as office_id,  "Houston" as office_name,  "77001" as office_zipcode,  "3" as head_salesperson_id, union all
      select "4" as office_id,  "Detroit" as office_name,  "48127" as office_zipcode,  "4" as head_salesperson_id, union all
      select "5" as office_id,  "Miami" as office_name,  "33101" as office_zipcode,  "5" as head_salesperson_id, union all
      select "6" as office_id,  "Orlando" as office_name,  "32789" as office_zipcode,  "6" as head_salesperson_id, union all
      select "7" as office_id,  "Seattle" as office_name,  "98101" as office_zipcode,  "7" as head_salesperson_id, union all
      select "8" as office_id,  "San Francisco" as office_name,  "94016" as office_zipcode,  "8" as head_salesperson_id, union all
      select "9" as office_id,  "Los Angeles" as office_name,  "90005" as office_zipcode,  "9" as head_salesperson_id, union all
      select "10" as office_id,  "Austin" as office_name,  "73301" as office_zipcode,  "10" as head_salesperson_id
      ;;
  }

  dimension: office_id {
    type:  string
    sql:  ${TABLE}.office_id ;;
  }

  dimension: office_name {
    type:  string
    sql:  ${TABLE}.office_name ;;
  }

  dimension: office_zip_code {
    type: zipcode
    sql: ${TABLE}.office_zipcode ;;
  }

  measure: count {
    type:  count
  }

}

view: sales {
  derived_table: {
    sql: select "1" as transaction_id,  date("2020-06-06") as date,  "6" as product_id,  "65" as salesperson_id,  "17" as customer_id,  "6" as office_id,  5 as hours,  9740 as sales,  "Florida" as transaction_state, union all
      select "2" as transaction_id,  date("2021-07-30") as date,  "2" as product_id,  "30" as salesperson_id,  "8" as customer_id,  "4" as office_id,  62 as hours,  98146 as sales,  "Iowa" as transaction_state, union all
      select "3" as transaction_id,  date("2021-01-05") as date,  "5" as product_id,  "15" as salesperson_id,  "5" as customer_id,  "3" as office_id,  3 as hours,  4899 as sales,  "New York" as transaction_state, union all
      select "4" as transaction_id,  date("2020-08-19") as date,  "8" as product_id,  "2" as salesperson_id,  "19" as customer_id,  "2" as office_id,  5 as hours,  6625 as sales,  "Utah" as transaction_state, union all
      select "5" as transaction_id,  date("2020-02-27") as date,  "8" as product_id,  "48" as salesperson_id,  "18" as customer_id,  "10" as office_id,  3 as hours,  3975 as sales,  "Alabama" as transaction_state, union all
      select "6" as transaction_id,  date("2021-06-24") as date,  "3" as product_id,  "20" as salesperson_id,  "1" as customer_id,  "3" as office_id,  19 as hours,  36176 as sales,  "Missouri" as transaction_state, union all
      select "7" as transaction_id,  date("2021-10-23") as date,  "5" as product_id,  "13" as salesperson_id,  "3" as customer_id,  "3" as office_id,  53 as hours,  86549 as sales,  "New York" as transaction_state, union all
      select "8" as transaction_id,  date("2020-01-21") as date,  "5" as product_id,  "63" as salesperson_id,  "16" as customer_id,  "1" as office_id,  15 as hours,  24495 as sales,  "California" as transaction_state, union all
      select "9" as transaction_id,  date("2021-09-18") as date,  "11" as product_id,  "73" as salesperson_id,  "17" as customer_id,  "1" as office_id,  52 as hours,  63284 as sales,  "New York" as transaction_state, union all
      select "10" as transaction_id,  date("2020-10-16") as date,  "11" as product_id,  "99" as salesperson_id,  "1" as customer_id,  "9" as office_id,  95 as hours,  115615 as sales,  "California" as transaction_state, union all
      select "11" as transaction_id,  date("2020-02-06") as date,  "3" as product_id,  "2" as salesperson_id,  "4" as customer_id,  "5" as office_id,  26 as hours,  49504 as sales,  "Michigan" as transaction_state, union all
      select "12" as transaction_id,  date("2020-04-08") as date,  "3" as product_id,  "3" as salesperson_id,  "9" as customer_id,  "10" as office_id,  21 as hours,  39984 as sales,  "California" as transaction_state, union all
      select "13" as transaction_id,  date("2020-04-08") as date,  "8" as product_id,  "42" as salesperson_id,  "14" as customer_id,  "3" as office_id,  14 as hours,  18550 as sales,  "District of Columbia" as transaction_state, union all
      select "14" as transaction_id,  date("2020-05-15") as date,  "6" as product_id,  "19" as salesperson_id,  "11" as customer_id,  "6" as office_id,  40 as hours,  77920 as sales,  "California" as transaction_state, union all
      select "15" as transaction_id,  date("2021-07-21") as date,  "6" as product_id,  "66" as salesperson_id,  "19" as customer_id,  "7" as office_id,  37 as hours,  72076 as sales,  "North Carolina" as transaction_state, union all
      select "16" as transaction_id,  date("2020-12-13") as date,  "6" as product_id,  "22" as salesperson_id,  "6" as customer_id,  "5" as office_id,  93 as hours,  181164 as sales,  "Ohio" as transaction_state, union all
      select "17" as transaction_id,  date("2020-08-28") as date,  "4" as product_id,  "86" as salesperson_id,  "8" as customer_id,  "7" as office_id,  59 as hours,  102365 as sales,  "Texas" as transaction_state, union all
      select "18" as transaction_id,  date("2021-07-03") as date,  "2" as product_id,  "5" as salesperson_id,  "6" as customer_id,  "7" as office_id,  7 as hours,  11081 as sales,  "Virginia" as transaction_state, union all
      select "19" as transaction_id,  date("2020-02-11") as date,  "8" as product_id,  "81" as salesperson_id,  "16" as customer_id,  "5" as office_id,  58 as hours,  76850 as sales,  "California" as transaction_state, union all
      select "20" as transaction_id,  date("2020-09-05") as date,  "1" as product_id,  "54" as salesperson_id,  "18" as customer_id,  "1" as office_id,  36 as hours,  44568 as sales,  "Washington" as transaction_state, union all
      select "21" as transaction_id,  date("2021-03-05") as date,  "7" as product_id,  "50" as salesperson_id,  "7" as customer_id,  "6" as office_id,  83 as hours,  164257 as sales,  "Florida" as transaction_state, union all
      select "22" as transaction_id,  date("2020-07-11") as date,  "11" as product_id,  "84" as salesperson_id,  "15" as customer_id,  "3" as office_id,  27 as hours,  32859 as sales,  "Virginia" as transaction_state, union all
      select "23" as transaction_id,  date("2021-06-13") as date,  "6" as product_id,  "14" as salesperson_id,  "18" as customer_id,  "4" as office_id,  42 as hours,  81816 as sales,  "New York" as transaction_state, union all
      select "24" as transaction_id,  date("2020-01-13") as date,  "6" as product_id,  "39" as salesperson_id,  "19" as customer_id,  "2" as office_id,  43 as hours,  83764 as sales,  "Maryland" as transaction_state, union all
      select "25" as transaction_id,  date("2020-08-06") as date,  "10" as product_id,  "97" as salesperson_id,  "11" as customer_id,  "2" as office_id,  52 as hours,  78312 as sales,  "New York" as transaction_state, union all
      select "26" as transaction_id,  date("2021-05-05") as date,  "7" as product_id,  "25" as salesperson_id,  "6" as customer_id,  "8" as office_id,  81 as hours,  160299 as sales,  "Massachusetts" as transaction_state, union all
      select "27" as transaction_id,  date("2020-03-05") as date,  "6" as product_id,  "21" as salesperson_id,  "15" as customer_id,  "4" as office_id,  57 as hours,  111036 as sales,  "Florida" as transaction_state, union all
      select "28" as transaction_id,  date("2020-10-20") as date,  "3" as product_id,  "57" as salesperson_id,  "12" as customer_id,  "10" as office_id,  17 as hours,  32368 as sales,  "Washington" as transaction_state, union all
      select "29" as transaction_id,  date("2020-07-15") as date,  "9" as product_id,  "58" as salesperson_id,  "14" as customer_id,  "4" as office_id,  39 as hours,  73866 as sales,  "New Hampshire" as transaction_state, union all
      select "30" as transaction_id,  date("2021-10-01") as date,  "6" as product_id,  "36" as salesperson_id,  "2" as customer_id,  "1" as office_id,  62 as hours,  120776 as sales,  "Pennsylvania" as transaction_state, union all
      select "31" as transaction_id,  date("2020-11-19") as date,  "9" as product_id,  "34" as salesperson_id,  "12" as customer_id,  "7" as office_id,  33 as hours,  62502 as sales,  "Florida" as transaction_state, union all
      select "32" as transaction_id,  date("2020-04-05") as date,  "8" as product_id,  "14" as salesperson_id,  "3" as customer_id,  "4" as office_id,  9 as hours,  11925 as sales,  "Texas" as transaction_state, union all
      select "33" as transaction_id,  date("2021-06-25") as date,  "6" as product_id,  "14" as salesperson_id,  "15" as customer_id,  "3" as office_id,  13 as hours,  25324 as sales,  "Illinois" as transaction_state, union all
      select "34" as transaction_id,  date("2020-04-29") as date,  "9" as product_id,  "66" as salesperson_id,  "12" as customer_id,  "3" as office_id,  76 as hours,  143944 as sales,  "Texas" as transaction_state, union all
      select "35" as transaction_id,  date("2021-10-15") as date,  "4" as product_id,  "26" as salesperson_id,  "8" as customer_id,  "8" as office_id,  44 as hours,  76340 as sales,  "Arizona" as transaction_state, union all
      select "36" as transaction_id,  date("2020-09-11") as date,  "2" as product_id,  "36" as salesperson_id,  "8" as customer_id,  "2" as office_id,  27 as hours,  42741 as sales,  "New York" as transaction_state, union all
      select "37" as transaction_id,  date("2020-11-08") as date,  "8" as product_id,  "53" as salesperson_id,  "20" as customer_id,  "9" as office_id,  20 as hours,  26500 as sales,  "Oklahoma" as transaction_state, union all
      select "38" as transaction_id,  date("2020-01-12") as date,  "7" as product_id,  "97" as salesperson_id,  "10" as customer_id,  "7" as office_id,  48 as hours,  94992 as sales,  "Ohio" as transaction_state, union all
      select "39" as transaction_id,  date("2021-02-09") as date,  "11" as product_id,  "92" as salesperson_id,  "6" as customer_id,  "6" as office_id,  5 as hours,  6085 as sales,  "Louisiana" as transaction_state, union all
      select "40" as transaction_id,  date("2020-06-29") as date,  "3" as product_id,  "30" as salesperson_id,  "7" as customer_id,  "7" as office_id,  28 as hours,  53312 as sales,  "California" as transaction_state, union all
      select "41" as transaction_id,  date("2021-09-17") as date,  "8" as product_id,  "51" as salesperson_id,  "7" as customer_id,  "5" as office_id,  22 as hours,  29150 as sales,  "Ohio" as transaction_state, union all
      select "42" as transaction_id,  date("2021-01-19") as date,  "4" as product_id,  "5" as salesperson_id,  "18" as customer_id,  "6" as office_id,  65 as hours,  112775 as sales,  "District of Columbia" as transaction_state, union all
      select "43" as transaction_id,  date("2021-09-14") as date,  "4" as product_id,  "72" as salesperson_id,  "10" as customer_id,  "2" as office_id,  15 as hours,  26025 as sales,  "Maryland" as transaction_state, union all
      select "44" as transaction_id,  date("2020-06-26") as date,  "6" as product_id,  "100" as salesperson_id,  "10" as customer_id,  "1" as office_id,  60 as hours,  116880 as sales,  "Arkansas" as transaction_state, union all
      select "45" as transaction_id,  date("2020-06-24") as date,  "7" as product_id,  "87" as salesperson_id,  "1" as customer_id,  "10" as office_id,  85 as hours,  168215 as sales,  "California" as transaction_state, union all
      select "46" as transaction_id,  date("2021-07-24") as date,  "10" as product_id,  "4" as salesperson_id,  "2" as customer_id,  "10" as office_id,  69 as hours,  103914 as sales,  "Missouri" as transaction_state, union all
      select "47" as transaction_id,  date("2021-04-23") as date,  "7" as product_id,  "83" as salesperson_id,  "15" as customer_id,  "7" as office_id,  92 as hours,  182068 as sales,  "California" as transaction_state, union all
      select "48" as transaction_id,  date("2021-06-30") as date,  "4" as product_id,  "78" as salesperson_id,  "20" as customer_id,  "1" as office_id,  68 as hours,  117980 as sales,  "Pennsylvania" as transaction_state, union all
      select "49" as transaction_id,  date("2021-05-25") as date,  "1" as product_id,  "67" as salesperson_id,  "17" as customer_id,  "4" as office_id,  83 as hours,  102754 as sales,  "California" as transaction_state, union all
      select "50" as transaction_id,  date("2021-05-26") as date,  "8" as product_id,  "33" as salesperson_id,  "15" as customer_id,  "6" as office_id,  28 as hours,  37100 as sales,  "Pennsylvania" as transaction_state, union all
      select "51" as transaction_id,  date("2020-11-13") as date,  "8" as product_id,  "28" as salesperson_id,  "9" as customer_id,  "10" as office_id,  62 as hours,  82150 as sales,  "California" as transaction_state, union all
      select "52" as transaction_id,  date("2020-07-12") as date,  "4" as product_id,  "94" as salesperson_id,  "10" as customer_id,  "4" as office_id,  25 as hours,  43375 as sales,  "Colorado" as transaction_state, union all
      select "53" as transaction_id,  date("2020-07-31") as date,  "5" as product_id,  "79" as salesperson_id,  "1" as customer_id,  "6" as office_id,  41 as hours,  66953 as sales,  "Texas" as transaction_state, union all
      select "54" as transaction_id,  date("2021-06-25") as date,  "1" as product_id,  "5" as salesperson_id,  "16" as customer_id,  "3" as office_id,  39 as hours,  48282 as sales,  "Ohio" as transaction_state, union all
      select "55" as transaction_id,  date("2020-05-17") as date,  "3" as product_id,  "51" as salesperson_id,  "19" as customer_id,  "4" as office_id,  74 as hours,  140896 as sales,  "California" as transaction_state, union all
      select "56" as transaction_id,  date("2021-03-07") as date,  "10" as product_id,  "10" as salesperson_id,  "14" as customer_id,  "2" as office_id,  33 as hours,  49698 as sales,  "Massachusetts" as transaction_state, union all
      select "57" as transaction_id,  date("2020-08-16") as date,  "9" as product_id,  "27" as salesperson_id,  "8" as customer_id,  "3" as office_id,  67 as hours,  126898 as sales,  "Utah" as transaction_state, union all
      select "58" as transaction_id,  date("2021-01-14") as date,  "8" as product_id,  "90" as salesperson_id,  "10" as customer_id,  "4" as office_id,  3 as hours,  3975 as sales,  "Connecticut" as transaction_state, union all
      select "59" as transaction_id,  date("2021-01-23") as date,  "3" as product_id,  "5" as salesperson_id,  "13" as customer_id,  "7" as office_id,  22 as hours,  41888 as sales,  "Oklahoma" as transaction_state, union all
      select "60" as transaction_id,  date("2021-01-16") as date,  "11" as product_id,  "26" as salesperson_id,  "16" as customer_id,  "7" as office_id,  44 as hours,  53548 as sales,  "Missouri" as transaction_state, union all
      select "61" as transaction_id,  date("2020-09-04") as date,  "5" as product_id,  "50" as salesperson_id,  "14" as customer_id,  "2" as office_id,  16 as hours,  26128 as sales,  "Minnesota" as transaction_state, union all
      select "62" as transaction_id,  date("2021-08-09") as date,  "6" as product_id,  "25" as salesperson_id,  "12" as customer_id,  "9" as office_id,  2 as hours,  3896 as sales,  "North Carolina" as transaction_state, union all
      select "63" as transaction_id,  date("2021-04-25") as date,  "4" as product_id,  "84" as salesperson_id,  "10" as customer_id,  "6" as office_id,  84 as hours,  145740 as sales,  "Utah" as transaction_state, union all
      select "64" as transaction_id,  date("2020-02-24") as date,  "9" as product_id,  "90" as salesperson_id,  "12" as customer_id,  "8" as office_id,  31 as hours,  58714 as sales,  "Ohio" as transaction_state, union all
      select "65" as transaction_id,  date("2021-05-02") as date,  "10" as product_id,  "76" as salesperson_id,  "12" as customer_id,  "3" as office_id,  59 as hours,  88854 as sales,  "District of Columbia" as transaction_state, union all
      select "66" as transaction_id,  date("2021-08-17") as date,  "7" as product_id,  "8" as salesperson_id,  "8" as customer_id,  "9" as office_id,  89 as hours,  176131 as sales,  "New York" as transaction_state, union all
      select "67" as transaction_id,  date("2020-08-17") as date,  "7" as product_id,  "96" as salesperson_id,  "6" as customer_id,  "9" as office_id,  59 as hours,  116761 as sales,  "Florida" as transaction_state, union all
      select "68" as transaction_id,  date("2021-09-16") as date,  "11" as product_id,  "60" as salesperson_id,  "11" as customer_id,  "1" as office_id,  66 as hours,  80322 as sales,  "Louisiana" as transaction_state, union all
      select "69" as transaction_id,  date("2020-08-23") as date,  "3" as product_id,  "84" as salesperson_id,  "11" as customer_id,  "7" as office_id,  4 as hours,  7616 as sales,  "Pennsylvania" as transaction_state, union all
      select "70" as transaction_id,  date("2020-08-15") as date,  "9" as product_id,  "85" as salesperson_id,  "16" as customer_id,  "8" as office_id,  57 as hours,  107958 as sales,  "California" as transaction_state, union all
      select "71" as transaction_id,  date("2020-06-03") as date,  "5" as product_id,  "45" as salesperson_id,  "20" as customer_id,  "6" as office_id,  11 as hours,  17963 as sales,  "New York" as transaction_state, union all
      select "72" as transaction_id,  date("2020-08-12") as date,  "3" as product_id,  "1" as salesperson_id,  "17" as customer_id,  "10" as office_id,  31 as hours,  59024 as sales,  "New York" as transaction_state, union all
      select "73" as transaction_id,  date("2020-04-10") as date,  "1" as product_id,  "17" as salesperson_id,  "20" as customer_id,  "6" as office_id,  95 as hours,  117610 as sales,  "Texas" as transaction_state, union all
      select "74" as transaction_id,  date("2020-02-08") as date,  "5" as product_id,  "65" as salesperson_id,  "7" as customer_id,  "9" as office_id,  47 as hours,  76751 as sales,  "Alabama" as transaction_state, union all
      select "75" as transaction_id,  date("2021-05-03") as date,  "5" as product_id,  "65" as salesperson_id,  "9" as customer_id,  "1" as office_id,  54 as hours,  88182 as sales,  "New York" as transaction_state, union all
      select "76" as transaction_id,  date("2020-04-29") as date,  "7" as product_id,  "45" as salesperson_id,  "14" as customer_id,  "8" as office_id,  45 as hours,  89055 as sales,  "Illinois" as transaction_state, union all
      select "77" as transaction_id,  date("2020-12-28") as date,  "3" as product_id,  "93" as salesperson_id,  "12" as customer_id,  "3" as office_id,  80 as hours,  152320 as sales,  "Tennessee" as transaction_state, union all
      select "78" as transaction_id,  date("2020-11-17") as date,  "2" as product_id,  "93" as salesperson_id,  "12" as customer_id,  "1" as office_id,  86 as hours,  136138 as sales,  "Virginia" as transaction_state, union all
      select "79" as transaction_id,  date("2020-02-12") as date,  "4" as product_id,  "6" as salesperson_id,  "5" as customer_id,  "2" as office_id,  92 as hours,  159620 as sales,  "Virginia" as transaction_state, union all
      select "80" as transaction_id,  date("2021-09-16") as date,  "9" as product_id,  "71" as salesperson_id,  "1" as customer_id,  "2" as office_id,  4 as hours,  7576 as sales,  "South Carolina" as transaction_state, union all
      select "81" as transaction_id,  date("2021-07-19") as date,  "1" as product_id,  "60" as salesperson_id,  "12" as customer_id,  "1" as office_id,  40 as hours,  49520 as sales,  "Missouri" as transaction_state, union all
      select "82" as transaction_id,  date("2021-06-26") as date,  "5" as product_id,  "8" as salesperson_id,  "12" as customer_id,  "8" as office_id,  52 as hours,  84916 as sales,  "Virginia" as transaction_state, union all
      select "83" as transaction_id,  date("2021-07-09") as date,  "7" as product_id,  "80" as salesperson_id,  "10" as customer_id,  "1" as office_id,  11 as hours,  21769 as sales,  "Kentucky" as transaction_state, union all
      select "84" as transaction_id,  date("2020-08-31") as date,  "11" as product_id,  "38" as salesperson_id,  "3" as customer_id,  "4" as office_id,  11 as hours,  13387 as sales,  "Ohio" as transaction_state, union all
      select "85" as transaction_id,  date("2021-08-31") as date,  "4" as product_id,  "21" as salesperson_id,  "5" as customer_id,  "9" as office_id,  40 as hours,  69400 as sales,  "Florida" as transaction_state, union all
      select "86" as transaction_id,  date("2021-03-21") as date,  "6" as product_id,  "98" as salesperson_id,  "20" as customer_id,  "10" as office_id,  88 as hours,  171424 as sales,  "California" as transaction_state, union all
      select "87" as transaction_id,  date("2020-01-18") as date,  "10" as product_id,  "83" as salesperson_id,  "13" as customer_id,  "5" as office_id,  37 as hours,  55722 as sales,  "Missouri" as transaction_state, union all
      select "88" as transaction_id,  date("2021-10-06") as date,  "11" as product_id,  "89" as salesperson_id,  "16" as customer_id,  "7" as office_id,  76 as hours,  92492 as sales,  "Pennsylvania" as transaction_state, union all
      select "89" as transaction_id,  date("2021-05-08") as date,  "8" as product_id,  "88" as salesperson_id,  "8" as customer_id,  "10" as office_id,  95 as hours,  125875 as sales,  "California" as transaction_state, union all
      select "90" as transaction_id,  date("2021-03-27") as date,  "2" as product_id,  "92" as salesperson_id,  "13" as customer_id,  "10" as office_id,  73 as hours,  115559 as sales,  "Utah" as transaction_state, union all
      select "91" as transaction_id,  date("2020-07-07") as date,  "5" as product_id,  "86" as salesperson_id,  "4" as customer_id,  "7" as office_id,  76 as hours,  124108 as sales,  "Texas" as transaction_state, union all
      select "92" as transaction_id,  date("2020-10-02") as date,  "9" as product_id,  "7" as salesperson_id,  "10" as customer_id,  "10" as office_id,  70 as hours,  132580 as sales,  "Louisiana" as transaction_state, union all
      select "93" as transaction_id,  date("2021-07-10") as date,  "10" as product_id,  "27" as salesperson_id,  "11" as customer_id,  "9" as office_id,  13 as hours,  19578 as sales,  "Texas" as transaction_state, union all
      select "94" as transaction_id,  date("2020-09-19") as date,  "4" as product_id,  "49" as salesperson_id,  "7" as customer_id,  "1" as office_id,  89 as hours,  154415 as sales,  "Ohio" as transaction_state, union all
      select "95" as transaction_id,  date("2020-07-27") as date,  "1" as product_id,  "10" as salesperson_id,  "14" as customer_id,  "8" as office_id,  36 as hours,  44568 as sales,  "Tennessee" as transaction_state, union all
      select "96" as transaction_id,  date("2021-01-09") as date,  "3" as product_id,  "45" as salesperson_id,  "18" as customer_id,  "4" as office_id,  45 as hours,  85680 as sales,  "New York" as transaction_state, union all
      select "97" as transaction_id,  date("2021-05-30") as date,  "5" as product_id,  "42" as salesperson_id,  "1" as customer_id,  "4" as office_id,  45 as hours,  73485 as sales,  "Florida" as transaction_state, union all
      select "98" as transaction_id,  date("2020-11-22") as date,  "7" as product_id,  "66" as salesperson_id,  "16" as customer_id,  "8" as office_id,  22 as hours,  43538 as sales,  "Texas" as transaction_state, union all
      select "99" as transaction_id,  date("2020-05-23") as date,  "8" as product_id,  "71" as salesperson_id,  "12" as customer_id,  "9" as office_id,  46 as hours,  60950 as sales,  "Pennsylvania" as transaction_state, union all
      select "100" as transaction_id,  date("2020-06-22") as date,  "4" as product_id,  "73" as salesperson_id,  "9" as customer_id,  "4" as office_id,  76 as hours,  131860 as sales,  "Ohio" as transaction_state, union all
      select "101" as transaction_id,  date("2021-03-17") as date,  "10" as product_id,  "75" as salesperson_id,  "11" as customer_id,  "5" as office_id,  97 as hours,  146082 as sales,  "Florida" as transaction_state, union all
      select "102" as transaction_id,  date("2020-08-12") as date,  "8" as product_id,  "57" as salesperson_id,  "17" as customer_id,  "4" as office_id,  22 as hours,  29150 as sales,  "District of Columbia" as transaction_state, union all
      select "103" as transaction_id,  date("2020-08-04") as date,  "1" as product_id,  "59" as salesperson_id,  "9" as customer_id,  "4" as office_id,  7 as hours,  8666 as sales,  "Alabama" as transaction_state, union all
      select "104" as transaction_id,  date("2021-09-22") as date,  "9" as product_id,  "29" as salesperson_id,  "5" as customer_id,  "5" as office_id,  77 as hours,  145838 as sales,  "Florida" as transaction_state, union all
      select "105" as transaction_id,  date("2020-08-11") as date,  "8" as product_id,  "52" as salesperson_id,  "7" as customer_id,  "7" as office_id,  84 as hours,  111300 as sales,  "Rhode Island" as transaction_state, union all
      select "106" as transaction_id,  date("2020-07-17") as date,  "5" as product_id,  "96" as salesperson_id,  "12" as customer_id,  "10" as office_id,  59 as hours,  96347 as sales,  "Texas" as transaction_state, union all
      select "107" as transaction_id,  date("2020-03-07") as date,  "1" as product_id,  "91" as salesperson_id,  "14" as customer_id,  "3" as office_id,  30 as hours,  37140 as sales,  "Tennessee" as transaction_state, union all
      select "108" as transaction_id,  date("2020-01-20") as date,  "3" as product_id,  "23" as salesperson_id,  "14" as customer_id,  "10" as office_id,  10 as hours,  19040 as sales,  "South Carolina" as transaction_state, union all
      select "109" as transaction_id,  date("2020-08-01") as date,  "6" as product_id,  "73" as salesperson_id,  "20" as customer_id,  "5" as office_id,  13 as hours,  25324 as sales,  "Washington" as transaction_state, union all
      select "110" as transaction_id,  date("2021-08-21") as date,  "5" as product_id,  "76" as salesperson_id,  "8" as customer_id,  "7" as office_id,  22 as hours,  35926 as sales,  "Connecticut" as transaction_state, union all
      select "111" as transaction_id,  date("2021-07-03") as date,  "1" as product_id,  "44" as salesperson_id,  "8" as customer_id,  "8" as office_id,  45 as hours,  55710 as sales,  "California" as transaction_state, union all
      select "112" as transaction_id,  date("2021-03-21") as date,  "9" as product_id,  "73" as salesperson_id,  "13" as customer_id,  "10" as office_id,  10 as hours,  18940 as sales,  "Colorado" as transaction_state, union all
      select "113" as transaction_id,  date("2020-10-21") as date,  "8" as product_id,  "39" as salesperson_id,  "8" as customer_id,  "1" as office_id,  78 as hours,  103350 as sales,  "Arizona" as transaction_state, union all
      select "114" as transaction_id,  date("2021-09-28") as date,  "10" as product_id,  "59" as salesperson_id,  "7" as customer_id,  "1" as office_id,  91 as hours,  137046 as sales,  "California" as transaction_state, union all
      select "115" as transaction_id,  date("2020-03-25") as date,  "8" as product_id,  "13" as salesperson_id,  "18" as customer_id,  "7" as office_id,  23 as hours,  30475 as sales,  "Florida" as transaction_state, union all
      select "116" as transaction_id,  date("2021-03-02") as date,  "1" as product_id,  "22" as salesperson_id,  "13" as customer_id,  "10" as office_id,  43 as hours,  53234 as sales,  "California" as transaction_state, union all
      select "117" as transaction_id,  date("2021-08-21") as date,  "5" as product_id,  "8" as salesperson_id,  "11" as customer_id,  "10" as office_id,  6 as hours,  9798 as sales,  "Virginia" as transaction_state, union all
      select "118" as transaction_id,  date("2021-09-22") as date,  "10" as product_id,  "61" as salesperson_id,  "7" as customer_id,  "9" as office_id,  71 as hours,  106926 as sales,  "Louisiana" as transaction_state, union all
      select "119" as transaction_id,  date("2021-10-27") as date,  "7" as product_id,  "47" as salesperson_id,  "16" as customer_id,  "8" as office_id,  30 as hours,  59370 as sales,  "Louisiana" as transaction_state, union all
      select "120" as transaction_id,  date("2021-04-30") as date,  "2" as product_id,  "6" as salesperson_id,  "3" as customer_id,  "8" as office_id,  65 as hours,  102895 as sales,  "Ohio" as transaction_state, union all
      select "121" as transaction_id,  date("2020-05-02") as date,  "11" as product_id,  "80" as salesperson_id,  "1" as customer_id,  "9" as office_id,  56 as hours,  68152 as sales,  "Maryland" as transaction_state, union all
      select "122" as transaction_id,  date("2020-07-02") as date,  "7" as product_id,  "64" as salesperson_id,  "8" as customer_id,  "3" as office_id,  89 as hours,  176131 as sales,  "Washington" as transaction_state, union all
      select "123" as transaction_id,  date("2020-06-10") as date,  "6" as product_id,  "43" as salesperson_id,  "11" as customer_id,  "10" as office_id,  53 as hours,  103244 as sales,  "District of Columbia" as transaction_state, union all
      select "124" as transaction_id,  date("2020-07-15") as date,  "2" as product_id,  "55" as salesperson_id,  "1" as customer_id,  "4" as office_id,  75 as hours,  118725 as sales,  "California" as transaction_state, union all
      select "125" as transaction_id,  date("2020-07-06") as date,  "11" as product_id,  "58" as salesperson_id,  "3" as customer_id,  "1" as office_id,  71 as hours,  86407 as sales,  "Massachusetts" as transaction_state, union all
      select "126" as transaction_id,  date("2020-09-12") as date,  "1" as product_id,  "9" as salesperson_id,  "3" as customer_id,  "5" as office_id,  89 as hours,  110182 as sales,  "Kansas" as transaction_state, union all
      select "127" as transaction_id,  date("2020-10-21") as date,  "11" as product_id,  "4" as salesperson_id,  "20" as customer_id,  "4" as office_id,  23 as hours,  27991 as sales,  "Florida" as transaction_state, union all
      select "128" as transaction_id,  date("2021-03-19") as date,  "10" as product_id,  "37" as salesperson_id,  "8" as customer_id,  "7" as office_id,  89 as hours,  134034 as sales,  "Ohio" as transaction_state, union all
      select "129" as transaction_id,  date("2020-10-05") as date,  "1" as product_id,  "47" as salesperson_id,  "7" as customer_id,  "7" as office_id,  88 as hours,  108944 as sales,  "Florida" as transaction_state, union all
      select "130" as transaction_id,  date("2021-05-10") as date,  "10" as product_id,  "28" as salesperson_id,  "2" as customer_id,  "8" as office_id,  92 as hours,  138552 as sales,  "Michigan" as transaction_state, union all
      select "131" as transaction_id,  date("2021-02-12") as date,  "4" as product_id,  "12" as salesperson_id,  "17" as customer_id,  "1" as office_id,  57 as hours,  98895 as sales,  "Indiana" as transaction_state, union all
      select "132" as transaction_id,  date("2020-01-05") as date,  "10" as product_id,  "26" as salesperson_id,  "18" as customer_id,  "6" as office_id,  5 as hours,  7530 as sales,  "New York" as transaction_state, union all
      select "133" as transaction_id,  date("2020-04-15") as date,  "5" as product_id,  "22" as salesperson_id,  "9" as customer_id,  "2" as office_id,  39 as hours,  63687 as sales,  "Texas" as transaction_state, union all
      select "134" as transaction_id,  date("2020-09-27") as date,  "3" as product_id,  "15" as salesperson_id,  "1" as customer_id,  "6" as office_id,  99 as hours,  188496 as sales,  "Pennsylvania" as transaction_state, union all
      select "135" as transaction_id,  date("2020-04-23") as date,  "1" as product_id,  "55" as salesperson_id,  "3" as customer_id,  "7" as office_id,  62 as hours,  76756 as sales,  "Florida" as transaction_state, union all
      select "136" as transaction_id,  date("2020-09-30") as date,  "5" as product_id,  "81" as salesperson_id,  "15" as customer_id,  "4" as office_id,  67 as hours,  109411 as sales,  "California" as transaction_state, union all
      select "137" as transaction_id,  date("2021-05-30") as date,  "4" as product_id,  "30" as salesperson_id,  "6" as customer_id,  "10" as office_id,  85 as hours,  147475 as sales,  "California" as transaction_state, union all
      select "138" as transaction_id,  date("2020-08-26") as date,  "9" as product_id,  "45" as salesperson_id,  "3" as customer_id,  "1" as office_id,  10 as hours,  18940 as sales,  "New York" as transaction_state, union all
      select "139" as transaction_id,  date("2020-12-26") as date,  "2" as product_id,  "39" as salesperson_id,  "7" as customer_id,  "4" as office_id,  17 as hours,  26911 as sales,  "California" as transaction_state, union all
      select "140" as transaction_id,  date("2021-06-27") as date,  "4" as product_id,  "68" as salesperson_id,  "3" as customer_id,  "9" as office_id,  80 as hours,  138800 as sales,  "Georgia" as transaction_state, union all
      select "141" as transaction_id,  date("2021-10-23") as date,  "9" as product_id,  "88" as salesperson_id,  "18" as customer_id,  "8" as office_id,  98 as hours,  185612 as sales,  "Utah" as transaction_state, union all
      select "142" as transaction_id,  date("2021-07-30") as date,  "1" as product_id,  "22" as salesperson_id,  "15" as customer_id,  "1" as office_id,  51 as hours,  63138 as sales,  "California" as transaction_state, union all
      select "143" as transaction_id,  date("2020-01-27") as date,  "11" as product_id,  "82" as salesperson_id,  "9" as customer_id,  "1" as office_id,  40 as hours,  48680 as sales,  "Alabama" as transaction_state, union all
      select "144" as transaction_id,  date("2021-10-26") as date,  "5" as product_id,  "60" as salesperson_id,  "10" as customer_id,  "4" as office_id,  14 as hours,  22862 as sales,  "Oregon" as transaction_state, union all
      select "145" as transaction_id,  date("2020-05-02") as date,  "3" as product_id,  "30" as salesperson_id,  "13" as customer_id,  "8" as office_id,  36 as hours,  68544 as sales,  "Florida" as transaction_state, union all
      select "146" as transaction_id,  date("2021-08-28") as date,  "2" as product_id,  "61" as salesperson_id,  "6" as customer_id,  "2" as office_id,  4 as hours,  6332 as sales,  "Texas" as transaction_state, union all
      select "147" as transaction_id,  date("2020-11-18") as date,  "1" as product_id,  "14" as salesperson_id,  "18" as customer_id,  "5" as office_id,  80 as hours,  99040 as sales,  "Illinois" as transaction_state, union all
      select "148" as transaction_id,  date("2020-05-19") as date,  "6" as product_id,  "54" as salesperson_id,  "15" as customer_id,  "3" as office_id,  73 as hours,  142204 as sales,  "New York" as transaction_state, union all
      select "149" as transaction_id,  date("2020-01-26") as date,  "5" as product_id,  "16" as salesperson_id,  "16" as customer_id,  "1" as office_id,  10 as hours,  16330 as sales,  "Nevada" as transaction_state, union all
      select "150" as transaction_id,  date("2020-05-03") as date,  "6" as product_id,  "41" as salesperson_id,  "15" as customer_id,  "8" as office_id,  45 as hours,  87660 as sales,  "New York" as transaction_state, union all
      select "151" as transaction_id,  date("2020-02-26") as date,  "11" as product_id,  "83" as salesperson_id,  "13" as customer_id,  "9" as office_id,  44 as hours,  53548 as sales,  "New York" as transaction_state, union all
      select "152" as transaction_id,  date("2020-03-10") as date,  "7" as product_id,  "57" as salesperson_id,  "8" as customer_id,  "2" as office_id,  23 as hours,  45517 as sales,  "Georgia" as transaction_state, union all
      select "153" as transaction_id,  date("2021-09-16") as date,  "6" as product_id,  "43" as salesperson_id,  "8" as customer_id,  "7" as office_id,  54 as hours,  105192 as sales,  "New Hampshire" as transaction_state, union all
      select "154" as transaction_id,  date("2020-11-27") as date,  "1" as product_id,  "71" as salesperson_id,  "11" as customer_id,  "9" as office_id,  74 as hours,  91612 as sales,  "Georgia" as transaction_state, union all
      select "155" as transaction_id,  date("2021-10-06") as date,  "9" as product_id,  "73" as salesperson_id,  "6" as customer_id,  "3" as office_id,  58 as hours,  109852 as sales,  "California" as transaction_state, union all
      select "156" as transaction_id,  date("2020-03-27") as date,  "4" as product_id,  "31" as salesperson_id,  "1" as customer_id,  "7" as office_id,  42 as hours,  72870 as sales,  "North Dakota" as transaction_state, union all
      select "157" as transaction_id,  date("2021-09-15") as date,  "2" as product_id,  "45" as salesperson_id,  "16" as customer_id,  "3" as office_id,  79 as hours,  125057 as sales,  "Florida" as transaction_state, union all
      select "158" as transaction_id,  date("2020-05-23") as date,  "6" as product_id,  "93" as salesperson_id,  "17" as customer_id,  "6" as office_id,  21 as hours,  40908 as sales,  "Florida" as transaction_state, union all
      select "159" as transaction_id,  date("2020-05-25") as date,  "11" as product_id,  "51" as salesperson_id,  "20" as customer_id,  "6" as office_id,  25 as hours,  30425 as sales,  "California" as transaction_state, union all
      select "160" as transaction_id,  date("2021-01-07") as date,  "3" as product_id,  "79" as salesperson_id,  "4" as customer_id,  "8" as office_id,  60 as hours,  114240 as sales,  "California" as transaction_state, union all
      select "161" as transaction_id,  date("2021-08-17") as date,  "4" as product_id,  "19" as salesperson_id,  "5" as customer_id,  "2" as office_id,  76 as hours,  131860 as sales,  "Maryland" as transaction_state, union all
      select "162" as transaction_id,  date("2020-04-18") as date,  "11" as product_id,  "60" as salesperson_id,  "14" as customer_id,  "7" as office_id,  22 as hours,  26774 as sales,  "Texas" as transaction_state, union all
      select "163" as transaction_id,  date("2021-03-18") as date,  "6" as product_id,  "94" as salesperson_id,  "1" as customer_id,  "9" as office_id,  60 as hours,  116880 as sales,  "New York" as transaction_state, union all
      select "164" as transaction_id,  date("2020-06-18") as date,  "3" as product_id,  "10" as salesperson_id,  "14" as customer_id,  "10" as office_id,  70 as hours,  133280 as sales,  "Virginia" as transaction_state, union all
      select "165" as transaction_id,  date("2021-07-21") as date,  "10" as product_id,  "100" as salesperson_id,  "17" as customer_id,  "6" as office_id,  70 as hours,  105420 as sales,  "Oklahoma" as transaction_state, union all
      select "166" as transaction_id,  date("2020-06-06") as date,  "10" as product_id,  "81" as salesperson_id,  "4" as customer_id,  "10" as office_id,  34 as hours,  51204 as sales,  "Nebraska" as transaction_state, union all
      select "167" as transaction_id,  date("2020-10-17") as date,  "1" as product_id,  "59" as salesperson_id,  "15" as customer_id,  "8" as office_id,  74 as hours,  91612 as sales,  "Missouri" as transaction_state, union all
      select "168" as transaction_id,  date("2020-04-18") as date,  "7" as product_id,  "21" as salesperson_id,  "14" as customer_id,  "10" as office_id,  53 as hours,  104887 as sales,  "Idaho" as transaction_state, union all
      select "169" as transaction_id,  date("2021-09-26") as date,  "4" as product_id,  "53" as salesperson_id,  "1" as customer_id,  "4" as office_id,  84 as hours,  145740 as sales,  "Texas" as transaction_state, union all
      select "170" as transaction_id,  date("2020-12-13") as date,  "10" as product_id,  "68" as salesperson_id,  "7" as customer_id,  "3" as office_id,  64 as hours,  96384 as sales,  "California" as transaction_state, union all
      select "171" as transaction_id,  date("2020-07-11") as date,  "9" as product_id,  "44" as salesperson_id,  "6" as customer_id,  "4" as office_id,  64 as hours,  121216 as sales,  "Oklahoma" as transaction_state, union all
      select "172" as transaction_id,  date("2020-09-26") as date,  "9" as product_id,  "22" as salesperson_id,  "1" as customer_id,  "5" as office_id,  21 as hours,  39774 as sales,  "District of Columbia" as transaction_state, union all
      select "173" as transaction_id,  date("2021-03-09") as date,  "2" as product_id,  "26" as salesperson_id,  "5" as customer_id,  "3" as office_id,  97 as hours,  153551 as sales,  "West Virginia" as transaction_state, union all
      select "174" as transaction_id,  date("2021-02-26") as date,  "10" as product_id,  "62" as salesperson_id,  "2" as customer_id,  "5" as office_id,  95 as hours,  143070 as sales,  "Virginia" as transaction_state, union all
      select "175" as transaction_id,  date("2021-10-23") as date,  "7" as product_id,  "37" as salesperson_id,  "4" as customer_id,  "9" as office_id,  13 as hours,  25727 as sales,  "Virginia" as transaction_state, union all
      select "176" as transaction_id,  date("2020-11-03") as date,  "2" as product_id,  "30" as salesperson_id,  "4" as customer_id,  "7" as office_id,  88 as hours,  139304 as sales,  "South Dakota" as transaction_state, union all
      select "177" as transaction_id,  date("2021-04-09") as date,  "10" as product_id,  "58" as salesperson_id,  "6" as customer_id,  "6" as office_id,  94 as hours,  141564 as sales,  "Missouri" as transaction_state, union all
      select "178" as transaction_id,  date("2020-05-24") as date,  "11" as product_id,  "60" as salesperson_id,  "6" as customer_id,  "10" as office_id,  29 as hours,  35293 as sales,  "Missouri" as transaction_state, union all
      select "179" as transaction_id,  date("2021-05-28") as date,  "11" as product_id,  "59" as salesperson_id,  "3" as customer_id,  "1" as office_id,  82 as hours,  99794 as sales,  "Iowa" as transaction_state, union all
      select "180" as transaction_id,  date("2021-04-14") as date,  "11" as product_id,  "10" as salesperson_id,  "11" as customer_id,  "4" as office_id,  46 as hours,  55982 as sales,  "Pennsylvania" as transaction_state, union all
      select "181" as transaction_id,  date("2021-03-05") as date,  "9" as product_id,  "75" as salesperson_id,  "3" as customer_id,  "8" as office_id,  43 as hours,  81442 as sales,  "Texas" as transaction_state, union all
      select "182" as transaction_id,  date("2020-08-06") as date,  "5" as product_id,  "21" as salesperson_id,  "9" as customer_id,  "4" as office_id,  37 as hours,  60421 as sales,  "Pennsylvania" as transaction_state, union all
      select "183" as transaction_id,  date("2021-01-14") as date,  "10" as product_id,  "92" as salesperson_id,  "17" as customer_id,  "5" as office_id,  14 as hours,  21084 as sales,  "Texas" as transaction_state, union all
      select "184" as transaction_id,  date("2021-10-23") as date,  "7" as product_id,  "97" as salesperson_id,  "13" as customer_id,  "5" as office_id,  28 as hours,  55412 as sales,  "Washington" as transaction_state, union all
      select "185" as transaction_id,  date("2021-09-28") as date,  "7" as product_id,  "58" as salesperson_id,  "18" as customer_id,  "10" as office_id,  96 as hours,  189984 as sales,  "Virginia" as transaction_state, union all
      select "186" as transaction_id,  date("2021-03-02") as date,  "10" as product_id,  "90" as salesperson_id,  "5" as customer_id,  "5" as office_id,  15 as hours,  22590 as sales,  "Texas" as transaction_state, union all
      select "187" as transaction_id,  date("2020-04-23") as date,  "6" as product_id,  "92" as salesperson_id,  "6" as customer_id,  "2" as office_id,  7 as hours,  13636 as sales,  "Illinois" as transaction_state, union all
      select "188" as transaction_id,  date("2020-10-02") as date,  "11" as product_id,  "28" as salesperson_id,  "5" as customer_id,  "3" as office_id,  12 as hours,  14604 as sales,  "Georgia" as transaction_state, union all
      select "189" as transaction_id,  date("2020-09-05") as date,  "8" as product_id,  "84" as salesperson_id,  "14" as customer_id,  "3" as office_id,  60 as hours,  79500 as sales,  "Pennsylvania" as transaction_state, union all
      select "190" as transaction_id,  date("2020-06-02") as date,  "2" as product_id,  "89" as salesperson_id,  "15" as customer_id,  "7" as office_id,  46 as hours,  72818 as sales,  "Utah" as transaction_state, union all
      select "191" as transaction_id,  date("2021-09-19") as date,  "8" as product_id,  "2" as salesperson_id,  "8" as customer_id,  "6" as office_id,  2 as hours,  2650 as sales,  "Minnesota" as transaction_state, union all
      select "192" as transaction_id,  date("2021-10-23") as date,  "4" as product_id,  "27" as salesperson_id,  "7" as customer_id,  "9" as office_id,  72 as hours,  124920 as sales,  "Alabama" as transaction_state, union all
      select "193" as transaction_id,  date("2021-02-23") as date,  "9" as product_id,  "62" as salesperson_id,  "4" as customer_id,  "5" as office_id,  49 as hours,  92806 as sales,  "Florida" as transaction_state, union all
      select "194" as transaction_id,  date("2020-01-21") as date,  "11" as product_id,  "54" as salesperson_id,  "12" as customer_id,  "9" as office_id,  40 as hours,  48680 as sales,  "Florida" as transaction_state, union all
      select "195" as transaction_id,  date("2021-06-27") as date,  "7" as product_id,  "51" as salesperson_id,  "6" as customer_id,  "2" as office_id,  99 as hours,  195921 as sales,  "Colorado" as transaction_state, union all
      select "196" as transaction_id,  date("2020-01-09") as date,  "8" as product_id,  "95" as salesperson_id,  "17" as customer_id,  "6" as office_id,  53 as hours,  70225 as sales,  "Ohio" as transaction_state, union all
      select "197" as transaction_id,  date("2020-06-01") as date,  "9" as product_id,  "48" as salesperson_id,  "7" as customer_id,  "8" as office_id,  57 as hours,  107958 as sales,  "Missouri" as transaction_state, union all
      select "198" as transaction_id,  date("2021-06-29") as date,  "11" as product_id,  "6" as salesperson_id,  "14" as customer_id,  "5" as office_id,  49 as hours,  59633 as sales,  "Kentucky" as transaction_state, union all
      select "199" as transaction_id,  date("2020-02-29") as date,  "4" as product_id,  "85" as salesperson_id,  "7" as customer_id,  "2" as office_id,  49 as hours,  85015 as sales,  "Ohio" as transaction_state, union all
      select "200" as transaction_id,  date("2020-11-13") as date,  "9" as product_id,  "3" as salesperson_id,  "15" as customer_id,  "5" as office_id,  22 as hours,  41668 as sales,  "Virginia" as transaction_state, union all
      select "201" as transaction_id,  date("2021-03-24") as date,  "11" as product_id,  "49" as salesperson_id,  "14" as customer_id,  "7" as office_id,  47 as hours,  57199 as sales,  "Wisconsin" as transaction_state, union all
      select "202" as transaction_id,  date("2020-11-23") as date,  "1" as product_id,  "51" as salesperson_id,  "9" as customer_id,  "1" as office_id,  42 as hours,  51996 as sales,  "Florida" as transaction_state, union all
      select "203" as transaction_id,  date("2021-10-31") as date,  "5" as product_id,  "89" as salesperson_id,  "15" as customer_id,  "7" as office_id,  48 as hours,  78384 as sales,  "Ohio" as transaction_state, union all
      select "204" as transaction_id,  date("2020-11-28") as date,  "4" as product_id,  "76" as salesperson_id,  "19" as customer_id,  "8" as office_id,  20 as hours,  34700 as sales,  "North Carolina" as transaction_state, union all
      select "205" as transaction_id,  date("2020-10-11") as date,  "11" as product_id,  "5" as salesperson_id,  "15" as customer_id,  "6" as office_id,  90 as hours,  109530 as sales,  "Ohio" as transaction_state, union all
      select "206" as transaction_id,  date("2021-04-03") as date,  "9" as product_id,  "44" as salesperson_id,  "8" as customer_id,  "4" as office_id,  58 as hours,  109852 as sales,  "Texas" as transaction_state, union all
      select "207" as transaction_id,  date("2020-12-10") as date,  "11" as product_id,  "90" as salesperson_id,  "19" as customer_id,  "6" as office_id,  67 as hours,  81539 as sales,  "Texas" as transaction_state, union all
      select "208" as transaction_id,  date("2021-09-06") as date,  "4" as product_id,  "47" as salesperson_id,  "1" as customer_id,  "6" as office_id,  68 as hours,  117980 as sales,  "Tennessee" as transaction_state, union all
      select "209" as transaction_id,  date("2020-04-28") as date,  "9" as product_id,  "83" as salesperson_id,  "2" as customer_id,  "1" as office_id,  93 as hours,  176142 as sales,  "Colorado" as transaction_state, union all
      select "210" as transaction_id,  date("2020-11-04") as date,  "2" as product_id,  "15" as salesperson_id,  "10" as customer_id,  "6" as office_id,  39 as hours,  61737 as sales,  "North Carolina" as transaction_state, union all
      select "211" as transaction_id,  date("2021-02-09") as date,  "9" as product_id,  "55" as salesperson_id,  "7" as customer_id,  "2" as office_id,  66 as hours,  125004 as sales,  "California" as transaction_state, union all
      select "212" as transaction_id,  date("2021-05-23") as date,  "3" as product_id,  "71" as salesperson_id,  "16" as customer_id,  "4" as office_id,  59 as hours,  112336 as sales,  "Missouri" as transaction_state, union all
      select "213" as transaction_id,  date("2020-03-28") as date,  "2" as product_id,  "55" as salesperson_id,  "4" as customer_id,  "10" as office_id,  7 as hours,  11081 as sales,  "Iowa" as transaction_state, union all
      select "214" as transaction_id,  date("2021-09-04") as date,  "3" as product_id,  "50" as salesperson_id,  "3" as customer_id,  "7" as office_id,  19 as hours,  36176 as sales,  "North Dakota" as transaction_state, union all
      select "215" as transaction_id,  date("2020-02-28") as date,  "9" as product_id,  "53" as salesperson_id,  "17" as customer_id,  "8" as office_id,  13 as hours,  24622 as sales,  "Texas" as transaction_state, union all
      select "216" as transaction_id,  date("2021-01-15") as date,  "1" as product_id,  "69" as salesperson_id,  "11" as customer_id,  "1" as office_id,  55 as hours,  68090 as sales,  "Idaho" as transaction_state, union all
      select "217" as transaction_id,  date("2021-09-24") as date,  "5" as product_id,  "35" as salesperson_id,  "5" as customer_id,  "4" as office_id,  62 as hours,  101246 as sales,  "Pennsylvania" as transaction_state, union all
      select "218" as transaction_id,  date("2021-04-30") as date,  "6" as product_id,  "32" as salesperson_id,  "8" as customer_id,  "10" as office_id,  28 as hours,  54544 as sales,  "Nevada" as transaction_state, union all
      select "219" as transaction_id,  date("2020-10-31") as date,  "8" as product_id,  "54" as salesperson_id,  "11" as customer_id,  "5" as office_id,  65 as hours,  86125 as sales,  "New York" as transaction_state, union all
      select "220" as transaction_id,  date("2020-02-24") as date,  "11" as product_id,  "67" as salesperson_id,  "16" as customer_id,  "10" as office_id,  67 as hours,  81539 as sales,  "California" as transaction_state, union all
      select "221" as transaction_id,  date("2020-09-08") as date,  "7" as product_id,  "92" as salesperson_id,  "18" as customer_id,  "9" as office_id,  74 as hours,  146446 as sales,  "Ohio" as transaction_state, union all
      select "222" as transaction_id,  date("2021-07-08") as date,  "3" as product_id,  "82" as salesperson_id,  "12" as customer_id,  "2" as office_id,  51 as hours,  97104 as sales,  "New York" as transaction_state, union all
      select "223" as transaction_id,  date("2020-10-14") as date,  "10" as product_id,  "2" as salesperson_id,  "6" as customer_id,  "2" as office_id,  17 as hours,  25602 as sales,  "Texas" as transaction_state, union all
      select "224" as transaction_id,  date("2021-07-22") as date,  "4" as product_id,  "87" as salesperson_id,  "20" as customer_id,  "10" as office_id,  38 as hours,  65930 as sales,  "Tennessee" as transaction_state, union all
      select "225" as transaction_id,  date("2021-06-29") as date,  "1" as product_id,  "53" as salesperson_id,  "3" as customer_id,  "9" as office_id,  57 as hours,  70566 as sales,  "Florida" as transaction_state, union all
      select "226" as transaction_id,  date("2020-05-02") as date,  "9" as product_id,  "58" as salesperson_id,  "9" as customer_id,  "2" as office_id,  45 as hours,  85230 as sales,  "Colorado" as transaction_state, union all
      select "227" as transaction_id,  date("2021-08-03") as date,  "8" as product_id,  "98" as salesperson_id,  "5" as customer_id,  "5" as office_id,  37 as hours,  49025 as sales,  "Mississippi" as transaction_state, union all
      select "228" as transaction_id,  date("2021-05-27") as date,  "11" as product_id,  "70" as salesperson_id,  "15" as customer_id,  "1" as office_id,  33 as hours,  40161 as sales,  "Texas" as transaction_state, union all
      select "229" as transaction_id,  date("2020-12-04") as date,  "3" as product_id,  "49" as salesperson_id,  "8" as customer_id,  "9" as office_id,  66 as hours,  125664 as sales,  "Arizona" as transaction_state, union all
      select "230" as transaction_id,  date("2021-08-04") as date,  "8" as product_id,  "27" as salesperson_id,  "1" as customer_id,  "8" as office_id,  60 as hours,  79500 as sales,  "District of Columbia" as transaction_state, union all
      select "231" as transaction_id,  date("2021-08-12") as date,  "1" as product_id,  "97" as salesperson_id,  "20" as customer_id,  "6" as office_id,  94 as hours,  116372 as sales,  "Texas" as transaction_state, union all
      select "232" as transaction_id,  date("2020-08-30") as date,  "4" as product_id,  "80" as salesperson_id,  "15" as customer_id,  "8" as office_id,  94 as hours,  163090 as sales,  "Mississippi" as transaction_state, union all
      select "233" as transaction_id,  date("2020-10-30") as date,  "10" as product_id,  "54" as salesperson_id,  "13" as customer_id,  "7" as office_id,  60 as hours,  90360 as sales,  "Florida" as transaction_state, union all
      select "234" as transaction_id,  date("2020-09-23") as date,  "2" as product_id,  "85" as salesperson_id,  "2" as customer_id,  "3" as office_id,  53 as hours,  83899 as sales,  "California" as transaction_state, union all
      select "235" as transaction_id,  date("2021-03-18") as date,  "11" as product_id,  "80" as salesperson_id,  "3" as customer_id,  "8" as office_id,  40 as hours,  48680 as sales,  "Illinois" as transaction_state, union all
      select "236" as transaction_id,  date("2020-09-16") as date,  "4" as product_id,  "70" as salesperson_id,  "14" as customer_id,  "3" as office_id,  37 as hours,  64195 as sales,  "Connecticut" as transaction_state, union all
      select "237" as transaction_id,  date("2020-05-25") as date,  "7" as product_id,  "100" as salesperson_id,  "9" as customer_id,  "3" as office_id,  80 as hours,  158320 as sales,  "Wisconsin" as transaction_state, union all
      select "238" as transaction_id,  date("2020-04-19") as date,  "10" as product_id,  "87" as salesperson_id,  "3" as customer_id,  "7" as office_id,  76 as hours,  114456 as sales,  "Illinois" as transaction_state, union all
      select "239" as transaction_id,  date("2020-07-19") as date,  "8" as product_id,  "2" as salesperson_id,  "3" as customer_id,  "3" as office_id,  54 as hours,  71550 as sales,  "Florida" as transaction_state, union all
      select "240" as transaction_id,  date("2021-03-31") as date,  "2" as product_id,  "7" as salesperson_id,  "8" as customer_id,  "10" as office_id,  31 as hours,  49073 as sales,  "Virginia" as transaction_state, union all
      select "241" as transaction_id,  date("2020-12-28") as date,  "9" as product_id,  "49" as salesperson_id,  "4" as customer_id,  "10" as office_id,  13 as hours,  24622 as sales,  "District of Columbia" as transaction_state, union all
      select "242" as transaction_id,  date("2020-04-30") as date,  "7" as product_id,  "70" as salesperson_id,  "9" as customer_id,  "8" as office_id,  57 as hours,  112803 as sales,  "California" as transaction_state, union all
      select "243" as transaction_id,  date("2021-02-19") as date,  "10" as product_id,  "15" as salesperson_id,  "1" as customer_id,  "6" as office_id,  76 as hours,  114456 as sales,  "New York" as transaction_state, union all
      select "244" as transaction_id,  date("2021-03-29") as date,  "11" as product_id,  "70" as salesperson_id,  "14" as customer_id,  "9" as office_id,  70 as hours,  85190 as sales,  "California" as transaction_state, union all
      select "245" as transaction_id,  date("2020-02-25") as date,  "8" as product_id,  "29" as salesperson_id,  "4" as customer_id,  "7" as office_id,  40 as hours,  53000 as sales,  "California" as transaction_state, union all
      select "246" as transaction_id,  date("2021-09-28") as date,  "7" as product_id,  "73" as salesperson_id,  "1" as customer_id,  "7" as office_id,  90 as hours,  178110 as sales,  "California" as transaction_state, union all
      select "247" as transaction_id,  date("2021-01-15") as date,  "11" as product_id,  "90" as salesperson_id,  "17" as customer_id,  "6" as office_id,  15 as hours,  18255 as sales,  "New York" as transaction_state, union all
      select "248" as transaction_id,  date("2021-02-24") as date,  "6" as product_id,  "63" as salesperson_id,  "4" as customer_id,  "2" as office_id,  40 as hours,  77920 as sales,  "Florida" as transaction_state, union all
      select "249" as transaction_id,  date("2020-08-11") as date,  "4" as product_id,  "45" as salesperson_id,  "16" as customer_id,  "7" as office_id,  78 as hours,  135330 as sales,  "Massachusetts" as transaction_state, union all
      select "250" as transaction_id,  date("2020-12-04") as date,  "7" as product_id,  "18" as salesperson_id,  "18" as customer_id,  "4" as office_id,  76 as hours,  150404 as sales,  "New York" as transaction_state, union all
      select "251" as transaction_id,  date("2021-01-13") as date,  "6" as product_id,  "43" as salesperson_id,  "8" as customer_id,  "5" as office_id,  71 as hours,  138308 as sales,  "Oklahoma" as transaction_state, union all
      select "252" as transaction_id,  date("2020-04-06") as date,  "9" as product_id,  "37" as salesperson_id,  "4" as customer_id,  "10" as office_id,  11 as hours,  20834 as sales,  "Pennsylvania" as transaction_state, union all
      select "253" as transaction_id,  date("2021-09-26") as date,  "6" as product_id,  "34" as salesperson_id,  "8" as customer_id,  "4" as office_id,  28 as hours,  54544 as sales,  "Alabama" as transaction_state, union all
      select "254" as transaction_id,  date("2021-03-21") as date,  "1" as product_id,  "28" as salesperson_id,  "18" as customer_id,  "1" as office_id,  56 as hours,  69328 as sales,  "Texas" as transaction_state, union all
      select "255" as transaction_id,  date("2021-10-15") as date,  "10" as product_id,  "24" as salesperson_id,  "2" as customer_id,  "1" as office_id,  62 as hours,  93372 as sales,  "District of Columbia" as transaction_state, union all
      select "256" as transaction_id,  date("2021-01-10") as date,  "9" as product_id,  "15" as salesperson_id,  "16" as customer_id,  "7" as office_id,  41 as hours,  77654 as sales,  "Florida" as transaction_state, union all
      select "257" as transaction_id,  date("2020-11-20") as date,  "11" as product_id,  "90" as salesperson_id,  "18" as customer_id,  "7" as office_id,  66 as hours,  80322 as sales,  "Kentucky" as transaction_state, union all
      select "258" as transaction_id,  date("2020-05-13") as date,  "1" as product_id,  "84" as salesperson_id,  "5" as customer_id,  "10" as office_id,  18 as hours,  22284 as sales,  "Pennsylvania" as transaction_state, union all
      select "259" as transaction_id,  date("2020-09-17") as date,  "3" as product_id,  "49" as salesperson_id,  "9" as customer_id,  "9" as office_id,  85 as hours,  161840 as sales,  "Florida" as transaction_state, union all
      select "260" as transaction_id,  date("2021-02-14") as date,  "7" as product_id,  "73" as salesperson_id,  "4" as customer_id,  "6" as office_id,  3 as hours,  5937 as sales,  "Wisconsin" as transaction_state, union all
      select "261" as transaction_id,  date("2021-07-08") as date,  "8" as product_id,  "29" as salesperson_id,  "6" as customer_id,  "6" as office_id,  16 as hours,  21200 as sales,  "Oklahoma" as transaction_state, union all
      select "262" as transaction_id,  date("2021-02-08") as date,  "9" as product_id,  "100" as salesperson_id,  "10" as customer_id,  "10" as office_id,  74 as hours,  140156 as sales,  "New York" as transaction_state, union all
      select "263" as transaction_id,  date("2020-07-05") as date,  "9" as product_id,  "86" as salesperson_id,  "10" as customer_id,  "2" as office_id,  80 as hours,  151520 as sales,  "Alabama" as transaction_state, union all
      select "264" as transaction_id,  date("2020-02-23") as date,  "2" as product_id,  "50" as salesperson_id,  "19" as customer_id,  "3" as office_id,  88 as hours,  139304 as sales,  "California" as transaction_state, union all
      select "265" as transaction_id,  date("2021-06-03") as date,  "8" as product_id,  "23" as salesperson_id,  "5" as customer_id,  "4" as office_id,  26 as hours,  34450 as sales,  "New York" as transaction_state, union all
      select "266" as transaction_id,  date("2021-01-29") as date,  "1" as product_id,  "97" as salesperson_id,  "4" as customer_id,  "1" as office_id,  1 as hours,  1238 as sales,  "North Carolina" as transaction_state, union all
      select "267" as transaction_id,  date("2020-07-21") as date,  "5" as product_id,  "53" as salesperson_id,  "7" as customer_id,  "6" as office_id,  94 as hours,  153502 as sales,  "South Carolina" as transaction_state, union all
      select "268" as transaction_id,  date("2021-05-18") as date,  "8" as product_id,  "85" as salesperson_id,  "9" as customer_id,  "10" as office_id,  84 as hours,  111300 as sales,  "Nevada" as transaction_state, union all
      select "269" as transaction_id,  date("2020-05-09") as date,  "2" as product_id,  "90" as salesperson_id,  "9" as customer_id,  "9" as office_id,  70 as hours,  110810 as sales,  "Missouri" as transaction_state, union all
      select "270" as transaction_id,  date("2020-10-17") as date,  "8" as product_id,  "13" as salesperson_id,  "11" as customer_id,  "9" as office_id,  82 as hours,  108650 as sales,  "Texas" as transaction_state, union all
      select "271" as transaction_id,  date("2021-03-27") as date,  "5" as product_id,  "66" as salesperson_id,  "5" as customer_id,  "8" as office_id,  96 as hours,  156768 as sales,  "Georgia" as transaction_state, union all
      select "272" as transaction_id,  date("2020-09-08") as date,  "6" as product_id,  "16" as salesperson_id,  "3" as customer_id,  "7" as office_id,  52 as hours,  101296 as sales,  "Washington" as transaction_state, union all
      select "273" as transaction_id,  date("2020-11-23") as date,  "4" as product_id,  "18" as salesperson_id,  "14" as customer_id,  "7" as office_id,  85 as hours,  147475 as sales,  "Oklahoma" as transaction_state, union all
      select "274" as transaction_id,  date("2021-06-23") as date,  "5" as product_id,  "56" as salesperson_id,  "18" as customer_id,  "5" as office_id,  14 as hours,  22862 as sales,  "Mississippi" as transaction_state, union all
      select "275" as transaction_id,  date("2021-07-07") as date,  "9" as product_id,  "68" as salesperson_id,  "20" as customer_id,  "1" as office_id,  64 as hours,  121216 as sales,  "Nebraska" as transaction_state, union all
      select "276" as transaction_id,  date("2021-06-13") as date,  "5" as product_id,  "25" as salesperson_id,  "20" as customer_id,  "6" as office_id,  96 as hours,  156768 as sales,  "Ohio" as transaction_state, union all
      select "277" as transaction_id,  date("2020-01-23") as date,  "2" as product_id,  "14" as salesperson_id,  "20" as customer_id,  "10" as office_id,  49 as hours,  77567 as sales,  "Indiana" as transaction_state, union all
      select "278" as transaction_id,  date("2021-07-24") as date,  "1" as product_id,  "72" as salesperson_id,  "1" as customer_id,  "1" as office_id,  35 as hours,  43330 as sales,  "New York" as transaction_state, union all
      select "279" as transaction_id,  date("2021-06-02") as date,  "11" as product_id,  "79" as salesperson_id,  "20" as customer_id,  "8" as office_id,  24 as hours,  29208 as sales,  "Florida" as transaction_state, union all
      select "280" as transaction_id,  date("2021-04-28") as date,  "1" as product_id,  "26" as salesperson_id,  "6" as customer_id,  "5" as office_id,  68 as hours,  84184 as sales,  "California" as transaction_state, union all
      select "281" as transaction_id,  date("2021-08-15") as date,  "7" as product_id,  "10" as salesperson_id,  "13" as customer_id,  "1" as office_id,  11 as hours,  21769 as sales,  "Ohio" as transaction_state, union all
      select "282" as transaction_id,  date("2021-10-02") as date,  "6" as product_id,  "35" as salesperson_id,  "16" as customer_id,  "2" as office_id,  46 as hours,  89608 as sales,  "Texas" as transaction_state, union all
      select "283" as transaction_id,  date("2021-09-16") as date,  "8" as product_id,  "69" as salesperson_id,  "3" as customer_id,  "6" as office_id,  94 as hours,  124550 as sales,  "California" as transaction_state, union all
      select "284" as transaction_id,  date("2020-04-14") as date,  "7" as product_id,  "99" as salesperson_id,  "5" as customer_id,  "8" as office_id,  13 as hours,  25727 as sales,  "Michigan" as transaction_state, union all
      select "285" as transaction_id,  date("2021-10-10") as date,  "4" as product_id,  "77" as salesperson_id,  "18" as customer_id,  "4" as office_id,  68 as hours,  117980 as sales,  "Texas" as transaction_state, union all
      select "286" as transaction_id,  date("2020-07-24") as date,  "1" as product_id,  "56" as salesperson_id,  "8" as customer_id,  "10" as office_id,  54 as hours,  66852 as sales,  "Texas" as transaction_state, union all
      select "287" as transaction_id,  date("2020-02-21") as date,  "10" as product_id,  "31" as salesperson_id,  "10" as customer_id,  "7" as office_id,  18 as hours,  27108 as sales,  "Massachusetts" as transaction_state, union all
      select "288" as transaction_id,  date("2020-08-27") as date,  "6" as product_id,  "58" as salesperson_id,  "7" as customer_id,  "7" as office_id,  12 as hours,  23376 as sales,  "Massachusetts" as transaction_state, union all
      select "289" as transaction_id,  date("2021-06-02") as date,  "11" as product_id,  "52" as salesperson_id,  "17" as customer_id,  "5" as office_id,  79 as hours,  96143 as sales,  "Iowa" as transaction_state, union all
      select "290" as transaction_id,  date("2021-03-15") as date,  "10" as product_id,  "70" as salesperson_id,  "14" as customer_id,  "6" as office_id,  52 as hours,  78312 as sales,  "Ohio" as transaction_state, union all
      select "291" as transaction_id,  date("2021-10-26") as date,  "10" as product_id,  "50" as salesperson_id,  "12" as customer_id,  "1" as office_id,  71 as hours,  106926 as sales,  "Missouri" as transaction_state, union all
      select "292" as transaction_id,  date("2021-08-02") as date,  "3" as product_id,  "43" as salesperson_id,  "19" as customer_id,  "6" as office_id,  22 as hours,  41888 as sales,  "New York" as transaction_state, union all
      select "293" as transaction_id,  date("2021-06-01") as date,  "8" as product_id,  "71" as salesperson_id,  "12" as customer_id,  "4" as office_id,  98 as hours,  129850 as sales,  "Texas" as transaction_state, union all
      select "294" as transaction_id,  date("2020-06-24") as date,  "1" as product_id,  "31" as salesperson_id,  "1" as customer_id,  "10" as office_id,  51 as hours,  63138 as sales,  "New York" as transaction_state, union all
      select "295" as transaction_id,  date("2020-06-18") as date,  "5" as product_id,  "38" as salesperson_id,  "12" as customer_id,  "4" as office_id,  52 as hours,  84916 as sales,  "Arizona" as transaction_state, union all
      select "296" as transaction_id,  date("2021-02-16") as date,  "8" as product_id,  "1" as salesperson_id,  "2" as customer_id,  "10" as office_id,  9 as hours,  11925 as sales,  "Pennsylvania" as transaction_state, union all
      select "297" as transaction_id,  date("2020-04-24") as date,  "7" as product_id,  "35" as salesperson_id,  "17" as customer_id,  "3" as office_id,  25 as hours,  49475 as sales,  "Georgia" as transaction_state, union all
      select "298" as transaction_id,  date("2020-07-03") as date,  "4" as product_id,  "14" as salesperson_id,  "15" as customer_id,  "8" as office_id,  72 as hours,  124920 as sales,  "Washington" as transaction_state, union all
      select "299" as transaction_id,  date("2021-03-05") as date,  "11" as product_id,  "23" as salesperson_id,  "19" as customer_id,  "3" as office_id,  86 as hours,  104662 as sales,  "Colorado" as transaction_state, union all
      select "300" as transaction_id,  date("2021-05-27") as date,  "2" as product_id,  "57" as salesperson_id,  "18" as customer_id,  "4" as office_id,  60 as hours,  94980 as sales,  "Arizona" as transaction_state, union all
      select "301" as transaction_id,  date("2021-07-10") as date,  "10" as product_id,  "1" as salesperson_id,  "4" as customer_id,  "1" as office_id,  56 as hours,  84336 as sales,  "North Carolina" as transaction_state, union all
      select "302" as transaction_id,  date("2020-09-08") as date,  "4" as product_id,  "23" as salesperson_id,  "15" as customer_id,  "4" as office_id,  30 as hours,  52050 as sales,  "Nebraska" as transaction_state, union all
      select "303" as transaction_id,  date("2020-12-28") as date,  "2" as product_id,  "32" as salesperson_id,  "19" as customer_id,  "1" as office_id,  60 as hours,  94980 as sales,  "Indiana" as transaction_state, union all
      select "304" as transaction_id,  date("2021-08-31") as date,  "8" as product_id,  "82" as salesperson_id,  "1" as customer_id,  "2" as office_id,  62 as hours,  82150 as sales,  "Texas" as transaction_state, union all
      select "305" as transaction_id,  date("2020-12-20") as date,  "1" as product_id,  "77" as salesperson_id,  "15" as customer_id,  "3" as office_id,  92 as hours,  113896 as sales,  "Colorado" as transaction_state, union all
      select "306" as transaction_id,  date("2020-02-04") as date,  "5" as product_id,  "52" as salesperson_id,  "10" as customer_id,  "1" as office_id,  4 as hours,  6532 as sales,  "Georgia" as transaction_state, union all
      select "307" as transaction_id,  date("2020-10-13") as date,  "6" as product_id,  "39" as salesperson_id,  "8" as customer_id,  "4" as office_id,  99 as hours,  192852 as sales,  "Colorado" as transaction_state, union all
      select "308" as transaction_id,  date("2020-07-09") as date,  "1" as product_id,  "15" as salesperson_id,  "11" as customer_id,  "3" as office_id,  11 as hours,  13618 as sales,  "Colorado" as transaction_state, union all
      select "309" as transaction_id,  date("2021-09-22") as date,  "2" as product_id,  "46" as salesperson_id,  "18" as customer_id,  "4" as office_id,  68 as hours,  107644 as sales,  "Arizona" as transaction_state, union all
      select "310" as transaction_id,  date("2020-10-07") as date,  "1" as product_id,  "13" as salesperson_id,  "5" as customer_id,  "4" as office_id,  18 as hours,  22284 as sales,  "Alabama" as transaction_state, union all
      select "311" as transaction_id,  date("2021-01-25") as date,  "8" as product_id,  "29" as salesperson_id,  "9" as customer_id,  "9" as office_id,  8 as hours,  10600 as sales,  "Ohio" as transaction_state, union all
      select "312" as transaction_id,  date("2021-06-20") as date,  "5" as product_id,  "54" as salesperson_id,  "9" as customer_id,  "1" as office_id,  23 as hours,  37559 as sales,  "Georgia" as transaction_state, union all
      select "313" as transaction_id,  date("2021-05-10") as date,  "7" as product_id,  "7" as salesperson_id,  "16" as customer_id,  "4" as office_id,  51 as hours,  100929 as sales,  "Florida" as transaction_state, union all
      select "314" as transaction_id,  date("2021-02-03") as date,  "8" as product_id,  "17" as salesperson_id,  "7" as customer_id,  "2" as office_id,  43 as hours,  56975 as sales,  "Ohio" as transaction_state, union all
      select "315" as transaction_id,  date("2021-05-20") as date,  "6" as product_id,  "77" as salesperson_id,  "16" as customer_id,  "1" as office_id,  20 as hours,  38960 as sales,  "District of Columbia" as transaction_state, union all
      select "316" as transaction_id,  date("2021-05-06") as date,  "4" as product_id,  "23" as salesperson_id,  "2" as customer_id,  "4" as office_id,  13 as hours,  22555 as sales,  "Colorado" as transaction_state, union all
      select "317" as transaction_id,  date("2020-06-05") as date,  "8" as product_id,  "19" as salesperson_id,  "17" as customer_id,  "8" as office_id,  97 as hours,  128525 as sales,  "Texas" as transaction_state, union all
      select "318" as transaction_id,  date("2020-07-05") as date,  "1" as product_id,  "64" as salesperson_id,  "8" as customer_id,  "1" as office_id,  31 as hours,  38378 as sales,  "Minnesota" as transaction_state, union all
      select "319" as transaction_id,  date("2020-12-21") as date,  "3" as product_id,  "2" as salesperson_id,  "3" as customer_id,  "7" as office_id,  93 as hours,  177072 as sales,  "Alabama" as transaction_state, union all
      select "320" as transaction_id,  date("2020-03-14") as date,  "7" as product_id,  "71" as salesperson_id,  "16" as customer_id,  "9" as office_id,  49 as hours,  96971 as sales,  "Minnesota" as transaction_state, union all
      select "321" as transaction_id,  date("2020-08-03") as date,  "5" as product_id,  "65" as salesperson_id,  "14" as customer_id,  "1" as office_id,  82 as hours,  133906 as sales,  "California" as transaction_state, union all
      select "322" as transaction_id,  date("2021-10-02") as date,  "10" as product_id,  "62" as salesperson_id,  "7" as customer_id,  "5" as office_id,  41 as hours,  61746 as sales,  "Florida" as transaction_state, union all
      select "323" as transaction_id,  date("2021-07-01") as date,  "5" as product_id,  "35" as salesperson_id,  "18" as customer_id,  "5" as office_id,  37 as hours,  60421 as sales,  "Michigan" as transaction_state, union all
      select "324" as transaction_id,  date("2020-11-04") as date,  "11" as product_id,  "94" as salesperson_id,  "7" as customer_id,  "7" as office_id,  62 as hours,  75454 as sales,  "Ohio" as transaction_state, union all
      select "325" as transaction_id,  date("2020-01-04") as date,  "8" as product_id,  "55" as salesperson_id,  "1" as customer_id,  "6" as office_id,  39 as hours,  51675 as sales,  "Texas" as transaction_state, union all
      select "326" as transaction_id,  date("2020-11-14") as date,  "10" as product_id,  "42" as salesperson_id,  "2" as customer_id,  "6" as office_id,  96 as hours,  144576 as sales,  "Oklahoma" as transaction_state, union all
      select "327" as transaction_id,  date("2021-01-23") as date,  "9" as product_id,  "99" as salesperson_id,  "19" as customer_id,  "9" as office_id,  87 as hours,  164778 as sales,  "Illinois" as transaction_state, union all
      select "328" as transaction_id,  date("2020-06-07") as date,  "11" as product_id,  "2" as salesperson_id,  "20" as customer_id,  "4" as office_id,  78 as hours,  94926 as sales,  "Michigan" as transaction_state, union all
      select "329" as transaction_id,  date("2021-04-28") as date,  "3" as product_id,  "74" as salesperson_id,  "15" as customer_id,  "2" as office_id,  37 as hours,  70448 as sales,  "Texas" as transaction_state, union all
      select "330" as transaction_id,  date("2021-09-08") as date,  "9" as product_id,  "73" as salesperson_id,  "11" as customer_id,  "6" as office_id,  41 as hours,  77654 as sales,  "Texas" as transaction_state, union all
      select "331" as transaction_id,  date("2021-02-23") as date,  "6" as product_id,  "23" as salesperson_id,  "19" as customer_id,  "8" as office_id,  29 as hours,  56492 as sales,  "Alabama" as transaction_state, union all
      select "332" as transaction_id,  date("2021-03-10") as date,  "4" as product_id,  "54" as salesperson_id,  "15" as customer_id,  "8" as office_id,  11 as hours,  19085 as sales,  "District of Columbia" as transaction_state, union all
      select "333" as transaction_id,  date("2021-04-01") as date,  "10" as product_id,  "23" as salesperson_id,  "10" as customer_id,  "1" as office_id,  2 as hours,  3012 as sales,  "Texas" as transaction_state, union all
      select "334" as transaction_id,  date("2020-08-30") as date,  "2" as product_id,  "25" as salesperson_id,  "18" as customer_id,  "10" as office_id,  100 as hours,  158300 as sales,  "California" as transaction_state, union all
      select "335" as transaction_id,  date("2020-05-08") as date,  "7" as product_id,  "69" as salesperson_id,  "14" as customer_id,  "1" as office_id,  40 as hours,  79160 as sales,  "Florida" as transaction_state, union all
      select "336" as transaction_id,  date("2020-01-24") as date,  "10" as product_id,  "11" as salesperson_id,  "14" as customer_id,  "3" as office_id,  27 as hours,  40662 as sales,  "Utah" as transaction_state, union all
      select "337" as transaction_id,  date("2021-10-22") as date,  "6" as product_id,  "51" as salesperson_id,  "5" as customer_id,  "9" as office_id,  5 as hours,  9740 as sales,  "California" as transaction_state, union all
      select "338" as transaction_id,  date("2021-04-06") as date,  "2" as product_id,  "84" as salesperson_id,  "4" as customer_id,  "9" as office_id,  72 as hours,  113976 as sales,  "Arizona" as transaction_state, union all
      select "339" as transaction_id,  date("2020-07-18") as date,  "10" as product_id,  "3" as salesperson_id,  "6" as customer_id,  "4" as office_id,  56 as hours,  84336 as sales,  "Maryland" as transaction_state, union all
      select "340" as transaction_id,  date("2021-03-04") as date,  "2" as product_id,  "100" as salesperson_id,  "16" as customer_id,  "1" as office_id,  56 as hours,  88648 as sales,  "Washington" as transaction_state, union all
      select "341" as transaction_id,  date("2020-10-30") as date,  "3" as product_id,  "97" as salesperson_id,  "13" as customer_id,  "6" as office_id,  36 as hours,  68544 as sales,  "New York" as transaction_state, union all
      select "342" as transaction_id,  date("2021-10-07") as date,  "9" as product_id,  "32" as salesperson_id,  "7" as customer_id,  "3" as office_id,  25 as hours,  47350 as sales,  "Missouri" as transaction_state, union all
      select "343" as transaction_id,  date("2021-10-14") as date,  "1" as product_id,  "11" as salesperson_id,  "1" as customer_id,  "1" as office_id,  81 as hours,  100278 as sales,  "Virginia" as transaction_state, union all
      select "344" as transaction_id,  date("2020-09-14") as date,  "6" as product_id,  "81" as salesperson_id,  "2" as customer_id,  "2" as office_id,  32 as hours,  62336 as sales,  "Nebraska" as transaction_state, union all
      select "345" as transaction_id,  date("2020-04-01") as date,  "7" as product_id,  "93" as salesperson_id,  "7" as customer_id,  "2" as office_id,  9 as hours,  17811 as sales,  "California" as transaction_state, union all
      select "346" as transaction_id,  date("2021-08-18") as date,  "11" as product_id,  "3" as salesperson_id,  "12" as customer_id,  "8" as office_id,  6 as hours,  7302 as sales,  "Wisconsin" as transaction_state, union all
      select "347" as transaction_id,  date("2021-01-06") as date,  "11" as product_id,  "21" as salesperson_id,  "1" as customer_id,  "9" as office_id,  40 as hours,  48680 as sales,  "Virginia" as transaction_state, union all
      select "348" as transaction_id,  date("2020-03-29") as date,  "2" as product_id,  "64" as salesperson_id,  "6" as customer_id,  "5" as office_id,  85 as hours,  134555 as sales,  "Texas" as transaction_state, union all
      select "349" as transaction_id,  date("2021-02-01") as date,  "6" as product_id,  "50" as salesperson_id,  "18" as customer_id,  "8" as office_id,  36 as hours,  70128 as sales,  "Alabama" as transaction_state, union all
      select "350" as transaction_id,  date("2020-02-06") as date,  "2" as product_id,  "66" as salesperson_id,  "12" as customer_id,  "10" as office_id,  31 as hours,  49073 as sales,  "Missouri" as transaction_state, union all
      select "351" as transaction_id,  date("2020-09-03") as date,  "1" as product_id,  "13" as salesperson_id,  "4" as customer_id,  "10" as office_id,  26 as hours,  32188 as sales,  "Minnesota" as transaction_state, union all
      select "352" as transaction_id,  date("2020-04-20") as date,  "7" as product_id,  "48" as salesperson_id,  "12" as customer_id,  "3" as office_id,  13 as hours,  25727 as sales,  "Michigan" as transaction_state, union all
      select "353" as transaction_id,  date("2020-07-27") as date,  "7" as product_id,  "6" as salesperson_id,  "3" as customer_id,  "2" as office_id,  1 as hours,  1979 as sales,  "Tennessee" as transaction_state, union all
      select "354" as transaction_id,  date("2021-08-19") as date,  "5" as product_id,  "31" as salesperson_id,  "13" as customer_id,  "6" as office_id,  59 as hours,  96347 as sales,  "Texas" as transaction_state, union all
      select "355" as transaction_id,  date("2021-10-09") as date,  "9" as product_id,  "18" as salesperson_id,  "17" as customer_id,  "9" as office_id,  52 as hours,  98488 as sales,  "New York" as transaction_state, union all
      select "356" as transaction_id,  date("2021-04-09") as date,  "4" as product_id,  "92" as salesperson_id,  "2" as customer_id,  "2" as office_id,  8 as hours,  13880 as sales,  "Arizona" as transaction_state, union all
      select "357" as transaction_id,  date("2021-02-02") as date,  "8" as product_id,  "57" as salesperson_id,  "10" as customer_id,  "5" as office_id,  19 as hours,  25175 as sales,  "New York" as transaction_state, union all
      select "358" as transaction_id,  date("2020-11-27") as date,  "7" as product_id,  "47" as salesperson_id,  "5" as customer_id,  "4" as office_id,  53 as hours,  104887 as sales,  "Missouri" as transaction_state, union all
      select "359" as transaction_id,  date("2020-09-03") as date,  "3" as product_id,  "50" as salesperson_id,  "15" as customer_id,  "6" as office_id,  13 as hours,  24752 as sales,  "Texas" as transaction_state, union all
      select "360" as transaction_id,  date("2020-01-29") as date,  "9" as product_id,  "21" as salesperson_id,  "3" as customer_id,  "6" as office_id,  46 as hours,  87124 as sales,  "California" as transaction_state, union all
      select "361" as transaction_id,  date("2020-08-29") as date,  "6" as product_id,  "35" as salesperson_id,  "12" as customer_id,  "9" as office_id,  15 as hours,  29220 as sales,  "Nevada" as transaction_state, union all
      select "362" as transaction_id,  date("2021-02-25") as date,  "9" as product_id,  "53" as salesperson_id,  "8" as customer_id,  "3" as office_id,  11 as hours,  20834 as sales,  "Nebraska" as transaction_state, union all
      select "363" as transaction_id,  date("2020-08-20") as date,  "5" as product_id,  "53" as salesperson_id,  "4" as customer_id,  "3" as office_id,  52 as hours,  84916 as sales,  "California" as transaction_state, union all
      select "364" as transaction_id,  date("2021-02-01") as date,  "9" as product_id,  "96" as salesperson_id,  "11" as customer_id,  "3" as office_id,  55 as hours,  104170 as sales,  "Illinois" as transaction_state, union all
      select "365" as transaction_id,  date("2020-03-26") as date,  "11" as product_id,  "60" as salesperson_id,  "16" as customer_id,  "5" as office_id,  85 as hours,  103445 as sales,  "Indiana" as transaction_state, union all
      select "366" as transaction_id,  date("2020-11-25") as date,  "4" as product_id,  "33" as salesperson_id,  "9" as customer_id,  "1" as office_id,  82 as hours,  142270 as sales,  "Michigan" as transaction_state, union all
      select "367" as transaction_id,  date("2021-08-15") as date,  "3" as product_id,  "81" as salesperson_id,  "7" as customer_id,  "4" as office_id,  89 as hours,  169456 as sales,  "Texas" as transaction_state, union all
      select "368" as transaction_id,  date("2021-02-05") as date,  "9" as product_id,  "2" as salesperson_id,  "19" as customer_id,  "5" as office_id,  79 as hours,  149626 as sales,  "Ohio" as transaction_state, union all
      select "369" as transaction_id,  date("2020-02-19") as date,  "4" as product_id,  "35" as salesperson_id,  "1" as customer_id,  "5" as office_id,  68 as hours,  117980 as sales,  "Kentucky" as transaction_state, union all
      select "370" as transaction_id,  date("2020-11-03") as date,  "9" as product_id,  "40" as salesperson_id,  "6" as customer_id,  "4" as office_id,  5 as hours,  9470 as sales,  "Alabama" as transaction_state, union all
      select "371" as transaction_id,  date("2021-04-14") as date,  "6" as product_id,  "90" as salesperson_id,  "13" as customer_id,  "7" as office_id,  78 as hours,  151944 as sales,  "California" as transaction_state, union all
      select "372" as transaction_id,  date("2020-03-17") as date,  "7" as product_id,  "11" as salesperson_id,  "19" as customer_id,  "3" as office_id,  87 as hours,  172173 as sales,  "Florida" as transaction_state, union all
      select "373" as transaction_id,  date("2021-10-25") as date,  "11" as product_id,  "31" as salesperson_id,  "13" as customer_id,  "2" as office_id,  51 as hours,  62067 as sales,  "Ohio" as transaction_state, union all
      select "374" as transaction_id,  date("2021-03-10") as date,  "5" as product_id,  "72" as salesperson_id,  "18" as customer_id,  "2" as office_id,  35 as hours,  57155 as sales,  "Missouri" as transaction_state, union all
      select "375" as transaction_id,  date("2020-09-30") as date,  "6" as product_id,  "73" as salesperson_id,  "12" as customer_id,  "6" as office_id,  33 as hours,  64284 as sales,  "Ohio" as transaction_state, union all
      select "376" as transaction_id,  date("2021-07-21") as date,  "4" as product_id,  "59" as salesperson_id,  "17" as customer_id,  "5" as office_id,  83 as hours,  144005 as sales,  "North Carolina" as transaction_state, union all
      select "377" as transaction_id,  date("2021-05-17") as date,  "6" as product_id,  "24" as salesperson_id,  "19" as customer_id,  "8" as office_id,  54 as hours,  105192 as sales,  "Washington" as transaction_state, union all
      select "378" as transaction_id,  date("2020-04-13") as date,  "1" as product_id,  "96" as salesperson_id,  "3" as customer_id,  "2" as office_id,  42 as hours,  51996 as sales,  "Texas" as transaction_state, union all
      select "379" as transaction_id,  date("2021-04-07") as date,  "10" as product_id,  "33" as salesperson_id,  "6" as customer_id,  "2" as office_id,  80 as hours,  120480 as sales,  "Texas" as transaction_state, union all
      select "380" as transaction_id,  date("2020-09-22") as date,  "7" as product_id,  "3" as salesperson_id,  "1" as customer_id,  "4" as office_id,  97 as hours,  191963 as sales,  "South Carolina" as transaction_state, union all
      select "381" as transaction_id,  date("2020-12-06") as date,  "4" as product_id,  "36" as salesperson_id,  "12" as customer_id,  "5" as office_id,  18 as hours,  31230 as sales,  "Washington" as transaction_state, union all
      select "382" as transaction_id,  date("2020-01-14") as date,  "10" as product_id,  "46" as salesperson_id,  "5" as customer_id,  "5" as office_id,  31 as hours,  46686 as sales,  "Texas" as transaction_state, union all
      select "383" as transaction_id,  date("2020-03-04") as date,  "2" as product_id,  "55" as salesperson_id,  "2" as customer_id,  "6" as office_id,  11 as hours,  17413 as sales,  "Wisconsin" as transaction_state, union all
      select "384" as transaction_id,  date("2021-07-23") as date,  "9" as product_id,  "48" as salesperson_id,  "4" as customer_id,  "8" as office_id,  88 as hours,  166672 as sales,  "New York" as transaction_state, union all
      select "385" as transaction_id,  date("2020-11-14") as date,  "1" as product_id,  "43" as salesperson_id,  "14" as customer_id,  "3" as office_id,  97 as hours,  120086 as sales,  "Nebraska" as transaction_state, union all
      select "386" as transaction_id,  date("2020-12-26") as date,  "1" as product_id,  "50" as salesperson_id,  "20" as customer_id,  "4" as office_id,  81 as hours,  100278 as sales,  "Indiana" as transaction_state, union all
      select "387" as transaction_id,  date("2020-03-06") as date,  "7" as product_id,  "39" as salesperson_id,  "8" as customer_id,  "8" as office_id,  29 as hours,  57391 as sales,  "Texas" as transaction_state, union all
      select "388" as transaction_id,  date("2020-10-05") as date,  "5" as product_id,  "40" as salesperson_id,  "2" as customer_id,  "10" as office_id,  65 as hours,  106145 as sales,  "New Jersey" as transaction_state, union all
      select "389" as transaction_id,  date("2021-05-31") as date,  "7" as product_id,  "15" as salesperson_id,  "17" as customer_id,  "5" as office_id,  48 as hours,  94992 as sales,  "New Mexico" as transaction_state, union all
      select "390" as transaction_id,  date("2021-04-09") as date,  "4" as product_id,  "52" as salesperson_id,  "18" as customer_id,  "4" as office_id,  84 as hours,  145740 as sales,  "Nebraska" as transaction_state, union all
      select "391" as transaction_id,  date("2021-07-01") as date,  "11" as product_id,  "82" as salesperson_id,  "6" as customer_id,  "9" as office_id,  78 as hours,  94926 as sales,  "Florida" as transaction_state, union all
      select "392" as transaction_id,  date("2021-09-19") as date,  "3" as product_id,  "80" as salesperson_id,  "3" as customer_id,  "7" as office_id,  5 as hours,  9520 as sales,  "New York" as transaction_state, union all
      select "393" as transaction_id,  date("2020-09-29") as date,  "7" as product_id,  "48" as salesperson_id,  "15" as customer_id,  "5" as office_id,  41 as hours,  81139 as sales,  "North Carolina" as transaction_state, union all
      select "394" as transaction_id,  date("2020-09-21") as date,  "7" as product_id,  "40" as salesperson_id,  "18" as customer_id,  "3" as office_id,  99 as hours,  195921 as sales,  "Ohio" as transaction_state, union all
      select "395" as transaction_id,  date("2021-02-11") as date,  "10" as product_id,  "95" as salesperson_id,  "5" as customer_id,  "2" as office_id,  82 as hours,  123492 as sales,  "Pennsylvania" as transaction_state, union all
      select "396" as transaction_id,  date("2021-03-03") as date,  "3" as product_id,  "61" as salesperson_id,  "7" as customer_id,  "2" as office_id,  61 as hours,  116144 as sales,  "Pennsylvania" as transaction_state, union all
      select "397" as transaction_id,  date("2020-10-26") as date,  "4" as product_id,  "47" as salesperson_id,  "10" as customer_id,  "5" as office_id,  79 as hours,  137065 as sales,  "South Carolina" as transaction_state, union all
      select "398" as transaction_id,  date("2021-03-20") as date,  "7" as product_id,  "54" as salesperson_id,  "7" as customer_id,  "7" as office_id,  83 as hours,  164257 as sales,  "Kansas" as transaction_state, union all
      select "399" as transaction_id,  date("2020-11-02") as date,  "11" as product_id,  "59" as salesperson_id,  "11" as customer_id,  "6" as office_id,  75 as hours,  91275 as sales,  "New York" as transaction_state, union all
      select "400" as transaction_id,  date("2020-01-19") as date,  "5" as product_id,  "34" as salesperson_id,  "17" as customer_id,  "6" as office_id,  6 as hours,  9798 as sales,  "North Carolina" as transaction_state
      ;;
  }

  drill_fields: [detail*]

  set: detail {
    fields: [transaction_id, transaction_date, office_id, salesperson_id, customer_id, state, total_sales, total_hours]
  }

  dimension: hours {
    type: number
    sql: ${TABLE}.hours ;;
  }

  dimension: sales {
    type: number
    sql: ${TABLE}.sales ;;
  }

  dimension: office_id {
    type: string
    sql: ${TABLE}.office_id ;;
  }

  dimension: transaction_id {
    type: string
    sql: ${TABLE}.transaction_id ;;
  }

  dimension: salesperson_id {
    type: string
    sql: ${TABLE}.salesperson_id ;;
  }

  dimension: customer_id {
    type: string
    sql: ${TABLE}.customer_id ;;
  }

  dimension_group: transaction {
    type: time
    timeframes: [date, week, month, year, raw]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date ;;
  }

  dimension: state {
    type: string
    map_layer_name: us_states
    sql:  ${TABLE}.transaction_state ;;
  }

  measure: count {
    type: count
  }

  measure: total_sales {
    type: sum
    value_format_name: usd_0
    sql: ${TABLE}.sales ;;
  }

  measure: average_sales {
    type: average
    value_format_name: usd_0
    sql: ${TABLE}.sales ;;
  }

  measure: total_hours {
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.hours ;;
  }

  measure: average_hours {
    type: average
    value_format_name: decimal_0
    sql: ${TABLE}.hours ;;
  }

  measure: hourly_price {
    type:  number
    value_format_name: usd_0
    sql: ${total_sales} / ${total_hours} ;;
  }


}



explore: sales {
  group_label: "Element Rental"
  description: "All customer and sales data can be found here"
  join: office {
    type: left_outer
    sql_on: ${sales.office_id} = ${office.office_id} ;;
    relationship: many_to_one
  }
  join: product {
    type: left_outer
    sql_on: sales.product_id = ${product.product_id} ;;
    relationship: many_to_one
  }
  join: salesperson {
    type: left_outer
    sql_on: ${sales.salesperson_id} = ${salesperson.salesperson_id} ;;
    relationship: many_to_one
  }
  join: customer {
    type: left_outer
    sql_on: ${sales.customer_id} = ${customer.customer_id} ;;
    relationship: many_to_one
  }
}

view: inventory {
  derived_table: {
    sql: select "1" as inventory_id,  "2" as product_id,  "Held" as status,  94 as condition,  "1" as office_id, union all
      select "2" as inventory_id,  "1" as product_id,  "Open" as status,  51 as condition,  "8" as office_id, union all
      select "3" as inventory_id,  "2" as product_id,  "Open" as status,  55 as condition,  "9" as office_id, union all
      select "4" as inventory_id,  "2" as product_id,  "Open" as status,  58 as condition,  "2" as office_id, union all
      select "5" as inventory_id,  "4" as product_id,  "Open" as status,  34 as condition,  "3" as office_id, union all
      select "6" as inventory_id,  "8" as product_id,  "Held" as status,  8 as condition,  "2" as office_id, union all
      select "7" as inventory_id,  "7" as product_id,  "Held" as status,  40 as condition,  "1" as office_id, union all
      select "8" as inventory_id,  "2" as product_id,  "Open" as status,  16 as condition,  "1" as office_id, union all
      select "9" as inventory_id,  "5" as product_id,  "Open" as status,  86 as condition,  "7" as office_id, union all
      select "10" as inventory_id,  "3" as product_id,  "Held" as status,  40 as condition,  "4" as office_id, union all
      select "11" as inventory_id,  "5" as product_id,  "Open" as status,  94 as condition,  "6" as office_id, union all
      select "12" as inventory_id,  "11" as product_id,  "Open" as status,  46 as condition,  "2" as office_id, union all
      select "13" as inventory_id,  "3" as product_id,  "Held" as status,  20 as condition,  "5" as office_id, union all
      select "14" as inventory_id,  "4" as product_id,  "Held" as status,  11 as condition,  "5" as office_id, union all
      select "15" as inventory_id,  "4" as product_id,  "Open" as status,  15 as condition,  "8" as office_id, union all
      select "16" as inventory_id,  "9" as product_id,  "Open" as status,  88 as condition,  "3" as office_id, union all
      select "17" as inventory_id,  "6" as product_id,  "Open" as status,  51 as condition,  "10" as office_id, union all
      select "18" as inventory_id,  "5" as product_id,  "Held" as status,  86 as condition,  "1" as office_id, union all
      select "19" as inventory_id,  "6" as product_id,  "Held" as status,  26 as condition,  "7" as office_id, union all
      select "20" as inventory_id,  "7" as product_id,  "Open" as status,  39 as condition,  "4" as office_id, union all
      select "21" as inventory_id,  "7" as product_id,  "Held" as status,  90 as condition,  "3" as office_id, union all
      select "22" as inventory_id,  "7" as product_id,  "Held" as status,  65 as condition,  "5" as office_id, union all
      select "23" as inventory_id,  "2" as product_id,  "Open" as status,  100 as condition,  "7" as office_id, union all
      select "24" as inventory_id,  "6" as product_id,  "Held" as status,  72 as condition,  "3" as office_id, union all
      select "25" as inventory_id,  "6" as product_id,  "Held" as status,  69 as condition,  "7" as office_id, union all
      select "26" as inventory_id,  "2" as product_id,  "Held" as status,  12 as condition,  "2" as office_id, union all
      select "27" as inventory_id,  "11" as product_id,  "Open" as status,  51 as condition,  "6" as office_id, union all
      select "28" as inventory_id,  "3" as product_id,  "Open" as status,  72 as condition,  "4" as office_id, union all
      select "29" as inventory_id,  "2" as product_id,  "Held" as status,  84 as condition,  "10" as office_id, union all
      select "30" as inventory_id,  "8" as product_id,  "Held" as status,  26 as condition,  "8" as office_id, union all
      select "31" as inventory_id,  "11" as product_id,  "Held" as status,  80 as condition,  "8" as office_id, union all
      select "32" as inventory_id,  "2" as product_id,  "Held" as status,  8 as condition,  "9" as office_id, union all
      select "33" as inventory_id,  "6" as product_id,  "Held" as status,  52 as condition,  "6" as office_id, union all
      select "34" as inventory_id,  "7" as product_id,  "Held" as status,  50 as condition,  "4" as office_id, union all
      select "35" as inventory_id,  "9" as product_id,  "Held" as status,  27 as condition,  "9" as office_id, union all
      select "36" as inventory_id,  "1" as product_id,  "Open" as status,  12 as condition,  "4" as office_id, union all
      select "37" as inventory_id,  "7" as product_id,  "Open" as status,  81 as condition,  "5" as office_id, union all
      select "38" as inventory_id,  "2" as product_id,  "Open" as status,  46 as condition,  "5" as office_id, union all
      select "39" as inventory_id,  "9" as product_id,  "Held" as status,  98 as condition,  "1" as office_id, union all
      select "40" as inventory_id,  "8" as product_id,  "Open" as status,  64 as condition,  "6" as office_id, union all
      select "41" as inventory_id,  "5" as product_id,  "Held" as status,  31 as condition,  "8" as office_id, union all
      select "42" as inventory_id,  "7" as product_id,  "Held" as status,  19 as condition,  "10" as office_id, union all
      select "43" as inventory_id,  "2" as product_id,  "Open" as status,  24 as condition,  "6" as office_id, union all
      select "44" as inventory_id,  "1" as product_id,  "Open" as status,  24 as condition,  "8" as office_id, union all
      select "45" as inventory_id,  "4" as product_id,  "Open" as status,  79 as condition,  "10" as office_id, union all
      select "46" as inventory_id,  "10" as product_id,  "Open" as status,  13 as condition,  "8" as office_id, union all
      select "47" as inventory_id,  "6" as product_id,  "Open" as status,  1 as condition,  "8" as office_id, union all
      select "48" as inventory_id,  "3" as product_id,  "Open" as status,  73 as condition,  "7" as office_id, union all
      select "49" as inventory_id,  "2" as product_id,  "Open" as status,  2 as condition,  "3" as office_id, union all
      select "50" as inventory_id,  "9" as product_id,  "Open" as status,  18 as condition,  "1" as office_id, union all
      select "51" as inventory_id,  "6" as product_id,  "Open" as status,  53 as condition,  "9" as office_id, union all
      select "52" as inventory_id,  "3" as product_id,  "Held" as status,  52 as condition,  "6" as office_id, union all
      select "53" as inventory_id,  "1" as product_id,  "Open" as status,  71 as condition,  "6" as office_id, union all
      select "54" as inventory_id,  "9" as product_id,  "Held" as status,  49 as condition,  "9" as office_id, union all
      select "55" as inventory_id,  "4" as product_id,  "Held" as status,  16 as condition,  "6" as office_id, union all
      select "56" as inventory_id,  "4" as product_id,  "Held" as status,  81 as condition,  "2" as office_id, union all
      select "57" as inventory_id,  "1" as product_id,  "Open" as status,  54 as condition,  "1" as office_id, union all
      select "58" as inventory_id,  "6" as product_id,  "Open" as status,  6 as condition,  "1" as office_id, union all
      select "59" as inventory_id,  "2" as product_id,  "Held" as status,  55 as condition,  "9" as office_id, union all
      select "60" as inventory_id,  "6" as product_id,  "Open" as status,  88 as condition,  "4" as office_id, union all
      select "61" as inventory_id,  "10" as product_id,  "Open" as status,  50 as condition,  "4" as office_id, union all
      select "62" as inventory_id,  "5" as product_id,  "Open" as status,  64 as condition,  "7" as office_id, union all
      select "63" as inventory_id,  "10" as product_id,  "Open" as status,  42 as condition,  "2" as office_id, union all
      select "64" as inventory_id,  "2" as product_id,  "Open" as status,  75 as condition,  "4" as office_id, union all
      select "65" as inventory_id,  "8" as product_id,  "Held" as status,  20 as condition,  "9" as office_id, union all
      select "66" as inventory_id,  "2" as product_id,  "Held" as status,  54 as condition,  "8" as office_id, union all
      select "67" as inventory_id,  "6" as product_id,  "Open" as status,  11 as condition,  "7" as office_id, union all
      select "68" as inventory_id,  "2" as product_id,  "Held" as status,  51 as condition,  "2" as office_id, union all
      select "69" as inventory_id,  "7" as product_id,  "Open" as status,  17 as condition,  "1" as office_id, union all
      select "70" as inventory_id,  "10" as product_id,  "Open" as status,  52 as condition,  "4" as office_id, union all
      select "71" as inventory_id,  "6" as product_id,  "Held" as status,  76 as condition,  "2" as office_id, union all
      select "72" as inventory_id,  "7" as product_id,  "Held" as status,  86 as condition,  "6" as office_id, union all
      select "73" as inventory_id,  "10" as product_id,  "Held" as status,  53 as condition,  "6" as office_id, union all
      select "74" as inventory_id,  "9" as product_id,  "Open" as status,  68 as condition,  "9" as office_id, union all
      select "75" as inventory_id,  "6" as product_id,  "Held" as status,  0 as condition,  "9" as office_id, union all
      select "76" as inventory_id,  "8" as product_id,  "Held" as status,  39 as condition,  "1" as office_id, union all
      select "77" as inventory_id,  "11" as product_id,  "Held" as status,  40 as condition,  "8" as office_id, union all
      select "78" as inventory_id,  "9" as product_id,  "Held" as status,  23 as condition,  "6" as office_id, union all
      select "79" as inventory_id,  "5" as product_id,  "Held" as status,  92 as condition,  "7" as office_id, union all
      select "80" as inventory_id,  "3" as product_id,  "Open" as status,  92 as condition,  "2" as office_id, union all
      select "81" as inventory_id,  "10" as product_id,  "Open" as status,  77 as condition,  "5" as office_id, union all
      select "82" as inventory_id,  "4" as product_id,  "Held" as status,  40 as condition,  "3" as office_id, union all
      select "83" as inventory_id,  "7" as product_id,  "Open" as status,  45 as condition,  "6" as office_id, union all
      select "84" as inventory_id,  "7" as product_id,  "Held" as status,  33 as condition,  "7" as office_id, union all
      select "85" as inventory_id,  "4" as product_id,  "Held" as status,  68 as condition,  "1" as office_id, union all
      select "86" as inventory_id,  "6" as product_id,  "Held" as status,  74 as condition,  "8" as office_id, union all
      select "87" as inventory_id,  "4" as product_id,  "Held" as status,  59 as condition,  "5" as office_id, union all
      select "88" as inventory_id,  "8" as product_id,  "Open" as status,  5 as condition,  "10" as office_id, union all
      select "89" as inventory_id,  "11" as product_id,  "Held" as status,  25 as condition,  "4" as office_id, union all
      select "90" as inventory_id,  "9" as product_id,  "Held" as status,  25 as condition,  "3" as office_id, union all
      select "91" as inventory_id,  "3" as product_id,  "Held" as status,  95 as condition,  "4" as office_id, union all
      select "92" as inventory_id,  "6" as product_id,  "Open" as status,  16 as condition,  "5" as office_id, union all
      select "93" as inventory_id,  "7" as product_id,  "Held" as status,  48 as condition,  "10" as office_id, union all
      select "94" as inventory_id,  "11" as product_id,  "Held" as status,  80 as condition,  "9" as office_id, union all
      select "95" as inventory_id,  "6" as product_id,  "Open" as status,  34 as condition,  "1" as office_id, union all
      select "96" as inventory_id,  "6" as product_id,  "Held" as status,  18 as condition,  "7" as office_id, union all
      select "97" as inventory_id,  "8" as product_id,  "Open" as status,  78 as condition,  "5" as office_id, union all
      select "98" as inventory_id,  "4" as product_id,  "Held" as status,  56 as condition,  "5" as office_id, union all
      select "99" as inventory_id,  "10" as product_id,  "Open" as status,  66 as condition,  "1" as office_id, union all
      select "100" as inventory_id,  "5" as product_id,  "Open" as status,  99 as condition,  "2" as office_id, union all
      select "101" as inventory_id,  "5" as product_id,  "Held" as status,  65 as condition,  "9" as office_id, union all
      select "102" as inventory_id,  "1" as product_id,  "Held" as status,  58 as condition,  "6" as office_id, union all
      select "103" as inventory_id,  "8" as product_id,  "Held" as status,  75 as condition,  "9" as office_id, union all
      select "104" as inventory_id,  "1" as product_id,  "Open" as status,  73 as condition,  "3" as office_id, union all
      select "105" as inventory_id,  "7" as product_id,  "Held" as status,  70 as condition,  "4" as office_id, union all
      select "106" as inventory_id,  "10" as product_id,  "Open" as status,  32 as condition,  "7" as office_id, union all
      select "107" as inventory_id,  "10" as product_id,  "Open" as status,  83 as condition,  "4" as office_id, union all
      select "108" as inventory_id,  "3" as product_id,  "Open" as status,  91 as condition,  "6" as office_id, union all
      select "109" as inventory_id,  "7" as product_id,  "Open" as status,  17 as condition,  "5" as office_id, union all
      select "110" as inventory_id,  "9" as product_id,  "Held" as status,  78 as condition,  "4" as office_id, union all
      select "111" as inventory_id,  "8" as product_id,  "Held" as status,  26 as condition,  "3" as office_id, union all
      select "112" as inventory_id,  "2" as product_id,  "Held" as status,  47 as condition,  "2" as office_id, union all
      select "113" as inventory_id,  "8" as product_id,  "Open" as status,  68 as condition,  "8" as office_id, union all
      select "114" as inventory_id,  "10" as product_id,  "Held" as status,  15 as condition,  "9" as office_id, union all
      select "115" as inventory_id,  "11" as product_id,  "Held" as status,  51 as condition,  "9" as office_id, union all
      select "116" as inventory_id,  "9" as product_id,  "Open" as status,  6 as condition,  "10" as office_id, union all
      select "117" as inventory_id,  "10" as product_id,  "Open" as status,  79 as condition,  "9" as office_id, union all
      select "118" as inventory_id,  "10" as product_id,  "Held" as status,  63 as condition,  "5" as office_id, union all
      select "119" as inventory_id,  "2" as product_id,  "Open" as status,  12 as condition,  "10" as office_id, union all
      select "120" as inventory_id,  "7" as product_id,  "Open" as status,  38 as condition,  "6" as office_id, union all
      select "121" as inventory_id,  "9" as product_id,  "Open" as status,  3 as condition,  "2" as office_id, union all
      select "122" as inventory_id,  "10" as product_id,  "Open" as status,  92 as condition,  "7" as office_id, union all
      select "123" as inventory_id,  "3" as product_id,  "Open" as status,  62 as condition,  "4" as office_id, union all
      select "124" as inventory_id,  "3" as product_id,  "Open" as status,  84 as condition,  "2" as office_id, union all
      select "125" as inventory_id,  "1" as product_id,  "Held" as status,  34 as condition,  "4" as office_id, union all
      select "126" as inventory_id,  "4" as product_id,  "Open" as status,  67 as condition,  "1" as office_id, union all
      select "127" as inventory_id,  "3" as product_id,  "Held" as status,  96 as condition,  "1" as office_id, union all
      select "128" as inventory_id,  "8" as product_id,  "Open" as status,  68 as condition,  "3" as office_id, union all
      select "129" as inventory_id,  "8" as product_id,  "Held" as status,  35 as condition,  "9" as office_id, union all
      select "130" as inventory_id,  "10" as product_id,  "Held" as status,  31 as condition,  "10" as office_id, union all
      select "131" as inventory_id,  "3" as product_id,  "Held" as status,  38 as condition,  "4" as office_id, union all
      select "132" as inventory_id,  "10" as product_id,  "Open" as status,  35 as condition,  "9" as office_id, union all
      select "133" as inventory_id,  "3" as product_id,  "Held" as status,  64 as condition,  "6" as office_id, union all
      select "134" as inventory_id,  "6" as product_id,  "Open" as status,  65 as condition,  "9" as office_id, union all
      select "135" as inventory_id,  "3" as product_id,  "Held" as status,  28 as condition,  "3" as office_id, union all
      select "136" as inventory_id,  "10" as product_id,  "Held" as status,  89 as condition,  "9" as office_id, union all
      select "137" as inventory_id,  "11" as product_id,  "Held" as status,  36 as condition,  "9" as office_id, union all
      select "138" as inventory_id,  "9" as product_id,  "Open" as status,  47 as condition,  "1" as office_id, union all
      select "139" as inventory_id,  "11" as product_id,  "Open" as status,  58 as condition,  "4" as office_id, union all
      select "140" as inventory_id,  "1" as product_id,  "Open" as status,  40 as condition,  "6" as office_id, union all
      select "141" as inventory_id,  "3" as product_id,  "Open" as status,  69 as condition,  "4" as office_id, union all
      select "142" as inventory_id,  "1" as product_id,  "Open" as status,  16 as condition,  "2" as office_id, union all
      select "143" as inventory_id,  "1" as product_id,  "Open" as status,  51 as condition,  "1" as office_id, union all
      select "144" as inventory_id,  "7" as product_id,  "Open" as status,  63 as condition,  "5" as office_id, union all
      select "145" as inventory_id,  "1" as product_id,  "Open" as status,  33 as condition,  "10" as office_id, union all
      select "146" as inventory_id,  "6" as product_id,  "Held" as status,  25 as condition,  "8" as office_id, union all
      select "147" as inventory_id,  "9" as product_id,  "Open" as status,  68 as condition,  "5" as office_id, union all
      select "148" as inventory_id,  "10" as product_id,  "Held" as status,  39 as condition,  "7" as office_id, union all
      select "149" as inventory_id,  "6" as product_id,  "Open" as status,  82 as condition,  "6" as office_id, union all
      select "150" as inventory_id,  "6" as product_id,  "Held" as status,  67 as condition,  "9" as office_id, union all
      select "151" as inventory_id,  "9" as product_id,  "Open" as status,  70 as condition,  "8" as office_id, union all
      select "152" as inventory_id,  "6" as product_id,  "Held" as status,  19 as condition,  "10" as office_id, union all
      select "153" as inventory_id,  "4" as product_id,  "Open" as status,  25 as condition,  "9" as office_id, union all
      select "154" as inventory_id,  "6" as product_id,  "Held" as status,  82 as condition,  "3" as office_id, union all
      select "155" as inventory_id,  "1" as product_id,  "Held" as status,  84 as condition,  "1" as office_id, union all
      select "156" as inventory_id,  "7" as product_id,  "Held" as status,  31 as condition,  "7" as office_id, union all
      select "157" as inventory_id,  "7" as product_id,  "Held" as status,  89 as condition,  "3" as office_id, union all
      select "158" as inventory_id,  "2" as product_id,  "Open" as status,  2 as condition,  "5" as office_id, union all
      select "159" as inventory_id,  "10" as product_id,  "Held" as status,  37 as condition,  "5" as office_id, union all
      select "160" as inventory_id,  "2" as product_id,  "Held" as status,  49 as condition,  "10" as office_id, union all
      select "161" as inventory_id,  "8" as product_id,  "Held" as status,  57 as condition,  "1" as office_id, union all
      select "162" as inventory_id,  "4" as product_id,  "Open" as status,  70 as condition,  "5" as office_id, union all
      select "163" as inventory_id,  "1" as product_id,  "Held" as status,  67 as condition,  "10" as office_id, union all
      select "164" as inventory_id,  "7" as product_id,  "Open" as status,  49 as condition,  "5" as office_id, union all
      select "165" as inventory_id,  "11" as product_id,  "Open" as status,  26 as condition,  "3" as office_id, union all
      select "166" as inventory_id,  "1" as product_id,  "Held" as status,  47 as condition,  "1" as office_id, union all
      select "167" as inventory_id,  "9" as product_id,  "Held" as status,  87 as condition,  "1" as office_id, union all
      select "168" as inventory_id,  "2" as product_id,  "Held" as status,  87 as condition,  "7" as office_id, union all
      select "169" as inventory_id,  "8" as product_id,  "Held" as status,  56 as condition,  "8" as office_id, union all
      select "170" as inventory_id,  "3" as product_id,  "Open" as status,  28 as condition,  "7" as office_id, union all
      select "171" as inventory_id,  "4" as product_id,  "Open" as status,  20 as condition,  "10" as office_id, union all
      select "172" as inventory_id,  "4" as product_id,  "Held" as status,  21 as condition,  "5" as office_id, union all
      select "173" as inventory_id,  "3" as product_id,  "Open" as status,  36 as condition,  "2" as office_id, union all
      select "174" as inventory_id,  "7" as product_id,  "Open" as status,  10 as condition,  "4" as office_id, union all
      select "175" as inventory_id,  "10" as product_id,  "Open" as status,  28 as condition,  "9" as office_id, union all
      select "176" as inventory_id,  "8" as product_id,  "Open" as status,  74 as condition,  "7" as office_id, union all
      select "177" as inventory_id,  "7" as product_id,  "Open" as status,  22 as condition,  "10" as office_id, union all
      select "178" as inventory_id,  "10" as product_id,  "Held" as status,  52 as condition,  "1" as office_id, union all
      select "179" as inventory_id,  "10" as product_id,  "Open" as status,  97 as condition,  "2" as office_id, union all
      select "180" as inventory_id,  "3" as product_id,  "Open" as status,  5 as condition,  "1" as office_id, union all
      select "181" as inventory_id,  "1" as product_id,  "Open" as status,  94 as condition,  "1" as office_id, union all
      select "182" as inventory_id,  "2" as product_id,  "Held" as status,  34 as condition,  "2" as office_id, union all
      select "183" as inventory_id,  "5" as product_id,  "Held" as status,  100 as condition,  "9" as office_id, union all
      select "184" as inventory_id,  "9" as product_id,  "Held" as status,  66 as condition,  "3" as office_id, union all
      select "185" as inventory_id,  "3" as product_id,  "Open" as status,  33 as condition,  "9" as office_id, union all
      select "186" as inventory_id,  "2" as product_id,  "Held" as status,  72 as condition,  "8" as office_id, union all
      select "187" as inventory_id,  "6" as product_id,  "Held" as status,  76 as condition,  "6" as office_id, union all
      select "188" as inventory_id,  "9" as product_id,  "Open" as status,  52 as condition,  "2" as office_id, union all
      select "189" as inventory_id,  "1" as product_id,  "Open" as status,  67 as condition,  "4" as office_id, union all
      select "190" as inventory_id,  "6" as product_id,  "Held" as status,  3 as condition,  "2" as office_id, union all
      select "191" as inventory_id,  "10" as product_id,  "Held" as status,  76 as condition,  "7" as office_id, union all
      select "192" as inventory_id,  "2" as product_id,  "Held" as status,  43 as condition,  "7" as office_id, union all
      select "193" as inventory_id,  "1" as product_id,  "Held" as status,  85 as condition,  "2" as office_id, union all
      select "194" as inventory_id,  "10" as product_id,  "Open" as status,  30 as condition,  "2" as office_id, union all
      select "195" as inventory_id,  "7" as product_id,  "Open" as status,  55 as condition,  "3" as office_id, union all
      select "196" as inventory_id,  "7" as product_id,  "Held" as status,  55 as condition,  "6" as office_id, union all
      select "197" as inventory_id,  "4" as product_id,  "Open" as status,  75 as condition,  "3" as office_id, union all
      select "198" as inventory_id,  "1" as product_id,  "Held" as status,  1 as condition,  "2" as office_id, union all
      select "199" as inventory_id,  "2" as product_id,  "Open" as status,  93 as condition,  "8" as office_id, union all
      select "200" as inventory_id,  "8" as product_id,  "Held" as status,  14 as condition,  "4" as office_id, union all
      select "201" as inventory_id,  "7" as product_id,  "Held" as status,  31 as condition,  "2" as office_id
       ;;
  }

  dimension: inventory_id {
    type: string
    sql: ${TABLE}.inventory_id ;;
  }

  dimension: product_id {
    type: string
    sql: ${TABLE}.product_id ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: office_id {
    type: string
    sql: ${TABLE}.office_id ;;
  }

  dimension: condition_bins {
    type: bin
    bins: [0, 10, 20, 30, 40, 50, 60, 70, 80, 90]
    style: integer
    sql: ${TABLE}.condition ;;
  }

  dimension: good_condition {
    type: yesno
    sql: condition >= 80 ;;
  }

  dimension: condition_type {
    type:  string
    sql: case when condition between 0 and 29 then 'Poor'
          when condition between 30 and 79 then 'Moderate'
          else 'Good' end;;
  }

  measure: count {
    type:  count
    value_format_name: decimal_0
  }

  measure: average_condition {
    type: average
    sql: ${TABLE}.condition ;;
    value_format_name: decimal_0
  }

  measure: count_of_good_conditioned_inventory {
    type:  count
    filters: [good_condition: "Yes"
    ]
    value_format_name: decimal_0
  }

}


explore: inventory {
  group_label: "Element Rental"
  description: "All current inventory data"
  join: office {
    type: left_outer
    sql_on: ${inventory.office_id} = ${office.office_id} ;;
    relationship: many_to_one
  }
  join: product {
    type: left_outer
    sql_on: inventory.product_id = ${product.product_id} ;;
    relationship: many_to_one
  }
  query: counts_by_condition_type {
    dimensions: [condition_type]
    measures: [count]
    label: "Counts by Condition Type"
    description: "Counts by Condition Type"
    limit: 100
  }
}
