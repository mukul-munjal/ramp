connection: "looker_partner_conn"

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project
# include: "/**/*.view.lkml"                 # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#

explore: users {
  join: order_items {
    type: left_outer
    sql_on: ${users.id} ${order_items.user_id} ;;
    relationship: one_to_many
  }
}
