# The name of this view in Looker is "County Zipcode Mapping"
view: county_zipcode_mapping {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `lookerdata.weather.county_zipcode_mapping`
    ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "County Ansi" in Explore.

  dimension: county_ansi {
    type: number
    sql: ${TABLE}.COUNTY_ANSI ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_county_ansi {
    type: sum
    sql: ${county_ansi} ;;
  }

  measure: average_county_ansi {
    type: average
    sql: ${county_ansi} ;;
  }

  dimension: county_fips {
    type: number
    sql: ${TABLE}.COUNTY_FIPS ;;
  }

  dimension: county_geoid {
    type: number
    value_format_name: id
    sql: ${TABLE}.COUNTY_GEOID ;;
  }

  dimension: county_name {
    type: string
    sql: ${TABLE}.COUNTY_NAME ;;
  }

  dimension: percent_of_county_area_in_zip {
    type: number
    sql: ${TABLE}.PERCENT_OF_COUNTY_AREA_IN_ZIP ;;
  }

  dimension: percent_of_county_households_in_zip {
    type: number
    sql: ${TABLE}.PERCENT_OF_COUNTY_HOUSEHOLDS_IN_ZIP ;;
  }

  dimension: percent_of_county_land_area_in_zip {
    type: number
    sql: ${TABLE}.PERCENT_OF_COUNTY_LAND_AREA_IN_ZIP ;;
  }

  dimension: percent_of_county_population_in_zip {
    type: number
    sql: ${TABLE}.PERCENT_OF_COUNTY_POPULATION_IN_ZIP ;;
  }

  dimension: percent_of_zip_area_in_county {
    type: number
    sql: ${TABLE}.PERCENT_OF_ZIP_AREA_IN_COUNTY ;;
  }

  dimension: percent_of_zip_households_in_county {
    type: number
    sql: ${TABLE}.PERCENT_OF_ZIP_HOUSEHOLDS_IN_COUNTY ;;
  }

  dimension: percent_of_zip_land_area_in_county {
    type: number
    sql: ${TABLE}.PERCENT_OF_ZIP_LAND_AREA_IN_COUNTY ;;
  }

  dimension: percent_of_zip_population_in_county {
    type: number
    sql: ${TABLE}.PERCENT_OF_ZIP_POPULATION_IN_COUNTY ;;
  }

  dimension: state_abbr {
    type: string
    sql: ${TABLE}.STATE_ABBR ;;
  }

  dimension: state_ansi {
    type: number
    sql: ${TABLE}.STATE_ANSI ;;
  }

  dimension: state_fips {
    type: number
    sql: ${TABLE}.STATE_FIPS ;;
  }

  dimension: state_name {
    type: string
    sql: ${TABLE}.STATE_NAME ;;
  }

  dimension: zip {
    type: zipcode
    sql: ${TABLE}.ZIP ;;
  }

  measure: count {
    type: count
    drill_fields: [state_name, county_name]
  }
}
