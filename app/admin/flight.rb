ActiveAdmin.register Flight do
  permit_params :origin, :destination, :airline_id

  actions :index, :show, :new, :create, :destroy
end
