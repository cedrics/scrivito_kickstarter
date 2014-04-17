# v2.0.0
  * Refactored user javascript to use data attributes instead of writing directly into a script tag.
  * Removed homepage and locale logic from `simple` theme, because there only is one homepage and
    one locale.
  * Removed `ForceHttps` module because it depends on the project and there are better solutions,
    than doing it in the application.
  * Removed the homepage selection, because the `simple` theme only runs under a single domain.
  * Removed the language switch from the `simple` theme, because it only creates one homepage for
    one language.
  * Removed `haml` dependency and changed all views from haml to erb.
  * Restructured all examples into a `simple` theme. The Kickstarter now generates a core and themes
    can build upon this core to provide views and overwrite anything necessary. This reduces the
    amount of generators and has a much better separation of concerns. For some components and
    widgets, this means that there are no examples anymore. The generators now create the structure
    for the editor to insert an example anywhere on the page.

# v1.3.0
  * Added `scrival_editors` as a dependency.

# v1.2.0
  * Rename `edit.html` to `details.html` as it is now required by the latest Scrival SDK. This also
    changed the method `mediabrowser_edit_view_path` to `mediabrowser_details_view_path`.
  * The `dialog.css` file has been removed. The functionality will be provided by the
    scrival_editors gem. (Thanks @agessler)

# v1.1.0
  * Update Travis Rake task to only use the tenant name and the api key.
  * Update Scrival SDK configuration.

# v1.0.0
  * Removed usage of `preset_attributes` and moved the logic into the Ruby on Rails application.
  * All generated widgets now use the new view template path under `app/views`.
  * Updated to Ruby on Rails version 4.
  * Add `child_order` referencelist attribut to the homepage to allow to sort child elements in
    place. (Thanks @kostia)
  * The homepage headline is now editable in place, instead of on the property view only.
  * Breadcrumbs access is now memoized for better performance on pages like the search result page,
    where breadcrumbs of one object are potentially displayed multiple times.
  * Removed JavaScript editors and the media browser. The functionality is now available with the
    new gem `scrival_editors`. This allows much easier updates of these components and removes many
    more complex files from a starting project.
  * Renamed `menubar` to `edit_toggle` which describes better, what it actually does.
  * Update blog posts to edit the author and date in-place instead of on the property view.
  * Added a slider editor for CMS string attributes that represent an integer. The slider editor
    allows to set the min, max and step value and uses jQuery UI. Simply use `data-editor="slider"`
    on a CMS field to enable it. `enum` fields automatically add the `data-min` and `data-max`
    attributes when the `cms_edit_enum` helper is used instead of `cms_tag`. (Thanks @cedrics)
  * All attribute type JavaScript editors "string", "text", "html", "enum", "multienum", "date",
    "linklist", "reference" and "referencelist" can now be used independently from their attribute
    type. This means it is possible to use the `string-editor` for `enum` values, for example or
    define a custom editor for string attributes. The attribute type editors still work by default
    but the editor can be defined in the `data-editor` HTML attribute on a Scrival `cms_tag` call.
  * The following generators are removed from the Kickstarter and partially provided by the Scrival
    SDK: `cms:obj`, `cms:widget`, `cms:controller` and `cms:scaffold`.
  * Removed all generators that only configure the Ruby on Rails application. These generators are:
    `component:amazon_ses`, `monitoring:newrelic`, `error_tracking:airbrake`,
    `error_tracking:honeybadger` and `tracking:google_analytics`. All functionality is fully
    described on their respective webpages and provide extensive documentation on how to extend and
    configure the Ruby on Rails application.
  * The styling for nested widgets is now provided by the Scrival and not necessary
    anymore in the Kickstarter.
  * Updated the string editor to use the `contenteditable` HTML5 attribute, which allows to edit
    content while keeping style information. (Thanks @cedrics and @dcsaszar)
  * Renamed `Column2Widget` to `TwoColumnWidget` and `Column3Widget` to `ThreeColumnWidget`.
    (Thanks @kostia)
  * Default CMS field placeholder and highlighting is moved into the Scrival, so it
    can be removed from the Kickstarter.
  * Removed `rails g cms:component:developer_tools` and `rails g cms:component:testing` as both are
    very project specific and have easy installers that are better described on their respective
    websites.
  * Bugfix: Search result page expected breadcrumps component. (Thanks @rouvenbehnke)
  * Removed `WorkspaceSelection` mixin, because the In-Place Editing menu bar allows to easily and
    comfortable switch the current working copy.
  * The `Column2Widget` and `Column3Widget` are now part of the default widget set generated by
    `rails g cms:kickstart`.
  * Made the `login` and `logout` button more prominent and moved it to the main navigation.
  * Extended `Image` and `Video` model to provide a more convenient `.create` method, that retrieves
    the `_path` and `_obj_class` automatically from the given `blob`.
  * `rails g cms:kickstart` can now also be applied to a Ruby on Rails application, that was created
    with the `--skip-git` option. (Thanks @cedrics)
  * Removed +Page+ module and further simplified standard CMS objects. The +menu_title+ is no longer
    used but the +headline+ attribute is now displayed directly.
  * Updated the `not_found` method in the `ApplicationController` to even handle cases, where the
    `ResourceNotFound` exception is thrown within the `not_found` method itself.
  * Removed usage of `Time#to_iso` because in all circumstances the `Time`, `Date` or `DateTime`
    object could be used directly.
  * Added a Flickr widget that is based on the Flickr Badge API. It allows to display 1 to 10 images
    and adds a whole set of customization options for the editor.
  * Removed all CRM related generators and related code like the profile page, the reset password
    page, and the form builder. The user authentication is changed to fixed credentials "root" for
    both login and password. The "custom_cloud.yml" file is no longer needed and the
    "infopark_crm_connector" is no longer included.
  * Bugfix: It is no longer the case that a resource is uploaded twice when dropped into the media
    browser. (Thanks @gertimon)
  * Bugfix: The page is now reloaded if a resource is deleted in the media browser to update all
    references on the page. (Thanks @gertimon)
  * The `slug` method is no longer overwritten by the generated Kickstarter code to allow full
    customization by gems or the developer within the project.
  * We removed the `NullHomepage` concept that was displayed if no homepage was published yet.
    Instead we recommend to publish right after running your generated migrations to have a homepage
    and login page available in your project.
  * Added customizable filters to the media browser. You can now define a set of available filters
    that have a name, title, icon and a Scrival JavaScript search query. A list of filter names can
    then be handed over to the media browser that looks up the filters and displays them in the left
    filter column. This allows to restrict or display any kind of filter in the media browser.
  * Removed dependency on `less` by using plain CSS and referencing bootstrap from a CDN.
  * Removed `bootstrap-datepicker-rails` dependency and switched to a jQuery UI datepicker with a
    timepicker addon.
  * renamed `infopark_kickstarter` to `scrival_kickstarter`
