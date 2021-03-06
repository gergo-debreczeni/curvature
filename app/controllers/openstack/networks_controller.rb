# Networks Controller
class Openstack::NetworksController < ApplicationController
  def index
    json_respond quantum().networks()
  end

  def create
    json_respond quantum().create_network(params[:name], get_data(:current_tenant))
  end

  def show
  end

  def destroy
    quan = quantum()
    ports = quan.ports()
    ports["ports"].each do |port|
      if port["status"] == "DOWN" and port['network_id'] == params[:id]
        quan.delete_port(port["id"])
      end
    end
    json_respond quan.delete_network(params[:id])
  end
end
