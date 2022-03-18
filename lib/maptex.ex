defmodule Maptex do
  use Maptex.Types
  
  @moduledoc """
  Documentation for `Maptex`.
  """

  def to_map(schema, source_map) do
	for {k, v} <- schema, into: %{}, do: {k, fetch(source_map, v)}
  end
  
  
  @spec fetch(map(), any()) :: result_t()
  
  def fetch(map, keys)
  
  def fetch(map, keys) when is_list(keys) do
    case Maptex.Fetcher.fetch(map, keys) do
		{:ok, value} -> value
		:error		 -> ""
	end
  end
  
  def fetch(map, keys) when is_binary(keys) do
	case String.contains?(keys, "+") do
		true	-> fetchjoin(map, String.split(keys, "+"))
		false	-> fetch(map, [keys])
	end
  end
 
  def fetch(map, keys) do
	fetch(map, [keys])
  end
  
  def fetch(map, keys, default) do
    case fetch(map, keys) do
      :error -> {:ok, default}
      result -> result
    end
  end
  
 
 def fetchjoin(map, keys) do
    case Maptex.Fetcher.fetchjoin(map, keys) do
		{:ok, value} -> value
		:error		 -> ""	
		value -> value
	end
  end
   
end
