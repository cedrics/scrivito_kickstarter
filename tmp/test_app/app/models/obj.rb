require File.join(Rails.root + 'lib/scrivito_kickstarter/cms_definitions')

# This class represents the base class of all CMS objects and implements behavior that all CMS
# objects have in common.
class Obj < ::Scrivito::BasicObj
  include ScrivitoKickstarter::CmsDefinitions

  def show_in_navigation?
    true
  end
  def show_breadcrumbs?
    true
  end

  def breadcrumbs
    @breadcrumbs ||= begin
      breadcrumbs = ancestors.select { |obj| obj.respond_to?(:show_in_navigation?) && obj.show_in_navigation? }
      breadcrumbs + [self]
    end
  end
end
