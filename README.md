# Maptex #

Maptex is an Elxir package used to transform data structures.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `maptex` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:maptex, "~> 0.1.0"}
  ]
end
```


## Overview ##

 This is a Map transformer library to prepare your target map from your source map so that the transformed map can be easily serialized through a JSON or XML Serializer.
 

### Simple Use ###

You can construct the transformer schema and render the new model from the source.

```elixir
# web/serializers/Simple_serializer.ex
defmodule SimpleSerializer do
	use Maptex
	
	schema=%{name: :first_name, age: :age}

	source=%{first_name: "Sean", last_name: "Mathew", age: "42", city: "Providence", state: "Boston", country: "US"}
	
	Maptex.to_map(schema, source)

end
```

would output 

```elixir

%{name: "Sean", age: "42"}

```

### Nested Use ###

You can construct the transformer schema and render the new model from the source.


```elixir
# web/serializers/Nested_serializer.ex
defmodule NestedSerializer do
	use Maptex
	
	schema=%{first_name: [:name, :first_name], last_name: [:name, :last_name], city: [:address, :city]}

	source=%{name: %{first_name: "Sean", last_name: "Mathew"}, age: "42", address: %{city: "Providence", state: "Boston", country: "US"}}
	
	Maptex.to_map(schema, source)

end
```
would output

```elixir

%{city: "Providence", first_name: "Sean", last_name: "Mathew"}

```

### Merged values ###

New model can have values that are merged from multiple keys in the source

```elixir
# web/serializers/Merged_serializer.ex
defmodule MergedSerializer do
	use Maptex
	
	schema=%{name: "first_name+last_name", age: :age, address: "houseno+street+city+state+country"}

	source=%{first_name: "Sean", last_name: "Mathew", age: "42", houseno: "123", street: "West Avenue", city: "Providence", state: "Boston", country: "US"}
		
	Maptex.to_map(schema, source)

end
```


would output

```elixir
%{
  address: "123 West Avenue Providence Boston US",
  age: "42",
  name: "Sean Mathew"
}
```
### Merge with commas ###


New model can have values that are merged from multiple keys in the source

```elixir
# web/serializers/CommaMerged_serializer.ex
defmodule CommaMergeSerializer do
	use Maptex
	
	schema=%{name: "first_name+last_name", age: :age, address: "houseno,+street,+city,+state,+country"}

	source=%{first_name: "Sean", last_name: "Mathew", age: "42", houseno: "123", street: "West Avenue", city: "Providence", state: "Boston", country: "US"}
		
	Maptex.to_map(schema, source)

end
```

would output

```elixir
%{
  address: "123, West Avenue, Providence, Boston, US",
  age: "42",
  name: "Sean Mathew"
}
```


