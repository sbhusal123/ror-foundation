# Rails Controller
- Inherits `ApplicationController:Base`


**projects_controller**

```rb
class ProjectsController < ApplicationController

  # set_project (private) method gets called before show, edit, update and destory paths controller reaches a point of execution.
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

> `before_action :set_project, only: %i[ show edit update destroy ]` this section basically sets a project id that's passed in the url
if show, edit, update or update urls are visited. Methods associated with those urls do not have body by default but explicitly being handled by
set_project method. 

> `project_params` method acts as a serializer that only accepts the parameters permited, usage: edit, create, patch.

## Respond to block

```rb
    
respond_to do |format|
    if @project.save
    format.html { redirect_to project_url(@project), notice: "Congratulations ! The project was created." }
    format.json { render :show, status: :created, location: @project }
    else
    format.html { render :new, status: :unprocessable_entity }
    format.json { render json: @project.errors, status: :unprocessable_entity }
    end
```

- It basically checks weather `#/projects/1` `/projects/1.json` and executes and formats acccordingly.
- Sort of like case statememt.
- If the object has `html` attribute -> `format.html` otherwise `format.json`

**Example**

```rb
x = "a string"

x.respond_to?("strip"); # true, string object has strip method

x.respond_to?("foo"); # false, string obje doesnt have foo method on it.
```


