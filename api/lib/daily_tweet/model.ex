defmodule DailyTweet.Model do
	alias DailyTweet.Repo
	
	@callback changeset(map()) :: Ecto.Changeset.t()
	@callback changeset_update(struct_or_changeset :: Ecto.Schema.t() | Ecto.Changeset.t(), map()) :: Ecto.Changeset.t()
	@callback find(String.t()) :: Ecto.Schema.t() | nil | no_return()
	@callback find_by(Keyword.t() | map()) :: [Ecto.Schema.t()] | nil | no_return()
	@callback list_all() :: [Ecto.Schema.t()]
	@callback create(map()) :: {:ok, Ecto.Schema.t()} | {:error, Ecto.Changeset.t()}
	@callback update(Ecto.Schema.t(), struct) ::
				  {:ok, Ecto.Schema.t()} | {:error, Ecto.Changeset.t()}
	@callback delete(struct_or_changeset :: Ecto.Schema.t() | Ecto.Changeset.t())
			  :: {:ok, Ecto.Schema.t()} | {:error, Ecto.Changeset.t()}
	
	defmacro __using__(_) do
		quote do
			@behaviour DailyTweet.Model
			@before_compile unquote(__MODULE__)
			
			use Ecto.Schema
			import Ecto.Changeset
			import Ecto.Query
			alias DailyTweet.Repo
			
			defoverridable DailyTweet.Model
		end
	end
 
	defmacro __before_compile__(_env) do
		quote do
			
			# Changeset API
			
			def changeset(attrs) do
				%__MODULE__{}
				|> changeset(attrs)
			end
			
			def changeset_update(%__MODULE__{} = object, attrs) do
				object
				|> changeset(attrs)
			end
			
			# Model API
			
			def find(id) do
				Repo.get(__MODULE__, id)
			end
			
			def find_by(conds) do
				Repo.get_by(__MODULE__, conds)
			end
			
			def list_all do
				__MODULE__
				|> Repo.all()
			end
			
			def create(attrs) do
				attrs
				|> changeset()
				|> Repo.insert()
			end
			
			def update(%__MODULE__{} = object, attrs) do
				object
				|> changeset(attrs)
				|> Repo.update()
			end
			
			def delete(%__MODULE__{} = object) do
				Repo.delete(object)
			end
   
		end
	end

end
