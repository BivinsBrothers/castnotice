class CategoriesController < ApplicationController
  def index
    @filters ||= {
      filters:
      {
        region: {
          label: "Region",
          values: Region.names
        },
        project: {
          label: "Type of Project",
          values: ProjectType.names
        },
        union: {
          label: "Union",
          values: Union.names
        }
      }
    }

    render json: @filters
  end
end
