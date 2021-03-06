defmodule Maptex.Types do

  defmacro __using__(_opts) do
    quote do
      @type maybe(t) :: t | nil

      @type ok_t :: {:ok, any()}
      @type result_t :: ok_t() | :error
      @type pair_t :: {any(), any()}
      @type flattend_map_entry_t :: {list(), any()}
      @type flattened_map_t :: list(flattend_map_entry_t())
    end
  end
end