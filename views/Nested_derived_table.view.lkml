
 explore: derived_test {}
  explore: derived_test_v2 {
    join: derived_test {
      relationship: one_to_one
      sql_on: ${derived_test_v2.ticket_num_bo} = ${derived_test.ticket_num_bo} ;;
    }
  }


  view: derived_test {
    derived_table: {
      sql:
      SELECT


    CASE
    WHEN ticket.FLAG_STATUS = {% parameter test_parm %} THEN 'A'
  --  WHEN ticket.FLAG_STATUS = {% parameter test_parm %} THEN 'C bucket'
    ELSE "B"
    end as mycase,
          count(ticket.NUM_BO) AS ticket_num_bo,
          ticket.FLAG_STATUS as flag_status

        FROM `lookerdata.sidney_thesis.ticket`
        AS ticket



        --where {% condition test_dim %} ticket.flag_status {% endcondition %}
        group by flag_status

        ;;

    }

    # derived_table: {
    #   sql: SELECT
    #       ticket.NUM_BO  AS ticket_num_bo,
    #       ticket.FLAG_STATUS as flag_status

    #   FROM `lookerdata.sidney_thesis.ticket`
    #       AS ticket
    #   WHERE {% condition string_test %} ticket.FLAG_STATUS {% endcondition %}
    #   LIMIT 500
    #   ;;
    # }

    # filter: string_test {
    #   suggest_dimension: flag_status
    #   type:string
    # }

    dimension: mycase_dim {
      sql: ${TABLE}.mycase ;;
    }

    filter: test_dim {
      type: string
      suggest_dimension: flag_status
      # sql: select flag_status in ("T") ;;
    }

    parameter: test_parm {
      type: string
      suggest_dimension: flag_status
    }

    measure: count {
      type: count
      #filters: [derived_test.flag_status: "T"]
      drill_fields: [detail*]
    }

    dimension: ticket_num_bo {
      type: number
      sql: ${TABLE}.ticket_num_bo ;;
    }

    dimension: flag_status {
      type: string
      sql: ${TABLE}.flag_status ;;
    }

    set: detail {
      fields: [ticket_num_bo]
    }

  }

########################################################################################

  view: derived_test_v2 {
    derived_table: {
      sql: SELECT
          ticket_num_bo,
          flag_status

        FROM ${derived_test.SQL_TABLE_NAME}
        AS derived_test

        ;;
    }

    filter: test_dim {
      type: string
      suggest_dimension: flag_status
      # sql: select flag_status in ("T") ;;
    }

    measure: count {
      type: count
      drill_fields: [detail*]
    }

    dimension: ticket_num_bo {
      type: number
      sql: ${TABLE}.ticket_num_bo ;;
    }

    dimension: flag_status {
      type: string
      sql: ${TABLE}.flag_status ;;
    }

    set: detail {
      fields: [ticket_num_bo]
    }

  }
