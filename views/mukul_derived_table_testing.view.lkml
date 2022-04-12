view: mukul_derived_table_testing {
  derived_table: {
    sql: select usaf as testing_created_view from weather.stations limit 50  ;;
  }

dimension: testing_created_view{
}

}
