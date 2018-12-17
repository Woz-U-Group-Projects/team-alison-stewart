module EventHelper
  include ProgramHelper

  def event_icon(event)
    program_icon event.event_type.program_slug
  end
end
