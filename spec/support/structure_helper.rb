require 'active_support/concern'

module StructureHelper
  extend ActiveSupport::Concern

  included do
    def structure(name)
      send("#{name}_structure").with_indifferent_access
    end

    let(:tourist_structure) do
      {
        id: a_kind_of(Integer),
        name: a_kind_of(String),
        email: a_kind_of(String)
      }
    end

    let(:guide_structure) do
      {
        id: a_kind_of(Integer),
        name: a_kind_of(String),
        email: a_kind_of(String)
      }
    end
  end
end
