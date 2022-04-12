connection: "lookerdata_publicdata_standard_sql"

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project
# include: "/**/*.view.lkml"                 # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard
include: "lookml_custom.dashboard.lookml"

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#





# explore: mukul_derived_table_testing {
#   sql_always_where: ${testing_created_view} >= (select usaf from weather.stations where usaf = '011920')  ;;

# }

explore: stations{}
