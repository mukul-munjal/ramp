# The name of this view in Looker is "Zcta County Map"
view: zcta_county_map {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `lookerdata.weather.zcta_county_map`
    ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Arealandpt" in Explore.

  dimension: arealandpt {
    type: string
    sql: ${TABLE}.arealandpt ;;
  }

  dimension: areapt {
    type: string
    sql: ${TABLE}.areapt ;;
  }

  dimension: coarea {
    type: string
    sql: ${TABLE}.coarea ;;
  }

  dimension: coarealand {
    type: string
    sql: ${TABLE}.coarealand ;;
  }

  dimension: coarealandpct {
    type: string
    sql: ${TABLE}.coarealandpct ;;
  }

  dimension: coareapct {
    type: string
    sql: ${TABLE}.coareapct ;;
  }

  dimension: cohu {
    type: string
    sql: ${TABLE}.cohu ;;
  }

  dimension: cohupct {
    type: string
    sql: ${TABLE}.cohupct ;;
  }

  dimension: copop {
    type: string
    sql: ${TABLE}.copop ;;
  }

  dimension: copoppct {
    type: string
    sql: ${TABLE}.copoppct ;;
  }

  dimension: county {
    type: string
    sql: ${TABLE}.county ;;
  }

  dimension: geoid {
    type: string
    sql: ${TABLE}.geoid ;;
  }

  dimension: hupt {
    type: string
    sql: ${TABLE}.hupt ;;
  }

  dimension: poppt {
    type: string
    sql: ${TABLE}.poppt ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: zarea {
    type: string
    sql: ${TABLE}.zarea ;;
  }

  dimension: zarealand {
    type: string
    sql: ${TABLE}.zarealand ;;
  }

  dimension: zarealandpct {
    type: string
    sql: ${TABLE}.zarealandpct ;;
  }

  dimension: zareapct {
    type: string
    sql: ${TABLE}.zareapct ;;
  }

  dimension: zcta5 {
    type: string
    sql: ${TABLE}.zcta5 ;;
  }

  dimension: zhu {
    type: string
    sql: ${TABLE}.zhu ;;
  }

  dimension: zhupct {
    type: string
    sql: ${TABLE}.zhupct ;;
  }

  dimension: zpop {
    type: string
    sql: ${TABLE}.zpop ;;
  }

  dimension: zpoppct {
    type: string
    sql: ${TABLE}.zpoppct ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
