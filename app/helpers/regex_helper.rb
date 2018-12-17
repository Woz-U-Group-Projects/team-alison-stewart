module RegexHelper
  # Address
  POSTAL_CODE = /\A[abceghjklmnprstvxyABCEGHJKLMNPRSTVXY]{1}\d{1}[a-zA-Z]{1} *\d{1}[a-zA-Z]{1}\d{1}\z/
  ZIP_CODE    = /\A\d{5}(-\d{4})?\z/

  # Important Date
  DYNAMIC_NAME = /\A(.*):(.*)\z/

  # Misc
  EMAIL         = /(^([^@\s]+)@((?:[-_a-z0-9]+\.)+[a-z]{2,})$)|(^$)/i
  NUMERAL       = /[012345678]/
  NUMBER        = /\A[-+]?[0-9]*\.?[0-9]+\Z/
  PHONE_NUMBER  = /\A([0-9\(\)\/\+ \-]*)\z/
  IMAGE_FILE    = /.*(\.jpg|\.jpeg|\.gif|\.png)\Z/
end
