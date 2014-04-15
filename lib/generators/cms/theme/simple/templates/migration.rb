class KickstarterSimpleTheme < ::Scrival::Migration
  def up
    homepage_path = '/en'
    configuration_path = "#{homepage_path}/_configuration"

    #
    # Root example
    #

    Obj.create(
      _path: '/',
      _obj_class: 'Root'
    )

    update_obj_class('Root', is_active: false)

    #
    # Homepage example
    #

    teaser_widget = Scrival::BasicWidget.new(
      _obj_class: 'TeaserWidget',
      headline: 'Welcome to Scrival',
      content: '<p>You successfully started your
        project. Basic components such as a top navigation, a search panel, this text widget, and a
        login page have been created for you to experiment with the building blocks of your website
        application. To access the documentation or get in touch with the Scrival support team,
        visit the Scrival Documentation.</p>',
      link_to: [
        Scrival::Link.new(
          url: 'https://scrival.com/preparation',
          title: 'Browse Scrival Documentation'
        ),
      ]
    )

    Obj.create(
      _path: homepage_path,
      _obj_class: 'Homepage',
      locale: 'en',
      headline: 'Company, Inc.',
      main_content: [
        teaser_widget,
      ]
    )

    #
    # Error not found page example
    #

    error_not_found_page = Obj.create(
      _path: "#{configuration_path}/error-not-found",
      _obj_class: 'ErrorPage',
      headline: 'Page not found'
    )

    obj = Obj.find_by_path(homepage_path)
    obj.update(
      error_not_found_page: error_not_found_page.id
    )

    #
    # Search page example
    #

    search_page = Obj.create(
      _path: "#{configuration_path}/search",
      _obj_class: 'SearchPage',
      headline: 'Search'
    )

    add_attribute_to('Homepage', {
      name: 'search_page',
      type: :reference,
      title: 'Search Page',
    })

    obj = Obj.find_by_path(homepage_path)
    obj.update(
      search_page: search_page.id
    )

    #
    # Login page example
    #

    login_page = Obj.create(
      _path: "#{configuration_path}/login",
      _obj_class: 'LoginPage',
      headline: 'Log in'
    )

    add_attribute_to('Homepage', {
      name: 'login_page',
      type: :reference,
      title: 'Login Page',
    })

    obj = Obj.find_by_path(homepage_path)
    obj.update(
      login_page: login_page.id
    )

    #
    # Content page example
    #

    Obj.create(
      _path: "#{homepage_path}/example-page",
      _obj_class: 'ContentPage',
      headline: 'Content Page'
    )

    #
    # Contact page example
    #

    Obj.create(
      _path: "#{homepage_path}/contact",
      _obj_class: 'ContactPage',
      headline: 'Contact'
    )


    #
    # Blog example
    #

    blog_path = "#{homepage_path}/blog"

    Obj.create(
      _path: blog_path,
      _obj_class: 'Blog',
      headline: 'Blog',
      disqus_shortname: 'your-disqus-shortname'
    )

    post_path = "#{blog_path}/post-example-1"

    post = Obj.create(
      _path: post_path,
      _obj_class: 'BlogPost',
      headline: 'Nulla viverra metus vitae nunc iaculis dignissim',
      author_id: 'admin@example.com',
      author_name: 'Administrator',
      published_at: Time.zone.now - 1.days
    )

    widget = Scrival::BasicWidget.new(
      _obj_class: 'TextWidget',
      content: '<p>Quisque eget sem sit amet risus gravida commodo et sed neque. Morbi pellentesque
        urna ut sapien auctor mattis. Donec quis cursus enim. Pellentesque sodales, elit nec
        accumsan congue, orci velit commodo orci, vel luctus nisi mi vitae erat. Cras lacus urna,
        sagittis tristique placerat vel, consectetur id leo. Vestibulum in congue mauris. Donec
        volutpat nibh ut nunc hendrerit porta. Pellentesque habitant morbi tristique senectus et
        netus et malesuada fames ac turpis egestas. Aliquam in felis quis neque aliquet rutrum.
        Morbi interdum aliquet sollicitudin. Curabitur eget erat vitae risus aliquam ultricies ac
        ut leo. Praesent eget lectus lorem, eu luctus velit. Proin rhoncus consequat consectetur.<p>'
    )

    widgets = post.send('main_content') << widget
    post.update('main_content' => widgets)

    post_path = "#{blog_path}/post-example-2"

    post = Obj.create(
      _path: post_path,
      _obj_class: 'BlogPost',
      headline: 'Excepteur sint occaecat cupidatat',
      author_id: 'admin@example.com',
      author_name: 'Administrator',
      published_at: Time.zone.now - 3.days
    )

    widget = Scrival::BasicWidget.new(
      _obj_class: 'TextWidget',
      content: '<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
        tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
        quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
        consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
        cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
        proident, sunt in culpa qui officia deserunt mollit anim id est laborum.<p>'
    )

    widgets = post.send('main_content') << widget
    post.update('main_content' => widgets)
  end
end
