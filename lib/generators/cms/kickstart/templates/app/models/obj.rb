require File.join(Rails.root + 'lib/scrivito/cms_definitions')

# This class represents the base class of all CMS objects and implements behavior that all CMS
# objects have in common.
class Obj < ::Scrivito::BasicObj
  include Scrivito::CmsDefinitions

  def show_in_navigation?
    true
  end
end
