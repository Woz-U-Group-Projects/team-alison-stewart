class Nodes::Text < Node
  # Constants
  FONTS = %w{
    Times-Roman
    Helvetica
    Helvetica-Bold
    Code39Eight
    CodabarTwo
  }

  ALIGNMENTS = %w{
    left
    center
    right
  }

  # Validations
  validates_presence_of :font_family
  validates_presence_of :point_size
  validates_numericality_of :point_size, greater_than: 0
  validates_presence_of :color
end
