# Rails Routes
- Core routes resource registration: `config/routes.rb`

## List all routes:
- `rails routes`

```rb
                                  Prefix Verb   URI Pattern                                                                                       Controller#Action
                                projects GET    /projects(.:format)                                                                               projects#index
                                         POST   /projects(.:format)                                                                               projects#create
                             new_project GET    /projects/new(.:format)                                                                           projects#new
                            edit_project GET    /projects/:id/edit(.:format)                                                                      projects#edit
                                 project GET    /projects/:id(.:format)                                                                           projects#show
                                         PATCH  /projects/:id(.:format)                                                                           projects#update
                                         PUT    /projects/:id(.:format)                                                                           projects#update
                                         DELETE /projects/:id(.:format)                                                                           projects#destroy
....
```

## Controller:
- app/controller/projects_controller.rb

```rb
class ProjectsController < ApplicationController
  before_action :set_project, only: %i[ show edit update destroy ]

  # GET /projects or /projects.json
  def index
    @projects = Project.all
  end

  # GET /projects/1 or /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects or /projects.json
  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to project_url(@project), notice: "Project was successfully created." }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1 or /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to project_url(@project), notice: "Project was successfully updated." }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1 or /projects/1.json
  def destroy
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url, notice: "Project was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def project_params
      params.require(:project).permit(:title, :description, :percent_complete)
    end
end
```

## List of commands associated:
- **Creating a controller:** ``rails g controller <ControllerName> <cont1> <cont2> ..``
- Generates routes, tests, views, controller, assets required for new controller.

Example: `rails g controller Pages contact about home` generates `pages/about`, `pages/contact`, `pages/home` controller

**controllers/pages_controller**

```rb
class PagesController < ApplicationController
  def contact
  end

  def about
  end

  def home
  end
end
```

**Routes Registered: routes.rb**

```rb
  get 'pages/contact'
  get 'pages/about'
  get 'pages/home'
```