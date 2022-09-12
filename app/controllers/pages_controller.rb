class PagesController < ApplicationController
  def contact
  end

  def about
    @title="My Custom Title"
  end

  def home
    # this passes context to view, template as a var
    @projects = Project.all
  end
end
