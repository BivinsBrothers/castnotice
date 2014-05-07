class CategoryJson
  def generate
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
  end
end
