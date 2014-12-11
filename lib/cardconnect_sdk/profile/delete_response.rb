module CardconnectSdk
  module Profile
    class DeleteResponse
      include Attributable

      # Standard Attributes for profile deletion
      attr_reader :profileid, :acctid, :resptext, :respcode, :respproc, :respstat
      
    end
  end
end

# {
#   "resptext": "Profile Deleted",
#   "respcode": "08",
#   "profileid": "12345678901234567890",
#   "acctid": "1",
#   "respproc": "PPS",
#   "respstat": "A"
# }
