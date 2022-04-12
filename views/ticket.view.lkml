view: ticket {
  sql_table_name: sidney_thesis.ticket ;;

  filter: status_filter {
    type: date
  }

#   dimension: select {
#     type: string
#     sql: (SELECT
#     NUM_BO AS ticket_num_bo
# FROM
#     sidney_thesis.${TABLE} AS ticket
# WHERE NUM_BO > 500
# LIMIT 500) ;;
#   }

  filter: abc {
    description: "ABC"
    type: string
    suggestions: ["800"]
    default_value: "800"
  }

  dimension: dddt {
    type: string
    hidden: no
    sql: {% if abc._is_filtered %}
      CASE WHEN 1 > {{abc._value}} then "Y" else "N"
      end
      {% else %}
      "N"
      {% endif %}
      ;;
  }

  dimension: status_satisfies_filter {
    type: yesno
    hidden: yes
    sql: {% date_start status_filter %} ;;
  }

  parameter: param_source_role {
    label: "Source Role"
    type: string
    allowed_value: {
      label: "(4) Marketing"
      value: "'(4) Marketing'"
    }
    allowed_value: {
      label: "(3) Test"
      value: "3"
    }
  }

  parameter: page {
    type: number
  }

  parameter: page_2 {
    type: number
    suggest_dimension: num_bo
  }

# html and drop down menu link  at the same time :

# <a href="#drillmenu" class="cell-clickable-content" target="_self">

  filter: test_filter {
    type: string
    suggest_dimension: flag_status
  }
  dimension: video {
    type: string
    sql: 'https://www.w3schools.com/html/mov_bbb.mp4' ;;
    html: <video width="500" height="400" controls preload="none"> <controls> <source src="{{ value }}" type="video/mp4"> </video> ;;
  }

  dimension: video_test {
    type: number
    sql: ${TABLE}.NUM_BO ;;
    link: {
      label: "test_video"
      url: "/explore/criminal_activity/ticket?qid=rp4edSfwF8BxVSXn0wXwV6&origin_space=438&toggle=dat,pik,vis"
      icon_url: "https://static.thenounproject.com/png/1813969-200.png"
    }
  }

  #    html: <a href="/looks/1792">{{value}}</a> ;;


  measure: your_measure {
    type: sum
    sql: (select ${TABLE}.NUM_BO from sidney_thesis.ticket where cast(${TABLE}.DATA_OCORRENCIA_BO as timestamp) > {% date_start status_filter %}) ;;
#     filters: {
#       field: status_satisfies_filter
#       value: "yes"
#     }
  }

  dimension: year {
    type: number
    sql: ${TABLE}.ANO ;;
    html: <a href="{{link}}">{{ rendered_value }} <br>
          <div style="font-size: 12px; line-height: 20px; letter-spacing: 0.08em; text-align:center">EV in 2y: <b>{{ rendered_value }}</b> (pred.) </div>
          <div style="font-size: 12px; line-height: 20px; letter-spacing: 0.08em; text-align:center">EV today: <b>{{ rendered_value }}</b> (est.) </div>
          </a>;;

    link: {
      label: "See Explanations by Feature Group"
      url: "{{ link }}&sorts=companies_state__q_predict_explanations.sum_shap_score+desc"
    }
    link: {
      label: "See Explanations by Feature"
      url: "{{ link }}&sorts=companies_state__q_predict_explanations.sum_shap_score+desc"
    }

  }

  dimension: environment {
    type: string
    sql: ${TABLE}.CONDUTA ;;
    # html: <p style=“color: grey; font-family: OpenSans; background-color:white; text-align:centre; font-size: 100%“>{{value}}</p>;;
  }

  dimension: test_suggestion{
    suggest_explore: suggestion
    suggest_dimension: environment
    sql: ${TABLE}.CONDUTA;;
  }


  filter: current_date_range {
    view_label: "Timeline Comparison Fields"
    label: "1. Date Range"
    description: "Select the date range you are interested in using this filter, can be used by itself. Make sure any filter on Event Date covers this period, or is removed."
    type: date
  }

  dimension: days_in_period {
    view_label: "Timeline Comparison Fields"
    description: "Gives the number of days in the current period date range"
    type: number
    sql: DATE_DIFF(DATE({% date_end current_date_range %}), DATE({% date_start current_date_range %}), DAY) ;;
    hidden: no
  }

  dimension: sidolga {
    type: string
    sql: case when 1=1 then "Flavia" else null end ;;
    map_layer_name: body
  }

  measure: min_date {
    type: min
    sql: ${date_police_report_date} ;;
    filters: [
      flag_status: "C",
      gender: "M"
    ]
  }

  dimension: gender {
    sql: ${people.gender};;
  }
  dimension_group: date_police_report{
#     group_label: "Date Police Report"

  type: time
  timeframes: [
    day_of_year,
    raw,
    year,
    date,
    week,
    week_of_year,
    month,
    quarter,
    month_name,
    day_of_week,
    quarter_of_year,
    fiscal_quarter,
    fiscal_quarter_of_year,
    fiscal_year,
    day_of_month,
    time_of_day,
    minute15,
    month_num
  ]
  convert_tz: no
  datatype: date
  sql: ${TABLE}.DATA_OCORRENCIA_BO ;;

  # html: {{ value | slice: 11, 5 }} ;;
#     html:{% assign seconds = 1 | times: 24 | times: 60 | times: 60 %}
# <a href="/explore/criminal_activity/ticket?fields=ticket.date_police_report_date&f[ticket.date_police_report_date]=before {{ value | date: "%s" | plus: seconds | date: "%Y-%m-%d" | url_encode }}">{{ value }}</a> ;;
}

dimension: t{}
# #################START LOOKER TEST#################

#   dimension_group: sales_looker {
#     view_label: "Looker test"
#     type: time
#     timeframes: [minute15]
#     sql: ${TABLE}.sale_date ;;
#     convert_tz: no
#     label: "Sale Closed"
#   }

#   dimension: substring_minute_15 {
#     view_label: "Looker test"
#     type: string
#     sql: substring(${sales_looker_minute15},11,10)||':00' ;;
#     order_by_field: sort_minute_15
#   }

#   dimension: sort_minute_15 {
#     hidden: yes
#     view_label: "Looker test"
#     type: number
#     sql: cast(replace(${substring_minute_15},':', '') as INTEGER);;
#   }

# #################END LOOKER TEST#################

# dimension: duration {
#   type: duration_day
#   sql_start: min(${TABLE}.DATA_OCORRENCIA_BO) ;;
#   sql_end: max(${TABLE}.DATA_OCORRENCIA_BO) ;;
# }

dimension: duration {
  type: duration_day
  sql_start: min(${TABLE}.DATA_OCORRENCIA_BO) ;;
  sql_end: max(${TABLE}.DATA_OCORRENCIA_BO) ;;
}


dimension: yr_mon {
  label: "yr mon"
  description: "Date the order was placed"
  sql: ${date_police_report_month} ;;
  html: {{ rendered_value | append: "-01" | date: "%m-%Y" }};;

}

dimension_group: sidney_timestamp{
  type: time
  timeframes: [
    time,
    day_of_year,
    raw,
    year,
    date,
    week,
    month,
    quarter,
    month_name,
    quarter_of_year,
    day_of_month,
    time_of_day
  ]
  convert_tz: no
  datatype: date
  sql: ${TABLE}.DATA_OCORRENCIA_BO ;;

}

dimension: date_police_report_test_raw2{
  sql: ${date_police_report_month} ;;
  html: {{ rendered_value | date: “%b %d” }};;
}

dimension: offence {
  type: string
  sql: ${TABLE}.DESDOBRAMENTO ;;
}

#   dimension: Pineapple_test {
#     sql: ${pineaple_people.age} ;;
#   }

dimension: flag_status {
  type: string
  sql: ${TABLE}.FLAG_STATUS ;;
}


dimension: page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_page_ {
  type: string
  sql: ${flag_status};;
}

filter: test_ken {
  type: date
}

dimension: sme_drill_fields{
  sql: ${TABLE}.FLAG_STATUS ;;

  link: {
    label: "Drill Dashboard"
#       url: "/dashboards/503?Year={{ _filters['ticket.date_police_report_year'] | url_encode }}&Gender={{ value }}"
    url: "/dashboards/503?Year={{ _filters['ticket.test_ken'] }}&Gender={{ value }}"

  }
}

dimension: test_encode{
  sql: ${num_bo} ;;
  # sql: ${date_police_report_year} ;;
  link: {
    label: "Drill Dashboard"
    url: "/dashboards/503?Year Test={{ people.gender._value }}"
  }
  link: {
    label: "Drill Dashboard 2"
    url: "/dashboards/503?Year Test={{ value | url_encode }}"

  }

}



dimension: time_police_report{
  type: string
  sql: ${TABLE}.HORA_OCORRENCIA_BO ;;
}

dimension: time_police_report22{
  type: number
  sql:
    CASE
    WHEN MOD(CAST(SUBSTR(HORA_OCORRENCIA_BO , 4) as INT64), 5) = 0 THEN NULL
    ELSE CAST(SUBSTR(HORA_OCORRENCIA_BO , 4) as INT64)
    END;;
}

dimension: Month {
  type: string
  sql: ${TABLE}.MES ;;
}

dimension_group: time_test{
  type: time
  timeframes: [
    raw,
    hour,
    time_of_day,
    second,
    minute,
    minute30

  ]
  convert_tz: no
  datatype: date
  sql: ${TABLE}.TIME_NEW ;;
}

dimension: num_bo {
  primary_key: yes
  type: number
  sql: ${TABLE}.NUM_BO ;;

  value_format: "0.00\%"

}

dimension: num_bo_test_external {
  type: number
  sql: ${people.num_bo} ;;
  value_format: "0.00\%"
}

dimension: num_bo_test_external_2 {
  type: number
  sql: ${people.num_bo}/${people.num_bo} ;;
  value_format: "0.00\%"
}

#   dimension: num_bo2 {
#     description: "test liquid"
#     type: number
#     sql: ${TABLE}.NUM_BO ;;
#     html:
#     {% if {{value}} >=1000 %}
#     {{value}} A
#     {% else %}
#     {{value}} B
#     {% endif %}
#     ;;
#   }

dimension: Test_liquid_variable{
  description: "test liquid"
  type: string
  sql:  {% if _user_attributes['climber_country'] == "sidneys" %}
          ${flag_status}
          {% elsif _user_attributes['climber_country'] == "sidneysXS" %}
          ${flag_status}
          {% else %}
          ${offence}
          {% endif %} ;;

}


dimension: num_bo3{
  type: number
  sql: ${TABLE}.NUM_BO ;;
  html:+ {{value}} $


    ;;
}

dimension: criminal_procedure_act {
  type: string
  sql: ${TABLE}.RUBRICA ;;
}

dimension: hour {
  type: number
  sql: distinct(substr(HORA_OCORRENCIA_BO,1,2)) ;;
}

dimension: hour_2 {
  type: date_hour
  sql: distinct(substr(HORA_OCORRENCIA_BO,1,2)) ;;
}
measure: count {
  type: count

  drill_fields: [tk_details*,num_bo]
  html: <a href="{{ link }}" style="color:powderblue;">{{ value }}</a> ;;


#     html: <a href="/explore/model/explore_name?fields=view_name.field_name1,view_name.field_name2,view_name.field_name3&f[view_name.filter_1]={{ value }}&pivots=view.field_2"> style="color:blue;">{{ value }}</a> ;;

}

measure: counttest {
  type: count
  html: <hr>
    <div class="alert alert-info vis">
    <p><span style="font-size: 10pt;"><strong>S&atilde;o Paulo Criminal Activity Dashboards</strong>&nbsp;counts with information of more than {{value}} of police report records the years 2013 and 2014.</span></p>
    <div class="alert alert-info vis">
    <div><span style="font-size: 10pt;">The dataset is divided per police report tickets, and in the each ticket contains information about the Police Station that recorded the ticket, time, date, address, region, type of crime, type of person(witness, suspect, victim), skin color, age, etc.</span></div>
    <div>&nbsp;</div>
    <div>
    <div><span style="font-size: 10pt;">My intention with these dashboard, was to bring an understanding how dangerous is to live in S&atilde;o Paulo city, one of the biggest cities of the world.&nbsp;</span></div>
    <div>
    <div>&nbsp;</div>
    <div><span style="font-size: 10pt;">The dashboards are built and divided per categories:</span></div>
    <div><span style="font-size: 10pt;">- Overall information about the data.</span></div>
    <div><span style="font-size: 10pt;">- Crimes per location.</span></div>
    <div><span style="font-size: 10pt;">- Crimes per gender</span></div>
    <div><span style="font-size: 10pt;">- Interesting numbers</span></div>
    <div>&nbsp;</div>
    <div>
    <div><span style="font-size: 10pt;">Despite the fact of the data show the negative side of the city, S&atilde;o Paulo receives millions of tourists from all over the world throughout the year, willing to enjoy this vibrant city, with its captivating museums, delicious restaurants or exciting nightlife.</span></div>
    <div>&nbsp;</div>
    <div><span style="font-size: 10pt;">Feel free to dig deep on the dashboards if you will to get some more specific answer for your interesting question!&nbsp;</span></div>
    </div>
    </div>
    </div>
    </div>
    </div></hr> ;;
}
set: tk_details {
  fields: [num_bo, offence, criminal_procedure_act]
}
dimension: Pivot {
  type: string
  description: "Defaults to metric if chosen metric filter unused"
  sql: CASE
          WHEN {% parameter chosen_pivot %} = 'IN' THEN ${flag_status}
          WHEN {% parameter chosen_pivot %} = 'US' THEN ${date_police_report_month}
          WHEN {% parameter chosen_pivot %} = 'US' THEN NULL
          ELSE NULL
        END;;
}

dimension: test {
  type: string
  sql: CASE WHEN
      ${flag_status} = "C"
      THEN "{{ chosen_pivot._parameter_value }}"
      ELSE "{{ chosen_pivot._parameter_value }}"
      END;;
}

parameter: chosen_pivot {
  type:  unquoted
  allowed_value: {
    label: "Brazil"
    value: "NA"
  }

  allowed_value: {
    label: "India"
    value: "IN"
  }
  allowed_value: {
    label: "United States"
    value: "US"
  }
}

measure: count_test {
  label: "test test {% parameter chosen_pivot %}"
  type: string
  sql: CASE
    WHEN ${sum_distinct} = Null THEN NULL
    ELSE NULL;;
}

#   dimension: is_count_greater_than_1 {
#     type: yesno
#     sql: ${count}>1 ;;
#   }

#   parameter: date_granularity {
#     type: date
#     allowed_value: {
#       label: "1 Year Ago"
#       value: "1 year ago"
#     }
#     allowed_value: {
#       label: "1 Day Ago"
#       value: "1 day ago"
#     }
#     allowed_value: {
#       label: "1 Month Ago"
#       value: "1 month ago"
#     }
#   }

#   dimension: date {
#     sql:
#     {% if date_granularity._parameter_value == "'Day'" %}
#       ${created_date}
#     {% elsif date_granularity._parameter_value == "'Month'" %}
#       ${created_month}
#     {% else %}
#       ${created_date}
#     {% endif %};;
#   }
# this works


measure: count_dis {
  type: count
  # html: <p style=“color: grey; font-family: OpenSans; background-color:white; text-align:centre; font-size: 150%“>My title</p> {{ rendered_value }} ;;
  html: {% if ticket.count_dis._value >= 1000 and ticket.count_dis._value >= 2000 %}
    <p style=“color: grey; font-family: OpenSans; background-color:white; text-align:centre; font-size: 50%“>My title</p><p style="font-size:200%">{{rendered_value}}</p>
        {% else %}
        {{value}}
        {% endif %};;
}

measure: sum_numbo {
  type: sum
  sql: ${num_bo} ;;
}

dimension: testsid {
  type: string
  sql: ${TABLE}.CONDUTA ;;
  html: {{num_bo._value}} ;;
}

#   dimension: test_andrea {
#     label: "{% if ticket.FLAG_STATUS._in_query %} Customer Success Representative
#     {% elsif ticket_second.FLAG_STATUS._in_query %} Account Executive
#     {% else %} Full Name {% endif %}"
#     type: number
#     sql: ${TABLE}.num_bo ;;
#     drill_fields: [num_bo,test_andrea]
#   }

#   measure: count_sidney {
#     type: count
#     sql: ${criminal_procedure_act} ;;
#   }

dimension: test_line2 {
  type: number
  sql: ${TABLE}.num_bo ;;
}

measure: distinct_1{
  type:  count_distinct
  sql: ${num_bo} ;;
}
measure: sum_distinct{
  type:  sum_distinct
  sql: ${num_bo} ;;
}

#   parameter: Filter-Test {
#     type: string
#
#     allowed_value: {
#       label: "Is Segment 1 In 30 to 60d"
#       value: "NA"
#     }
#
#     allowed_value: {
#       label: "Is Segment 2 In 30 to 60d"
#       value: "IN"
#     }
#     allowed_value: {
#       label: "Is Segment 3 In 30 to 60d"
#       value: "US"
#     }
#
#     allowed_value: {
#       label: "Is Segment 4 In 30 to 60d"
#       value: "US"
#     }
#
#   }
#
#   parameter: Is_Segment_2_In_30_to_60d {
#     type: string
#
#     allowed_value: {
#       label: "1"
#       value: "1"
#     }
#
#     allowed_value: {
#       label: "0"
#       value: "0"
#     }
#
#   }
#
#   parameter: Is_Segment_1_In_30_to_60d {
#     type: string
#
#     allowed_value: {
#       label: "1"
#       value: "1"
#     }
#
#     allowed_value: {
#       label: "0"
#       value: "0"
#     }
#
#   }
#
#   parameter: Is_Segment_3_In_30_to_60d {
#     type: string
#
#     allowed_value: {
#       label: "1"
#       value: "1"
#     }
#
#     allowed_value: {
#       label: "0"
#       value: "0"
#     }
#
#   }
#
#   parameter: Is_Segment_4_In_30_to_60d {
#     type: string
#
#     allowed_value: {
#       label: "1"
#       value: "1"
#     }
#
#     allowed_value: {
#       label: "0"
#       value: "0"
#     }
#
#   }
#

measure: TICKERT{
  view_label: "for tests"
  type: count_distinct
  sql:${num_bo};;
  # drill_fields: [num_bo]
  # html: <a href="/explore/criminal_activity/ticket?fields=ticket.sme_lookml*&f&f[ticket.date_police_report_year]={{ _filters['ticket.date_police_report_year'] | url_encode }}&f[people.skin_color]={{ _filters['people.skin_color'] | url_encode }}&f[ticket.criminal_procedure_act]={{ value }}&pivots=people.gender&limit=50&column_limit=20">{{ value }}</a> ;;
  link: {
    label: "content failure"
    url:"/explore/criminal_activity/ticket?fields=ticket.sme_lookml*&f&f[ticket.date_police_report_year]={{ _filters['ticket.date_police_report_year'] | url_encode }}&f[people.skin_color]={{ _filters['people.skin_color'] | url_encode }}&f[ticket.criminal_procedure_act]={{ value }}&pivots=people.gender&limit=50&column_limit=20"
    # url:"{% assign vis_config = '{ \"type\" : \"ds_content_failure_msg_diff\"}' %} {{ link }}&vis_config= {{ vis_config | encode_uri }}"
  }
}

measure: TICKERT_1{
  type: sum
  view_label: "for tests"
  sql: (select 2) ;;
}


dimension: criminal_procedure_act_sme {
  label: "Criminal Procedure Act"
  view_label: "SME Lookml"
  type: string
  sql: ${TABLE}.RUBRICA ;;
  html: <a href="/exp lore/criminal_activity/ticket?fields=ticket.sme_lookml*&f&f[ticket.date_police_report_year]={{ _filters['ticket.date_police_report_year'] | url_encode }}&f[people.skin_color]={{ _filters['people.skin_color'] | url_encode }}&f[ticket.criminal_procedure_act]={{ value }}&pivots=people.gender&limit=50&column_limit=20">{{ value }}</a> ;;
}

set: my_set {
  fields: [criminal_procedure_act,date_police_report_day_of_year,date_police_report_month,people.gender,count]
}

dimension: external_reference {
  type: string
  sql: ${people.gender} ;;
}

measure: returned_count {
  type: count_distinct
  sql: ${num_bo} ;;
  drill_fields: [detail*]
  link: {
    label: "Explore Top 20 Results"
    url: "{{ link }}&total=on"
  }
}

set: detail {
  fields: [num_bo,count,flag_status,date_police_report_date,date_police_report_day_of_month,date_police_report_day_of_week,date_police_report_month_name,count,criminal_procedure_act]
}

parameter: max_rank {
  type: number
}

dimension: rank_limit {
  type: number
  sql: {% parameter max_rank %} ;;
}

measure: date_sid {
  view_label: "easy to see"
  sql: min(${date_police_report_date}) ;;
}

dimension: date_dius2 {
  view_label: "easy to see"
  type: date
  sql: ${date_police_report_date} ;;
}

measure: max_date_region{
  type: date
  sql: max(${date_police_report_raw}) ;;
  convert_tz: no
}
}
