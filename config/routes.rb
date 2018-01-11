get "/sipgate/unassigned_calls" => "sipgate_connector#unassigned_calls",      as: :sipgate_unassigned_calls
get "/sipgate/auth"       => "sipgate_connector#auth",      as: :sipgate_auth
get "/sipgate/callback"   => "sipgate_connector#callback",  as: :sipgate_callback

post "/sipgate/make_call" => "sipgate_connector#make_call", as: :sipgate_make_call
post "/sipgate/toggle_call_status" => "sipgate_connector#toggle_call_status", as: :toggle_call_status